DECLARE

    enddate Date;
    curDate Date;

BEGIN
    SELECT sysdate into curDate from dual;
    For R in (SELECT rental_id, rental_end_date from rental) Loop
        if R.rental_end_date < curDate then 
            Delete from rental where rental_id = R.rental_id;
        end if;
    End loop;
End;

/