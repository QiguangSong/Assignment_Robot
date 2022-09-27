*** Settings ***
Documentation     get payment keywords
Resource          ../Keywords/CommonKeywords.robot

*** Variables ***


*** Keywords ***
I get payments with
    [Arguments]    ${user}  ${passwd}    ${route}=finance/api/v1.0/payments
    [Documentation]    Get payment with user credentials
    ${auth}=  Create List  ${user}  ${passwd}
    Create Session  paymentsession  ${URL}  verify=true   auth=${auth}
    ${response}=  Get Request  paymentsession    ${route}
    [Return]    ${response}


Payment should contain purchase
    [Arguments]    ${payment}    ${purchase}
    [Documentation]    Payment should contain specific purchase ID
    ${PaymentLength}=   Get Length	    ${payment.json()['payments'][-1]}
    Should Be Equal As Integers  ${PaymentLength}  6
    ${titleFromList}=  Get From List   ${payment.json()['payments'][-1]}   1
    Should Be Equal As Integers  ${titleFromList}  ${purchase}