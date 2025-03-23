
# Controle de Tarefas - Delphi
Este projeto é um sistema de controle de tarefas desenvolvido em Delphi. Ele permite o cadastro e gerenciamento de usuários e tarefas, além de atribuir tarefas aos usuários com controle de permissões.


## Estrutura do Projeto
A estrutura do projeto está organizada da seguinte forma:

/src          → Arquivos fonte do Delphi (.pas, .dfm)
/formularios  → Telas do sistema
/dados        → Módulos de acesso ao banco de dados
/modelos      → Classes para representar as entidades
## Tecnologias Utilizadas
**Delphi 12**

**FireDAC** para conexão com o banco de dados

**VCL Forms** para interface gráfica

## Installation

Configuração do Banco de Dados
Este sistema pode ser configurado para utilizar **Firebird**, **PostgreSQL**, **MySQL** ou**SQL Server.** Para este exemplo, estamos utilizando Firebird.

## Estrutura do Banco de Dados:

```bash 
CREATE TABLE IF NOT EXISTS usuario (
    codigo INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    direito CHAR(1) CHECK (direito IN ('O', 'S')) NOT NULL
);
```

```bash 
CREATE TABLE IF NOT EXISTS tarefa (
    codigo INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo CHAR(1) CHECK (tipo IN ('D', 'S', 'Q', 'M')) NOT NULL
);
```

```bash 
CREATE TABLE IF NOT EXISTS usuario_tarefa (
    cod_usuario INTEGER,
    cod_tarefa INTEGER,
    PRIMARY KEY (cod_usuario, cod_tarefa),
    FOREIGN KEY (cod_usuario) REFERENCES usuario(codigo),
    FOREIGN KEY (cod_tarefa) REFERENCES tarefa(codigo)
); 
```



## Configuração do Banco de Dados (Arquivo config.ini):

Na pasta dos arquivos, crie ou edite o arquivo config.ini com as seguintes informações:

```bash
[DATABASE]
DriverID=MySQL
Server=localhost
Database=bdTarefa
User_Name=root
Password=
Port=3306
```

Altere os parâmetros Server, Database, User_Name, Password e Port conforme a configuração do seu banco de dados Firebird.



## Configuração do Projeto Delphi
- Abra o projeto no Delphi.

- Verifique se a conexão com o banco de dados Firebird está funcionando corretamente. Caso esteja utilizando FireDAC, configure o componente TFDConnection para apontar para o banco de dados conforme as configurações definidas no arquivo config.ini.

- Compile e execute o projeto.
## Primeiro Acesso
Para o primeiro acesso, utilize as credenciais padrão:

- Usuário: código 1
- Senha: admin

Essas credenciais são configuradas diretamente no banco de dados como um usuário inicial.
## Tela de Login
O sistema possui uma tela de login onde o usuário deve fornecer seu nome de usuário e senha.

Caso as credenciais sejam válidas, o sistema permite o acesso conforme o nível de permissão (Operador ou Supervisor).



## Funcionalidades
- Cadastro de Usuários: Cadastro, edição e remoção de usuários.
- Cadastro de Tarefas: Criação e gerenciamento de tarefas.
- Atribuição de Tarefas: Vinculação de tarefas aos usuários.
- Controle de Permissões: Supervisores podem cadastrar usuários e tarefas, enquanto operadores podem visualizar apenas suas tarefas atribuídas.
- Controle de Permissões
- Supervisor: Pode cadastrar usuários, tarefas e atribuir tarefas.
- Operador: Pode apenas consultar as tarefas atribuídas.
