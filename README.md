# PUFF rails API

Rails v. 5.1.1
Ruby 2.4.0

Heroku URL: https://icuff17-api.herokuapp.com

###Como usar

    Após ter instalado Ruby e Ruby on Rails, execute localmente usando 'rails server'.
    Verifique a porta que o servidor vai utilizar (3000 se você não tiver feito nenhuma alteração)
    e você pode acessar por localhost:3000/ (mantive a página padrão "You're on rails")

    Obs: Use 'rails server -b $IP -p $PORT' se estiver usando a cloud9 IDE

    Todos parametros de requisição assim como de resposta são esperados em JSON

## URLs

### POST /login

Retorna o token de login do usuário (caso haja sucesso na autenticação). 
Use o token para manipular o restante da API como o usuário correto logado. 
(Incluindo o token no header 'Authorization')

**Parametros:** reg, password
**Retorna:** auth_token

    Exemplo:
        Parametros: {"reg": "123123123", "password": "123123123"}

        Retorna: {"auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTQxMDcyODJ9.Qwo-zc5wtNaKqVyoH_2ZSBNFIiMWoZY0hsUSvnc5YAc"}

