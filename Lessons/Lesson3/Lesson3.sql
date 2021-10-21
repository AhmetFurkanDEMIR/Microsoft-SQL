USE VTDERS21EKIM;

SELECT * FROM kisiler;

-- sehir bilgilerinden sadece tek sekilde dondurur, tekrar etmeden
SELECT DISTINCT sehir from kisiler;

-- select sorgusu ile sart calistirma
SELECT * FROM kisiler WHERE sehir='Ankara'

-- select sorgusu ile sart calistirma
SELECT * FROM kisiler WHERE id > 1;

-- id 1 'e esit olmayan
SELECT * FROM kisiler WHERE id <> 1;

-- arasinda ki degerleri alir
SELECT * FROM kisiler WHERE id BETWEEN 2 AND 3;

-- dogum yili 1820 ve 1900 arasin da ki kisiler
SELECT * FROM yazarlar WHERE DOGUM_YILI BETWEEN 1820 AND 1900; 

-- arasinda ki degerleri alir
SELECT * FROM kisiler WHERE ad BETWEEN 'A' AND 'P';

-- alfabetik olarak ali den daha buyuk olan verileri dondurur
SELECT * FROM kisiler WHERE ad > 'Ali';

-- where and sarti 
SELECT * FROM yazarlar WHERE DOGUM_YILI>1825 and DOGUM_YILI<1943;

SELECT * FROM UYELER WHERE ISIM='Deniz' AND CINSIYET='K';

-- where or sarti
SELECT * FROM UYELER WHERE ISIM='Deniz' OR CINSIYET='K';

-- where and ve or sarti
SELECT * FROM UYELER WHERE CINSIYET='E' AND (SOYISIM='Aydın' OR SOYISIM='Zafer');

-- adi ayni anda ahmet ve mehmet olani dondurur
SELECT * FROM PERSONEL WHERE ISIM='Ahmet' AND ISIM='Mehmet'; 

-- yasi 30 dan büyük ve erkek veya yaş 25 ten küçük ve kadin
SELECT * FROM PERSONEL WHERE (YAS>30 and CINSIYET='E') or (yas<25 and CINSIYET='K');

-- yasi otuzdan buyuk veya ankarada yasiyan ve maasi 2500 den buyuk veya cinsiyeti kadin
SELECT * FROM PERSONEL WHERE (YAS>30 or KENT='Ankara') and (MAAS>2500 or CINSIYET='K');

-- order by siralama
-- asc kucukten buyuge
-- desc buyukten kucuge
SELECT ISIM, SOYISIM FROM PERSONEL ORDER BY ISIM;

SELECT ISIM, SOYISIM FROM PERSONEL ORDER BY SOYISIM DESC;

-- turkiye de erkek olanlarin maasinin siralanmasi
SELECT * FROM PERSONEL WHERE CINSIYET='E' and ULKE='Türkiye'  ORDER BY MAAS;

-- en ustten 2 veri
SELECT TOP 2 * FROM PERSONEL WHERE CINSIYET='E' and ULKE='Türkiye'  ORDER BY MAAS;

-- string karsilastirmasi
SELECT * from PERSONEL where ISIM LIKE 'Hans'; 

-- ismi H harfi ile baslayanlar
SELECT * from PERSONEL where ISIM LIKE 'H%';

-- ismi z harfi ile biten
SELECT * from uyeler where ISIM LIKE '%z';
 
-- ismin de er olan
SELECT * from uyeler where ISIM LIKE '%er%';

--  ismin de er olmayan
SELECT * from uyeler where ISIM LIKE '%er%';

-- like jokerleri
-- % = birden fazla karekterin yerine gecer,  _ = 1 adet karekterin yerine gecer
-- [liste] = liste de ki herhangibiri olan, [^liste] veya [!liste] = liste de olmayan karakterlerden biri

-- tek karakter doldurma ornegi
SELECT * FROM UYELER WHERE UYE_ADI LIKE 'H_ZAFER';

-- liste de ki herhangi bir harfin olmasi yeterlidir
SELECT * FROM UYELER WHERE UYE_ADI LIKE 'er[hckm]an';

-- adi e veya k harfi ile baslamayan
SELECT * FROM UYELER WHERE UYE_ADI LIKE '[^EK]%';

-- in, icinde karsilastirmasi
SELECT * FROM UYELER WHERE CINSIYET IN ('e', 'k');

-- as (alias), linux da kine benzer, kisaltma amacli
SELECT ISIM AS ad, SOYISIM AS soy FROM PERSONEL ORDER BY ad; 

-- tablo adi kisaltma
SELECT u.isim FROM uyeler u;
