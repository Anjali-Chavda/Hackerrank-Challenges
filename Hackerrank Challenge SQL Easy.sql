/* 1. Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA. */

select * from CITY 
where COUNTRYCODE = 'USA' and POPULATION > 100000

/* 2. Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA */

select NAME from CITY  
where COUNTRYCODE = 'USA' and POPULATION  > 120000;

/* 3. Query all columns (attributes) for every row in the CITY table. */

select * from CITY;

/* 4. Query all columns for a city in CITY with the ID 1661. */

select * from CITY 
where ID = 1661;

/* 5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN. */

select * from CITY 
where COUNTRYCODE = 'JPN';

/* 6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN. */

select NAME from CITY 
where COUNTRYCODE = 'JPN';

/* 7. Query a list of CITY and STATE from the STATION table. */

select CITY, STATE from STATION;

/* 8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer. */

select distinct(CITY) from STATION 
where ID % 2 = 0; 

/* 9. Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table. */

select count(city) - count(distinct(city)) from station;

/* 10. Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically. */

with a as (select city as c, length(city) as len 
		  from station 
          where length(city) = (select min(length(city)) from station) 
          order by c asc limit 1) 
select c, len from a 
	union 
(select city as c, length(city) as len 
from station 
where length(city) = (select max(length(city)) from station) 
order by c limit 1);

/* 11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates. */

select distinct CITY 
from STATION 
where CITY like 'A%' or CITY like 'E%' or CITY like 'I%' or CITY like 'O%' or CITY like 'U%';

/* 12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates. */

select distinct CITY 
from STATION 
where right(CITY, 1) in ('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U');

/* 13. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates. */

select distinct CITY 
from STATION 
where left(CITY, 1) in ('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U') 
	and right(CITY, 1) in ('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U');
    
/* 14. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates. */

select distinct CITY 
from STATION 
where left(CITY, 1) not in ('a', 'e', 'i', 'o', 'u');

/* 15. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates. */

select distinct CITY 
from STATION 
where right(CITY, 1) not in ('a', 'e', 'i', 'o', 'u' );

/* 16. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates. */

select distinct CITY 
from STATION 
where left(CITY, 1) not in('a', 'e', 'i', 'o', 'u') 
	or right(CITY, 1) not in('a', 'e', 'i', 'o', 'u');
    
/* 17. Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates. */

select distinct CITY 
from STATION  
where left(CITY, 1) not in('a', 'e', 'i', 'o', 'u') 
	and right(CITY, 1) not in('a', 'e', 'i', 'o', 'u');
    
/* 18. Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID. */

select Name from STUDENTS 
where Marks > 75
order by right(Name, 3), ID;

/* 19. Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order. */

select NAME from Employee 
order by Name;

/* 20. Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  per month who have been employees for less than  months. Sort your result by ascending employee_id. */

select Name from Employee 
where salary > 2000 and months < 10 
order by employee_ID;

/* 21. Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

Equilateral: It's a triangle with 3 sides of equal length.
Isosceles: It's a triangle with 2 sides of equal length.
Scalene: It's a triangle with 3 sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle. */

select case 
    when(a=b and b=c) then 'Equilateral' 
    when (a+b<=c or b+c<=a or c+a<=b) then 'Not A Triangle' 
    when (a!=b and b!=c and c!=a) then 'Scalene' 
    else 'Isosceles' 
    end 
from triangles;

/* 22. Query a count of the number of cities in CITY having a Population larger than 100,000. */

select count(NAME) from CITY 
where POPULATION > 100000;

/* 23. Query the total population of all cities in CITY where District is California. */

select sum(POPULATION) 
from CITY 
where DISTRICT = 'California';

/* 24. Query the average population of all cities in CITY where District is California. */

select avg(POPULATION) 
from CITY 
where DISTRICT = 'California';

/* 25. Query the average population for all cities in CITY, rounded down to the nearest integer. */

select round(avg(POPULATION)) 
from CITY;

/* 26. Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN. */

select sum(POPULATION) 
from CITY 
where COUNTRYCODE = 'JPN';

/* 27. Query the difference between the maximum and minimum populations in CITY. */

select max(POPULATION) - min(POPULATION) 
from CITY;

/* 28. Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's 0 key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), and round it up to the next integer. */

select round(avg(Salary)) - round(avg(replace(Salary, '0', ''))) 
from Employees;

/* 29. We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers. */

select max(months * salary), count(salary*months) 
from employee 
where salary * months in ( select max(salary * months) from employee);

/* 30. Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.*/

select round(sum(LAT_N),2) , round(sum(LONG_W),2) 
from STATION;

/* 31. Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7780 and less than 137.2345. Truncate your answer to 4 decimal places. */

select round(sum(LAT_N), 4) 
from STATION 
where LAT_N > 38.7880 and LAT_N < 137.2345;

/* 32. Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345. Truncate your answer to 4 decimal places. */

select round(max(LAT_N), 4) 
from STATION 
where LAT_N < 137.2345;

/* 33. Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345. Round your answer to 4 decimal places.*/

select round(LONG_W, 4) 
from STATION 
where LAT_N = (select max(LAT_N) from STATION where LAT_N < 137.2345);

/* 34. Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to 4 decimal places. */

select round(min(LAT_N),4) 
from station 
where LAT_N > 38.7780 
order by LAT_N asc 
limit 1;

/* 35. Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to 4 decimal places.*/

select round(LONG_W, 4) 
from STATION 
where LAT_N =  (select min(LAT_N) from station where LAT_N> 38.7780);

/* 36. Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'. */

select sum(c1.POPULATION) 
from CITY c1 
join COUNTRY c2 on c1.COUNTRYCODE = c2.CODE 
where CONTINENT = 'Asia';

/* 37. Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'. */

select c1.NAME 
from CITY c1 
join COUNTRY c2 on c1.COUNTRYCODE = c2.CODE 
where c2.CONTINENT = 'Africa';

/* 38. Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer. */

select c2.CONTINENT, floor(avg(c1.POPULATION)) 
from COUNTRY c2 
join CITY c1 on c1.COUNTRYCODE = c2.CODE 
group by c2.CONTINENT;

/* 39. P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
* * * * * 
* * * * 
* * * 
* * 
*                       */

with recursive stars as (select 20 as n union all select n-1 from stars where n>0)

select repeat('* ', n) from stars
where n > 0;

/* 40. P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
* 
* * 
* * * 
* * * * 
* * * * *                 */

with recursive stars as (select 1 as n union all select n + 1 from stars where n <= 20)

select repeat('* ', n) from stars
where n <= 20;


