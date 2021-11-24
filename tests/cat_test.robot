*** Settings ***
Library    RequestsLibrary

*** Variables ***
${base_URL}     http://3.80.130.41:8000
${spartans}    /api/spartans/


*** Test Cases ***
TC1_Get_Return_All_Spartans
    RequestsLibrary.Create Session     baseURI       ${base_URL}
    ${response}=     GET On Session    baseURI    ${spartans}

    log to console    ${response.status_code}
    log to console    ${response.content}
    log to console    ${response.headers}

    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}   200

TC1_Get_Add_New_Spartan
    create session    baseURI   ${base_URL}
    ${body}=    create dictionary        id: 111       name: Zagor    gender: Male   phone: 587964130123
    ${header}=  create dictionary    Content-Type=application/json
    ${response}=    post request    baseURI       ${spartans}   data=${body}    headers=${header}

    log to console    ${response.status_code}
    log to console    ${response.content}

    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}   200