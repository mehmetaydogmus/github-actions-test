*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections
Suite Setup    Create Session  jsonplaceholder  https://jsonplaceholder.typicode.com


*** Variables ***
${base_URL}    http://dummy.restapiexample.com/api/v1
${Servicename}    /create
${sample_body}    {"name":"test","salary":"123","age":"23"}

*** Test Cases ***
PostRequest
    RequestsLibrary.Create Session     baseURI       ${base_URL}
    &{body}=    Create Dictionary    name=priya salary=00 age=16
    &{headers}=    Create Dictionary    content-type=application/json
    ${response}=    RequestsLibrary.Post Request    baseURI    ${Servicename}    data=${body}    headers=${headers}
    Log To Console    ${response}
    Log To Console    ${response.status_code}

Response Validation
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1      Should Be Equal As Strings    1

Quick Get Request Test
    ${response}=    GET  https://www.google.com
    Status Should Be  201

Quick Get Request With Parameters Test
    ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200Quick Get A JSON Body Test
    ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1    Should Be Equal As Strings    1  ${response.json()}[id]

Post Request Test
    &{data}=    Create dictionary  title=Robotframework requests  body=This is a test!  userId=1
    ${resp}=    POST On Session    jsonplaceholder  /posts  json=${data}  expected_status=anything
    Status Should Be                 201  ${resp}

Post Normal Request Test
    &{data}=    Create dictionary  A=Robotframework requests  B=This is a test!    C=1
    ${resp}=    POST    https://jsonplaceholder.typicode.com/posts  json=${data}  expected_status=201
    Status Should Be                 201  ${resp}
