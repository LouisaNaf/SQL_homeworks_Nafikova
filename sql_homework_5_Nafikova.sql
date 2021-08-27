
--task5  (lesson6)
-- Компьютерная фирма: Создать таблицу all_products_with_index_task5 как объединение всех данных 
--по ключу code (union all) и сделать флаг (flag) по цене > максимальной по принтеру. 
--Также добавить нумерацию (через оконные функции) по каждой категории продукта в порядке возрастания цены (price_index). 
-- По этому price_index сделать индекс

create table all_products_with_index_task5 as 
select * ,
case 
	when price > (select max(price) from printer)
	then '1'
	else '0'
end flag,
row_number (*) over (partition by type order by price) as price_index
from
(select product.model, price, product.type, maker from product join laptop  on product.model = laptop.model
union all
select product.model, price, product.type, maker  from product join pc on product.model = pc.model 
union all 
select product.model, price, product.type, maker  from product join printer  on product.model = printer.model) t


select *
from all_products_with_index_task5

create index price_index
on all_products_with_index_task5 (price_index)
