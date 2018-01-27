# PUFF rails API

Rails v. 5.1.1
Ruby 2.4.0

Heroku URL: https://icuff17-api.herokuapp.com

### Como usar

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

### GET /users_reg

Retorna objeto JSON do usuário atual

**Parametros:** HEADER: auth_token
**Retorna:** Objeto JSON do usuário (HTTP status: 200) ou não autorizado (HTTP 401)

    Exemplo:
        Parametros: (HEADER) {"Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTQxMDcyODJ9.Qwo-zc5wtNaKqVyoH_2ZSBNFIiMWoZY0hsUSvnc5YAc"}

        Retorna: {"reg": "123123123", "password": "[cifrado]", "name": "Foo Bar"}

### POST /change

Troca a senha do usuário.
Retorna o booleano se a troca de senha foi executada.

**Parametros:** HEADER: auth_token, PARAMS: password, password_new, password_new_confirmation
**Retorna:** Objeto JSON do booleano (HTTP status: 200) ou não autorizado (HTTP 401)

    Exemplo:
        Parametros: (HEADER) {"Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTQxMDcyODJ9.Qwo-zc5wtNaKqVyoH_2ZSBNFIiMWoZY0hsUSvnc5YAc"}
                    (PARAMS) {"passoword": "foobar", "password_new": "123", "password_new_confirmation": "123"}

        Retorna: {true} ou {false} caso a confirmação ou senha não conferem
        
### POST /rate
         
**Parametros:** HEADER: auth_token, PARAMS: t, rate
**Retorna:** Objeto JSON dos ratings criados (HTTP status: 200) ou não autorizado (HTTP 401)

    Exemplo:
        Parametros: (HEADER) {"Authorization": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MTQxMDcyODJ9.Qwo-zc5wtNaKqVyoH_2ZSBNFIiMWoZY0hsUSvnc5YAc"}
                    (PARAMS) {"t": "11", "rate": "1/2/3"}

        Retorna: {"rate": "1", "teacher_id": "11", "user_id": 16, "param_id": 1}
        
### GET /teachers

Retorna lista de todos professores (sem avaliação).

**Retorna:** Objeto JSON da lista (HTTP status: 200)

    Exemplo:
    
        Retorna: {"id":11,"photo":"http://ic.uff.br/phto.png", "name":"Professor1", "subject":"Fundamentos de Arquitetura de Computadores", "created_at":"2017-10-25T14:35:19.342Z","updated_at":"2017-10-25T14:35:19.342Z"},
                 {"id":12,"photo":"http://ic.uff.br/phto.png", "name":"Professor2", "subject":"Fundamentos de Arquitetura de Computadores", "created_at":"2017-11-26T15:35:19.342Z", "updated_at":"2017-11-26T15:35:19.342Z"}
                 
                 
### GET /teachers

Retorna objeto JSON de um professor (sem avaliação).

**Retorna:** Objeto JSON do professor (HTTP status: 200)

    Exemplo:
    
        Retorna: {"id":11, "photo":"http://ic.uff.br/phto.png", "name":"Professor1", "subject":"Fundamentos de Arquitetura de Computadores", "created_at":"2017-10-25T14:35:19.342Z", "updated_at":"2017-10-25T14:35:19.342Z"}
        
### GET /rating

Retorna a avaliação geral do professor em porcentagem na ordem: Foco, Material e Frequência

**Parametros:** PARAMS:teacher (id do professor)
**Retorna:** Objeto JSON do booleano (HTTP status: 200) ou não encontrado (HTTP 404)

    Exemplo:
        Parametros: (PARAMS) htpp://localhost:3000/?teacher=11

        Retorna: [80.0, 85.45, 81.82]
