*** Settings ***
Documentation     This file contains testcases for the application
Resource          ../../config/package.robot
Test Setup       Open Page
Test Teardown    Close Page

*** Test Cases ***

Caso de Teste 1: Selecionar Empréstimo com Garantia Imóvel e verificar o carregamento do formulário
    [Documentation]    Verificar se a opção "Empréstimo com Garantia Imóvel" carrega o formulário correto.
    [Tags]             verificarFormularioEmprestimo
    Acessar a URL da calculadora
    Selecionar Empréstimo com Garantia Imóvel e escolher PJ ou PF
    Clicar em Próxima Etapa
    Verificar se o formulário de Empréstimo com Garantia Imóvel é exibido  

Caso de Teste 2: Preencher o formulário de Empréstimo com Garantia Imóvel e realizar o cálculo
    [Documentation]    Preencher o formulário para PF e realizar o cálculo.
    [Tags]             preencherFormularioEmprestimo
    Acessar a URL da calculadora
    Selecionar Empréstimo com Garantia Imóvel e escolher PJ ou PF
    Clicar em Próxima Etapa
    Verificar se o formulário de Empréstimo com Garantia Imóvel é exibido  
    Selecionar Tipo do Imóvel (Residencial ou Comercial)
    Preencher os campos - Empréstimo
    Clicar em Calcular
    Validar os resultados do cálculo - Empréstimo

Caso de Teste 3: Verificar validação de campos obrigatórios no formulário de Empréstimo com Garantia Imóvel
    [Documentation]    Testar a validação do formulário ao deixar campos obrigatórios em branco.
    [Tags]             validarCamposEmprestimo
    Acessar a URL da calculadora
    Selecionar Empréstimo com Garantia Imóvel e escolher PJ ou PF
    Clicar em Próxima Etapa
    Verificar se o formulário de Empréstimo com Garantia Imóvel é exibido  
    Selecionar Tipo do Imóvel (Residencial ou Comercial) 
    Clicar em Calcular
    Verificar se mensagens de erro são exibidas       