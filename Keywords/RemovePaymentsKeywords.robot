*** Settings ***
Documentation     remove payment keywords
Resource          ../Keywords/CommonKeywords.robot

*** Variables ***


*** Keywords ***
I remove payments with
    [Arguments]    ${user}  ${passwd}    ${id}    ${route}=finance/api/v1.0/payments/
    [Documentation]    remove payment with user credentials
    ${auth}=  Create List  ${user}  ${passwd}
    Create Session  paymentsession  ${URL}  verify=true   auth=${auth}
    ${response}=  Delete Request  paymentsession    ${route}${id}
    [Return]    ${response}


