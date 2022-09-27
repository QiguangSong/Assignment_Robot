*** Settings ***
Documentation     Test suite to Romove payments
Resource          ../Keywords/CommonKeywords.robot
# Suite Setup             Web App Test Suite Setup
# Suite Teardown          Web App Test Suite Teardown

*** Test Cases ***
TestID_Remove_Payments_With_Admin
    [Documentation]    Remove payment with admin user
    [Tags]    RemovePayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I remove payments with    admin    admin    1
    Then Status Should Be    200    ${response}
    And Should Be Equal As Integers  ${response.json()['deleted']}    1

TestID_Remove_Payments_With_Admin_Wrong_Password
    [Documentation]    Remove payment with admin user
    [Tags]    RemovePayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I remove payments with    admin    song    1
    Then Status Should Be    403    ${response}

TestID_Remove_Payments_With_Normal_User
    [Documentation]    Remove payment with admin user
    [Tags]    RemovePayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I remove payments with    john    john    1
    Then Status Should Be    403    ${response}

TestID_Remove_Payments_With_Non_Exsitent_PaymentID
    [Documentation]    Remove payment with admin user
    [Tags]    RemovePayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I remove payments with    admin    admin    99
    Then Status Should Be    200    ${response}
    And Should Be Equal As Integers  ${response.json()['deleted']}    0
