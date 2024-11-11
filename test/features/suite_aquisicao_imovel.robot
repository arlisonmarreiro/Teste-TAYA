*** Settings ***
Documentation     This file contains testcases for the application
Resource          ../../config/package.robot
Test Setup       Open Page
Test Teardown    Close Page

*** Test Cases ***

Caso de Teste 1: Selecionar Aquisição de Imóvel e verificar o carregamento do formulário
    [Documentation]    Verificar se a opção "Aquisição de Imóvel" carrega o formulário correto.
    [Tags]             verificarFormularioAquisicao
    Acessar a URL da calculadora
    Selecionar Aquisição de Imóvel
    Clicar em Próxima Etapa
    Verificar se o formulário de Aquisição de Imóvel é exibido com os campos adequados.  

Caso de Teste 2: Preencher o formulário de Aquisição de Imóvel e realizar o cálculo
    [Documentation]    Preencher os campos do formulário e calcular o valor de financiamento.
    [Tags]             preencherFormularioAquisicao
    Acessar a URL da calculadora
    Selecionar Aquisição de Imóvel
    Clicar em Próxima Etapa
    Verificar se o formulário de Aquisição de Imóvel é exibido com os campos adequados.
    Selecionar Tipo do Imóvel (Residencial ou Comercial)
    Preencher os campos - Aquisição
    Ativar/desativar a opção de financiar despesas
    Clicar em Calcular
    Validar os resultados do cálculo - Aquisição

Caso de Teste 3: Verificar validação de campos obrigatórios no formulário de Aquisição de Imóvel
    [Documentation]    Testar a validação do formulário ao deixar campos obrigatórios em branco.
    [Tags]             validarCamposAquisicao
    Acessar a URL da calculadora
    Selecionar Aquisição de Imóvel
    Clicar em Próxima Etapa
    Verificar se o formulário de Aquisição de Imóvel é exibido com os campos adequados.
    Selecionar Tipo do Imóvel (Residencial ou Comercial)
    Ativar/desativar a opção de financiar despesas
    Clicar em Calcular
    Verificar se mensagens de erro são exibidas