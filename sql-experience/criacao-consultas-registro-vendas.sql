create table registro_vendas(
	ID_NF SMALLINT(255),
	ID_ITEM TINYINT(100),
	COD_PROD SMALLINT(255), 
	VALOR_UNIT DECIMAL(65),
	QUANTIDADE SMALLINT (255),
	PERCENT_DESCONTO TINYINT(100));
	
INSERT INTO registro_vendas(
	ID_NF, 
	ID_ITEM, 
	COD_PROD, 
	VALOR_UNIT, 
	QUANTIDADE, 
	PERCENT_DESCONTO) VALUES
	(1,1,1,25.00,10,5),
	(1,2,2,13.50,3,NULL),
	(1,3,3,15.00,2,NULL),
	(1,4,4,10.00,1,NULL),
	(1,5,5,30.00,1,NULL),
	(2,1,3,15.00,4,NULL),
	(2,2,4,10.00,5,NULL),
	(2,3,5,30.00,7,NULL),
	(3,1,1,25.00,5,NULL),
	(3,2,4,10.00,4,NULL),
	(3,3,5,30.00,5,NULL),
	(3,4,2,13.50,7,NULL),
	(4,1,5,30.00,10,15),
	(4,2,4,10.00,12,5),
	(4,3,1,25.00,13,5),
	(4,4,2,13.50,15,5),
	(5,1,3,15.00,3,NULL),
	(5,2,5,30.00,6,NULL),
	(6,1,1,25.00,22,15),
	(6,2,3,15.00,25,20),
	(7,1,1,25.00,10,3),
	(7,2,2,13.50,10,4),
	(7,3,3,15.00,10,4),
	(7,4,5,30.00,10,1);
/*	
Solucionando problemas
*/

/*
a) Pesquise os itens que foram vendidos sem desconto. As colunas presentes no
resultado da consulta são: ID_NF, ID_ITEM, COD_PROD E VALOR_UNIT.
*/

	SELECT ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT FROM registro_vendas WHERE PERCENT_DESCONTO IS NULL;


/*
b) Pesquise os itens que foram vendidos com desconto. As colunas presentes no
resultado da consulta são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT E O VALOR
VENDIDO. OBS: O valor vendido é igual ao VALOR_UNIT -
(VALOR_UNIT*(DESCONTO/100)).

*/

SELECT ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, (VALOR_UNIT*(1-PERCENT_DESCONTO/100)) as VALOR_VENDIDO FROM registro_vendas WHERE PERCENT_DESCONTO IS NOT NULL;

/*
c) Altere o valor do desconto (para zero) de todos os registros onde este campo é nulo.
*/

update registro_vendas set percent_desconto=0 where percent_desconto is null;

/*
d) Pesquise os itens que foram vendidos. As colunas presentes no resultado da consulta
são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_TOTAL, DESCONTO,
VALOR_VENDIDO. OBS: O VALOR_TOTAL é obtido pela fórmula: QUANTIDADE *
VALOR_UNIT. O VALOR_VENDIDO é igual a VALOR_UNIT -
(VALOR_UNIT*(DESCONTO/100)).
*/

SELECT ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, (QUANTIDADE * VALOR_UNIT) AS VALOR_TOTAL, PERCENT_DESCONTO, (VALOR_UNIT * (1-PERCENT_DESCONTO/100)) AS VALOR_VENDIDO FROM registro_vendas;


/*
e) Pesquise o valor total das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_TOTAL. OBS: O 
VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. Agrupe o
resultado da consulta por ID_NF.
*/

select ID_NF, (QUANTIDADE*VALOR_UNIT) AS VALOR_TOTAL from registro_vendas order by VALOR_TOTAL DESC;

/*
f) Pesquise o valor vendido das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_VENDIDO. OBS: O
VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. O
VALOR_VENDIDO é igual a ∑ VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)). Agrupe
o resultado da consulta por ID_NF.
*/

select ID_NF, SUM(VALOR_UNIT * (1-PERCENT_DESCONTO/100)) AS VALOR_VENDIDO from registro_vendas group by ID_NF;
/*
g) Consulte o produto que mais vendeu no geral. As colunas presentes no resultado da
consulta são: COD_PROD, QUANTIDADE. Agrupe o resultado da consulta por
COD_PROD.
*/

select COD_PROD, MAX(QUANTIDADE) from registro_vendas group by COD_PROD;

/*
h) Consulte as NF que foram vendidas mais de 10 unidades de pelo menos um produto.
As colunas presentes no resultado da consulta são: ID_NF, COD_PROD, QUANTIDADE.
Agrupe o resultado da consulta por ID_NF, COD_PROD.
*/

select ID_NF, COD_PROD, SUM(QUANTIDADE) from registro_vendas where QUANTIDADE>10 group by ID_NF, COD_PROD;

/*
i) Pesquise o valor total das NF, onde esse valor seja maior que 500, e ordene o
resultado do maior valor para o menor. As colunas presentes no resultado da consulta
são: ID_NF, VALOR_TOT. OBS: O VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE
* VALOR_UNIT. Agrupe o resultado da consulta por ID_NF.
*/

select ID_NF, SUM(QUANTIDADE*VALOR_UNIT) AS VALOR_TOTAL from registro_vendas where (QUANTIDADE*VALOR_UNIT) > 500 group by ID_NF;
/*
j) Qual o valor médio dos descontos dados por produto. As colunas presentes no
resultado da consulta são: COD_PROD, MEDIA. Agrupe o resultado da consulta por
COD_PROD.
*/

select COD_PROD, AVG(PERCENT_DESCONTO) AS MEDIA from registro_vendas group by COD_PROD;

/*
k) Qual o menor, maior e o valor médio dos descontos dados por produto. As colunas
presentes no resultado da consulta são: COD_PROD, MENOR, MAIOR, MEDIA. Agrupe
o resultado da consulta por COD_PROD.
*/

select COD_PROD, MIN(PERCENT_DESCONTO) AS MENOR, MAX(PERCENT_DESCONTO) AS MAIOR, AVG(PERCENT_DESCONTO) AS MEDIA from registro_vendas group by COD_PROD;

/*
l) Quais as NF que possuem mais de 3 itens vendidos. As colunas presentes no resultado
da consulta são: ID_NF, QTD_ITENS. OBS:: NÃO ESTÁ RELACIONADO A QUANTIDADE
VENDIDA DO ITEM E SIM A QUANTIDADE DE ITENS POR NOTA FISCAL. Agrupe o
resultado da consulta por ID_NF.
*/

select ID_NF, count(ID_NF) as QTD_ITENS from registro_vendas group by ID_NF  having QTD_ITENS > 3;

