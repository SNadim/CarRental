SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE Trigger DriverAssigned
after insert 
on rental

BEGIN
    DBMS_OUTPUT.PUT_LINE('Car assigned to customer');
END;
/


CREATE OR REPLACE PROCEDURE assignCar(carID IN number,cID IN number,startDate IN Date, endDate IN Date, rentStatus IN VARCHAR2)
IS
    rentalID number;
    flag number;
BEGIN
    flag := 1;
    FOR R IN (SELECT * FROM rental) LOOP
        IF R.car_id = carID AND R.customer_id = cID then
            flag :=0;
        END IF;
    END LOOP;
    
    IF flag = 1 then
        SELECT count(rental_id) into rentalID FROM rental;
        insert into rental values(rentalID+1,carID,cID, startDate, endDate,rentStatus);



        For K in (select car_id from car1) LOOP
            if K.car_id = 9 then
                update car1 set car_status = 'rented' where car_id = carID;
                exit;
            end if;
        END LOOP;


        For K in (select car_id from car2@site_vm) LOOP
            if K.car_id = 9 then
                update car2@site_vm set car_status = 'rented' where car_id = carID;
                exit;
            end if;
        END LOOP;
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('Data Already Exists');
    END IF;

END assignCar;
/

ACCEPT carID NUMBER PROMPT "Car ID = ";
ACCEPT cID NUMBER PROMPT "Customer ID = ";
ACCEPT startDate Date PROMPT "Start Date = ";
ACCEPT endDate Date PROMPT "End Date = ";
ACCEPT rentStatus char PROMPT "Rental Status = ";

DECLARE
    cID number;
    carID number;
    startDate date;
    endDate date;
    rentStatus VARCHAR2(20);
BEGIN
    cID  := '&CID';
    carID := '&CARID';
    startDate := '&startDate';
    endDate := '&endDate';
    rentStatus := '&rentStatus';

    DBMS_OUTPUT.PUT_LINE(CID);
    DBMS_OUTPUT.PUT_LINE(carID);
    DBMS_OUTPUT.PUT_LINE(startDate);
    DBMS_OUTPUT.PUT_LINE(endDate);
    DBMS_OUTPUT.PUT_LINE(rentStatus);
    assignCar(carID,cID,startDate,endDate,rentStatus);
END;
/

commit;