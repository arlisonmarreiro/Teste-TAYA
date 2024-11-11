*** Settings ***
Documentation     This file contains page variables for the application
Resource        ../../config/package.robot

*** Variables ***

${EmprestimoBtn}                        xpath=//div[text()="Empréstimo com Garantia Imóvel"]
${pfBtn}                                xpath=//div[text()='PF']
${pjBtn}                                xpath=//div[text()='PJ']
@{opcoesPF&PJ}                          ${pjBtn}   ${pfBtn} 
${valorEmprestimoInput}                 xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[3]
${prazoPagamentoInput}                  xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[4]
${financiarIofCheckbox}                 xpath=(//input[@type="checkbox"])[1]
${financiarTarifaAvaliacaoCheckbox}     xpath=(//input[@type="checkbox"])[2]
${financiarEmissaoContrato}             xpath=(//input[@type="checkbox"])[3]