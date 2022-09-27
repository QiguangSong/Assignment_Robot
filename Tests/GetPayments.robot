*** Settings ***
Documentation     Test suite to get payments
Resource          ../Keywords/GetPaymentsKeywords.robot
# Suite Setup             Web App Test Suite Setup
# Suite Teardown          Web App Test Suite Teardown

*** Test Cases ***
TestID_Get_Payments_Single_Defalt_With_Admin
    [Documentation]    Get Predifined Payment
    [Tags]    GetPayment Get
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    ${response}    When I get payments with    admin    admin
    Then Status Should Be    200    ${response}
    And Payment should contain purchase    ${response}    12345

TestID_Get_Payments_Wrong_Password
    [Documentation]    Get Predifined Payment with wrong password
    [Tags]    GetPayment Get
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    ${response}    When I get payments with    admin    john
    Then Status Should Be    403    ${response}

TestID_Get_Payments_With_Normal_User
    [Documentation]    Get Payment with normal user
    [Tags]    GetPayment Get
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    ${response}    When I get payments with    john    john
    Then Status Should Be    200    ${response}
    And Payment should contain purchase    ${response}    12345

TestID_Get_Payments_With_Non_User
    [Documentation]    Get payment with non exsitent user
    [Tags]    GetPayment Get
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    ${response}    When I get payments with    song    song
    Then Status Should Be    403    ${response}

TestID_Get_Payments_With_Wrong_Route
    [Documentation]    Get payment with a wrong route
    [Tags]    GetPayment Get
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    ${response}    When I get payments with    song    song    finance/api/v1.0/pay
    Then Status Should Be    404    ${response}

