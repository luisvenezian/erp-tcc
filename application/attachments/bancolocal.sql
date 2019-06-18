SELECT * FROM SYS_USUARIO;
GO
CREATE SCHEMA users;
CREATE SCHEMA si;
GO
DROP TABLE users.permission
CREATE TABLE users.permission(
user_name varchar(15) NOT NULL,
app_id INT NOT NULL
CONSTRAINT pk_user_permission PRIMARY KEY (user_name, app_id)
)
SELECT * FROM users.permission

CREATE TABLE si.application(
app_id INT identity NOT NULL,
app_name varchar(60) NOT NULL,
app_name_controller varchar(60) NOT NULL,
app_create_date datetime NOT NULL,
user_name_create_app varchar(15) NOT NULL,
si_name_application varchar(60) NOT NULL
CONSTRAINT pk_sis_application_control PRIMARY KEY(app_name)
)

GO
SELECT * FROM si.application;
SELECT * FROM users.permission; 
INSERT INTO si.application values ('Pedidos','pedido',getdate(),'KPL.LUIS','ICORP')
INSERT INTO users.permission values ('KPL.LUIS','1')
