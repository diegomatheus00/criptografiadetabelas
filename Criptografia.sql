CREATE TABLE Usuario
(
   ID INT IDENTITY,
   [LOGIN] VARCHAR(MAX),
   SENHA VARBINARY (MAX)
)
GO


-----------------------------------------

CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'PASSWORD@123'
GO

CREATE CERTIFICATE Certificado
ENCRYPTION BY PASSWORD = 'SENHA@123'
WITH SUBJECT = 'Certificado Senha Usuario'
GO

CREATE SYMMETRIC KEY ChaveSenha
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE Certificado --
GO


-----------------------------------------

SELECT * FROM SYS.symmetric_keys
GO
SELECT * FROM SYS.certificates
GO

-----------------------------------------

OPEN SYMMETRIC KEY ChaveSenha
DECRYPTION BY CERTIFICATE Certificado

DECLARE @GUID UNIQUEIDENTIFIER = (SELECT KEY_GUID('ChaveSenha'))
INSERT INTO Usuario VALUES ('FABIO', ENCRYPTBYKEY(@GUID, 'fabio123'))
GO

SELECT    * FROM Usuario

CLOSE SYMMETRIC KEY ChaveSenha


-----------------------------------------

