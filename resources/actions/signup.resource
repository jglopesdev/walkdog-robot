*** Settings ***
Documentation        Ações, steps e elementos da funcionalidade de cadastro

Library        Browser

*** Keywords ***
Go to signup page
    Click    css=a[href="/signup"]

    Wait For Elements State    form h1    visible    5000
    Get Text                   form h1    equal      Faça seu cadastro

Fill signup form
    [Arguments]      ${dog_walker}    
    Fill Text        css=input[name=name]           ${dog_walker}[name]
    Fill Text        css=input[name=email]          ${dog_walker}[email]
    Fill Text        css=input[name=cpf]            ${dog_walker}[cpf]
    Fill Text        css=input[name=cep]            ${dog_walker}[cep]

    Click            css=input[type=button][value$=CEP]
    
    Get Property     css=input[name=addressStreet]      value    equal    ${dog_walker}[street]
    Get Property     css=input[name=addressDistrict]    value    equal    ${dog_walker}[district]
    Get Property     css=input[name=addressCityUf]      value    equal    ${dog_walker}[city_uf]

    Fill Text        css=input[name=addressNumber]        ${dog_walker}[number]
    Fill Text        css=input[name=addressDetails]       ${dog_walker}[details]

    Upload File By Selector    css=input[type=file]    ${EXECDIR}/resources/fixtures/${dog_walker}[cnh]

Additional Service
    [Arguments]        ${additional_service}
    Click        xpath=//span[text()="${additional_service}"]/..    
    
Submit signup form
    Click            css=.button-register
    
Popup should be
    [Arguments]      ${expected_text}
    Wait For Elements State    css=.swal2-html-container    visible    5
    Get Text                   css=.swal2-html-container    equal      ${expected_text}

Alert should be
    [Arguments]      ${expected_text}
    Wait For Elements State    css=.alert-error >> text=${expected_text}    visible    5
