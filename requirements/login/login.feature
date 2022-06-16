Feature: Login
    Como um cliente
    Quero acessar minha conta e me manter logado
    Para que eu possa ver e responder enquetes de forma rapida

Scenario: Credenciais Validas
    Dado que o cliente informou credenciais validas
    Quando solicitar para fazer login
    Entao o sistema deve enviar o usuario para a tela de pesquisas
    e manter o usuario conectado

Scenario: Credenciais invalidas
    Dado que o cliente informou credenciais invalidas
    quando solicitar para fazer login
    Entao o sistema deve retornar uma mensagem de erro
