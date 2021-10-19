-- Amazon.com dan Python ile cekilmis orjinal veriler.
-- verilerin toplam adedi 5084
-- veritabani nin toplam boyutu 592 MB

USE DB_AmazonProducts;

-- hizli bir bicimde en ustteki 1000 veriyi ceker
SELECT TOP (1000) [Names]
      ,[Images]
      ,[Urls]
      ,[Prices]
  FROM [DB_AmazonProducts].[dbo].[TB_AmazonProducts];

-- veri tabaninda ki toplam urun sayisi
-- 5084
SELECT COUNT(*) FROM TB_AmazonProducts;

-- Amazon.com da ki Apple elektronik urunlerini ceker.
SELECT * FROM TB_AmazonProducts WHERE Names LIKE('%Apple%');

-- Amazon.com da ki kategori olarak telefonlari ceker.
SELECT * FROM TB_AmazonProducts WHERE Names LIKE('%Telefon%');

-- Amazon.com da ki Samsung marka kulakliklari ceker.
SELECT * FROM TB_AmazonProducts WHERE 
Names LIKE('%Samsung%') AND Names LIKE('%Kulaklık%');

-- Urunler de eksik veri var mi kontrolu
SELECT * FROM TB_AmazonProducts WHERE Names IS NULL OR 
Urls IS NULL OR Prices IS NULL ;

-- urunleri artan fiyata gore siralar
SELECT * FROM TB_AmazonProducts ORDER BY Prices ASC;

-- urunleri azalan fiyata gore siralar
SELECT * FROM TB_AmazonProducts ORDER BY Prices DESC;

-- Amazon.com da ki elektronik urunlerin en yuksek fiyati
SELECT MAX(Prices) FROM TB_AmazonProducts;

-- en yuksek fiyata sahip urun fotografi
SELECT Images FROM TB_AmazonProducts WHERE 
Prices=(SELECT MAX(Prices) FROM TB_AmazonProducts);

-- en dusuk fiyata sahip urun fotografi
SELECT Images FROM TB_AmazonProducts WHERE 
Prices=(SELECT MIN(Prices) FROM TB_AmazonProducts);

-- Amazon.com da ki elektronik urunlerin en dusuk fiyati
SELECT MIN(Prices) FROM TB_AmazonProducts;

-- Amazon.com da ki elektronik urunlerin ortalama fiyatlari
SELECT AVG(Prices) FROM TB_AmazonProducts;

-- Amazon.com da ortalamanin ustunde satilan elektronik urunler
SELECT * FROM TB_AmazonProducts WHERE 
(SELECT AVG(Prices) FROM TB_AmazonProducts)>Prices;

-- Amazon.com da ortalamanin altinda satilan elektronik urunler
SELECT * FROM TB_AmazonProducts WHERE 
(SELECT AVG(Prices) FROM TB_AmazonProducts)<Prices;

-- bu komut ile Amazon.com da ki ortalamanın altin da ki verileri (satirlari) sildim.
DELETE FROM TB_AmazonProducts WHERE (SELECT AVG(Prices) FROM TB_AmazonProducts)>Prices;

-- bu komut ile de Amazon.com da ki kalan urunler den ortalamanın ustun de ki verileri (satirlari) sildim.
DELETE FROM TB_AmazonProducts WHERE (SELECT AVG(Prices) FROM TB_AmazonProducts)<Prices;

-- Tablo da bulunan Amazon.com da ki tum urunleri (satir/veri) sildim
DELETE FROM TB_AmazonProducts;

-- Veritabani kontrolu
SELECT * FROM TB_AmazonProducts;

-- Veritabanin da bulunan DB_AmazonProducts veritabani tamamen silinir.
DROP DATABASE DB_AmazonProducts;
