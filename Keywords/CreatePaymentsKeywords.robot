*** Settings ***
Documentation     Test suite to create payments
Resource          ../Keywords/CommonKeywords.robot
# Suite Setup             Web App Test Suite Setup
# Suite Teardown          Web App Test Suite Teardown

*** Test Cases ***
TestID_Create_Payments_Single_With_Admin
    [Documentation]    Create payment with admin user
    [Tags]    CreatePayment Get
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    ${response}    When I create payments with    admin    admin
    Then Status Should Be    200    ${response}
    And Payment should contain purchase    ${response}    12345
