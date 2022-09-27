*** Settings ***
Library               Collections
Library               RequestsLibrary
Library               json
Library               requests
Library               Process
Library               ../Libraries/Database/db_sqlite.py
Resource              ../Keywords/CreatePaymentsKeywords.robot
Resource              ../Keywords/GetPaymentsKeywords.robot
Resource              ../Keywords/ConvertPaymentsKeywords.robot
Resource              ../Keywords/RemovePaymentsKeywords.robot

*** Variables ***
${URL}=   http://127.0.0.1:5000


*** Keywords ***
Web App test case setup
    [Documentation]    Web App test case setup


Web App test case teardown
    [Documentation]    Web App test case teardown
    reset