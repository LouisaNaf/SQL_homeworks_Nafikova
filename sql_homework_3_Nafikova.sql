--task10 (lesson4)
-- ������������ �����: �� ���� products_price_categories_with_makers ��������� 
--�� ������� ������������� ������ (X: category_price, Y: count)


--task11 (lesson4)
-- ������������ �����: �� ���� products_price_categories_with_makers �� ������� �� A & D ������ (X: category_price, Y: count)


--task12 (lesson4)
-- �������: ������� ����� ������� ships, �� � �������� ������� �� ������ ���������� � ����� N (ships_without_n)
create table ships_2 as 
select * from ships where name not like 'N%'

--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). 
-- �������: model, maker, type

select pc.model, maker, product.type  from pc join product on pc.model = product.model
union all
select printer.model, maker, product.type  from printer join product on printer.model = product.model
union all
select laptop.model, maker, product.type  from laptop join product on laptop.model = product.model


--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, 
--� ���� ���� ����� ������� PC - "1", � ��������� - "0"

select *,
case 
	when price > (select avg(price) from printer)
	then '1'
	else '0'
	end flag
from printer


--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)
select *
from outcomes full join ships 
on ships.name = outcomes.ship
where class is null


--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.
select name from battles
where cast(date as varchar(4)) not in 
		(select cast (launched as varchar(4)) from ships)


--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
select battle 
from outcomes full join ships 
on ships.name = outcomes.ship
where class = 'Kongo' and battle is not null


--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) 
-- � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) 
--� ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag
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
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� 
--���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
					
select printer.model
from printer join product on product.model = printer.model
where maker = 'A'
and price > (select avg (price) from printer join product on product.model = printer.model
			where maker = 'D' or maker = 'C')
		
					
--task4 (lesson4)
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� 
-- ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
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
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)
select avg (price)
from
	(select pc.model, maker, price from product join pc on product.model = pc.model 
	union 
	select printer.model, maker, price  from product join printer on product.model = printer.model
	union 
	select laptop.model, maker, price  from product join laptop on product.model = laptop.model) g
where maker = 'A'

		
--task6 (lesson4)
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count

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
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)



--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'

create table printer_updated as table printer

delete from printer_updated
where model in (select printer_updated.model from product join printer_updated on product.model = printer_updated.model
         where maker = 'D')

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view 
--� �������������� �������� ������������� (�������� printer_updated_with_makers)
       
 create view printer_updated_with_makers as 
 select code, printer_updated.model, color, printer_updated.type, price, maker 
 from product join printer_updated on product.model = printer_updated.model 
         
         
--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). 
--�� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)

create view sunk_ships_by_classes as
select count(*),
	case 
		when class is null
		then '0'
		else class 
	end class_with_0
from ships full join outcomes on ships.name = outcomes.ship
group by class_with_0
	 
 
--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)




--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: 
--���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0

create table classes_with_flag as table classes
select *,
	case 
		when numguns >= 9
		then '1'
		else '0'
	end flag
from classes_with_flag 


--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)



--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".

select count(*)
from ships 
where name like 'O%' or name like 'M%'


--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.
select count(*)
from ships 
where name like '% %'

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
