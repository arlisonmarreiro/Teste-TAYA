*** Settings ***
Documentation     This file contains login keywords for the application
Resource          ../../config/package.robot

*** Keywords ***

Acessar a URL da calculadora
    Wait Until Element Is Visible        ${aquisiçãoImovelBtn}

Selecionar Aquisição de Imóvel
    Click Element                        ${aquisiçãoImovelBtn}

Clicar em Próxima Etapa
    Click Element                        ${proximaEtapaBtn}

Verificar se o formulário de Aquisição de Imóvel é exibido com os campos adequados.
    Wait Until Element Is Visible        ${dataNascimentoInput}
    Capture Page Screenshot

Selecionar Tipo do Imóvel (Residencial ou Comercial)
    ${RANDOM_IMOVEL_OPTION}=   Evaluate    random.choice(${imoveis})
    Set Suite Variable       ${RANDOM_IMOVEL_OPTION}              
    Click Element            ${RANDOM_IMOVEL_OPTION}


Preencher os campos - Aquisição
    # Data nascimento
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
    # Valor do Imóvel
    ${valor_imovel}=    Evaluate    random.randint(100000, 1000000)    modules=random
    Input Text    ${valorImovelInput}    ${valor_imovel}    
    Set Suite Variable    ${valor_imovel}      
    # Valor do Financiamento
    ${percentual_minimo}=   Set Variable  0.70
    ${percentual_maximo}=  Set Variable  0.80
    ${valor_minimo_financiamento}=    Evaluate    int(${valor_imovel} * ${percentual_minimo})
    ${valor_maximo_financiamento}=    Evaluate    int(${valor_imovel} * ${percentual_maximo})
    Set Suite Variable    ${valor_minimo_financiamento}
    Set Suite Variable    ${valor_maximo_financiamento}
    # Valor do Financiamento (dentro do limite de 85%)
    ${valor_financiamento}=    Evaluate    random.randint(${valor_minimo_financiamento}, ${valor_maximo_financiamento})    modules=random
    Input Text   ${valorFinanciamentoInput}    ${valor_financiamento}
    Set Suite Variable    ${valor_financiamento}
    Set Suite Variable    ${valor_financiamento}
    # Prazo de Financiamento
    # Calcular o prazo máximo permitido com base na idade e o limite de 80 anos e 6 meses
    ${limite_idade_em_meses}=   Set Variable  966    # 80 anos e 6 meses em meses
    ${prazo_maximo_por_idade}=    Evaluate    ${limite_idade_em_meses} - (${idade_atual} * 12)
    ${prazo_maximo_permitido}=    Evaluate    min(420, ${prazo_maximo_por_idade})    # Limite máximo de 420 meses
    ${prazo_financiamento}=    Evaluate    random.randint(12, ${prazo_maximo_permitido})    modules=random
    Input Text    ${prazoFinanciamentoInput}    ${prazo_financiamento}
    Set Suite Variable    ${prazo_financiamento}
    Set Suite Variable    ${prazo_maximo_permitido}
    Capture Page Screenshot

Ativar/desativar a opção de financiar despesas
    ${aleatorio}=    Evaluate    random.randint(0, 1)    modules=random
    Run Keyword If    '${aleatorio}' == '1'    Click Element    ${financiarCheckBox}
    ${estado}=    Get Element Attribute    ${financiarCheckBox}    checked
    Log    Estado do checkbox: ${estado}
    Capture Page Screenshot

Clicar em Calcular
    Click Element        ${calcularBtn} 

Validar os resultados do cálculo - Aquisição
    Wait Until Element Is Visible   xpath=//div[contains(text(), "Valor do Imóvel")]/following-sibling::div
    ${valor_imovel_exibido}=    Get Text    xpath=//div[contains(text(), "Valor do Imóvel")]/following-sibling::div
    ${valor_financiamento_exibido}=    Get Text    xpath=//div[contains(text(), "Valor do Financiamento")]/following-sibling::div
    ${prazo_exibido}=    Get Text    xpath=//div[contains(text(), "Prazo")]/following-sibling::div
    ${prazo_exibido_num}=    Evaluate    int(re.sub(r'[^0-9]', '', "${prazo_exibido}"))    modules=re
    ${prazo_financiamento}=    Convert To Integer    ${prazo_financiamento}
    ${data_nascimento_exibida}=    Get Text    xpath=//div[contains(text(), "Data de Nascimento")]/following-sibling::div

    # # Formatar os valores para comparação
    ${valor_imovel_formatado}=    Evaluate    "R$ {:,.2f}".format(${valor_imovel}).replace(',', 'X').replace('.', ',').replace('X', '.')
    ${valor_financiamento_exibido_num}=    Evaluate    float(re.sub(r'[^0-9,]', '', "${valor_financiamento_exibido}").replace(",", "."))    modules=re

    # # Validar os valores
    Should Be Equal As Strings    ${valor_imovel_exibido}    ${valor_imovel_formatado}    Valor do Imóvel não confere
    #Should Be True    ${valor_minimo_financiamento} <= ${valor_financiamento_exibido_num} <= ${valor_maximo_financiamento}    "Valor do Financiamento ajustado está fora do intervalo esperado"
    Log    ${prazo_exibido}
    Log    ${prazo_financiamento}
    Should Be Equal As Numbers    ${prazo_exibido_num}    ${prazo_financiamento}    "O prazo exibido não corresponde ao prazo de financiamento esperado"
    Should Be Equal As Strings    ${data_nascimento_exibida}    ${data_nascimento}    Data de Nascimento não confere
    # Capture Page Screenshot

Verificar se mensagens de erro são exibidas
    Element Should Be Visible     ${campoObrigatorioMsg}
    Capture Page Screenshot