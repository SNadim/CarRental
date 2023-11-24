CREATE OR REPLACE PACKAGE CustomerCheck AS 
   -- Adds a customer 
   Function FindCustomer(c_id   number) 
   return number; 
   
END CustomerCheck; 
/

CREATE OR REPLACE PACKAGE BODY CustomerCheck AS 
   Function FindCustomer(c_id   number)
   return number
   is
   c number;

begin

    FOR R IN (SELECT c11.customer_id FROM CUSTOMER11 C11 JOIN customer12@SITE_LINK C21 ON C11.customer_id = C21.Customer_ID UNION SELECT c12.customer_id FROM CUSTOMER21 C12 JOIN customer22@SITE_LINK C22 ON C12.customer_id = C22.Customer_ID)
    LOOP
    IF R.Customer_ID = c_id THEN
      return 1;
    end if;
    END LOOP;
    
    return 0;       

   End FindCustomer;
END CustomerCheck; 
/


Declare

cid number := &x;
ex number;

Begin
    ex := CustomerCheck.FindCustomer(cid);

    if ex =1 THEN
        DBMS_Output.put_line('Id does exit');
    ELSE
        DBMS_Output.put_line('Id does not exit');
    end if;

End;
/

select count(customer_id) from (SELECT c11.customer_id FROM CUSTOMER11 C11 JOIN customer12@SITE_LINK C21 ON C11.customer_id = C21.Customer_ID UNION SELECT c12.customer_id FROM CUSTOMER21 C12 JOIN customer22@SITE_LINK C22 ON C12.customer_id = C22.Customer_ID)