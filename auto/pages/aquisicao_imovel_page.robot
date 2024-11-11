*** Settings ***
Documentation     This file contains page variables for the application
Resource        ../../config/package.robot

*** Variables ***

${URL}            https://imobiliario.desenvolvimento.taya.com.br/calculadora/aai-controle
${BROWSER}        chrome

${aquisiçãoImovelBtn}        xpath=//div[text()="Aquisição de Imóvel"]
${proximaEtapaBtn}           xpath=//button[contains(@class, "MuiButton-containedPrimary") and contains(@class, "MuiButton-fullWidth") and text()="PRÓXIMA ETAPA"]

${imovelResidencial}         xpath=//span[text()="Residencial"]
${imovelComercial}           xpath=//span[text()="Comercial"]
@{imoveis}                   ${imovelResidencial}    ${imovelComercial} 
${dataNascimentoInput}       xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[1]
${valorImovelInput}          xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[2]
${valorFinanciamentoInput}   xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[3]
${prazoFinanciamentoInput}   xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[4]
${financiarCheckBox}         xpath=//input[@type="checkbox"]
${calcularBtn}               xpath=//button[@type="submit"]

${campoObrigatorioMsg}       xpath=//p[contains(@class, 'MuiFormHelperText-root') and contains(@class, 'Mui-error') and text()="Campo obrigatório"]
