CREATE DATABASE Db_Kutuphane;
USE Db_Kutuphane;

CREATE TABLE Kullanici(

    kullanici_id INT PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(20),
    soyad NVARCHAR(20),
    yas int,
    tc CHAR(11),
    tel CHAR(11),
    adres NVARCHAR(30)
);

CREATE TABLE Kitap_tur(

    tur_id int PRIMARY KEY IDENTITY(1,1),
    tur NVARCHAR(15)

);

CREATE TABLE kitaplar(

    kitap_id int PRIMARY KEY IDENTITY(1,1),
    ad NVARCHAR(20),
    tur_id int FOREIGN KEY REFERENCES Kitap_tur(tur_id)

);

CREATE TABLE Kutuphane(

    emanet_id INT PRIMARY KEY IDENTITY(1,1),
    kullanici_id INT FOREIGN KEY REFERENCES Kullanici(kullanici_id),
    kitap_id INT FOREIGN KEY REFERENCES kitaplar(kitap_id),
    alis_tarih datetime DEFAULT CURRENT_TIMESTAMP,
    iade_tarih datetime

);

INSERT INTO Kitap_tur VALUES ('Korku'),
('Gerilim'),
('Aksiyon'),
('Romantik'),
('Dini'),
('Tarihi'),
('Savaş')

select * from Kitap_tur;

INSERT INTO kitaplar VALUES('alice harikalar', 7),
('Suç ve ceza', 3),
('Çanakkale savaşı', 6),
('Hz Muhammed',5),
('Hz Isa',5),
('Evlilik',4),
('Istanbulun Fethi',6);

select * from kitaplar;

INSERT INTO Kullanici VALUES('Ahmet Furkan', 'DEMIR', 20, '22222222222', '0536547802', 'Konya'),
('Misirli', 'Omar', 25, '11111111111', '0539517312', 'Misir'),
('Said', 'topcu', 30, '11411811984', '0838717312', 'Izmir'),
('Merve', 'Kalemogillari', 40, '97411811844', '0138712411', 'Istanbul')

SELECT * FROM Kullanici;
SELECT * FROM kitaplar;

INSERT INTO Kutuphane(kullanici_id, kitap_id) VALUES(1, 3),
(2,4),
(3,5),
(4,5),
(1,6),
(1,7),
(4,4),
(2,3),
(3,5)

SELECT * FROM Kutuphane;

DECLARE @iade DATETIME 
set @iade = CURRENT_TIMESTAMP;
SELECT @iade
UPDATE Kutuphane set iade_tarih=@iade WHERE emanet_id=7;

-- kutuphane bilgileri
SELECT Kullanici.ad, Kullanici.soyad, Kullanici.tel, kitaplar.ad, Kitap_tur.tur, Kutuphane.alis_tarih, Kutuphane.iade_tarih
FROM Kutuphane
INNER JOIN Kullanici ON Kutuphane.kullanici_id=Kullanici.kullanici_id
INNER JOIN kitaplar ON Kutuphane.kitap_id=kitaplar.kitap_id
INNER JOIN Kitap_tur ON kitaplar.tur_id=Kitap_tur.tur_id

SELECT Kullanici.kullanici_id, Kullanici.ad, Kullanici.soyad
from Kutuphane
INNER JOIN Kullanici ON kutuphane.kullanici_id=Kullanici.kullanici_id;

SELECT Kullanici.ad, Kullanici.soyad, kitaplar.ad, Kitap_tur.tur
from Kutuphane
INNER JOIN Kullanici on Kutuphane.kullanici_id=Kullanici.kullanici_id
INNER JOIN kitaplar on Kutuphane.kitap_id=kitaplar.kitap_id
INNER JOIN Kitap_tur on kitaplar.tur_id=Kitap_tur.tur_id

-- YAS ORTALAMSI
SELECT AVG(Kullanici.yas)
FROM Kutuphane 
INNER JOIN Kullanici on Kutuphane.kullanici_id=Kullanici.kullanici_id;

-- En yuksek yas 1. yontem
select TOP(1) Kullanici.yas
FROM Kutuphane
INNER JOIN Kullanici on Kutuphane.kullanici_id=Kullanici.kullanici_id
ORDER BY Kullanici.yas desc;

-- En yuksek yas 2. yontem
Declare @maxYas Int;
set @maxYas= (Select max(Kullanici.yas)
FROM Kutuphane
INNER JOIN Kullanici ON Kutuphane.kullanici_id=Kullanici.kullanici_id);

Select Kullanici.ad, Kullanici.soyad, Kullanici.yas 
FROM Kutuphane
INNER JOIN Kullanici ON Kutuphane.kullanici_id=Kullanici.kullanici_id
where Kullanici.yas=@maxYas;

-- view
CREATE VIEW [QueryKullanici] AS select Kullanici.ad, Kullanici.soyad, Kullanici.yas 
from Kutuphane
INNER JOIN Kullanici ON Kutuphane.kullanici_id=Kullanici.kullanici_id;
select * from QueryKullanici;

-- inner join group by
Select Kullanici.ad, count(Kullanici.kullanici_id) [Kitap alma sayisi] 
From Kutuphane
INNER JOIN Kullanici ON Kutuphane.kullanici_id=Kullanici.kullanici_id
GROUP BY Kullanici.kullanici_id, Kullanici.ad;


-- inner join ve where
-- ortalama yastan buyuk olan kullanicilar
DECLARE @avgYas int;
set @avgYas = (select avg(Kullanici.yas)
from Kutuphane
INNER JOIN Kullanici ON Kutuphane.kullanici_id=Kullanici.kullanici_id)

SELECT Kullanici.ad, Kullanici.soyad, Kullanici.yas
FROM Kutuphane
INNER JOIN Kullanici ON Kutuphane.kullanici_id=Kullanici.kullanici_id
WHERE Kullanici.yas>@avgYas

-- PROCEDURE, fonksiyon, tekrari onlemek icin
CREATE PROCEDURE upSelectAll 
AS
BEGIN

    SELECT * from Kutuphane;

END

-- cagirilma yontemleri
upSelectAll;
exec upSelectAll;

-- parametre alması
CREATE PROCEDURE upSelectYas
@yas int
AS
BEGIN

    SELECT Kullanici.ad, Kullanici.soyad, Kullanici.yas, kitaplar.ad, Kitap_tur.tur
    FROM Kutuphane
    INNER JOIN Kullanici on Kutuphane.kullanici_id=Kullanici.kullanici_id
    INNER JOIN kitaplar on Kutuphane.kitap_id=kitaplar.kitap_id
    INNER JOIN Kitap_tur on kitaplar.tur_id=Kitap_tur.tur_id
    WHERE Kullanici.yas >=@yas;

END

-- PROCEDURE tekrar duzenleme
ALTER PROCEDURE upSelectYas
@yas int
AS
BEGIN

    SELECT Kullanici.ad, Kullanici.soyad, Kullanici.yas, kitaplar.ad, Kitap_tur.tur
    FROM Kutuphane
    INNER JOIN Kullanici on Kutuphane.kullanici_id=Kullanici.kullanici_id
    INNER JOIN kitaplar on Kutuphane.kitap_id=kitaplar.kitap_id
    INNER JOIN Kitap_tur on kitaplar.tur_id=Kitap_tur.tur_id
    WHERE Kullanici.yas >@yas;

END

upSelectYas 25;
exec upSelectYas 25;

-- PROCEDURE kaynak kodlari
sp_helptext upSelectYas;

-- procedure siler
drop procedure upSelectYas;


-- procedure kodunu şifreler
ALTER PROCEDURE upSelectAll 
WITH encryption
AS
BEGIN

    SELECT * from Kutuphane;

END

-- kod sifreli oldugu icin hata verir
-- sp_helptext upSelectYas;


-- PROCEDURE return
CREATE PROCEDURE upAVGyas
@yasIf INT,
@avgYas INT OUTPUT
AS
BEGIN

    SET @avgYas=(Select avg(Kullanici.yas)
    FROM Kutuphane
    INNER JOIN Kullanici ON Kutuphane.kullanici_id=Kullanici.kullanici_id
    WHERE Kullanici.yas>@yasIf);

END

declare @avgYas int;
exec upAVGyas 0, @avgYas OUTPUT;
print @avgYas
