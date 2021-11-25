CREATE DATABASE VT_ALISVERIS;
USE VT_ALISVERIS;

CREATE TABLE TblMusteriler(
	
	id INT PRIMARY KEY IDENTITY(1,1),
	isim VARCHAR(30) NOT NULL,
	soyisim VARCHAR(30) NOT NULL,
	ceptel VARCHAR(11) NOT NULL,
	mail VARCHAR(30) NOT NULL
);

CREATE TABLE TblUrunKategori(
	
	id INT PRIMARY KEY IDENTITY(1,1),
	kategori VARCHAR(50) NOT NULL,
);

CREATE TABLE TblUrunler(

	id INT PRIMARY KEY IDENTITY(1,1),
	ad VARCHAR(50) NOT NULL,
	fiyat FLOAT NOT NULL,
	barkod VARCHAR(30) NOT NULL,
	urun_kategori_id INT FOREIGN KEY REFERENCES TblUrunKategori(id)
);

CREATE TABLE TblAlisverisKayit(

	alisveris_id INT PRIMARY KEY IDENTITY(1,1),
	musteri_id INT FOREIGN KEY REFERENCES TblMusteriler(id),
	urun_id INT FOREIGN KEY REFERENCES TblUrunler(id),
	adet INT NOT NULL,
	tarih datetime DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO TblMusteriler VALUES
('Ali', 'KAYA', '05555555555','alikaya@gmail.com'),
('Veli', 'DATLI', '05555555444', 'velidagli@gmail.com'),
('Ayþe', 'BILIR', '05555555333', 'aysebilir@gmail.com')

INSERT INTO TblUrunKategori VALUES
('GIDA'), ('SARKÜTERI'), ('ÇIKOLATA'), ('BISKÜVI'), ('UNLU MAMULLER'), ('TEMIZLIK ÜRÜNLERI')

select * from TblAlisverisKayit

select * from TblUrunler

INSERT INTO TblUrunler VALUES
('Çay', 29.75, '113', 1),
('Ekmek', 1.4, '114', 5),
('Halley', 1.5, '115', 4),
('Negro', 2.5, '116', 4),
('Deterjan', 35.55, '117', 6),
('Ayçiçek Yagi', 98.55, '118', 1),
('Gevrek', 15.25, '119', 5)

INSERT INTO TblUrunler VALUES
('Ayçiçek Yagi', 98.55, '118', 1),
('Gevrek', 15.25, '119', 5)


INSERT INTO TblAlisverisKayit (musteri_id, urun_id, adet) VALUES
(1, 2, 3),
(2, 1, 2),
(3, 1, 1),
(1, 5, 2)

Select * from TblAlisverisKayit

SELECT TblMusteriler.isim, TblMusteriler.soyisim, TblUrunler.ad, TblUrunler.fiyat, TblAlisverisKayit.tarih from((TblAlisverisKayit
INNER JOIN TblMusteriler ON TblAlisverisKayit.musteri_id = TblMusteriler.id)
INNER JOIN TblUrunler ON TblAlisverisKayit.urun_id = TblUrunler.id)
