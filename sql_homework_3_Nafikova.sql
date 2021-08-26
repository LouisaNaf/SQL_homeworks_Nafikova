--task10 (lesson4)
-- Êîìïüþòåðíàÿ ôèðìà: Íà áàçå products_price_categories_with_makers ïîñòðîèòü 
--ïî êàæäîìó ïðîèçâîäèòåëþ ãðàôèê (X: category_price, Y: count)


--task11 (lesson4)
-- Êîìïüþòåðíàÿ ôèðìà: Íà áàçå products_price_categories_with_makers ïî ñòðîèòü ïî A & D ãðàôèê (X: category_price, Y: count)


--task12 (lesson4)
-- Êîðàáëè: Ñäåëàòü êîïèþ òàáëèöû ships, íî ó íàçâàíèå êîðàáëÿ íå äîëæíî íà÷èíàòüñÿ ñ áóêâû N (ships_without_n)
create table ships_2 as 
select * from ships where name not like 'N%'

--ñõåìà ÁÄ: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--Êîìïüþòåðíàÿ ôèðìà: Âûâåñòè ñïèñîê âñåõ ïðîäóêòîâ è ïðîèçâîäèòåëÿ ñ óêàçàíèåì òèïà ïðîäóêòà (pc, printer, laptop). 
-- Âûâåñòè: model, maker, type

select pc.model, maker, product.type  from pc join product on pc.model = product.model
union all
select printer.model, maker, product.type  from printer join product on printer.model = product.model
union all
select laptop.model, maker, product.type  from laptop join product on laptop.model = product.model


--task14 (lesson3)
--Êîìïüþòåðíàÿ ôèðìà: Ïðè âûâîäå âñåõ çíà÷åíèé èç òàáëèöû printer äîïîëíèòåëüíî âûâåñòè äëÿ òåõ, 
--ó êîãî öåíà âûøåé ñðåäíåé PC - "1", ó îñòàëüíûõ - "0"

select *,
case 
	when price > (select avg(price) from PC)
	then '1'
	else '0'
	end flag
from printer


--task15 (lesson3)
--Êîðàáëè: Âûâåñòè ñïèñîê êîðàáëåé, ó êîòîðûõ class îòñóòñòâóåò (IS NULL)
select *
from outcomes full join ships 
on ships.name = outcomes.ship
where class is null


--task16 (lesson3)
--Êîðàáëè: Óêàæèòå ñðàæåíèÿ, êîòîðûå ïðîèçîøëè â ãîäû, íå ñîâïàäàþùèå íè ñ îäíèì èç ãîäîâ ñïóñêà êîðàáëåé íà âîäó.
select name from battles
where cast(date as varchar(4)) not in 
		(select cast (launched as varchar(4)) from ships)


--task17 (lesson3)
--Êîðàáëè: Íàéäèòå ñðàæåíèÿ, â êîòîðûõ ó÷àñòâîâàëè êîðàáëè êëàññà Kongo èç òàáëèöû Ships.
select battle 
from outcomes full join ships 
on ships.name = outcomes.ship
where class = 'Kongo' and battle is not null


--task1  (lesson4)
-- Êîìïüþòåðíàÿ ôèðìà: Ñäåëàòü view (íàçâàíèå all_products_flag_300) äëÿ âñåõ òîâàðîâ (pc, printer, laptop) 
-- ñ ôëàãîì, åñëè ñòîèìîñòü áîëüøå > 300. Âî view òðè êîëîíêè: model, price, flag
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
-- Êîìïüþòåðíàÿ ôèðìà: Ñäåëàòü view (íàçâàíèå all_products_flag_avg_price) äëÿ âñåõ òîâàðîâ (pc, printer, laptop) 
--ñ ôëàãîì, åñëè ñòîèìîñòü áîëüøå cðåäíåé . Âî view òðè êîëîíêè: model, price, flag
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
-- Êîìïüþòåðíàÿ ôèðìà: Âûâåñòè âñå ïðèíòåðû ïðîèçâîäèòåëÿ = 'A' ñî ñòîèìîñòüþ 
--âûøå ñðåäíåé ïî ïðèíòåðàì ïðîèçâîäèòåëÿ = 'D' è 'C'. Âûâåñòè model
					
select printer.model
from printer join product on product.model = printer.model
where maker = 'A'
and price > (select avg (price) from printer join product on product.model = printer.model
			where maker = 'D' or maker = 'C')
		
					
--task4 (lesson4)
-- Êîìïüþòåðíàÿ ôèðìà: Âûâåñòè âñå òîâàðû ïðîèçâîäèòåëÿ = 'A' ñî ñòîèìîñòüþ 
-- âûøå ñðåäíåé ïî ïðèíòåðàì ïðîèçâîäèòåëÿ = 'D' è 'C'. Âûâåñòè model
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
-- Êîìïüþòåðíàÿ ôèðìà: Êàêàÿ ñðåäíÿÿ öåíà ñðåäè óíèêàëüíûõ ïðîäóêòîâ ïðîèçâîäèòåëÿ = 'A' (printer & laptop & pc)
select avg (price)
from
	(select pc.model, maker, price from product join pc on product.model = pc.model 
	union 
	select printer.model, maker, price  from product join printer on product.model = printer.model
	union 
	select laptop.model, maker, price  from product join laptop on product.model = laptop.model) g
where maker = 'A'

		
--task6 (lesson4)
-- Êîìïüþòåðíàÿ ôèðìà: Ñäåëàòü view ñ êîëè÷åñòâîì òîâàðîâ (íàçâàíèå count_products_by_makers) ïî êàæäîìó ïðîèçâîäèòåëþ. Âî view: maker, count

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
-- Ïî ïðåäûäóùåìó view (count_products_by_makers) ñäåëàòü ãðàôèê â colab (X: maker, y: count)



--task8 (lesson4)
-- Êîìïüþòåðíàÿ ôèðìà: Ñäåëàòü êîïèþ òàáëèöû printer (íàçâàíèå printer_updated) è óäàëèòü èç íåå âñå ïðèíòåðû ïðîèçâîäèòåëÿ 'D'

create table printer_updated as table printer

delete from printer_updated
where model in (select printer_updated.model from product join printer_updated on product.model = printer_updated.model
         where maker = 'D')

--task9 (lesson4)
-- Êîìïüþòåðíàÿ ôèðìà: Ñäåëàòü íà áàçå òàáëèöû (printer_updated) view 
--ñ äîïîëíèòåëüíîé êîëîíêîé ïðîèçâîäèòåëÿ (íàçâàíèå printer_updated_with_makers)
       
 create view printer_updated_with_makers as 
 select code, printer_updated.model, color, printer_updated.type, price, maker 
 from product join printer_updated on product.model = printer_updated.model 
         
         
--task10 (lesson4)
-- Êîðàáëè: Ñäåëàòü view c êîëè÷åñòâîì ïîòîïëåííûõ êîðàáëåé è êëàññîì êîðàáëÿ (íàçâàíèå sunk_ships_by_classes). 
--Âî view: count, class (åñëè çíà÷åíèÿ êëàññà íåò/IS NULL, òî çàìåíèòü íà 0)

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
-- Êîðàáëè: Ïî ïðåäûäóùåìó view (sunk_ships_by_classes) ñäåëàòü ãðàôèê â colab (X: class, Y: count)




--task12 (lesson4)
-- Êîðàáëè: Ñäåëàòü êîïèþ òàáëèöû classes (íàçâàíèå classes_with_flag) è äîáàâèòü â íåå flag: 
--åñëè êîëè÷åñòâî îðóäèé áîëüøå èëè ðàâíî 9 - òî 1, èíà÷å 0

create table classes_with_flag as table classes
select *,
	case 
		when numguns >= 9
		then '1'
		else '0'
	end flag
from classes_with_flag 


--task13 (lesson4)
-- Êîðàáëè: Ñäåëàòü ãðàôèê â colab ïî òàáëèöå classes ñ êîëè÷åñòâîì êëàññîâ ïî ñòðàíàì (X: country, Y: count)



--task14 (lesson4)
-- Êîðàáëè: Âåðíóòü êîëè÷åñòâî êîðàáëåé, ó êîòîðûõ íàçâàíèå íà÷èíàåòñÿ ñ áóêâû "O" èëè "M".

select count(*)
from ships 
where name like 'O%' or name like 'M%'


--task15 (lesson4)
-- Êîðàáëè: Âåðíóòü êîëè÷åñòâî êîðàáëåé, ó êîòîðûõ íàçâàíèå ñîñòîèò èç äâóõ ñëîâ.
select count(*)
from ships 
where name like '% %'

--task16 (lesson4)
-- Êîðàáëè: Ïîñòðîèòü ãðàôèê ñ êîëè÷åñòâîì çàïóùåííûõ íà âîäó êîðàáëåé è ãîäîì çàïóñêà (X: year, Y: count)
