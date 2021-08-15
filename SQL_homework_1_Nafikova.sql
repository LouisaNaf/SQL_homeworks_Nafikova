--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

Задание 1: Вывести name, class по кораблям, выпущенным после 1920
select name, class
from ships where launched > 1920


Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
--1)
select name, class
from ships where launched > 1920 and launched <= 1942 
--2)
select name, class
from ships where launched between 1921 and 1942


Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
select count(*), class
from ships 
group by class


Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)
select class, country
from classes
where bore >= 16


Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
select ship
from Outcomes
where battle = 'North Atlantic' and result = 'sunk'


Задание 6: Вывести название (ship) последнего потопленного корабля
select ship
from Outcomes o join battles b on o.battle = b.name
where date = (select max(date) from Outcomes o join battles b on o.battle = b.name)
and result = 'sunk'


Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
select ship, class 
from (Outcomes o full outer join ships s on o.ship = s.name)
where ship in
	(select ship
	from Outcomes o join battles b on o.battle = b.name
	where date = (select max(date) from Outcomes o join battles b on o.battle = b.name)
	and result = 'sunk')


Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
select ship, class 
from Outcomes o full outer join ships s on o.ship = s.name
where 
	class in 
	(select class from classes where bore >=16)
and 
	ship in
	(select ship
	from Outcomes o join battles b on o.battle = b.name
	where result = 'sunk')

	
Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
select class 
from classes where country = 'USA'


Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
select name, c.class
from ships s join  classes c on s.class = c.class 
where country = 'USA'


