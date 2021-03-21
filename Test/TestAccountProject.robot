*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Library         RequestsLibrary
Library           OperatingSystem
Library           JSONLibrary
Library           Collections

*** Variables ***
${Base_URL}  http://localhost:8080/jakarta-ee-getting-started
${id}  4


*** Test Cases ***   
RestGetTest
    Create Session    get_accounts               ${Base_URL}
    ${response}=   GET On Session     get_accounts      rest/accountHolders
    log to console   ${response.status_code}
    log to console   ${response.content}
    log to console   ${response.headers}
    #Validation
    Status Should Be  200    ${response}  
    ${body}=  convert to string   ${response.content}
    Should Contain    ${body}    Masa   
    ${contentTypeValue}=   get from dictionary    ${response.headers}   Content-Type
    Should Be Equal    ${contentTypeValue}    application/json 
RestGet2Test
    Create Session    get_userAccount               ${Base_URL}
    ${response}=   GET On Session     get_userAccount        rest/accountHolders/${id}
    log to console   ${response.status_code}
    log to console   ${response.content}
    log to console   ${response.headers}
    #Validation
    Status Should Be  200    ${response}   
    ${body}=  convert to string   ${response.content}
    Should Contain    ${body}    Masa  
    ${contentTypeValue}=   get from dictionary    ${response.headers}   Content-Type
    Should Be Equal    ${contentTypeValue}    application/json   
RestPostTest
     Create Session    add_account               ${Base_URL}
     &{data}=          Create dictionary  id=200  firstName=Maya  lastName=Mohsin  balance=400
     ${response}=          POST On Session    add_account     rest/accountHolders    json=${data}
     Status Should Be  201    ${response}
     Dictionary Should Contain Key        ${response.json()}     id
RestPutTest
     Create Session    update_account               ${Base_URL}
     &{data}=          Create dictionary  id=4  firstName=Masa  lastName=Shabib  balance=100
     ${response}=          PUT On Session    update_account     rest/accountHolders/${id}    json=${data}
     Status Should Be  201    ${response}
RestDeleteTest
     Create Session    delete_account               ${Base_URL}
     ${response}=          Delete On Session    delete_account     rest/accountHolders/${id}    
     Status Should Be  200    ${response}
    
