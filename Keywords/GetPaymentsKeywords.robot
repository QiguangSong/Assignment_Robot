*** Settings ***
Documentation     get payment keywords
Resource          ../Keywords/CommonKeywords.robot

*** Variables ***


*** Keywords ***
I get payments with
    [Arguments]    ${user}  ${passwd}
    [Documentation]    Get payment with user credentials
    ${auth}=  Create List  ${user}  ${passwd}
    Create Session  paymentsession  ${URL}  verify=true   auth=${auth}
    ${response}=  Get Request  paymentsession  finance/api/v1.0/payments
    [Return]    ${response}


Payment should contain purchase
    [Arguments]    ${payment}    ${purchase}
    [Documentation]    Payment should contain specific purchase ID
    ${PaymentLength}=   Get Length	    ${payment.json()['payments'][0]}
    Should Be Equal As Integers  ${PaymentLength}  6
    ${titleFromList}=  Get From List   ${payment.json()['payments'][0]}   1
    Should Be Equal As Integers  ${titleFromList}  ${purchase}
