USE PERSONEL;

-- trigger oluşturma
CREATE TRIGGER trg_TblPersonel_forInsert 
ON PERSONELLER
FOR INSERT
AS BEGIN

    SELECT * FROM inserted;

END

-- trigger silme
DROP TRIGGER trg_TblPersonel_forInsert;

-- ALTER MODİFİYE CEKME
ALTER TRIGGER trg_TblPersonel_forInsert 
ON PERSONELLER
FOR INSERT
AS BEGIN

    PRINT 'FDSFDS';

END

insert into PERSONELLER VALUES('hghgf', 'gfgf', 'gfg', 50);

-- tablodaki degisiklikleri takip etmek icin
CREATE TABLE TblPersonellerAudit(

    id INT PRIMARY KEY IDENTITY(1,1),
    AuditData NVARCHAR(100)

);

CREATE TRIGGER trg_TblPersonel_forInsert2
ON PERSONELLER
FOR INSERT
AS BEGIN

    DECLARE @id INT;
    SELECT @id = id from inserted; 
    INSERT INTO TblPersonellerAudit VALUES(CAST(@id AS NVARCHAR(3)) + 'id burada' + CAST(GETDATE() AS nvarchar(20)))

END

insert into PERSONELLER VALUES('hghgf', 'gfgf', 'gfg', 50);

SELECT * FROM TblPersonellerAudit;

-- delete trigger
CREATE TRIGGER trg_TblPersonel_forDelete
ON PERSONELLER
FOR DELETE
AS BEGIN

    SELECT * FROM deleted;

END

-- TSQL

-- IF
DECLARE @sayi INT
SET @sayi = 5;

IF @sayi>1
    BEGIN

        PRINT 'BUYUKTUR'

    END
    
    
DECLARE @count INT;
SET @count = 8;

IF @count=99
BEGIN
    PRINT @count
END

ELSE IF @count=98
BEGIN

PRINT @count
END

ELSE
BEGIN
    PRINT @count

END

-- WHILE
WHILE @sayi<=99
BEGIN

PRINT 'CALİSİYOR'
SET @sayi = @sayi+1
END

-- sistem fonksiyon degiskenleri
SELECT @@CPU_BUSY

-- case
SELECT [ad], [zamli maas] = 

    CASE [cinsiyet]

        WHEN 'K' THEN maas*3
        WHEN 'E' THEN maas*2
        ELSE -99

    END,

    [id]

FROM Personeller;

-- case like
SELECT [name], [a ve m] = 

    CASE

        WHEN [name] LIKE 'a%' THEN 'A'
        WHEN [name] LIKE 'm%' THEN 'M'
        ELSE 'No'

    END,

    [id]

FROM Personeller;

-- TRY CATCH
BEGIN TRY
DROP TABLE olmayanTablo
END TRY
BEGIN CATCH
PRINT 'HATA'
PRINT ERROR_NUMBER();
PRINT ERROR_MESSAGE();
END CATCH
