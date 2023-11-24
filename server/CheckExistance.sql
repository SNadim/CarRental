SET SERVEROUTPUT ON;
SET VERIFY OFF;

--add new car
CREATE OR REPLACE Trigger CustomerInsert
after insert 
on customer11

BEGIN
    DBMS_OUTPUT.PUT_LINE('New customer added.');
END;
/


CREATE OR REPLACE PACKAGE CustomerCheck AS 
   -- Adds a customer 
   Function FindCustomer(customerPhoneNumber  in customer11.customer_phone_number%TYPE) 
   return number; 
   
END CustomerCheck; 
/

CREATE OR REPLACE PACKAGE BODY CustomerCheck AS 
   Function FindCustomer(customerPhoneNumber  in customer11.customer_phone_number%TYPE)
   return number
   is
   c number;

begin
    FOR R IN (SELECT c11.customer_phone_number FROM CUSTOMER11 C11 JOIN customer12@SITE_LINK C21 ON C11.customer_id = C21.Customer_ID UNION SELECT c12.customer_phone_number FROM CUSTOMER21 C12 JOIN customer22@SITE_LINK C22 ON C12.customer_id = C22.Customer_ID)
    LOOP
    IF R.customer_phone_number = customerPhoneNumber THEN
      return 1;
    end if;
   END LOOP;
    
   return 0;       

   End FindCustomer;
END CustomerCheck; 
/



-- select count(customer_id) from (SELECT c11.customer_id FROM CUSTOMER11 C11 JOIN customer12@SITE_LINK C21 ON C11.customer_id = C21.Customer_ID UNION SELECT c12.customer_id FROM CUSTOMER21 C12 JOIN customer22@SITE_LINK C22 ON C12.customer_id = C22.Customer_ID)