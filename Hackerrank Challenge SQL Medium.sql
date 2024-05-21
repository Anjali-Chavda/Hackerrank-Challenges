/* 1. Generate the following two result sets:
(a) Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
(b) Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
Note: There will be at least two entries in the table for each type of occupation. */

#(a).
select concat(name, Case when Occupation = 'Doctor' then '(D) ' 
					when Occupation = 'Actor' then '(A) ' 
                    when Occupation = 'Professor' then '(P)' 
                    when Occupation = 'Singer' then '(S)' else ' ' end ) 
from Occupations 
order by 1;

#(b)
select "There are a total of ", count(Occupation), concat(lower(occupation),'s.') 
from Occupations 
group by 1,3 
order by 2,3;

/* 2. Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation. */

SELECT MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS "Doctor", 
	   MAX(CASE WHEN occupation = 'Professor' THEN name END) AS "Professor", 
       MAX(CASE WHEN occupation = 'Singer' THEN name END) AS "Singer", 
       MAX(CASE WHEN occupation = 'Actor' THEN name END) AS "Actor" 
FROM (select Name , Occupation, row_number() over( partition by Occupation order by Name) as Row_num 
	  From OCCUPATIONS) as ord 
      group by Row_num
      
/* 3. Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node. */

SELECT 
    N, 
    CASE
        WHEN P IS NULL THEN 'Root'
        WHEN N IN (SELECT P FROM BST) THEN 'Inner'
        ELSE 'Leaf' 
    END AS node_type 
FROM BST 
ORDER BY N;

/* 4. write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code. */

SELECT 
	cpy.company_code, 
    cpy.founder, 
    COUNT(DISTINCT employee.lead_manager_code), 
    COUNT(DISTINCT employee.senior_manager_code), 
    COUNT(DISTINCT employee.manager_code), 
    COUNT(DISTINCT employee.employee_code) 
FROM company AS cpy 
LEFT JOIN employee ON cpy.company_code = employee.company_code 
GROUP BY cpy.company_code, cpy.founder 
ORDER BY cpy.company_code;

/* 5. Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places. */

select round(abs(min(LAT_N) - max(LAT_N)) + abs(min(LONG_W) - max(LONG_W)), 4) 
from STATION;

/* 6. Query the Euclidean Distance between points P1 and P2 and format your answer to display 4 decimal digits. */

select format(sqrt(pow(max(LAT_N) - min(LAT_N),2)+ pow(max(LONG_W) - min(LONG_W),2)),4) 
from STATION;

/* 7. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places. */

select round(s.LAT_N, 4) 
from STATION s 
where (select count(LAT_N) 
	  from STATION 
      where LAT_N < s.LAT_N) = (select count(LAT_N) 
								from STATION 
                                where LAT_N > s.LAT_N);
                                
/* 8. Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
Write a query to help Eve. */

select 
	case when Grade < 8 then 'NULL' else Name end as Student_Name, 
    Grade, 
    Marks 
from Students, Grades 
where Marks between Min_Mark and Max_Mark 
order by Grade desc, Name asc;

/* 9. Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id. */

select h.hacker_id, h.name 
from submissions s 
join challenges c on s.challenge_id = c.challenge_id 
join difficulty d on c.difficulty_level = d.difficulty_level 
join hackers h on s.hacker_id = h.hacker_id 
where s.score = d.score and c.difficulty_level = d.difficulty_level 
group by h.hacker_id, h.name 
having count(s.hacker_id) > 1 
order by count(s.hacker_id) desc, s.hacker_id asc;

/* 10. Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.*/

select w.id,  wp.age, w.coins_needed, w.power 
from wands w 
join wands_Property wp on w.code=wp.code 
where (w.code, w.coins_needed, w.power) in (select code, min(coins_needed), power from Wands group by code, power) and 
	  w.code in (select code from wands_property where is_evil = 0) 
order by w.power desc, wp.age desc;

/* 11. Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result. */

with a as (select h.hacker_id, name, count(challenge_id) as cnt 
		  from Hackers h 
          join Challenges c on h.hacker_id = c.hacker_id
          group by h.hacker_id, name 
          order by count(challenge_id) desc, hacker_id),

b as (select cnt, count(*) as same_cnt 
	 from a 
     group by cnt 
     having count(*) = 1 or cnt = (select max(cnt) from a) order by cnt desc)

select hacker_id, name, a.cnt 
from a 
join b on a.cnt = b.cnt;

/* 12. You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of 0 from your result. */

select h.hacker_id, h.name, sum(s.max_score) as total 
from hackers h 
join (select hacker_id, challenge_id, max(score) as max_score 
	 from submissions s 
     group by hacker_id, challenge_id having 
     max(score) > 0) as s on h.hacker_id = s.hacker_id 
group by h.hacker_id, h.name 
order by total desc, hacker_id asc ;

/* 13. You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.
Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project. */

with _lag_end_to_start as (
    select 
        start_date,
        end_date,
        datediff(lag(end_date) over (order by start_date asc), start_date) as gap_between_tasks
    from projects
    order by start_date),
_grouping as (
    select 
        *,
        sum(case when gap_between_tasks <> 0 then 1 else 0 end) over (order by start_date asc) as grp
    from _lag_end_to_start)
    
select
    min(start_date) as _grp_start,
    max(end_date) as _grp_finish
from _grouping
group by grp
order by datediff(_grp_finish, _grp_start) asc, _grp_start;

/* 14. You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer. */

select s.name from students s 
join (select *, p.salary as f_sal from packages p 
	 join 
     (select f.id as main, f.friend_id, p.salary as id_sal from friends f 
     join packages p on f.id = p.id)t on p.id = t.friend_id 
     where p.salary > t.id_sal) t2 on s.id = t2.main 
order by t2.f_sal;

/* 15. You are given a table, Functions, containing two columns: X and Y.
Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1. */

select a.x, a.y 
from functions a 
cross join functions b 
where a.x = b.y and a.y = b.x 
group by a.x, a.y 
having a.x < a.y or count(*) > 1 
order by a.x;

/* 16. Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).
For example, the output for all prime numbers <= 10 would be: 2&3&5&7 */

WITH RECURSIVE seq AS (
  SELECT 2 AS v UNION ALL SELECT v + 1  FROM seq WHERE v < 1000),

primes AS (
    SELECT n FROM (
        SELECT IF(s1.v/2 >= s2.v AND s1.v mod s2.v = 0, 0, s1.v) as col1, s1.v as n FROM seq s1 CROSS JOIN seq s2
    ) as tbl1  
    GROUP BY 1 
    HAVING min(col1) = n)

SELECT GROUP_CONCAT(n order by n SEPARATOR "&") FROM primes;


