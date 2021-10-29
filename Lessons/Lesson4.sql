USE VTDERS21EKIM;

-- Kümeleme Fonksiyonları
-- Veri tabanında bu fonksiyonları kullanrak istegimizi hizli bir sekilde gerceklestirebiliriz
-- tum fonksiyonları gormek icin dokumana ilerleyiniz, https://www.w3schools.com/sql/sql_ref_sqlserver.asp

-- AVG, Sutun ortalamasi alir
-- bu ornek de personel tablosunda ki calisanların maas ortalamasini alir
SELECT avg(maas) FROM PERSONEL;

-- 2000 den buyuk olan maaslarin ortalamasini alir
SELECT avg(maas) FROM PERSONEL where maas>2000;

-- Round, yuvarlama yapar
-- virgulden sonraki paremetreye gore basamagi yuvarlar
Select round(5.3569,2) yuvarlanmis;

-- ceiling, sayiyi bir ust basamaga yuvarlar
SELECT CEILING(50.00001) [ust basamak];

-- floor, sayiyi bir alt basamaga yuvarlar
SELECT FLOOR(50.999999) [alt basamak]

-- count, satir yani veri adedini dondurur, 
-- count(sutunAdi) seklinde kullanilirsa null olan degerler hesaba katilmaz
-- count(*) seklinde kulanilirsa tum satir yani veri sayisini dondurur

-- degeri dolu olan 9 personel var
SELECT count(maas) from PERSONEL;

-- personel tablosunda kesinlikle 9 kişi yani veri var
SELECT count(*) From PERSONEL;

-- maasi 2000 den buyuk olan null olmayan deger sayisi
SELECT count(maas) from PERSONEL where maas>2000;

-- distinct, sutunde ki verilerden kendine ozgu bir deger olanlari dondurur, yani tekrarlamadan 
-- 4 farkli ulke sayisi oldugunu goruyoruz
select count(distinct ulke) as ulkeSayısı from personel

-- 4 farkli ulke oldugunu goruyoruz
Select distinct ulke from personel

-- iki ic ice select sorgusu yazabiliriz
-- bu ornek de en buyuk yas degeri select sorgusu ile bulunur ve 
-- bir diger select sorgusunda bu degere sahip kisi aranir ve ekrana bastirilir
select isim, yas from personel where yas=(select max(yas) from personel)

-- tam tersi en kucuk yasa sahip kisi
select isim, yas from personel where yas=(select min(yas) from personel)

-- Sum, sütunun toplamini alir
-- tum personellerin toplam maasi
select sum(maas) from personel;

-- sum ile baska bir yontemle ortalama da alinabilir
select sum(maas)/count(maas) from personel;

--* GROUP BY *--
-- Secilen sutunlarda verinin gruplanmasini ve gruplarda ayri islemler yapilmasina olanak tanir

-- ulkeleri kendi arasinda gruplar
Select ulke from Personel GROUP by ulke;

-- ulkelerdeki insanlari gruplayarak ortalama maasini hesaplayan sorgu
Select ulke, avg(maas) [ortalama maas] from PERSONEL group by ulke;

-- sirayla ulkelerine ve kentlerine gore gruplama
-- yani birden cok gruplama yapabiliyoruz
Select ulke, kent from personel group by ulke, kent;

-- Soru: personelleri önce ülkeye sonra cinsiyete göre gruplayıp ülke, cinsiyet,
-- yas ortalamalarını, ve her grupta kaç personel olduğunu donsuren sorgu.

Select ulke, cinsiyet, avg(yas) [yas ortalamasi], count(*) [toplam personel sayisi] 
from PERSONEL GROUP by ulke, cinsiyet;

-- Soru: Maaşı 2000'den büyük olan personelleri ülke ve cinsiyetlerine göre gruplayip 
-- ülke, cinsiyet, yas ortalamalarını, ve her grupta kaç personel olduğunu donduren sorguyu yaziniz.
Select ulke, cinsiyet, avg(yas), count(*) from personel where maas > 2000 GROUP by ulke, cinsiyet;

--* HAVING *--
-- where ifadesi gibi filitreleme yani sart yazmamizi saglar, ancak where tum sutunlarda bu islemi gerceklestirir
-- Having ise ayirdigimiz gruplarda ki sutunler icersinde bir filitreleme yapmamizi saglar, tum sutunlarda degil

-- Soru: personelleri kentlerine göre gruplayıp eger bu kentlerde 1 den fazla kisi olan grup var ise
-- ekrana getiren sorguyu yaziniz
Select kent, count(*) [kentde ki personel sayisi] from personel group by kent having count(*)>1; 

-- Soru: personelleri ülkelerine göre gruplayıp cinsiyeti Erkek olan; her bir grubun ortalama, maaşı
-- 3000'den büyük olan grubun ulke adi ve ortalama maaslarini getiren sorguyu yaziniz.
Select ulke, avg(maas) [ortalama maas] from personel where cinsiyet='E' GROUP by ulke having avg(maas)>3000;

-- Soru: Maaşı 2000'e eşit veya daha fazla olan personelleri ülkelerine göre gruplayıp
-- grubun yaş ortlaması 25 e eşit veya daha büyük olan grupların ülke, yaş ortalaması,
-- maaş ortalaması ve kişi sayısı bilgilerini getiren sorguyu yaziniz
Select ulke, avg(yas) [yas ortalamasi], avg(maas) [maas ortalamasi], count(*) [kisi sayisi] from PERSONEL
where maas >=2000 group by ulke HAVING avg(yas) >=25;

-- Soru: personelleri ulkelerine göre gruplayıp, grupları kendi içlerindeki maaş bilgilerine göre
-- en yuksek maas ortalamasina sahip olan ulkeyi getiren sorgu

-- 1. yontem
Select TOP(1) ulke, avg(maas) [Ulke maas ortalamasi] from PERSONEL
GROUP by ulke ORDER by avg(maas) DESC;

-- 2. yontem
CREATE VIEW [sorgu] AS SELECT ulke, avg(maas) [UlkeMaasOrtalamasi] from personel group by ulke;
Select max(UlkeMaasOrtalamasi) [UlkeMaasOrtalamasi] from sorgu1;

