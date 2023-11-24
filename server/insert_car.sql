SET SERVEROUTPUT ON;
SET VERIFY OFF;

--add new car
CREATE OR REPLACE Trigger CarInserted
after insert 
on car1

BEGIN
    DBMS_OUTPUT.PUT_LINE('New Car added.');
END;
/

ACCEPT carModel char PROMPT "Car Model = "
ACCEPT carCapacity number PROMPT "Car Capacity = "
ACCEPT carStatus char PROMPT "Availability = "
ACCEPT PRIC number PROMPT "Rent Price = "

DECLARE
    carID car1.car_id%TYPE;
    carModel car1.car_model%TYPE;
    carCapacity car1.car_capacity%TYPE;
    carStatus car1.car_status%TYPE;
    price NUMBER;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Add New Car:');
    carModel := '&carModel';
    carCapacity := &carCapacity;
    carStatus := '&carStatus';
    price := &PRIC;

    select count(car_id) into carID from (select car_id from car1 union select car_id from car2@site_link);
    if carCapacity = 10 then
        insert into car1 values (carID+1,carModel,carCapacity,carStatus,price);
    else
        insert into car2@site_link values (carID+1,carModel,carCapacity,carStatus,price);
    end if;
    

END;
/

commit;

