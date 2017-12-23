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
**Retorna:** auth_token (HTTP 200) ou HTTP 401 caso não tenha sido passado uma combinação correta reg + password

    Exemplo:
        Parametros: {"reg": "123123123", "password": "123123123"}

        Retorna: {"auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTQxMDcyODJ9.Qwo-zc5wtNaKqVyoH_2ZSBNFIiMWoZY0hsUSvnc5YAc"}


### POST /users

Cria um novo usuário e retorna um objeto JSON representando o novo usuário.

**Parametros:** name, reg, password, password_confirmation
**Retorna:** Objeto JSON do usuário criado (HTTP status: 201) ou o objeto JSON com os erros a serem consertados (HTTP 422)

    Exemplo:
        Parametros: {"reg": "123123123", "password": "123123123", "password_confirmation": "123123123", "name": "Foo Bar"}

        Retorna: {"reg": "123123123", "password": "[cifrado]", "name": "Foo Bar"}

### POST /users_reg

Retorna objeto JSON do usuário atual

**Parametros:** HEADER: auth_token
**Retorna:** Objeto JSON do usuário (HTTP status: 200) ou não autorizado (HTTP 401)

    Exemplo:
        Parametros: (HEADER) {"Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTQxMDcyODJ9.Qwo-zc5wtNaKqVyoH_2ZSBNFIiMWoZY0hsUSvnc5YAc"}

        Retorna: {"reg": "123123123", "password": "[cifrado]", "name": "Foo Bar"}

### POST /users_reg

Retorna objeto JSON do usuário atual

**Parametros:** HEADER: auth_token
**Retorna:** Objeto JSON do usuário (HTTP status: 200) ou não autorizado (HTTP 401)

    Exemplo:
        Parametros: (HEADER) {"Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTQxMDcyODJ9.Qwo-zc5wtNaKqVyoH_2ZSBNFIiMWoZY0hsUSvnc5YAc"}

        Retorna: {"reg": "123123123", "password": "[cifrado]", "name": "Foo Bar"}
