/* 1. Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are 0.
Note: A specific contest can be used to screen candidates at more than one college, but each college only holds 1 screening contest. */

with s as (select c1.contest_id, sum(s.total_submissions) as s_ts, sum(s.total_accepted_submissions) as s_tas 
		  from submission_stats s 
          inner join challenges ch on ch.challenge_id = s.challenge_id 
          inner join colleges c1 on c1.college_id = ch.college_id 
          group by c1.contest_id),

t as (select c2.contest_id, sum(v.total_views) as s_tv, sum(v.total_unique_views) as s_tuv 
	 from view_stats v 
     inner join challenges ch1 on ch1.challenge_id = v.challenge_id 
     inner join colleges c2 on c2.college_id = ch1.college_id 
     group by c2.contest_id)

select c.contest_id, hacker_id, name, s_ts, s_tas, s_tv, s_tuv 
from contests c 
inner join s on c.contest_id = s.contest_id 
inner join t on c.contest_id = t.contest_id 
where (s_ts > 0 or s_tas > 0 or s_tv > 0 or s_tuv > 0) 
order by c.contest_id;