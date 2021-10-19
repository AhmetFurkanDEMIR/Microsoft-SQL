-- CREATE, INSERT, UPDATE, DELETE, SELECT

-- veritabani olusturma
CREATE DATABASE DB_OKUL;

-- veritabanini secme
USE DB_OKUL;

-- tabloya sutunleri ekleme
CREATE TABLE TblOgrenci(

	id INT NOT NULL,
	isim VARCHAR(30) NOT NULL,
	soyisim VARCHAR(20)

);

-- tabloya yeni sutun ekleme
ALTER TABLE TblOgrenci ADD dtarihi VARCHAR(30);

-- dtarihi sutununun veri tipini degistirdik
ALTER TABLE TblOgrenci ALTER COLUMN dtarihi DATE;

-- isim sutununun degisken tipini degistirdik, uzunluguda
ALTER TABLE TblOgrenci ALTER COLUMN isim NVARCHAR(40);

-- tabloya yeni veri ekleme
INSERT INTO TblOgrenci VALUES(0,'Ahmet Furkan', 'DEMIR', '2017/08/25');

-- tum tabloyu cekip print ettik
SELECT * FROM TblOgrenci;

-- sutune gore veri cekme okuma
SELECT id, isim, soyisim, dtarihi FROM TblOgrenci;

-- sarta gore veri cekme okuma
SELECT * FROM TblOgrenci WHERE soyisim > 'a';

-- sarta gore veri cekme okuma
SELECT * FROM TblOgrenci WHERE id > 0;

-- sarta gore veri cekme okuma
SELECT * FROM TblOgrenci WHERE isim LIKE '%a';

-- sutune gore veri ekleme, sirayla, bos birakilabilir
INSERT INTO TblOgrenci(id, isim, soyisim) VALUES(1, 'Mehmet Faruk', 'Kalemci');

-- toplu veri ekleme 
INSERT INTO TblOgrenci VALUES
(2, 'mehmet ali', 'tasci', '2018/07/25'),
(3, 'merve seda', 'soner', '2001/01/29'),
(4, 'canan tasci', 'kocer', '2000/07/25');

-- veri de secilen id 'nin isimini deigstirme
UPDATE TblOgrenci SET isim = 'Degistirildi Mehmet' WHERE id=4;

-- tablo da secilen verinin (satirin) silinmesi
DELETE FROM TblOgrenci WHERE id = 5;

-- yeni ogretmen tablosu
CREATE TABLE TblOgretmen(id INT);


-- VERI TIPI DONUSTURME DENEMESİ
-- 0,1,2,3 İNT VE STRİNG OLARAK DONUSTURDUK
-- AMA 'AA' İNT DONUSTURULEMİYOR
INSERT INTO TblOgretmen VALUES (0), (1), (2), (3), (4);

SELECT * FROM TblOgretmen;

ALTER TABLE TblOgretmen ALTER COLUMN id VARCHAR(2);

INSERT INTO TblOgretmen VALUES (4);

ALTER TABLE TblOgretmen ALTER COLUMN id INT;

ALTER TABLE TblOgretmen ALTER COLUMN id VARCHAR(2);

INSERT INTO TblOgretmen VALUES ('aa');

-- ERROR
-- ALTER TABLE TblOgretmen ALTER COLUMN id INT;

-- otamatik id artar
CREATE TABLE TblDersler(

	id INT IDENTITY(1,1),
	ders_adi VARCHAR(20),
	PRIMARY KEY(id)
);

-- GO komutunu ayrı satir da kullan
-- GO komutu kendisinden onceki kod yıgınını bitirdigini belirtir. (once tanimlanan degisken kullanilamaz)
-- sonuncu GO yok ise sorgu servera gonderilemez.

GO

INSERT INTO TblDersler VALUES('MATEMATİK')

GO 5

-- en ustten 2 veri siler.
DELETE TOP(2) from TblDersler;

-- tabloyu sifirlar
TRUNCATE TABLE TblDersler;
