--task1  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

SELECT 
   CASE WHEN Grades.Grade > 7 
   THEN Students.Name 
   ELSE 'NULL' 
   END AS Name, Grades.Grade, Students.Marks
FROM Students JOIN Grades ON Students.Marks BETWEEN Grades.Min_Mark AND Grades.Max_Mark
ORDER BY Grades.Grade DESC, Name, Students.Marks;


--task2  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/occupations/problem

select min(Doctor), min(Professor), min(Singer), min(Actor)
from
(Select  RANK() OVER(PARTITION BY occupation ORDER BY name) rank,
    case OCCUPATION when 'Doctor' then NAME end AS Doctor,
    case OCCUPATION when 'Professor' then NAME end AS Professor,
    case OCCUPATION when 'Singer' then NAME end AS Singer,
    case OCCUPATION when 'Actor' then NAME end AS Actor
from occupations)
group by rank
order by rank;


--task3  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-9/problem

SELECT DISTINCT CITY FROM STATION
WHERE NOT (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%');


--task4  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-10/problem

SELECT DISTINCT CITY FROM STATION
WHERE NOT (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u');


--task5  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-11/problem

SELECT DISTINCT CITY FROM STATION
WHERE NOT (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%')
UNION
SELECT DISTINCT CITY FROM STATION
WHERE NOT (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u');


--task6  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/weather-observation-station-12/problem

SELECT DISTINCT CITY FROM STATION
WHERE NOT (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%')
AND NOT (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u');


--task7  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/salary-of-employees/problem

SELECT name FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id;


--task8  (lesson9)
-- oracle: https://www.hackerrank.com/challenges/the-report/problem

SELECT 
   CASE WHEN Grades.Grade > 7 
   THEN Students.Name 
   ELSE 'NULL' 
   END AS Name, Grades.Grade, Students.Marks
FROM Students JOIN Grades ON Students.Marks BETWEEN Grades.Min_Mark AND Grades.Max_Mark
ORDER BY Grades.Grade DESC, Name, Students.Marks;
