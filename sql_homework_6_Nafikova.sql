--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). 
-- В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко


--task2  (lesson7)
 -- oracle: https://leetcode.com/problems/duplicate-emails/

select Email
from Person 
group by Email
having count(*)> 1

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

select a.name as Employee
from Employee a
join Employee b
on b.Id = a.ManagerId
where a.salary > b.salary

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/

select * 
from
	(select Score, dense_rank() over (order by score desc) Rank
	from Scores)

--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/

select FirstName, LastName, City, State
from Person left join Address
on Person.PersonId = Address.PersonId

