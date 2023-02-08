CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler3
-- İsmi Mustafa Bak ve Nesibe Yılmaz olan kayıtları silelim

DELETE FROM ogrenciler3 WHERE isim='Mustafa Bak' or isim = 'Nesibe Yilmaz';

-- Veli ismi Hasan olan datayi silelim

DELETE FROM ogrenciler3 WHERE veli_isim='Hasan'

-- TRUNCATE --
-- Bir tablodaki tum verileri geri alamayacagimiz sekilde siler. Sartli silme yapmaz.
TRUNCATE TABLE ogrenciler3;

CREATE TABLE talebeler1
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar1(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler1(id)
on delete cascade
);

-- ON DELETE CASCADE
DROP TABLE if exists talebeler -- Eger tablo varsa tabloyu siler

INSERT INTO talebeler1 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler1 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler1 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler1 VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler1 VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar1 VALUES ('123','kimya',75);
INSERT INTO notlar1 VALUES ('124', 'fizik',65);
INSERT INTO notlar1 VALUES ('125', 'tarih',90);
INSERT INTO notlar1 VALUES ('126', 'Matematik',90);

select * from talebeler1;
select * from notlar1;

-- Notlar tablosundan id'si 123 olan datayı silelim

DELETE FROM notlar WHERE talebe_id='123';

--Talebeler tablosundan id'si 126 olan datayi silelim

DELETE FROM talebeler1 WHERE id='126';

-- ON SELECT CASCADE --
/*
Normalde data silmek için önce "Child Table" dan datayi siler daha sonra parent'dan sileriz ama
ON DELETE CASCADE iliskisi kurulduğunda direk "Parent Table"  dan datayi silebiliriz. Data "Parent"dan
silindiğinde "Child" dan da silinir.
*/

CREATE TABLE talebe
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
CREATE TABLE not1(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebe(id)
on delete cascade
);

INSERT INTO talebe VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebe VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebe VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebe VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebe VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO not1 VALUES ('123','kimya',75);
INSERT INTO not1 VALUES ('124', 'fizik',65);
INSERT INTO not1 VALUES ('125', 'tarih',90);
INSERT INTO not1 VALUES ('126', 'Matematik',90);

select * from talebe;
select * from not1;

--Talebeler tablosundan id'si 126 olan datayi silelim

delete from talebe where id='126';

/*
    Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablo dan da silinir
*/

-- IN CONDITION

DROP TABLE if exists musteriler;

CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler

-- Musteriler tablosundan urun ismi orange, apple veya apricot olan tum datalari listeleyiniz

Select * from musteriler WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

-- IN CONDITION

SELECT * FROM musteriler WHERE urun_isim IN('Orange','Apple','Apricot');

-- NOT IN --> Yazdigimiz verilerin disindakileri getirir

SELECT * FROM musteriler WHERE urun_isim NOT IN('Orange','Apple','Apricot');

-- BETWEEN CONDITION

--Musteriler tablosundan urun_id'si 20 ile 40 arasinda olan tum verileri listeleyiniz
SELECT * FROM musteriler WHERE urun_id>=20 AND urun_id<=40;

SELECT * FROM musteriler WHERE urun_id BETWEEN 20 AND 40;

SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 40;

-- 		SUBQUERIES
--SUBQUERY baska bir SORGU(query)’nun icinde calisan SORGU’dur

CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);
INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);

SELECT * from calisanlar2
select * from markalar

-- Calisan sayisi 15.000'den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve maaslarini listeleyiniz.
SELECT isim,maas,isyeri FROM calisanlar2
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE calisan_sayisi>15000);

-- marka_id’si 101’den büyük olan marka çalişanlarinin 
-- isim, maaş ve şehirlerini listeleyiniz

SELECT isim,maas,sehir FROM calisanlar2
WHERE isyeri IN (SELECT marka_isim FROM markalar WHERE marka_id>101);

-- ÖDEV- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.

--AGGREGATE METHOD

-- Calisanlar tablosundan en yuksek maasi listeleyelim
SELECT max(maas) AS maksimum_maas FROM calisanlar2;

/*
	Eger bir sutuna gecici olarak bir isim vermek istersek AS komutunu yazdiktan sonra
vermek istediginiz ismi yazariz.
*/

-- Calisanlar tablosundan en dusuk maasi listeleyelim
SELECT min(maas) AS en_dusuk_maas FROM calisanlar2;

-- Calisanlar tablosundaki maas'larin toplamini listeleyiniz
SELECT sum(maas) AS toplam_maas FROM calisanlar2;

-- Calisanlar tablosundaki maas'larin ortalamasini listeleyiniz
SELECT avg(maas) FROM calisanlar2;
SELECT round(avg(maas),2) FROM calisanlar2

-- Calisanlar tablosundaki maas'larin sayisini listeleyiniz
SELECT count(maas) AS maas_sayısı FROM calisanlar2;
SELECT count(*) AS maas_sayısı FROM calisanlar2;

/*
	Eger coun(*) kullanirsak tablodaki tum satirlarin(row) sayisini verir.
	Sutun adi kullanirsak o sutundaki sayilari verir.
*/

select * from calisanlar2
select * from markalar

-- AGGREGATE METHODLARDA SUBQUERY
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz

SELECT marka_id,marka_isim,
(SELECT count(sehir)  FROM calisanlar2
WHERE marka_isim=isyeri) FROM markalar;
SELECT marka_id,marka_isim,
(SELECT count(sehir)  AS sehir_sayisi FROM calisanlar2 --count yazan yere sehir yazisi yazdik
WHERE marka_isim=isyeri) FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz

SELECT marka_isim,calisan_sayisi,
(SELECT sum(maas) FROM calisanlar2 WHERE isyeri=marka_isim) AS toplam_maas
FROM markalar

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
-- maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

SELECT marka_isim,calisan_sayisi,
(SELECT Max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaask,
(SELECT Min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
FROM markalar;

--VIEW KULLANIMI
/*
Yaptigimiz sorgulari hafizaya alir ve tekrar bizden istenen sorgulama yerine
view'e atadigimiz ismi SELECT komutuyla cagiririz
*/
Create VIEW maxminmaas
AS
SELECT marka_isim,calisan_sayisi,
(SELECT Max(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as enyuksekmaask,
(SELECT Min(maas) FROM calisanlar2 WHERE isyeri=marka_isim) as endusukmaas
FROM markalar;

SELECT * FROM maxminmaas;

-- 							EXISTS CONDITION
/*
EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer
olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde
bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar
*/

CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT * FROM mart
SELECT * FROM nisan

/*
	MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
	URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
	MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
 */
 
-- Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve  bu ürünleri
-- NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

SELECT urun_id,musteri_isim FROM mart
WHERE exists (SELECT urun_id FROM nisan WHERE mart.urun_id=nisan.urun_id);

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler2 -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no)
on delete cascade
);    
INSERT INTO urunler2 VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler2 VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler2 VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler2 VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler2 VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler2 VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler2 VALUES(104, 1007,'Phone', 'Aslan Yılmaz');
select * from tedarikciler
select * from urunler2

--  vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
/*
UPDATE tablo_adi
SET sutun_ismi = 'istenen veri' WHERE sutun_ismi = 'istenen veri'
*/
UPDATE tedarikciler
SET firma_ismi = 'Vestel' WHERE vergi_no=102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
UPDATE tedarikciler
SET firma_ismi = 'Casper',irtibat_ismi='Ali Veli' WHERE vergi_no=101

--  urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
UPDATE urunler2
SET urun_isim = 'Telefon' WHERE urun_isim='Phone';

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
UPDATE urunler2
SET urun_id = urun_id + 1 WHERE urun_id>1004;

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
UPDATE urunler2
SET urun_id = urun_id + ted_vergino

-- urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi
-- 'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.

UPDATE urunler2
SET urun_isim = (select firma_ismi from tedarikciler WHERE irtibat_ismi = 'Adam Eve')
WHERE musteri_isim='Ali Bak';

-- Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.
update urunler2
set musteri_isim=(select irtibat_ismi from tedarikciler where firma_ismi='Apple')
where urun_isim='Laptop';


