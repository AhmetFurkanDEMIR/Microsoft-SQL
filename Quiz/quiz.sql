USE VT_SARF_MAZLEME;

-- 1. SORU --
CREATE TABLE TEDARIKCI(

    T_ID INT PRIMARY KEY,
    AD VARCHAR(20),
    VERGI_NO INT NOT NULL,
    TEDARIK_EDILEN_URUN_KODU INT,
    ADRES VARCHAR(20) DEFAULT 'KONYA'

);

-- 2. SORU --
ALTER TABLE MUSTERI ALTER COLUMN MUSTERI_NO INT NOT NULL;
ALTER TABLE MUSTERI ADD CONSTRAINT PK_MUS PRIMARY KEY(MUSTERI_NO);
ALTER TABLE SIPARIS ADD CONSTRAINT FK_MUS FOREIGN KEY (MUSTERI_KODU) REFERENCES MUSTERI(MUSTERI_NO) ON DELETE SET NULL;

-- 3. SORU --
ALTER TABLE URUN ALTER COLUMN U_ID INT NOT NULL;
ALTER TABLE URUN ADD CONSTRAINT PK_URUN PRIMARY KEY(U_ID);
ALTER TABLE TEDARIKCI ADD CONSTRAINT FK_TED FOREIGN KEY(TEDARIK_EDILEN_URUN_KODU) REFERENCES URUN(U_ID) ON DELETE SET NULL;

-- 4. SORU --
SELECT SUM(SIPARIS.MIKTAR*URUN.BIRIM_FIYAT) [TOPLAM] 
FROM URUN
INNER JOIN SIPARIS ON URUN.U_ID=SIPARIS.URUN_KODU; 

-- 5. SORU 1. YONTEM --
DECLARE @top INT;
SET @tOP = 
(SELECT SUM(SIPARIS.MIKTAR*URUN.BIRIM_FIYAT) 
FROM SIPARIS
INNER JOIN URUN ON SIPARIS.URUN_KODU=URUN.U_ID
INNER JOIN MUSTERI ON MUSTERI.MUSTERI_NO=SIPARIS.MUSTERI_KODU
GROUP BY MUSTERI.AD HAVING MUSTERI.AD='AYSE')

SELECT MUSTERI.AD, MUSTERI.SOYAD, MUSTERI.TELEFON, @top [SIPARIS TOPLAM]
FROM MUSTERI WHERE MUSTERI.AD='AYSE'; 

-- 5. SORU 2. YONTEM --
DECLARE @toplam INT;
SET @toplam = (select sum(URUN.BIRIM_FIYAT * SIPARIS.MIKTAR) from SIPARIS inner join URUN on SIPARIS.URUN_KODU = URUN.U_ID where SIPARIS.MUSTERI_KODU in (select MUSTERI_NO from MUSTERI where AD = 'Ayşe' and SOYAD = 'Dağlı'))
select MUSTERI.AD, MUSTERI.SOYAD, MUSTERI.TELEFON, @toplam [siparis toplam]
from MUSTERI WHERE MUSTERI.AD='AYSE';

-- 6. SORU --
CREATE VIEW [SIPARIS_BILGILERI] AS SELECT MUSTERI.AD, MUSTERI.SOYAD, URUN.AD [urun ad], URUN.BIRIM_FIYAT, SIPARIS.MIKTAR, URUN.BIRIM_FIYAT*SIPARIS.MIKTAR [TUTAR]
FROM SIPARIS
INNER JOIN MUSTERI ON SIPARIS.MUSTERI_KODU=MUSTERI.MUSTERI_NO
INNER JOIN URUN ON SIPARIS.URUN_KODU=URUN.U_ID;

SELECT * FROM SIPARIS_BILGILERI;

-- 7. SORU --
SELECT SIPARIS.ODEME_TURU, SUM(SIPARIS.MIKTAR*URUN.BIRIM_FIYAT) [TOPLAM] 
FROM SIPARIS
INNER JOIN URUN ON SIPARIS.URUN_KODU=URUN.U_ID
GROUP BY SIPARIS.ODEME_TURU;

-- 8. SORU --
CREATE VIEW [QUERY_CASE] AS SELECT MUSTERI.AD,
    
    CASE SIPARIS.ODEME_TURU

        WHEN 1 THEN SIPARIS.MIKTAR*URUN.BIRIM_FIYAT
        ELSE NULL
    
    END [PESIN],

    CASE SIPARIS.ODEME_TURU

        WHEN 2 THEN SIPARIS.MIKTAR*URUN.BIRIM_FIYAT
        ELSE NULL
    
    END [KREDI],

    CASE SIPARIS.ODEME_TURU

        WHEN 3 THEN SIPARIS.MIKTAR*URUN.BIRIM_FIYAT
        ELSE NULL
    
    END [CEK]


FROM SIPARIS
INNER JOIN MUSTERI ON SIPARIS.MUSTERI_KODU=MUSTERI.MUSTERI_NO
INNER JOIN URUN ON URUN.U_ID=SIPARIS.URUN_KODU;

SELECT QUERY_CASE.AD, SUM(QUERY_CASE.PESIN) [PESIN], SUM(QUERY_CASE.KREDI) [KREDI], SUM(QUERY_CASE.CEK) [CEK] FROM QUERY_CASE
GROUP BY QUERY_CASE.AD;
