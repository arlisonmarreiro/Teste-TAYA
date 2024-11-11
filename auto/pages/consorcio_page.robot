*** Settings ***
Documentation     This file contains page variables for the application
Resource        ../../config/package.robot

*** Variables ***

${ConsorcioBtn}                        xpath=//div[text()="Consórcio"]
${bemVeiculoLeve}                      xpath=//span[text()="Veículo Leve"]
${bemImovel}                           xpath=//span[text()="Imóvel"]
${bemMotocicleta}                      xpath=//span[text()="Motocicleta"]
${bemVeiculoPesado}                    xpath=//span[text()="Veículo Pesado"]
@{bens}    ${bemVeiculoLeve}   ${bemImovel}   ${bemMotocicleta}   ${bemVeiculoPesado}
${dataNascimentoInput}                 xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[1]
${valorDoBem}                          xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[2]
${valorDoCredito}                      xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[3]
${prazoPagamento}                      xpath=(//input[contains(@class, "MuiInputBase-input") and @inputmode="numeric"])[4]