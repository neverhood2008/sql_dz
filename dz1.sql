SELECT * FROM dz1.phones;

/*
задание 2
Напишите SELECT-запрос, который выводит название товара, производителя и цену для товаров, количество которых превышает 2
*/

SELECT product_name, manufacturer,price FROM dz1.phones
where product_count>2;

/*
задание 3
Выведите SELECT-запросом весь ассортимент товаров марки “Samsung”
*/
SELECT product_name, product_count ,price FROM dz1.phones
where manufacturer='samsung';

/*
задание 4
С помощью SELECT-запроса с оператором LIKE / REGEXP найти:
4.1.* Товары, в которых есть упоминание "Iphone"
*/
SELECT product_name, product_count ,price FROM dz1.phones
where manufacturer like 'iphone';

/*
задание 4
С помощью SELECT-запроса с оператором LIKE / REGEXP найти:
4.2.* Товары, в которых есть упоминание "Samsung"
*/

SELECT product_name, product_count ,price FROM dz1.phones
where manufacturer like 'samsung';

/*
задание 4
С помощью SELECT-запроса с оператором LIKE / REGEXP найти:
4.3.* Товары, в названии которых есть ЦИФРЫ
*/

SELECT product_name FROM dz1.phones
where product_name   REGEXP '[0-9]' ;


/*
задание 4
С помощью SELECT-запроса с оператором LIKE / REGEXP найти:
4.4.* Товары, в названии которых есть ЦИФРА "8"
*/
SELECT product_name FROM dz1.phones
where product_name like '%8%';




