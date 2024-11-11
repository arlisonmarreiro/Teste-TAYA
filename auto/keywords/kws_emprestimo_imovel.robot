*** Settings ***
Documentation     This file contains login keywords for the application
Resource          ../../config/package.robot

*** Keywords ***

Selecionar Empréstimo com Garantia Imóvel e escolher PJ ou PF
    Wait Until Element Is Visible      ${EmprestimoBtn}
    Click Element                      ${EmprestimoBtn}
    ${RANDOM_EMPRESTIMO_OPTION}=   Evaluate    random.choice(${opcoesPF&PJ})
    Set Suite Variable       ${RANDOM_EMPRESTIMO_OPTION}              
    Click Element            ${RANDOM_EMPRESTIMO_OPTION}

Verificar se o formulário de Empréstimo com Garantia Imóvel é exibido  
    Wait Until Element Is Visible        ${dataNascimentoInput}

Preencher os campos - Empréstimo
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

    # Valor do Imóvel
    ${valor_imovel}=    Evaluate    random.randint(100000, 1000000)    modules=random
    Input Text    ${valorImovelInput}    ${valor_imovel}    
    Set Suite Variable    ${valor_imovel}
    # Valor do Empréstimo
    ${percentual_minimo}=   Set Variable  0.50
    ${percentual_maximo}=   Set Variable  0.60
    ${valor_minimo_emprestimo}=    Evaluate    int(${valor_imovel} * ${percentual_minimo})
    ${valor_maximo_emprestimo}=    Evaluate    int(${valor_imovel} * ${percentual_maximo})
    Set Suite Variable    ${valor_minimo_emprestimo}
    Set Suite Variable    ${valor_maximo_emprestimo}
    # Valor do Empréstimo (dentro do limite de 60%)
    ${valor_emprestimo}=    Evaluate    random.randint(${valor_minimo_emprestimo}, ${valor_maximo_emprestimo})    modules=random
    Input Text   ${valorEmprestimoInput}    ${valor_emprestimo}
    Set Suite Variable    ${valor_emprestimo}
    # Prazo de Pagamento
    # O prazo máximo para empréstimo é de 240 meses
    ${prazo_maximo_emprestimo}=   Set Variable  240
    ${prazo_emprestimo}=    Evaluate    random.randint(12, ${prazo_maximo_emprestimo})    modules=random
    Input Text    ${prazoPagamentoInput}    ${prazo_emprestimo}
    Set Suite Variable    ${prazo_emprestimo}
    Set Suite Variable    ${prazo_maximo_emprestimo}
    #Checkboxs
    ${aleatorio}=    Evaluate    random.randint(0, 1)    modules=random
    Run Keyword If    '${aleatorio}' == '1'    Click Element    ${financiarIofCheckbox}
    ${estado_iof}=    Get Element Attribute    ${financiarIofCheckbox}    checked
    # Checkbox para Financiar Tarifa de Avaliação
    ${aleatorio}=    Evaluate    random.randint(0, 1)    modules=random
    Run Keyword If    '${aleatorio}' == '1'    Click Element    ${financiarTarifaAvaliacaoCheckbox}
    ${estado_tarifa_avaliacao}=    Get Element Attribute    ${financiarTarifaAvaliacaoCheckbox}    checked
    # Checkbox para Financiar Emissão de Contrato
    ${aleatorio}=    Evaluate    random.randint(0, 1)    modules=random
    Run Keyword If    '${aleatorio}' == '1'    Click Element    ${financiarEmissaoContrato}
    ${estado_emissao_contrato}=    Get Element Attribute    ${financiarEmissaoContrato}    checked
   
Validar os resultados do cálculo - Empréstimo
    Wait Until Element Is Visible   xpath=//div[contains(text(), "Valor do Imóvel")]/following-sibling::div

    # Capturar valores exibidos
    ${valor_imovel_exibido}=    Get Text    xpath=//div[contains(text(), "Valor do Imóvel")]/following-sibling::div
    ${valor_emprestimo_exibido}=    Get Text    xpath=//div[contains(text(), "Valor do Empréstimo")]/following-sibling::div
    ${prazo_exibido}=    Get Text    xpath=//div[contains(text(), "Prazo")]/following-sibling::div

    # Formatar os valores inseridos para comparação
    ${valor_imovel_formatado}=    Evaluate    "R$ {:,.2f}".format(${valor_imovel}).replace(',', 'X').replace('.', ',').replace('X', '.')
    ${prazo_formatado}=    Evaluate    "{} meses".format(${prazo_emprestimo})

    # Validar os valores exibidos são os mesmos inseridos
    Should Be Equal As Strings    ${valor_imovel_exibido}    ${valor_imovel_formatado}    Valor do Imóvel não confere
    Should Be Equal As Strings    ${prazo_exibido}    ${prazo_formatado}    Prazo não confere
    Capture Page Screenshot




