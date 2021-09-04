--task11 (lesson5)
-- ������������ �����: ��������� ������ � �� ������� � ������������ ������ �� ���� 
--products_with_lowest_price (X: maker, Y1: max_price, Y2: avg)price


--task12 (lesson5)
-- ������������ �����: ������� view, � ������� ����� ������������ �������� ���� laptop 
--(�� ����� ���� ��������� �� ����� ��������). �����: ��� ������ �� laptop, ����� ��������, ������ ���� �������

create view page_num_laptop as
SELECT *, 
      CASE WHEN num % 2 = 0 THEN num/2 ELSE num/2 + 1 END AS page_num, 
      CASE WHEN total % 2 = 0 THEN total/2 ELSE total/2 + 1 END AS num_of_pages
FROM (
      SELECT *, ROW_NUMBER() OVER(ORDER BY price DESC) AS num, 
             COUNT(*) OVER() AS total 
      FROM Laptop
) X;


--task1 (lesson5)
-- ������������ �����: ������� view (pages_all_products), � ������� ����� ������������ �������� ���� ��������� 
--(�� ����� ���� ��������� �� ����� ��������). �����: ��� ������ �� laptop, ����� ��������, ������ ���� �������

create view pages_all_products as
SELECT *, 
      CASE WHEN num % 2 = 0 THEN num/2 ELSE num/2 + 1 END AS page_num, 
      CASE WHEN total % 2 = 0 THEN total/2 ELSE total/2 + 1 END AS num_of_pages
FROM (
      SELECT *, ROW_NUMBER() OVER(ORDER BY price DESC) AS num, 
             COUNT(*) OVER() AS total 
      FROM 
      (select price, maker,product.model, product.type from product join laptop on product.model = laptop.model 
      union all
      select price, maker,product.model, product.type from product join pc on product.model = pc.model 
      union all
      select price, maker,product.model, product.type from product join printer on product.model = printer.model 
      ) Y
) X


--task2 (lesson5)
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� ���������� ����������� 
--���� ������� �� ���� ����������. �����: �������������,

create view distribution_by_typ as 
select type, 
count(type)/(sum(count(type)) over ()) as c
from product 
group by type


--task3 (lesson5)
-- ������������ �����: ������� �� ���� ����������� view ������ - �������� ���������



--task4 (lesson5)
-- �������: ������� ����� ������� ships (ships_two_words), �� � �������� ������� ������ �������� �� ���� ����
create table ships_two_words as 
select * from ships
where name like '% %'

select * from ships_two_words


--task5 (lesson5)
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"
select *
from outcomes full join ships 
on ships.name = outcomes.ship
where class is null and name like 'S%' or class is null and ship like 'S%'


--task6 (lesson5)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� 
--������������� = 'C' � ��� ����� ������� (����� ������� �������). ������� model


 select printer.model,
 row_number () over (order by price desc) as rn 
 from product join printer on product.model = printer.model
 where maker = 'A' 
 and price > (select avg (price)
			  from product join printer on product.model = printer.model
			  where maker = 'C' )
UNION ALL
select *
from 
(
  select  printer.model,
  row_number () over (order by price desc) as rn 
  from product join printer on product.model = printer.model
) a 
where rn <= 3
			  

