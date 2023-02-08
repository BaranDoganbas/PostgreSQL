-- ODEV
-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz
-- calisan sayilarini listeleyiniz

SELECT marka_id,calisan_sayisi FROM markalar
WHERE marka_isim IN (SELECT isyeri FROM calisanlar2 WHERE sehir='Ankara');

select * from markalar
select * from calisanlar2


