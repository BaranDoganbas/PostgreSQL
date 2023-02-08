CREATE TABLE ogrenciler5
(
ogrenci_no char(7),-- Uzunluğunu bildiğimiz stringler için CHAR kullanılır
isim varchar(20), -- Uzunluğunu bilmediğimiz stringler için VARCHAR kullanırız
soyisim varchar(25),
not_ort real,-- Ondalıklı sayılar için kullanılır(Double gibi)
kayit_tarih date);
-- VAROLAN BİR TABLODAN YENİ BİR TABLO OLUŞTURMA
CREATE TABLE NOTLAR
AS
SELECT isim,not_ort FROM ogrenciler5;
select * from notlar;
--INSERT- TABLO İÇİNE VERİ EKLEME
INSERT INTO notlar VALUES ('Osman',95.5);
INSERT INTO notlar VALUES ('Sumeyye',95.5);
INSERT INTO notlar VALUES ('Salih',95.5);
INSERT INTO notlar VALUES ('Hakan',95.5);
INSERT INTO notlar VALUES ('Adem',95.5);
select * from notlar;
select isim from notlar;
-- CONSTRAINT
--UNIQEU
--NOT NULL
CREATE TABLE ogrenciler7
(
ogrenci_no char(7) unique,
isim varchar(20) not null,
soyisim varchar(25),
not_ort real,
kayit_tarih date
);
select * from ogrenciler7;

INSERT INTO ogrenciler7 VALUES ('1234567','Baran','Doganbas',75.5,now())
INSERT INTO ogrenciler7 VALUES ('1234568','Ali','Veli',75.5,now())
INSERT INTO ogrenciler7 (ogrenci_no,soyisim,not_ort) VALUES ('1234569','Evren',85.5);-- NOT NULL kisitlamasi oldugu icin bu veri eklenemez

-- PRIMARY KEY

CREATE TABLE ogrenciler8
(
ogrenci_no char(7) PRIMARY KEY,
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarih date
);

-- PRIMARY KEY atamasi 2.Yol

CREATE TABLE ogrenciler9
(
ogrenci_no char(7), 
isim varchar(20), 
soyisim varchar(25), 
not_ort real,
kayit_tarih date,
CONSTRAINT ogr primary key(ogrenci_no)
);

CREATE TABLE ogrenciler10
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarih date,
PRIMARY KEY(ogrenci_no)
);

-- FOREIGN KEY

/*
Practice 4:
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/

CREATE TABLE tedarikciler3
(
tedarikci_id char(5) PRIMARY KEY,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)
);

CREATE TABLE urunler(
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY(tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

SELECT * FROM tedarikciler3;
select * from urunler:

/*
“calisanlar” isimli bir Tablo olusturun. 
Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun. 
“id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.
Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.
*/

CREATE TABLE calisanlar(
id char(5) PRIMARY KEY,
isim varchar(20) unique,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE adresler(
adres_id char(5),
sokak varchar(15),
cadde varchar(15),
sehir varchar(15),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * from calisanlar1;
SELECT * FROM adresler;

-- CHECK CONSTRAINT

CREATE TABLE calisanlar1(
id char(15) PRIMARY KEY,
isim varchar(30) unique,
maas int CHECK (maas>10000),
ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');

-- DQL -- WHERE KULLANIMI

SELECT * FROM calisanlar;
SELECT isim from calisanlar;

-- Calisanlar tablosundan maasi 5000'den buyuk olan isimleri listeleyiniz
Select isim from calisanlar WHERE maas>5000;

-- Calisanlar tablosundan ismi Veli Han olan tum verileri listeleyiniz.
select * from calisanlar WHERE isim='Veli Han';

-- Calisanlar tablosundan maasi 5000 olan tum verileri listeleyiniz
Select * from calisanlar WHERE maas=5000;

-- DML -- DELETE KOMUTU
Delete from calisanlar; -- Eger parent table baska bir child tablo ile iliskili ise once child tablo silinmelidir
Delete from adresler;
SELECT * FROM adresler;

-- Adresler tablosundan sehri Antep olan verileri silelim
DELETE FROM adresler WHERE sehir='Antep';

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
CREATE TABLE ogrenciler11
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler11 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler11 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler11 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler11 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler11 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler11 VALUES(127, 'Mustafa Bak', 'Ali', 99);
