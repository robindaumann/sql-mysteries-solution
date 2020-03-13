select description
from crime_scene_report
where city = 'SQL City'
and date = 20180115
and type = 'murder';

-- Security footage shows that there were 2 witnesses.
-- The first witness lives at the last house on "Northwestern Dr".
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".

select transcript
from person as p
join interview as i on i.person_id = p.id
where address_street_name like 'Northwestern Dr%'
order by address_number desc
limit 1;

-- 1. witness Morty Schapiro (14887)
-- I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag.
-- The membership number on the bag started with "48Z". Only gold members have those bags.
-- The man got into a car with a plate that included "H42W".

select transcript
from person as p
join interview as i on i.person_id = p.id
where address_street_name = 'Franklin Ave'
and name like 'Annabel%';

-- 2. witness Annabel Miller (16371)
-- I saw the murder happen, and I recognized the killer from my gym when
-- I was working out last week on January the 9th.

select p.id, p.name
from get_fit_now_member as m
join person as p on p.id = m.person_id
join drivers_license as d on d.id = p.license_id
join get_fit_now_check_in as c on c.membership_id = m.id
where m.id like '48Z%'
and membership_status = 'gold'
and check_in_date = '20180109'
and plate_number like '%H42W%';

-- Solution: Jeremy Bowers (67318)

-- Additional challenge

select transcript
from interview
where person_id = 67318;

-- I was hired by a woman with a lot of money. I don't know her name but I know she's around
-- 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she
-- attended the SQL Symphony Concert 3 times in December 2017.

select p.id, p.name, count(*) as event_count
from drivers_license as dl
join person as p on p.license_id = dl.id
join facebook_event_checkin as fb on fb.person_id = p.id
where gender = 'female'
and height between 65 and 67
and hair_color = 'red'
and car_make = 'Tesla'
and car_model = 'Model S'
and event_name = 'SQL Symphony Concert'
and substr(date,1,6) = '201712' -- date like '201712%'
group by p.id;

-- Solution: Miranda Priestly (99716)
