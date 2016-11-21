/* 	
 *	BRUNO LEONE ALEXANDRE PACHECO CORREA
 *	leone.analistadesistemas@outlook.com.br
 *	https://github.com/leonebruno
 */

-- [1] Realizar o script de criação do banco de dados acima
CREATE DATABASE Vendas;

USE Vendas;

CREATE TABLE Produtos
(
	CB INT NOT NULL,
	NomeProd VARCHAR(15) NOT NULL,
	ValorProduto INT NOT NULL,
	CONSTRAINT PkProdutos PRIMARY KEY (CB)
);
CREATE TABLE Vendedores
(
	Mat INT NOT NULL,
	NomeVendedor VARCHAR(255) NOT NULL,
	Sexo CHAR NOT NULL,
	CONSTRAINT PkVendedores PRIMARY KEY(Mat)
);
CREATE TABLE Vendas
(
	CodVenda INT NOT NULL,
	DataVenda DATE NOT NULL,
	Mat INT,
	CONSTRAINT PkVendas PRIMARY KEY (CodVenda),
	CONSTRAINT FkVendas FOREIGN KEY (Mat) REFERENCES Vendedores (Mat)
);
CREATE TABLE ItensVendidos
(
	CodV INT NOT NULL,
	CB INT NOT NULL,
	Qtde INT NOT NULL,
	CONSTRAINT PkItensVendidos PRIMARY KEY (CodV, CB),
	CONSTRAINT FkCodigoVenda FOREIGN KEY (CodV) REFERENCES Vendas (CodVenda),
	CONSTRAINT FkCodigoBarra FOREIGN KEY (CB) REFERENCES Produtos (CB)
);

-- [2] Realizar o povoamento do banco de dados criado, conforme tabelas acima
INSERT INTO Produtos VALUES (10, 'Mouse', 10.00);
INSERT INTO Produtos VALUES (20, 'Teclado', 20.00);
INSERT INTO Produtos VALUES (30, 'Impressora', 230.00);
INSERT INTO Produtos VALUES (40, 'HD 180 GB', 380.00);

INSERT INTO Vendedores VALUES (1030, 'Paula Santos', 'F');
INSERT INTO Vendedores VALUES (1040, 'Cássio Lopes', 'M');
INSERT INTO Vendedores VALUES (1050, 'Paulo Sadia', 'M');
INSERT INTO Vendedores VALUES (1060, 'Camila Dias', 'F');

INSERT INTO Vendas (CodVenda, DataVenda, Mat) VALUES (100, '10/11/2009', 1030);
INSERT INTO Vendas (CodVenda, DataVenda, Mat) VALUES (200, '12/11/2009', 1030);
INSERT INTO Vendas (CodVenda, DataVenda, Mat) VALUES (300, '12/11/2009', 1040);
INSERT INTO Vendas (CodVenda, DataVenda, Mat) VALUES (400, '13/11/2009', 1050);

INSERT INTO ItensVendidos VALUES (100, 10, 1);
INSERT INTO ItensVendidos VALUES (200, 10, 2);
INSERT INTO ItensVendidos VALUES (300, 20, 3);
INSERT INTO ItensVendidos VALUES (300, 30, 4);
INSERT INTO ItensVendidos VALUES (400, 10, 5);
INSERT INTO ItensVendidos VALUES (400, 20, 3);

-- [3] Gerar o diagrama lógico
--FEITO O DIAGRAMA DE CLASSES

-- [4] Gerar os scripts para as requisições abaixo:

-- [4.1] Criar na tabela vendas um atributo decimal denominado valor_venda
ALTER TABLE Vendas ADD Valor_Venda DECIMAL(10,2);

-- SELECT * FROM Vendas;

-- [4.2] Atualizar esse atributo valor_ venda para R$ 1000,00 na venda de código
UPDATE Vendas SET Valor_Venda=1000.00 WHERE CodVenda=100;

-- [4.3] Atualizar esse atributo valor_venda para R$ 1500,00 na venda de código 200
UPDATE Vendas SET Valor_Venda=1500.00 WHERE CodVenda=200;

-- [4.4] Atualizar esse atributo valor_venda para R$ 2000,00 na venda de código 300
UPDATE Vendas SET Valor_Venda=2000.00 WHERE CodVenda=300;

-- [4.5] Atualizar esse atributo valor_venda para R$ 500,00 na venda de código 400
UPDATE Vendas SET Valor_Venda=500.00 WHERE CodVenda=400;

-- SELECT * FROM Vendas;

-- [4.6] 
SELECT Vendedores.Mat,SUM(Valor_Venda) FROM Vendas JOIN Vendedores ON Vendas.Mat = Vendedores.Mat GROUP BY Vendedores.Mat;

-- [4.8]
INSERT INTO Produtos (CB, NomeProd, ValorProduto) VALUES (150, 'Mouse sem fio', 49);

-- [4.9] 
ALTER TABLE Vendedores ADD Email VARCHAR(255);

--OK 
UPDATE Vendedores SET Email='paula@praticadb.com.br' WHERE Mat = 1030;
UPDATE Vendedores SET Email='cassio@praticadb.com.br' WHERE Mat = 1040;
UPDATE Vendedores SET Email='paulo@praticadb.com.br' WHERE Mat = 1050;
UPDATE Vendedores SET Email='camila@praticadb.com.br' WHERE Mat = 1060;

-- [4.10] 
SELECT CB, NomeProd, ValorProduto FROM Produtos;

-- [5] Acrescentar na tabela vendedor uma coluna denominada loja varchar(50) 
ALTER TABLE Vendedores ADD Loja VARCHAR(50);

-- [6] Atribuir uma loja para cada funcionário cadastrado 
UPDATE Vendedores SET Loja='Centro' WHERE Mat=1030;
UPDATE Vendedores SET Loja='Buritis' WHERE Mat=1040;
UPDATE Vendedores SET Loja='Savassi' WHERE Mat=1050;
UPDATE Vendedores SET Loja='Centro' WHERE Mat=1060;

-- [7] – Incluir um novo produto com CB=179; nome=”HD EXTERNO” e valor do produto=R$ 249 
INSERT INTO Produtos VALUES (179,'HD Externo',249.00);
SELECT * FROM Produtos;
-- fim
-- --------------------------------------------------------------------
-- [8] Excluir o produto de código de barra = 179 
DELETE FROM Produtos WHERE cb = 179;
SELECT * FROM Produtos;

SELECT * FROM Produtos AS Tabela_de_Preços;

-- [3] Listar o nome de todas as nossas lojas da tabela vendedor 
SELECT UPPER(Loja) FROM Vendedores;

-- [4] Utilizando-se do comando distinct list apenas uma vez o nome das lojas
SELECT DISTINCT UPPER(Loja) FROM Vendedores;

-- [5] Listar o nome dos vendedores e o nome de suas lojas que trabalham na loja Centro ou na Loja Buritis 
SELECT UPPER(NomeVendedor), UPPER(Loja) FROM Vendedores WHERE Loja = 'Centro' OR Loja = 'Buritis' ORDER BY Loja;

-- [6] Listar o nome do vendedor e o nome da loja do mesmo sabendo que esse é o vendedor que realizou a maior venda entre um período  
SELECT UPPER(Vendedores.NomeVendedor), UPPER(Vendedores.Loja) FROM Vendedores INNER JOIN Vendas ON Vendedores.Mat=Vendas.Mat ORDER BY Loja;

-- [7] Listar o nome do vendedor e o nome da loja do mesmo sabendo que esse nunca realizou nenhuma venda
SELECT UPPER(Vendedores.NomeVendedor),UPPER(Vendedores.Loja) FROM Vendedores WHERE Vendedores.Mat NOT IN (SELECT Vendas.Mat FROM Vendas);

-- [8] Obter o nome das lojas que possuem mais de um funcionário 
SELECT Vendedores.Loja, COUNT(Vendedores.Loja) AS Repetitions FROM Vendedores GROUP BY Loja HAVING COUNT(Loja)>1;

-- [9] Para cada loja obter o número de vendas, o total das vendas e a média de vendas agrupadas por loja;
SELECT Loja, COUNT(Vendas.CodVenda) AS QtdVendas, SUM(Vendas.Valor_Venda) AS ValTotal,  AVG(Vendas.Valor_Venda) AS Media FROM Vendas JOIN Vendedores ON Vendedores.Mat=Vendas.Mat GROUP BY Vendedores.Loja;

-- [10] Obter a média de vendas de cada vendedor;
SELECT Vendas.Mat AS Matricula, AVG(Vendas.Valor_Venda) AS MediaVendas FROM Vendas GROUP BY Vendas.Mat;

-- [11] Para cada loja que possua mais de um funcionário obter a total de vendas da mesma.
SELECT Vendas.Mat, SUM(Vendas.Valor_Venda) AS ValorTotal FROM Vendas INNER JOIN Vendedores ON Vendedores.Mat=Vendas.Mat GROUP BY Vendas.Mat;

-- [12] Acrescentar um novo vendedor onde a loja do mesmo seja NULL
INSERT INTO Vendedores VALUES (1070, 'Antonio Dias', 'M', 'antoniodias@praticadb.com.br', NULL);

-- [13] Obter o nome dos vendedores que não estão alocados em nenhuma loja – comando is null
SELECT Vendedores.NomeVendedor FROM Vendedores WHERE Vendedores.Loja IS NULL;

-- [14] 
SELECT Vendedores.NomeVendedor FROM Vendedores WHERE Vendedores.Loja IS NOT NULL;

-- [15] Listar o nome de todos os vendedores que iniciam seu nome com a letra P
SELECT Vendedores.NomeVendedor FROM Vendedores WHERE Vendedores.NomeVendedor LIKE 'P%';

-- [16] Listar o nome de todos os vendedores que tenham o nome “Lopes”
SELECT Vendedores.NomeVendedor FROM Vendedores WHERE Vendedores.NomeVendedor LIKE '%Lopes%';

-- [17] Aumentar em 20% os valores de todos os produtos
UPDATE Produtos SET Produtos.ValorProduto = Produtos.ValorProduto * (1.20);

-- [18] Gerar uma lista com o somatório de vendas por sexo
SELECT Vendedores.sexo, SUM(Vendas.Valor_Venda) AS TotalVenda FROM Vendas JOIN Vendedores ON Vendedores.Mat=Vendas.Mat GROUP BY Vendedores.sexo;

-- [19] Gerar uma lista com o somatório de vendas por loja
SELECT UPPER(Vendedores.Loja), SUM(Vendas.Valor_Venda) AS TotalVendas FROM Vendas INNER JOIN Vendedores ON Vendedores.Mat=Vendas.Mat GROUP BY Vendedores.Loja;

-- [20] Listar o código e nome do vendedor de todas as vendas de um determinado períodot
SELECT Vendedores.Mat AS Matricula, Vendedores.NomeVendedor AS NomeVendedor FROM Vendedores INNER JOIN Vendas ON Vendas.Mat=Vendedores.Mat WHERE Vendas.datavenda LIKE '2009-11-12';

-- [21] Listar o número de vendedores por loja
SELECT UPPER(Vendedores.Loja), COUNT(Vendedores.Loja) FROM Vendedores GROUP BY Vendedores.Loja;

-- [22] Listar apenas as lojas com mais de 01 Vendedor
SELECT UPPER(Vendedores.Loja), COUNT(Vendedores.Loja) FROM  Vendedores GROUP BY Vendedores.Loja HAVING COUNT(Vendedores.Loja) > 1;

-- [23] Listar todas as lojas com venda superior a média de vendas da empresa
SELECT DISTINCT Vendas.Mat, Vendas.Valor_Venda FROM Vendas WHERE Vendas.Valor_Venda > (SELECT AVG(Vendas.Valor_Venda) FROM Vendas);

-- [24] Listar o nome do produto mais caro de nossa loja
SELECT MAX(Produtos.ValorProduto) AS ProdutosMaisCaro FROM Produtos;

-- [25] Listar o nome do produto mais barato de nossa loja
SELECT MIN(Produtos.ValorProduto) AS ProdutosMaisBarato FROM Produtos;

-- [26] Listar o nome dos vendedores ordenados alafabeticamente
SELECT UPPER(Vendedores.NomeVendedor) FROM Vendedores ORDER BY 1 ASC;

-- [27] Listar o código, data da venda e o nome dos vendedores ordenados pelo valor da venda de maneira decrescente
SELECT Vendas.CodVenda AS CodigoVenda, Vendas.DataVenda AS DataVenda, Vendedores.NomeVendedor AS NomeVendedor--, Vendas.valor_venda 
FROM Vendas INNER JOIN Vendedores ON Vendedores.MAT=Vendas.Mat ORDER BY valor_venda DESC;

-- [28] Listar o nome dos 03 produtos mais vendidos, agrupados pelo CB
SELECT TOP 3 Produtos.NomeProd, ItensVendidos.Qtde FROM Produtos INNER JOIN ItensVendidos ON ItensVendidos.CB=Produtos.CB ORDER BY ItensVendidos.Qtde DESC;

-- [29] Obter o nome do vendedor e o nome da loja de todos os vendedores com vendas inferiores a média da empresa


-- [30] Selecionar todos os vendedores e o somatório de vendas por período.
SELECT Vendedores.NomeVendedor, SUM(Vendas.valor_venda), Vendas.DataVenda FROM Vendedores INNER JOIN Vendas ON Vendas.Mat=Vendedores.MAT GROUP BY Vendedores.NomeVendedor, Vendas.DataVenda;

-- [31] Listar todos os produtos de uma determinada categoria
CREATE TABLE Categorias(
	CodCategoria INT NOT NULL,
	NomeCatergoria VARCHAR(255) NOT NULL,
	CONSTRAINT PkCodCategoria PRIMARY KEY (CodCategoria)
)

ALTER TABLE Produtos ADD Categoria INT;

ALTER TABLE Produtos ADD CONSTRAINT FkCodCategoria FOREIGN KEY (Categoria) REFERENCES Categorias (CodCategoria);

INSERT INTO Categorias VALUES (1000, 'Informatica');

UPDATE Produtos SET Categoria=1000;

SELECT * FROM Produtos WHERE Produtos.Categoria = 1000;

-- [32]  Listar todos os produtos e o nome de suas categorias
SELECT Produtos.NomeProd, Categorias.NomeCatergoria AS Categoria FROM Produtos, Categorias;

-- [33] Listar a quantidade de produtos por categoria
SELECT COUNT(Produtos.NomeProd) AS Numeros, Categorias.NomeCatergoria AS Categoria FROM Produtos, Categorias WHERE Produtos.Categoria = 1000 GROUP BY Categorias.NomeCatergoria, Produtos.Categoria;

--PARTE III
CREATE TABLE tblcliente(
	IDCLIENTE INT IDENTITY(1,1) NOT NULL, 
	CPF_CNPJ INT NOT NULL UNIQUE,
	Nome VARCHAR(255) NOT NULL,
	Cidade VARCHAR(255),
	CONSTRAINT PkIdCliente PRIMARY KEY (IDCLIENTE)
)

--Para Mysql
CREATE TABLE tblcliente(
	IDCLIENTE INT AUTO_INCREMENTO NOT NULL,
	CPF_CNPJ INT NOT NULL UNIQUE,
	Nome VARCHAR(255) NOT NULL,
	Cidade VARCHAR(255),
	CONSTRAINT PkIdCliente PRIMARY KEY (IDCLIENTE)
)

ALTER TABLE tblcliente ADD DEFAULT 'BH' FOR Cidade;

INSERT INTO tblcliente (Nome, CPF_CNPJ) VALUES ('Rodrigo de Matos', '123');
INSERT INTO tblcliente (Nome, CPF_CNPJ, Cidade) VALUES ('Rafaela Mendes', '456', 'Nova Lima');
INSERT INTO tblcliente (Nome, CPF_CNPJ) VALUES ('Janaina Cardoso','789');
INSERT INTO tblcliente (Nome, CPF_CNPJ, Cidade) VALUES ('Rogério Cardoso','999','Nova Lima');

-- [Tarefa] Sabendo que todo pedidos deve estar vinculado a um cliente, crie o atributo CODCLI na tabela pedidos como FK
CREATE TABLE Pedidos(
	CodPedidos INT NOT NULL,
	CodCli INT NOT NULL,
	CONSTRAINT FkCodCli FOREIGN KEY (CodCli) REFERENCES  tblcliente (IDCLIENTE),
	CONSTRAINT PkCodPedidos PRIMARY KEY (CodPedidos)
)

--Faça os pedidos de número 100, 200 e 400 estarem vinculados ao codcli de número 2*/
INSERT INTO Pedidos VALUES ('100', '2');
INSERT INTO Pedidos VALUES ('200', '2');
INSERT INTO Pedidos VALUES ('400', '2');

--Gere uma nova venda de número 500, na data de hoje, vinculados ao vendedor de número 1030 e pertencente ao cliente de código 1, sendo o valor total da venda no valor de R$ 40,00
ALTER TABLE Vendas ADD CodCliente INT;

ALTER TABLE Vendas ADD CONSTRAINT FkCodCli FOREIGN KEY (CodCli) REFERENCES tblcliente (IDCLIENTE);

INSERT INTO Vendas VALUES ('500', GETDATE(), 1030, 40.00, 1);

-- Na tabela itens vendidos, insira dois mouses e um teclado vinculados ao pedido de número 500
ALTER TABLE ItensVendidos ADD COLUMN CodPedidos INT;
ALTER TABLE ItensVendidos ADD CONSTRAINT FkCodPedido FOREIGN KEY (CodPedidos) REFERENCES Pedidos (CodPedidos);

--Não consigo mais

--BEGIN TRANSACTION
INSERT INTO Pedidos VALUES (500, 2);

INSERT INTO ItensVendidos VALUES (600, 10, 2, 500);
INSERT INTO ItensVendidos VALUES (600, 20, 1, 500);
--COMMIT

-----------------------------------------------------

-- Gere um script que liste um ranking de nossos melhores clientes com o seu total comprado em um determinado período

-- Gere  um script que forneça o nome do cliente, o número, data e valor de todos os pedidos de um determinado cliente. 

-- Listar todos os pedidos que não estão vinculados a nenhum cliente 

-- Criar na tabela cliente mais um campo chamado emailcli do tipo varchar(255) – lembre-se que esse campo deve ser único – apesar de não ser nossa chave primária. 

-- Listar todas as cidades onde estão localizados nossos clientes.

-- Listar a quantidade de clientes em cada cidade

-- Listar o nome de todos os clientes ordenados alfabeticamente 

-- Listar o total de vendas por cidade

-- Listar todos os clientes que nunca realizaram nenhum pedido na empresa. 