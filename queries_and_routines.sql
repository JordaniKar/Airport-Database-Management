use 2026_kursova_rabota;

/*SELECT с ограничаващо условие*/
 Select id, take_off_date, duration_minutes 
from flights 
where duration_minutes > 120;

/*Агрегатна функция и GROUP BY*/
Select crew_role, count(*) as total_members
from crew_members
group by crew_role;

/*INNER JOIN*/
Select flights.id, planes.plane_type, planes.company
from flights
inner join planes on flights.plane_id = planes.id;

/*OUTER JOIN*/
Select crew_members.crew_name, flight_crew.flight_id
from crew_members
left outer join flight_crew on crew_members.id = flight_crew.crew_member_id;

/*Вложен SELECT*/
Select * 
from flights 
where departure_airport_id = (select id from airports where city = 'Sofia');

/*JOIN + Агрегатна функция*/
Select planes.company, sum(flights.duration_minutes) as total_minutes
from flights
inner join planes on flights.plane_id = planes.id
group by planes.company;

/*TRIGGER*/
Delimiter //
Create trigger  prevent_crew_overlays
before insert on flight_crew
for each row
begin
    declare flight_date date;
    declare conflict_count int;
    
    select take_off_date into flight_date 
    from flights 
    where id = new.flight_id;

    Select count(*) into conflict_count
    from flight_crew fc
    join flights on fc.flight_id = f.id
    where fc.crew_member_id = new.crew_member_id and f.take_off_date = flight_date;

    If conflict_count > 0 then
        signal sqlstate '45000'
        set message_text = 'Error: Crew member is already assigned to another flight on this date!';
    end if;
end; //
delimiter ;

/*PROCEDURE*/
Delimiter //
Create procedure PlaneUsageWhileReport()
begin
    declare done int default false;
    declare current_plane varchar(50);
    declare current_company varchar(100);
    declare total_min int;
    
    declare plane_cursor cursor for select p.plane_type, p.company, SUM(f.duration_minutes)
	from planes p
	left outer join flights f on p.id = f.plane_id
	group by p.id;

    declare continue handler for not found set done = true;

    open plane_cursor;
    fetch plane_cursor into current_plane, current_company, total_min;

    while not done do
        if total_min > 600 then select concat('WARNING: ', current_plane, ' [', current_company, '] has high usage: ', total_min, ' min.') as State;
		else select concat('OK: ', current_plane, ' is at ', total_min, ' min.') as State;
        end if;
       fetch plane_cursor into current_plane, current_company, total_min;
    end while;
    close plane_cursor;
end; //
delimiter ;

 