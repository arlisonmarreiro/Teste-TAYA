*** Settings ***
Documentation     This file contains login keywords for the application
Resource          ../../config/package.robot

*** Keywords ***

Selecionar Consorcio e escolher PJ ou PF
    Wait Until Element Is Visible      ${ConsorcioBtn}
    Click Element                      ${ConsorcioBtn}
    ${RANDOM_CONSORCIO_OPTION}=   Evaluate    random.choice(${opcoesPF&PJ})
    Set Suite Variable       ${RANDOM_CONSORCIO_OPTION}              
    Click Element            ${RANDOM_CONSORCIO_OPTION}

Verificar se o formulário de Consórcio é exibido  
    Wait Until Element Is Visible        ${dataNascimentoInput}

Selecionar tipo de bem
    ${RANDOM_BEM_OPTION}=   Evaluate    random.choice(${bens})
    Set Suite Variable       ${RANDOM_BEM_OPTION}              
    Click Element            ${RANDOM_BEM_OPTION}   

Preencher os campos - Consórcio
    # Data de Nascimento
    ${ano_atual}=    Evaluate    2024
    ${idade_minima}=    Evaluate    18
    ${idade_maxima}=    Evaluate    70
    ${ano_nascimento}=    Evaluate    ${ano_atual} - random.randint(${idade_minima}, ${idade_maxima})    modules=random
    ${mes_nascimento}=    Evaluate    random.randint(1, 12)    modules=random
    ${dia_nascimento}=    Evaluate    random.randint(1, 28)    modules=random
    ${data_nascimento}=    Evaluate    "{:02d}/{:02d}/{}".format(${dia_nascimento}, ${mes_nascimento}, ${ano_nascimento})
    Input Text    ${dataNascimentoInput}    ${data_nascimento}
    Set Suite Variable    ${data_nascimento}
    ${idade_atual}=    Evaluate    ${ano_atual} - ${ano_nascimento}
    # Valor do Bem
    ${valor_bem}=    Evaluate    random.randint(100000, 1000000)    modules=random
    Input Text    ${valorDoBem}    ${valor_bem}    
    Set Suite Variable    ${valor_bem}
    # Valor do Crédito
    ${percentual_minimo}=   Set Variable  0.50
    ${percentual_maximo}=   Set Variable  1.00
    ${valor_minimo_credito}=    Evaluate    int(${valor_bem} * ${percentual_minimo})
    ${valor_maximo_credito}=    Evaluate    int(${valor_bem} * ${percentual_maximo})
    Set Suite Variable    ${valor_minimo_credito}
    Set Suite Variable    ${valor_maximo_credito}
    # Valor do Crédito (dentro do limite de 100%)
    ${valor_credito}=    Evaluate    random.randint(${valor_minimo_credito}, ${valor_maximo_credito})    modules=random
    Input Text   ${valorDoCredito}    ${valor_credito}
    Set Suite Variable    ${valor_credito}
    # Prazo de Pagamento
    # O prazo máximo para consórcio é de 240 meses
    ${prazo_maximo_consorcio}=   Set Variable  240
    ${prazo_consorcio}=    Evaluate    random.randint(12, ${prazo_maximo_consorcio})    modules=random
    Input Text    ${prazoPagamento}    ${prazo_consorcio}
    Set Suite Variable    ${prazo_consorcio}
    Set Suite Variable    ${prazo_maximo_consorcio}
    Capture Page Screenshot     

Validar os resultados do cálculo - Consorcio
    # Aguardar o elemento e capturar valores exibidos (considerando o bug de nomenclatura)
    Wait Until Element Is Visible   xpath=//div[contains(text(), "Valor do Imóvel")]/following-sibling::div

    ${valor_bem_exibido}=           Get Text    xpath=//div[contains(text(), "Valor do Imóvel")]/following-sibling::div
    ${valor_credito_exibido}=       Get Text    xpath=//div[contains(text(), "Valor do Financiamento")]/following-sibling::div
    ${prazo_exibido}=               Get Text    xpath=//div[contains(text(), "Prazo")]/following-sibling::div
    # Formatar os valores inseridos para comparação
    ${valor_bem_formatado}=         Evaluate    "R$ {:,.2f}".format(${valor_bem}).replace(',', 'X').replace('.', ',').replace('X', '.')
    ${valor_credito_formatado}=     Evaluate    "R$ {:,.2f}".format(${valor_credito}).replace(',', 'X').replace('.', ',').replace('X', '.')
    ${prazo_formatado}=             Evaluate    "{} meses".format(${prazo_consorcio})
    # Validar que os valores exibidos são os mesmos inseridos
    Should Be Equal As Strings      ${valor_bem_exibido}    ${valor_bem_formatado}    "Valor do Bem não confere"
    Should Be Equal As Strings      ${valor_credito_exibido}    ${valor_credito_formatado}    "Valor do Crédito não confere"
    Should Be Equal As Strings      ${prazo_exibido}    ${prazo_formatado}    "Prazo não confere"
    Capture Page Screenshot