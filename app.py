import db
from flask import Flask, jsonify, abort, request, make_response, url_for
from flask_httpauth import HTTPBasicAuth
from werkzeug.security import generate_password_hash, check_password_hash


db.reset()

app = Flask(__name__)
auth = HTTPBasicAuth()

users = {
    'admin': generate_password_hash('admin'),
    'john': generate_password_hash('john')
}

@auth.verify_password
def verify_password(username, password):
    if username in users \
    and check_password_hash(users.get(username), password):
        return username
    return None


@app.route('/')
def index():
    return 'Welcome, {}!'.format(auth.current_user() or 'Guest')


@app.route('/finance/api/v1.0/payments', methods = ['GET'])
@auth.login_required
def list_payments():
    """Get list of all payments."""
    rows = db.query('SELECT * FROM payments;')
    return jsonify({'payments': rows})


@app.route('/finance/api/v1.0/payments', methods = ['PUT'])
@auth.login_required
def create_payment():
    """Create payment."""
    print(auth.current_user())
    if request.json and 'purchase' in request.json \
    and 'amount' in request.json and 'currency' in request.json:
        statement = 'INSERT INTO payments (purchase, user, amount, currency, completed) ' + \
                    'VALUES ({}, "{}", {}, "{}", 0);'.format(
                    request.json['purchase'],
                    auth.current_user(),
                    request.json['amount'],
                    request.json['currency'])
        count = db.execute(statement)
    else:
        abort(400)
    return jsonify({'created': count})


@app.route('/finance/api/v1.0/payments', methods = ['POST'])
@auth.login_required
def process_payments():
    """Process payments - convert amounts to EUR currency."""
    count = 0
    rates = db.query('SELECT name, rate FROM currency')
    print(rates)
    for rate in rates:
        statement = 'UPDATE payments SET amount = amount * {}, currency = "EUR", completed = 1 '.format(rate[1]) + \
                    'WHERE currency = "{}" AND completed = 0'.format(rate[0])
        count += db.execute(statement)
    return jsonify({'processed': count} )


@app.route('/finance/api/v1.0/payments/<int:payment_id>', methods = ['DELETE'])
@auth.login_required
def remove_payment(payment_id):
    statement = 'DELETE FROM payments WHERE id = {}'.format(payment_id)
    count = db.execute(statement)
    return jsonify({'deleted': count})


@auth.error_handler
def unauthorized():
    data = {'error': 'Unauthorized access'}
    return make_response(jsonify(data), 403)
    
@app.errorhandler(400)
def bad_request(error):
    data = {'error': 'Bad request'}
    return make_response(jsonify(data), 400)

@app.errorhandler(404)
def not_found(error):
    data = {'error': 'Not found'}
    return make_response(jsonify(data), 404)



if __name__ == '__main__':
    app.run(host= '0.0.0.0', debug=True)

