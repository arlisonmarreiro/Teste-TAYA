*** Settings ***

Library     SeleniumLibrary
Library     String

## Keywords ##

Resource    ../auto/keywords/kws_aquisicao_imovel.robot
Resource    ../auto/keywords/kws_emprestimo_imovel.robot
Resource    ../auto/keywords/kws_suite_consorcio.robot

## Pages ##

Resource    ../auto/pages/aquisicao_imovel_page.robot
Resource    ../auto/pages/emprestimo_imovel_page.robot
Resource    ../auto/pages/consorcio_page.robot



## Hooks ##

Resource       hooks.robot