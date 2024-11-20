#!/bin/bash

# Obter a versão do Google Chrome instalada
CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+\.\d+')

# Montar a URL para o download do ChromeDriver correspondente
DRIVER_URL="https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip"

# Baixar o ChromeDriver correspondente
wget $DRIVER_URL -O chromedriver_linux64.zip

# Verificar se o download foi bem-sucedido
if [[ $? -ne 0 ]]; then
    echo "Falha no download do ChromeDriver. Verifique se a versão do ChromeDriver está disponível."
    exit 1
fi

# Descompactar o ChromeDriver
unzip -o chromedriver_linux64.zip

# Mover o ChromeDriver para /usr/local/bin e dar permissões de execução
sudo mv -f chromedriver-linux64/chromedriver /usr/local/bin/chromedriver
sudo chmod +x /usr/local/bin/chromedriver

# Limpar o arquivo baixado e o diretório descompactado
rm chromedriver_linux64.zip
rm -rf chromedriver-linux64

# Verificar a versão instalada do ChromeDriver
INSTALLED_DRIVER_VERSION=$(chromedriver --version)

echo "ChromeDriver atualizado para a versão: $INSTALLED_DRIVER_VERSION"

