--									ALIASES
-- Aliases kodu ile tablo yazdirilirken, field isimleri sadece o cikti icin degistirilebilir.

SELECT * FROM calisanlar2

CREATE TABLE calisanlar3 (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar3 VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO calisanlar3 VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO calisanlar3 VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from calisanlar3

-- Eğer iki sutunun verilerini birleştirmek istersek concat sembolu || kullanırız
SELECT calisan_id AS id, calisan_isim||' '||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar3
--2. YOl
SELECT calisan_id AS id, concat (calisan_isim,calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar3

--			IS NULL CONDITION
-- Arama yapilan field’da NULL degeri almis kayitlari getirir

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli'); 

select * from insanlar

-- Name sutununda null olan degerleri listeleyelim

select isim from insanlar where isim is null

-- Insanlar tablosunda sadece null olmayan degerleri listeleyiniz

SELECT isim FROM insanlar WHERE isim IS NOT NULL

-- Insanlar toplasunda null değer almış verileri no name olarak değiştiriniz

UPDATE insanlar
SET isim='No Name'
WHERE isim IS NULL

-- 								ORDER BY CLAUSE
/*
	Tablolardaki verileri siralamak icin ORDER BY komutu kullaniriz
	Buyukten kucuge ya da kucukten buyuge siralama yapabiliriz
	Default olarak kucukten buyuge siralama yapar (ASCENDING)
	Eger BUYUKTEN KUCUGE siralamak istersek ORDER BY komutundan sonra DESC komutunu kullaniriz
	ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
	yapmak icin kullanilir
	ORDER BY komutu sadece SELECT komutu Ile kullanilir
*/

drop table if exists insanlar

CREATE TABLE insanlar2
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar2 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar2 VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar2 VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar2 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar2 VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar2 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

--Insanlar tablosundaki datalari adres’e gore siralayin

select * from insanlar2 ORDER BY adres;

SELECT * FROM insanlar2 ORDER BY soyisim;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin

SELECT * FROM insanlar2 WHERE isim='Mine' ORDER BY ssn;

-- NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
-- Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin

SELECT * FROM insanlar2 WHERE soyisim='Bulut' ORDER BY 4

-- Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin

SELECT * FROM insanlar2 ORDER BY ssn DESC;

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin

SELECT * FROM insanlar2 ORDER BY isim ASC, soyisim DESC;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
Eger sutun uzunluguna gore siralamak istersek LENGTH komutu kullaniriz
Ve yine uzunlugu buyukten kucuge siralamak istersek  sonuna DESC komutunu ekleriz
*/
SELECT isim,soyisim FROM insanlar2 ORDER BY LENGTH(soyisim) desc;

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız

SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar2 ORDER BY LENGTH(isim||soyisim);

SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar2 ORDER BY LENGTH(isim)+ LENGTH(soyisim);

SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar2 ORDER BY LENGTH(concat(isim,soyisim));

--GROUP BY KULLANIMI
/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM manav

-- Isme gore alinan toplam urunleri listeleyiniz

SELECT isim,sum(urun_miktar) AS aldigi_toplam_urun FROM manav
GROUP BY isim;

-- Isme gore alinan toplam urunleri bulun ve urunleri buyukten kucuge listeleyiniz

SELECT isim,sum(urun_miktar) AS aldigi_toplam_urun FROM manav
GROUP BY isim
ORDER BY aldigi_toplam_urun DESC;

-- Urun ismine gore urunu alan toplam kisi sayisi
SELECT urun_adi,count(isim) FROM manav
GROUP BY urun_adi;

SELECT isim,count(urun_adi) FROM manav
GROUP BY isim;

SELECT isim,count(urun_adi) AS aldigi_urun_cesidi FROM manav
GROUP BY isim;


