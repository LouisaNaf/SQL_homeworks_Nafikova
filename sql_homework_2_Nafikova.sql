--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task17
--Корабли: Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select battle
from ships join outcomes 
on ships.name = outcomes.ship
where class = 'Kongo'


--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. 
--Вывести: класс и число потопленных кораблей.

select class, count (*)
from ships full join outcomes 
on ships.name = outcomes.ship
where result = 'sunk'
group by class


--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. 
--Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

select  class, min (launched)
from ships 
group by class


--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, 
--вывести имя класса и число потопленных кораблей.

select class, count (*)
from ships full join outcomes 
on ships.name = outcomes.ship
where result = 'sunk'
and 
class in
	(select class
	from ships full join outcomes 
	on ships.name = outcomes.ship
	group by class
	having count(*) >= 3)
group by class



--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения 
--(учесть корабли из таблицы Outcomes).

WITH AllShips as
(select name, class
 from Ships
 UNION
 select ship,
 case when ship is not null then 'a' else 'b' end new_column
 FROM Outcomes
 )
select AllShips.name
from AllShips, Classes
where AllShips.class = Classes.class and
      Classes.numGuns >= all (select c.numGuns 
      						  from Classes c 
                              where c.class in 
		                      	   (select AllShips.class from AllShips) and
		                           Classes.displacement = c.displacement)
                       

--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM 
--и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

select distinct maker
from printer join product
on printer.model=product.model 
	intersect                             
select distinct maker 
from product join pc 
on pc.model=product.model  
	where type='PC' 
	and ram=(select min(ram) from pc)  
	and speed = (select max(speed) 
		           from 
		           (select speed from pc 
		            where ram=(select min(ram) from pc)) as t)     
	            

