------------------------------------------------------
-- Alisveris sitesi iç,n 3 ayrı tablo oluşturuldu. Müşteri ve ürün arasında çoka-çok bir ilişki vardır. 
-- 3 ayrı tablo ile bu ilişkileri 1-N ilşkilere indirgeyelim.

CREATE DATABASE VT_ALISVERIS3
USE VT_ALISVERIS3 -- VT_ALISVERIS isimli vt yi kullan  

CREATE TABLE TblMusteriler
(  
id INT PRIMARY KEY IDENTITY(1,1),  
isim VARCHAR(30) NOT NULL,  
soyisim VARCHAR(30) NOT NULL,
mail VARCHAR(30) NOT NULL   
); 


CREATE TABLE TblUrunKategori(
id INT PRIMARY KEY IDENTITY(1,1),
kategori VARCHAR(50) NOT NULL
);

CREATE TABLE TblUrunler
(  
id INT PRIMARY KEY IDENTITY(1,1),  
ad VARCHAR(50) NOT NULL,  
fiyat FLOAT NOT NULL,
barkod VARCHAR(30) NOT NULL,
urun_kategori_id INT FOREIGN KEY REFERENCES TblUrunKategori(id)   
); 

CREATE TABLE TblMusteriAlisverisTarihi(
id INT PRIMARY KEY IDENTITY(1,1), 
tarih datetime DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE TblAlisverisKayit
(  
alisveris_id INT FOREIGN KEY REFERENCES  TblMusteriAlisverisTarihi(id), 
musteri_id INT FOREIGN KEY REFERENCES TblMusteriler(id),
urun_id INT FOREIGN KEY REFERENCES TblUrunler(id),
urun_fiyat FLOAT NOT NULL,  
adet INT NOT NULL
); 


--------------------------------------------------------Tablolara veri ekleme------------------------------------------------------
 INSERT INTO TblMusteriler VALUES ('Ali','KAYA', 'ak@com.tr'),
								  ('Hasan','ALAN', 'ha@com.tr'),
								  ('Ayşe','Bilir', 'ab@com.tr')		

					
INSERT INTO TblUrunKategori VALUES 
('GIDA'), ('ŞARKÜTERİ'),('ÇİKOLATA'),('BİSKÜVİ'),('UNLU MAMÜLLER'),('TEMİZLİK ÜRÜNLERİ')
 

INSERT INTO TblUrunler VALUES ('Peynir',15.00, '100', 2),
							  ('Yumurta',23.50, '101', 1),
							  ('Çay', 19.50, '102', 1),
							  ('Halley', 1.5, '103', 4),
							  ('Negro', 2.5, '104', 4),
							  ('Deterjan', 35.55, '105', 6)

------------------------------------------------------------------------
---BİRİNCİ MÜŞTERİ PEYNİR, YUMURTA, ÇAY ve Negroyu TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------
-- Öncelikle tüm müşteri ve ürünleri görelim
select * from TblUrunler 
select * from TblMusteriler
select * from TblMusteriAlisverisTarihi
select * from TblAlisverisKayit

INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);
--tarih alanı varsayılan olarak CURRENT_TIMESTAMP özelliğine sahip olsa hem id, hem tarih otomatik değer aldığında VALUES kısmı boş kalır ve kayda izin verilmez. 
-- VALUES (CURRENT_TIMESTAMP); şeklinde kayıt gerçekleştirildi.


--Aşağıda @Fiyat değişkenine veritabanından çekilen ürün fiyatı değer olarak atanacaktır. @Fiyat ile ilgili kodların BİRLİKTE çalıştırılması gerekmektedir.
--1. PEYNİR SATIN ALMA
DECLARE @Fiyat Float   -- fiyat adında bir değişken tanımlandı. Değişken isimleri kesinlikle @ ile başlamalıdır.
set  @Fiyat = (select fiyat from TblUrunler where id = 1);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 1, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float
set  @Fiyat = (select fiyat from TblUrunler where id = 2);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 2, @Fiyat ,5) 

--3. Çay SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 3);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 3, @Fiyat ,4) 

--4. Negro SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 5);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (1, 1, 5, @Fiyat ,7) 													

------------------------------------------------------------------------
---BİRİNCİ MÜŞTERİ PEYNİR, YUMURTA ve ÇAYI TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------


-- SELECT-WHERE İLE 4tablodan kayıt çekme  (TblMusteriler, TblUrunler, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENİFİYAT, TblAlisverisKayit.urun_fiyat ESKİFİYAT,
TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM TblAlisverisKayit, TblMusteriler, TblUrunler, TblMusteriAlisverisTarihi
WHERE ((TblMusteriler.id = TblAlisverisKayit.musteri_id) and (TblUrunler.id = TblAlisverisKayit.urun_id)) and (TblAlisverisKayit.alisveris_id=TblMusteriAlisverisTarihi.id)


-- SELECT-INNER JOIN İLE 4tablodan kayıt çekme  (TblMusteriler, TblUrunler, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENİFİYAT, TblAlisverisKayit.urun_fiyat ESKİFİYAT,
TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id);


------------------------------------------------------------------------
---İKİNCİ MÜŞTERİ PEYNİR, YUMURTA ve Deterjanı TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------
INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);
--tarih alanı varsayılan olarak CURRENT_TIMESTAMP özelliğine sahip olsa hem id, hem tarih otomatik değer aldığında VALUES kısmı boş kalır ve kayda izin verilmez. 
-- VALUES (CURRENT_TIMESTAMP); şeklinde kayıt gerçekleştirildi.


--Aşağıda @Fiyat değişkenine veritabanından çekilen ürün fiyatı değer olarak atanacaktır. @Fiyat ile ilgili kodların BİRLİKTE çalıştırılması gerekmektedir.
--1. PEYNİR SATIN ALMA
DECLARE @Fiyat Float   -- fiyat adında bir değişken tanımlandı. Değişken isimleri kesinlikle @ ile başlamalıdır.
set  @Fiyat = (select fiyat from TblUrunler where id = 1);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (2, 2, 1, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (2, 2, 2, @Fiyat ,5) 
													
--3. Deterjan SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 6);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (2, 2, 6, @Fiyat ,5)
------------------------------------------------------------------------
---İKİNCİ MÜŞTERİ PEYNİR, YUMURTA ve ÇAYI TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------




------------------------------------------------------------------------
---ÜÇÜNCÜ MÜŞTERİ Halley, Yumurta ve Negroyu TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------
INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);

--Aşağıda @Fiyat değişkenine veritabanından çekilen ürün fiyatı değer olarak atanacaktır. @Fiyat ile ilgili kodların BİRLİKTE çalıştırılması gerekmektedir.
--1. Halley SATIN ALMA
DECLARE @Fiyat Float   -- fiyat adında bir değişken tanımlandı. Değişken isimleri kesinlikle @ ile başlamalıdır.
set  @Fiyat = (select fiyat from TblUrunler where id = 4);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (3, 3, 4, @Fiyat ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (3, 3, 2, @Fiyat ,10) 
													
--3. Negro SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 5);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (3, 3, 5, @Fiyat ,8)
------------------------------------------------------------------------
---ÜÇÜNCÜ MÜŞTERİ PEYNİR, YUMURTA ve ÇAYI TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------





------------------------------------------------------------------------
---BİRİNCİ MÜŞTERİ Deterjan, Yumurta ve Çayı TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------
-- Öncelikle tüm müşteri ve ürünleri görelim
select * from TblUrunler 
select * from TblMusteriler
select * from TblAlisverisKayit

INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);

--Aşağıda @Fiyat değişkenine veritabanından çekilen ürün fiyatı değer olarak atanacaktır. @Fiyat ile ilgili kodların BİRLİKTE çalıştırılması gerekmektedir.
--1. Deterjan SATIN ALMA
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (4, 1, 6, 99 ,3) 


--2. Yumurta SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 2); 
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (4, 2, 2, @Fiyat ,7) 

--3. Çay SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 3);
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (4, 1, 3, @Fiyat ,4) 
------------------------------------------------------------------------
---BİRİNCİ MÜŞTERİ Deterjan, Yumurta ve Çayı TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------



--PEYNİR FİYATI GÜNCELLENDİ
select * from TblUrunler
UPDATE TblUrunler SET fiyat = 17.25 where id = 1


------------------------------------------------------------------------
---İKİNCİ MÜŞTERİ Peynir ve Halleyi TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------
-- Öncelikle tüm müşteri ve ürünleri görelim
select * from TblUrunler 
select * from TblMusteriler

INSERT INTO TblMusteriAlisverisTarihi (tarih) VALUES (CURRENT_TIMESTAMP);

--Aşağıda @Fiyat değişkenine veritabanından çekilen ürün fiyatı değer olarak atanacaktır. @Fiyat ile ilgili kodların BİRLİKTE çalıştırılması gerekmektedir.
--1. Peynir SATIN ALMA
DECLARE @Fiyat Float   -- fiyat adında bir değişken tanımlandı. Değişken isimleri kesinlikle @ ile başlamalıdır.
set  @Fiyat = (select fiyat from TblUrunler where id = 1);  --"select @Fiyat" veya "Print @Fiyat" ile değer görülebilir
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (5, 2, 1, @Fiyat ,4) 


--2. Halley SATIN ALMA
DECLARE @Fiyat Float  
set  @Fiyat = (select fiyat from TblUrunler where id = 4); 
INSERT INTO TblAlisverisKayit (alisveris_id, musteri_id, urun_id, urun_fiyat, adet) VALUES (5, 2, 4, @Fiyat ,7) 

------------------------------------------------------------------------
---İKİNCİ MÜŞTERİ Peynir ve Halleyi TEK BİR ALIŞVERİŞTE ALIRSA---
------------------------------------------------------------------------



-- SELECT-INNER JOIN İLE 4tablodan kayıt çekme  (TblMusteriler, TblUrunler, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENİFİYAT, TblAlisverisKayit.urun_fiyat ESKİFİYAT,
TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id);


-- SELECT-WHERE İLE 5tablodan kayıt çekme  (TblMusteriler, TblUrunler, TblUrunKategori, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENİFİYAT, TblAlisverisKayit.urun_fiyat ESKİFİYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM TblAlisverisKayit, TblMusteriler, TblUrunler, TblMusteriAlisverisTarihi, TblUrunKategori
WHERE (
(TblMusteriler.id = TblAlisverisKayit.musteri_id) and (TblUrunler.id = TblAlisverisKayit.urun_id)) and 
((TblAlisverisKayit.alisveris_id=TblMusteriAlisverisTarihi.id) and (TblUrunler.urun_kategori_id=TblUrunKategori.id))


-- SELECT-INNER JOIN İLE 5tablodan kayıt çekme  (TblMusteriler, TblUrunler,  TblUrunKategori, TblAlisverisKayit, TblMusteriAlisverisTarihi)
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENİFİYAT, TblAlisverisKayit.urun_fiyat ESKİFİYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
);



------------------------------ GEÇMİŞ ALIŞVERİŞLERLE İLGİLİ GENEL SORGULAR ----------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- id si 1 olan müşterinin alışveriş geçmişi
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENİFİYAT, TblAlisverisKayit.urun_fiyat ESKİFİYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
) where TblMusteriler.id = 1


-- id si 2 olan alışverişin bilgileri
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENİFİYAT, TblAlisverisKayit.urun_fiyat ESKİFİYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
) where TblAlisverisKayit.alisveris_id = 2


-- En son yapılan alışverişe ait bilgileri getir
SELECT TblAlisverisKayit.alisveris_id, TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat YENİFİYAT, TblAlisverisKayit.urun_fiyat ESKİFİYAT,
TblUrunKategori.kategori, TblAlisverisKayit.adet, TblMusteriAlisverisTarihi.tarih
FROM (TblAlisverisKayit 
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id= TblMusteriler.id
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id
INNER JOIN TblMusteriAlisverisTarihi ON TblAlisverisKayit.alisveris_id = TblMusteriAlisverisTarihi.id
INNER JOIN TblUrunKategori ON TblUrunler.urun_kategori_id = TblUrunKategori.id
) where TblAlisverisKayit.alisveris_id = (Select max(alisveris_id) from TblAlisverisKayit)




select * from TblAlisverisKayit

-- Tüm alışverişlerin toplam fiyat tutarı
SELECT sum(TblAlisverisKayit.urun_fiyat*TblAlisverisKayit.adet)
FROM TblAlisverisKayit 

-- Her bir müşterinin şu ana kadar yaptığı alışverişlerin toplam fiyat tutarı
SELECT TblAlisverisKayit.musteri_id, sum(TblAlisverisKayit.urun_fiyat*TblAlisverisKayit.adet)
FROM TblAlisverisKayit,TblMusteriler group by TblAlisverisKayit.musteri_id

