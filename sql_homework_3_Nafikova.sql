--task10 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить по каждому производителю график (X: category_price, Y: count)

--task11 (lesson4)
-- Компьютерная фирма: На базе products_price_categories_with_makers по строить по A & D график (X: category_price, Y: count)


--task12 (lesson4)
-- Корабли: Сделать копию таблицы ships, но у название корабля не должно начинаться с буквы N (ships_without_n)
create table ships_2 as 
select * from ships where name not like 'N%'

--task13 (lesson3)
--Компьютерная фирма: Вывести список всех продуктов и производителя с указанием типа продукта (pc, printer, laptop). 
-- Вывести: model, maker, type

select pc.model, maker, product.type  from pc join product on pc.model = product.model
union all
select printer.model, maker, product.type  from printer join product on printer.model = product.model
union all
select laptop.model, maker, product.type  from laptop join product on laptop.model = product.model

--task14 (lesson3)
--Компьютерная фирма: При выводе всех значений из таблицы printer дополнительно вывести для тех, 
--у кого цена вышей средней PC - "1", у остальных - "0"

select *,
case 
	when price > (select avg(price) from PC)
	then '1'
	else '0'
	end flag
from printer


--task15 (lesson3)
--Корабли: Вывести список кораблей, у которых class отсутствует (IS NULL)
select *
from outcomes full join ships 
on ships.name = outcomes.ship
where class is null


--task16 (lesson3)
--Корабли: Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
select name from battles
where cast(date as varchar(4)) not in 
		(select cast (launched as varchar(4)) from ships)


--task17 (lesson3)
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select battle 
from outcomes full join ships 
on ships.name = outcomes.ship
where class = 'Kongo' and battle is not null


--task1  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_300) для всех товаров (pc, printer, laptop) 
-- с флагом, если стоимость больше > 300. Во view три колонки: model, price, flag

create view all_products_flag_300 as
select model, price,
case
	when price > 300
	then '1'
	else '0'
end flag
from
	(select pc.model, price from product join pc on product.model = pc.model 
	union all
	select printer.model, price from product join printer on product.model = printer.model
	union all
	select laptop.model, price from product join laptop on product.model = laptop.model) a


--task2  (lesson4)
-- Компьютерная фирма: Сделать view (название all_products_flag_avg_price) для всех товаров (pc, printer, laptop) 
--с флагом, если стоимость больше cредней . Во view три колонки: model, price, flag

create view all_products_flag_avg_price as
select model, price,
case
	when price > (select avg(price) 
					from
					(select product.model, price from product join pc on product.model = pc.model 
					union all
					select product.model, price from product join printer on product.model = printer.model
					union all
					select product.model, price from product join laptop on product.model = laptop.model) t)
					then '1'
					else '0'
end flag
	from
					(select product.model, price from product join pc on product.model = pc.model 
					union all
					select product.model, price from product join printer on product.model = printer.model
					union all
					select product.model, price from product join laptop on product.model = laptop.model) g
	
	
--task3  (lesson4)
-- Компьютерная фирма: Вывести все принтеры производителя = 'A' со стоимостью 
--выше средней по принтерам производителя = 'D' и 'C'. Вывести model

select printer.model
from printer join product on product.model = printer.model
where maker = 'A'
and price > (select avg (price) from printer join product on product.model = printer.model
			where maker = 'D' or maker = 'C')
		
					
--task4 (lesson4)
-- Компьютерная фирма: Вывести все товары производителя = 'A' со стоимостью 
-- выше средней по принтерам производителя = 'D' и 'C'. Вывести model
select model
from
	(select pc.model, maker,price from product join pc on product.model = pc.model 
	union all
	select printer.model, maker,price  from product join printer on product.model = printer.model
	union all
	select laptop.model, maker,price  from product join laptop on product.model = laptop.model) g
where maker = 'A'
and price > (select avg (price) from printer join product on product.model = printer.model
		where maker = 'D' or maker = 'C')
						
			
--task5 (lesson4)
-- Компьютерная фирма: Какая средняя цена среди уникальных продуктов производителя = 'A' (printer & laptop & pc)
select avg (price)
from
	(select pc.model, maker, price from product join pc on product.model = pc.model 
	union 
	select printer.model, maker, price  from product join printer on product.model = printer.model
	union 
	select laptop.model, maker, price  from product join laptop on product.model = laptop.model) g
where maker = 'A'

		
--task6 (lesson4)
-- Компьютерная фирма: Сделать view с количеством товаров (название count_products_by_makers) по каждому производителю. Во view: maker, count

create view count_products_by_makers as
select maker, count(*)
from
	(select pc.model, maker, price from product join pc on product.model = pc.model 
	union all
	select printer.model, maker, price from product join printer on product.model = printer.model
	union all
	select laptop.model, maker, price from product join laptop on product.model = laptop.model) t
group by maker


--task7 (lesson4)
-- По предыдущему view (count_products_by_makers) сделать график в colab (X: maker, y: count)



--task8 (lesson4)
-- Компьютерная фирма: Сделать копию таблицы printer (название printer_updated) и удалить из нее все принтеры производителя 'D'
create table printer_updated as table printer

delete from printer_updated
where model in (select printer_updated.model from product join printer_updated on product.model = printer_updated.model
         where maker = 'D')


--task9 (lesson4)
-- Компьютерная фирма: Сделать на базе таблицы (printer_updated) view 
--с дополнительной колонкой производителя (название printer_updated_with_makers)
       
 create view printer_updated_with_makers as 
 select code, printer_updated.model, color, printer_updated.type, price, maker 
 from product join printer_updated on product.model = printer_updated.model 
         
         
--task10 (lesson4)
-- Корабли: Сделать view c количеством потопленных кораблей и классом корабля (название sunk_ships_by_classes). 
--Во view: count, class (если значения класса нет/IS NULL, то заменить на 0)

create view sunk_ships_by_classes as
select count(*),
	case 
		when class is null
		then '0'
		else class 
	end class_with_0
from ships full join outcomes on ships.name = outcomes.ship
where result = 'sunk'
group by class_with_0
	 
 
--task11 (lesson4)
-- Корабли: По предыдущему view (sunk_ships_by_classes) сделать график в colab (X: class, Y: count)



--task12 (lesson4)
-- Корабли: Сделать копию таблицы classes (название classes_with_flag) и добавить в нее flag: 
--если количество орудий больше или равно 9 - то 1, иначе 0

create table classes_with_flag as table classes
select *,
	case 
		when numguns >= 9
		then '1'
		else '0'
	end flag
from classes_with_flag 


--task13 (lesson4)
-- Корабли: Сделать график в colab по таблице classes с количеством классов по странам (X: country, Y: count)



--task14 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название начинается с буквы "O" или "M".

select count(*)
from ships 
where name like 'O%' or name like 'M%'


--task15 (lesson4)
-- Корабли: Вернуть количество кораблей, у которых название состоит из двух слов.
select count(*)
from ships 
where name like '% %'

--task16 (lesson4)
-- Корабли: Построить график с количеством запущенных на воду кораблей и годом запуска (X: year, Y: count)

