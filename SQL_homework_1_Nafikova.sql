--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

������� 1: ������� name, class �� ��������, ���������� ����� 1920
select name, class
from ships where launched > 1920


������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942
--1)
select name, class
from ships where launched > 1920 and launched <= 1942 
--2)
select name, class
from ships where launched between 1921 and 1942


������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class
select count(*), class
from ships 
group by class


������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)
select class, country
from classes
where bore >= 16


������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.
select ship
from Outcomes
where battle = 'North Atlantic' and result = 'sunk'


������� 6: ������� �������� (ship) ���������� ������������ �������
select ship
from Outcomes o join battles b on o.battle = b.name
where date = (select max(date) from Outcomes o join battles b on o.battle = b.name)
and result = 'sunk'


������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������
select ship, class 
from (Outcomes o full outer join ships s on o.ship = s.name)
where ship in
	(select ship
	from Outcomes o join battles b on o.battle = b.name
	where date = (select max(date) from Outcomes o join battles b on o.battle = b.name)
	and result = 'sunk')


������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class
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

	
������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class
select class 
from classes where country = 'USA'


������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class
select name, c.class
from ships s join  classes c on s.class = c.class 
where country = 'USA'


