*** Settings ***
Documentation     create payment keywords
Resource          ../Keywords/CommonKeywords.robot

*** Variables ***


*** Keywords ***
I create payments with
    [Arguments]    ${user}  ${passwd}    ${body}    ${route}=finance/api/v1.0/payments
    [Documentation]    Create payment with user credentials
    ${auth}=  Create List  ${user}  ${passwd}
    Create Session  paymentsession  ${URL}  verify=true   auth=${auth}
    ${response}=  Put Request  paymentsession    ${route}    json=${body}
    [Return]    ${response}


