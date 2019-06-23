# ![alt text](https://github.com/venezianluis/erp/blob/master/application/documentation/doc_img/logo/icon-hinode.png)  Usuários e Permissões

### Autor: Luis Felipe A. Venezian
### Data: 23/06/2019

# Modelagem de dados
O arranjo desenvolvido restringe algumas situações a fim de garantir a integridade dos dados,
faciliando sua administração.
![Modelagem](https://github.com/venezianluis/erp/blob/master/application/documentation/database/img/er_diagram_users_concessions.jpg)

### Decrição por Coluna 
##### USERS.PROFILES 
Tabela armazena os dados principais do perfil dos usuários da 
base.

Coluna      | Descrição
---------   | ------
id_user     | Id identificador do usuário no sistema
user_first_name | Primeiro nome do usuário
user_last_name | Sobrenome do usuário
user_login  | Texto utilizado na efetuação do Login do Usuário 
user_password | Senha do usuário, não criptografada
user_email | Endereço de e-mail do usuário
user_contry_id | Id identificador do país de origem do usuário
user_create_date | Data em que o usuário foi criado
user_phone_number | Número de telefone do usuário
user_phone_prefix | Prefixo do número de telefone do usuário
user_job_role | Cargo do usuário
user_bio | Descrição de biografica do usuário 

##### SI.APPLICATIONS 
Tabela armazena todas as aplicações do sistema.

Coluna      | Descrição
---------   | ------
id_app     | Id identificador da aplicação no sistema
app_name | Nome da aplicação
app_name_controler | Nome da página Controller da aplicação no Projeto
app_create_date | Data da criação da aplicação
app_url_redirect | URL para se redirecionar para página da aplicação
system_id | Id identificador se a qual sistema a aplicação se refere
is_report | Determina se a aplicação é um relatório ou não
is_active | Determina se a aplicação está ativa ou não

##### USERS.CONCESSIONS
Tabela N:N relaciona as permissões entre usuários e aplicações.

Coluna      | Descrição
---------   | ------
user_id     | Id identificador do usuário no sistema
app_id | Id identificador da aplicação no sistema
record_concession_date | Dia em que foi registrada a permissão para o usuário.
