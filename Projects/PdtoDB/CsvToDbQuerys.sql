USE CSVtoDB;

-- toplam satir veri sayisi
SELECT COUNT(*) FROM AmazonPrime;

-- tum veriler
SELECT * FROM AmazonPrime;

-- tipi movie olan verileri cektik
SELECT * FROM AmazonPrime WHERE type LIKE 'Movie';

-- tipi TV show olanları cektik
SELECT * FROM AmazonPrime WHERE type NOT LIKE 'Movie';

-- almanya da cekilen dizi filmlerin yaratıcısını cektik
SELECT director FROM AmazonPrime WHERE country LIKE 'Germany';

-- 2010 dan sonra çekilen dizi filmler
SELECT * FROM AmazonPrime WHERE release_year > 2010;

-- adinda zombie kelime geçen filmler
SELECT * FROM AmazonPrime WHERE title LIKE '%zombie%' AND [type] LIKE 'Movie';

-- s5363 'e sahip show_id satiri silindi
DELETE FROM AmazonPrime WHERE show_id LIKE 's5363';

-- Jay Lee yapımcisina ait tum dizi filmler silinir
DELETE FROM AmazonPrime WHERE director LIKE 'Jay Lee';

-- disardan tabloya kendi olusturdugum veriyi ekledim
INSERT INTO AmazonPrime(show_id, [type] , title, director, [cast], country, date_added, release_year, rating,duration) 
VALUES('S55555', 'Movie', 'Zombie Film', 'Ahmet Furkan DEMIR', 'demir', 'Turkey', 'May 24, 2021', 2022, '18+', '5 Seasons');

-- tabloya yeni sutun ekledim
ALTER TABLE AmazonPrime ADD temp VARCHAR(30);

-- secilen sutunun veritipini degistirdik
ALTER TABLE AmazonPrime ALTER COLUMN release_year FLOAT;
ALTER TABLE AmazonPrime ALTER COLUMN release_year INT;

-- en yeni film den itibaren en eski filme siralama yapar
SELECT * FROM AmazonPrime ORDER BY release_year DESC;

-- tabloyu yeni bir tabloya kopyaladim
-- cunki silme islemlerini bu tablo da yapacagim
SELECT * INTO NewAmazonPrime FROM AmazonPrime;

-- Ahmet furkan demir yapımcisina ait tum eserler silinir.
DELETE FROM NewAmazonPrime WHERE director LIKE 'Ahmet Furkan DEMIR';

-- 2018 den sonra ki tum eserleri siler
DELETE FROM NewAmazonPrime WHERE release_year >= 2018;

-- en ussten 20 veri silinir
DELETE TOP(20) FROM NewAmazonPrime;

-- tabloyu sifirlar
TRUNCATE TABLE NewAmazonPrime;

-- tablo icersinde ki tum verileri siler
DELETE FROM NewAmazonPrime;

-- NewAmazonPrime tablosu silinir
DROP TABLE NewAmazonPrime;
