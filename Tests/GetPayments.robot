*** Settings ***
Documentation     Test suite to get payments
Resource          ../Keywords/GetPaymentsKeywords.robot
# Suite Setup             Web App Test Suite Setup
# Suite Teardown          Web App Test Suite Teardown

*** Test Cases ***
TestID_Get_Payments_Single_Defalt
    [Documentation]    Get Predifined Payment
    [Tags]    GetPayment Get
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    ${response}    When I get payments with    admin    admin
    Then Status Should Be    200    ${response}
    And Payment should contain purchase    ${response}    12345
