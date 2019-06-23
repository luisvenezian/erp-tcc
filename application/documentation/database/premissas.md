# ![alt text](https://github.com/venezianluis/erp/blob/master/application/documentation/doc_img/logo/icon-hinode.png "Logo Hinode") Premissas para o uso do Banco de Dados

### Autor: Luis Felipe A. Venezian
### Data: 23/06/2019

- [x] Todos os nomes dos objetos devem estar com fonte caixa baixa.
- [x] Todos os nomes dos objetos devem ser separados por "_" (underline).
- [x] Todos os objetos do tipo procedure devem possuir sufixo "_sp".
- [x] Todas as Primary Keys devem respeitar o padrão: PK_TABLENAME_COLUMNCONSTRAINT (Ou PKC, se composta), onde TABLENAME é o nome da tabela e COLUMNCONSTRAINT o nome da coluna de chave primária. 
- [x] Todas as Foreign Keys devem respeitar o padrão: FK_TABLENAME_COLUMNCONSTRAINT, onde TABLENAME é o nome da tabela e COLUMNCONSTRAINT o nome da coluna de chave estrangeira.
- [x] Todas as Views devem ser iniciadas com prefixo "vw_".
