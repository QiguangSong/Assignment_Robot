*** Settings ***
Documentation     Test suite to create payments
Resource          ../Keywords/CommonKeywords.robot
# Suite Setup             Web App Test Suite Setup
# Suite Teardown          Web App Test Suite Teardown

*** Test Cases ***
TestID_Create_Payments_Single_With_Admin
    [Documentation]    Create payment with admin user
    [Tags]    CreatePayment PUT
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    ${response}   When I create payments with    admin    admin    ${body}
    Then Status Should Be    200    ${response}
    And Should Be Equal As Integers  ${response.json()['created']}    1
    ${response}    Then I get payments with    admin    admin
    And Status Should Be    200    ${response}
    And Payment should contain purchase    ${response}    1001

TestID_Create_Payments_Single_With_Wrong_Password
    [Documentation]    Create payment with admin user wrong password
    [Tags]    CreatePayment PUT
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    ${response}   When I create payments with    admin    song    ${body}
    Then Status Should Be    403    ${response}

TestID_Create_Payments_Single_With_John
    [Documentation]    Create payment with john user
    [Tags]    CreatePayment PUT
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    ${response}   When I create payments with    song    song    ${body}
    Then Status Should Be    403    ${response}

TestID_Create_Payments_Single_With_Non_User
    [Documentation]    Create payment with Non exsitent user
    [Tags]    CreatePayment PUT
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    ${response}   When I create payments with    song    song    ${body}
    Then Status Should Be    403    ${response}

TestID_Create_Payments_Single_With_Missing_Amount
    [Documentation]    Create payment with missing amount
    [Tags]    CreatePayment PUT
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  currency=GBP  completed=2
    ${response}   When I create payments with    admin    admin    ${body}
    Then Status Should Be    400    ${response}

TestID_Create_Payments_Single_With_Empty_Body
    [Documentation]    Create payment with empty Body
    [Tags]    CreatePayment PUT
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary
    ${response}   When I create payments with    admin    admin    ${body}
    Then Status Should Be    400    ${response}

TestID_Create_Payments_Single_With_Wrong_Currency
    [Documentation]    Create payment with wrong currency
    [Tags]    CreatePayment PUT
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=RMB  completed=2
    ${response}   When I create payments with    admin    admin    ${body}
    Then Status Should Be    400    ${response}

TestID_Create_Payments_Single_With_Amount_String
    [Documentation]    Create payment with amount sting
    [Tags]    CreatePayment PUT
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=abc  currency=RMB  completed=2
    ${response}   When I create payments with    admin    admin    ${body}
    Then Status Should Be    500    ${response}

TestID_Create_Payments_Single_With_Wrong_Path
    [Documentation]    Create payment with amount sting
    [Tags]    CreatePayment PUT
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=100  currency=RMB  completed=2
    ${response}   When I create payments with    admin    admin    ${body}    finance/api/v1.0/payme
    Then Status Should Be    404    ${response}

