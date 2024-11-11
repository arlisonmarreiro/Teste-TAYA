*** Settings ***
Documentation     This file contains testcases for the application
Resource          ../../config/package.robot
Test Setup       Open Page
Test Teardown    Close Page

*** Test Cases ***

Caso de Teste 1: Selecionar Consórcio e verificar o carregamento do formulário
    [Documentation]    Verificar se a opção "Consórcio" carrega o formulário correto.
    [Tags]             verificarFormularioConsorcio
    Acessar a URL da calculadora
    Selecionar Consorcio e escolher PJ ou PF
    Clicar em Próxima Etapa
    Verificar se o formulário de Consórcio é exibido

Caso de Teste 2: Preencher o formulário de Consórcio e realizar o cálculo
    [Documentation]    Preencher o formulário e calcular o valor do crédito.
    [Tags]             preencherFormularioConsorcio
    Acessar a URL da calculadora
    Selecionar Consorcio e escolher PJ ou PF
    Clicar em Próxima Etapa
    Verificar se o formulário de Consórcio é exibido
    Selecionar tipo de bem
    Preencher os campos - Consórcio
    Clicar em Calcular    
    Validar os resultados do cálculo - Consorcio

Caso de Teste 3: Verificar validação de campos obrigatórios no formulário de Consórcio
    [Documentation]    Testar a validação do formulário ao deixar campos obrigatórios em branco.
    [Tags]             validarCamposConsorcio
    Acessar a URL da calculadora
    Selecionar Consorcio e escolher PJ ou PF
    Clicar em Próxima Etapa
    Verificar se o formulário de Consórcio é exibido
    Selecionar tipo de bem    
    Clicar em Calcular      
    Verificar se mensagens de erro são exibidas           