CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int
);

INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

SELECT * FROM maas
SELECT * FROM musteri_urun

-- DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

-- Musteri urun tablosundan urun isimlerini tekrarsiz(grup) listeleyin

--GROUP BY COZUMU
SELECT urun_isim FROM musteri_urun
GROUP BY urun_isim

--DISTINCT COZUMU
SELECT DISTINCT urun_isim
FROM musteri_urun

-- Tabloda kac farkli meyve vardir ?

SELECT urun_isim, count(urun_isim) FROM musteri_urun
GROUP BY urun_isim

-- FETCH NEXT () ROW ONLY / OFFSET / LIMIT

-- Musteri urun tablosundan ilk uc kaydi listeleyiniz

SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 3 ROW ONLY;

-- LIMIT
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT(3);

-- Musteri urun tablosundan ilk kaydi listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id
LIMIT 1

-- Musteri urun tablosundan son uc kaydi listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id DESC
LIMIT(3);

-- EN yuksek maasi alan musteriyi listeleyiniz

SELECT * FROM maas ORDER BY maas DESC
LIMIT(1);

-- Maas tablosundan en yuksek ikinci maasi listeleyiniz

SELECT * FROM maas ORDER BY maas DESC
OFFSET 1 LIMIT(1);
/*
OFFSET --> Satir atlamak istedigimizde offset komutunu kullaniriz
*/
SELECT * FROM maas ORDER BY maas DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY

-- Maas tablosundan en dusuk 4. maasi listeleyiniz

SELECT * FROM maas ORDER BY maas ASC
OFFSET 3 LIMIT(1);
/*
DDL - ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */
CREATE TABLE personel 
(
id int,
isim varchar(50), 
sehir varchar(50), 
maas int, 
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford'); 
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda')

SELECT * FROM personel
-- 1) ADD default deger ile tabloya bir field ekleme

ALTER TABLE personel
ADD ulke varchar(30)

ALTER TABLE personel
ADD zipcode varchar(30)

ALTER TABLE personel
ADD adres varchar(50) DEFAULT 'Turkiye' -- DEFAULT yazarsak olusturdugumuz sutuna belirttigimiz veriyi tum satirlara girer

-- 2) DROP tablodan sutun silme

ALTER TABLE personel
DROP COLUMN zipcode

ALTER TABLE personel
DROP adres, drop sirket -- Iki sutunu birden sildik

-- 3) RENAME COLUMN sutun adi degistirme

ALTER TABLE personel
RENAME COLUMN sehir TO il;

-- 4) RENAME tablonun ismini degistirme

SELECT * FROM isci

ALTER TABLE personel
RENAME TO isci

-- 5) TYPE/SET sutunlarin ozelliklerini degistirme

ALTER TABLE isci
ALTER COLUMN il TYPE varchar(30),
ALTER COLUMN maas SET NOT NULL;
/*
Eger numeric data tipine sahip bir sutunun data turune string bir data turu atamak istersek 
TYPE varchar(30) USING(maas::varchar(30)) bu formati kullaniriz
*/
ALTER COLUMN maas
TYPE varchar(30) USING(maas::varchar(30))

DROP TABLE ogrenciler2
/*
	-->	TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT)
	Transaction baslatmak icin BEGIN komutu kullanmamiz gerekir ve Transaction'i sonlandirmak icin 
	COMMIT komutunu calistirmaliyiz.
*/

CREATE TABLE ogrenciler2
(
id serial, -- Serial data turu otomatik olarak birden baslayarak sirali olarak sayi atamasi yapar
		   -- INSERT INTO ile tabloya veri eklerken serial data turunu kullandigim veri degeri yerine DEFAULT yazariz
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real 
);

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT

Select * from ogrenciler2
delete from ogrenciler2



