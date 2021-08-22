--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task17
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
select battle
from ships join outcomes 
on ships.name = outcomes.ship
where class = 'Kongo'


--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. 
--�������: ����� � ����� ����������� ��������.

select class, count (*)
from ships full join outcomes 
on ships.name = outcomes.ship
where result = 'sunk'
group by class


--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. 
--���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.

select  class, min (launched)
from ships 
group by class


--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� � ���� ������, 
--������� ��� ������ � ����� ����������� ��������.

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
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� ������ �� ������������� 
--(������ ������� �� ������� Outcomes).

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
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� RAM 
--� � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker

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
	            

