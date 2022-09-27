*** Settings ***
Documentation     convert payment keywords
Resource          ../Keywords/CommonKeywords.robot

*** Variables ***


*** Keywords ***
I convert payments with
    [Arguments]    ${user}  ${passwd}    ${route}=finance/api/v1.0/payments
    [Documentation]    Convert payment with user credentials
    ${auth}=  Create List  ${user}  ${passwd}
    Create Session  paymentsession  ${URL}  verify=true   auth=${auth}
    ${response}=  Post Request  paymentsession    ${route}
    [Return]    ${response}


