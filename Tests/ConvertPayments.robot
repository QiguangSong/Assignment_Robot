*** Settings ***
Documentation     Test suite to Convert payments
Resource          ../Keywords/CommonKeywords.robot
# Suite Setup             Web App Test Suite Setup
# Suite Teardown          Web App Test Suite Teardown

*** Test Cases ***
TestID_Convert_Payments_With_Admin_GBP
    [Documentation]    Convert payment with admin user
    [Tags]    ConvertPayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I convert payments with    admin    admin
    Then Status Should Be    200    ${response}
    And Should Be Equal As Integers  ${response.json()['processed']}    1
    ${response}   Then I get payments with    admin    admin
    Payment should contain currency   ${response}    EUR
    Payment should not contain currency   ${response}    GBP

TestID_Convert_Payments_With_Admin_USD
    [Documentation]    Convert payment with admin user
    [Tags]    ConvertPayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=USD  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I convert payments with    admin    admin
    Then Status Should Be    200    ${response}
    And Should Be Equal As Integers  ${response.json()['processed']}    1
    ${response}   Then I get payments with    admin    admin
    Payment should contain currency   ${response}    EUR
    Payment should not contain currency   ${response}    USD

TestID_Convert_Payments_With_Admin_USD_GBP
    [Documentation]    Convert payment with admin user
    [Tags]    ConvertPayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=USD  completed=2
    When I create payments with    admin    admin    ${body}
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=GBP  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I convert payments with    admin    admin
    Then Status Should Be    200    ${response}
    And Should Be Equal As Integers  ${response.json()['processed']}    2
    ${response}   Then I get payments with    admin    admin
    Payment should contain currency   ${response}    EUR
    Payment should not contain currency   ${response}    USD
    Payment should not contain currency   ${response}    GBP

TestID_Convert_Payments_With_Wrong_Password
    [Documentation]    Convert payment with admin user wrong password
    [Tags]    ConvertPayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=USD  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I convert payments with    admin    song
    Then Status Should Be    403    ${response}

TestID_Convert_Payments_With_Normal_User
    [Documentation]    Convert payment with admin user wrong password
    [Tags]    ConvertPayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=USD  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I convert payments with    john    john
    Then Status Should Be    403    ${response}

TestID_Convert_Payments_With_Wrong_Path
    [Documentation]    Convert payment with admin user wrong password
    [Tags]    ConvertPayment Post
#    [Setup]    Web App test case setup
    [Teardown]    Web App test case teardown
    &{body}=      Create Dictionary      purchase=1001  user=john  amount=9000  currency=USD  completed=2
    When I create payments with    admin    admin    ${body}
    ${response}   Then I convert payments with    john    john    finance/api/v1.0/pay
    Then Status Should Be    404    ${response}
