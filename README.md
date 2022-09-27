# Assignment Test Automation Engineer

## App Design Documentation / Requriments

The application displays a welcome page which shows a greeting
and implements an API `/finance/api/v1.0/payments` which supports below methods:

1. `GET /finance/api/v1.0/payments` - to retrieve all the payments from SQLite database as a list (allowed for admins only).

1. `PUT /finance/api/v1.0/payments` with json data in this form `{"purchase": <integer>, "amount": <float>, "currency": "<str>"}` where currency code is a 3-letter captalized string (e.g. `GBP`, `USD`, `EUR`) - to create a payment entry in the database (allowed for authorized users).

1. `POST /finance/api/v1.0/payments` - process all payments, where `completed` is still `0`: change the currency to `EUR` (convert amount to `EUR` according to the rates in the currency table) and set `completed` to `1` (allowed for admins only).

1. `DELETE /finance/api/v1.0/payments/<payment_id>` - to remove the payment by the given `payment_id` (allowed for admins to remove any payment and for the users to remove only their payments).

_Notes_:

* Currently, two users are registered in the system: `admin/admin` and `john/john`.
* At present time the application supports basic authentication only.

## Deployment Instructions

1. Start the web application - in a terminal window, execute `python app.py`.
1. Application will start in localhost:5000

_Note_: you will need to install necessary Python dependencies.

## Test Assignment

_Note_: Please complete and assignment and share the results (code & reports) in github or in zipfloder.

<h3><B>Test strategy</B></h3>

#### 1. Explore the actual behavior of the application using `curl` or `Postman` or any other tool.
Please check ./assignment.postman_collection.json file, this is an exploratory test via Postman, during the exploratory test some issue can be found already
#### 2. Design a test strategy for the application, create a checklist of potential test cases and prioritize them. 

   2.1 Features analyse: Creation payment; List payment; Convert payment; Delete payment; Basic Authentication  
   
   2.2 Test cases design:   
   
   2.2.1 Test suite Create payment: 
   * Create payment with user admin and password admin --> 200
   * Create payment with user admin and password wrong --> 403
   * Create payment with user john and password john --> 200
   * Create payment with user nonexsit and password nonexsit --> 403
   * Create payment with a payload missing amount --> 400
   * Create payment with a empty body --> 400
   * Create payment with a payload currency is not USD EUR GBP --> 400
   * Create payment with a payload amount is a sting --> 500
   * Create payment with a wrong path /finance/api/v1.0/pay --> 404

   2.2.2 Test suite Get payment: 
   * Get payment with user admin and password admin --> 200
   * Get payment with user admin and password wrong --> 403
   * Get payment with user john and password john --> 200
   * Get payment with user nonexsit and password nonexsit --> 403
   * Get payment with a wrong path /finance/api/v1.0/pay --> 404

   2.2.3 Test suite Convert payment: 
   * Convert payment with user admin and password admin --> 200
   * Convert payment with user admin and password wrong --> 403
   * Convert payment with user john and password john --> 200
   * Convert payment when non-euro payment are 0 --> 200 and processed payments is 0
   * Convert payment when non-euro payment are 1 --> 200 and processed payments is 1
   * Convert payment when non-euro payment are multiple --> 200 processed payments more than 1
   * Convert payment with a wrong path /finance/api/v1.0/pay --> 404

   2.2.4 Test suite Remove payment: 
   * Remove payment with user admin and password admin --> 200
   * Remove payment with user admin and password wrong --> 403
   * Remove payment with user john and password john --> 200
   * Remove payment when payment id is valid --> 200 and deleted is 1
   * Remove payment when payment id is invalid int --> 200 and deleted is 0
   * Remove payment when payment id is invalid string --> 404
   * Remove payment with a wrong path /finance/api/v1.0/pay --> 404

<h3><B>Test Automation</B></h3>    
   
#### 3. Automate test cases a)in Python: create test libraries,b)in Robot Framework: import these libraries and create test suites and test cases.

   _Note_: after each test consider to return the test target (app, data) into the same state.
   * Please check Test cases under ./Tests
   * The keyword Web App test case teardown call the function reset to drop tables and create new ones with data.
   
#### 4. Execute test cases locally using robot framework and from a docker container.      
   Please check the docker file ./Dockerfile.test

<h3><B>Test Report</B></h3>  
#### 5. Provide a test report generated by Robot Framework. What issues have been discovered and what defects would you submit?   
   5.1 Robot Test Report is available under ./report.html  
   5.2 Potential Bugs: The bugs are found according to the general feature logic, but not on the code level 
   * Normal user should not be able to create/convert/delete payment for the other user
   * Create payment with a non-exsitent currency should fail and get 400 error 

#### 6. The application uses SQLite database, but what will change in your code if it gets replaced with MySQL or MS SQL or Oracle?    
   6.1 Query should be updated because different databases have different syntax or datatype:   
   6.1.1 update with mssql query: please check ./Libraries/Database/db_mssql.py
   6.1.2 update with mysql query: please check ./Libraries/Database/db_mysql.py
   6.1.3 update with oracle query: as far as I remember oracle doesn't support 
   ```DROP TABLE IF EXISTS``` and oracle has very strict data type and expected values
   6.2 Python package per Database are different, and the way to interact with queries are a bit different
   6.3 In practical, Python 
   
#### 7. What would you improve in your approach and code if you have more time?     
   7.1 Implement Test Suite Setup to start flask app and Suite Teardown to stop flask app

