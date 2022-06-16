--------------------------------------------------------
--  File created - Friday-July-02-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type BOOKING_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."BOOKING_TY" AS OBJECT(
Id INTEGER,
Customer REF customer_ty,
Course REF course_ty
);


/

--------------------------------------------------------
--  DDL for Type COURSE_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."COURSE_TY" AS OBJECT(
Id INTEGER,
Name VARCHAR(20),
Description VARCHAR(50),
Cost FLOAT,
day VARCHAR(10),
Time VARCHAR(5),
Instructor REF instructor_ty,
Attending_customers customers_NT
) not final;


/

--------------------------------------------------------
--  DDL for Type CUSTOMERS_NT
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."CUSTOMERS_NT" as table of REF customer_ty;


/

--------------------------------------------------------
--  DDL for Type CUSTOMERWITHTOOLS_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."CUSTOMERWITHTOOLS_TY" UNDER customer_ty (
Month_price FLOAT
);


/

--------------------------------------------------------
--  DDL for Type CUSTOMER_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."CUSTOMER_TY" AS OBJECT (
Tax_code VARCHAR(21),
Name VARCHAR(20),
Surname VARCHAR(20),
Address VARCHAR(40),
dateOfBirth DATE
) not final;


/

--------------------------------------------------------
--  DDL for Type EXERCISEFORCARD_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."EXERCISEFORCARD_TY" AS OBJECT(
Exercise REF exercise_ty,
Num_series INTEGER,
Num_repetition INTEGER
);


/

--------------------------------------------------------
--  DDL for Type EXERCISES_NT
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."EXERCISES_NT" as table of exerciseForCard_ty;


/

--------------------------------------------------------
--  DDL for Type EXERCISE_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."EXERCISE_TY" AS OBJECT(
Technical_name VARCHAR(20),
Description VARCHAR(50)
);


/

--------------------------------------------------------
--  DDL for Type INSTRUCTOR_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."INSTRUCTOR_TY" AS OBJECT(
Tax_code VARCHAR(21),
Name VARCHAR(20),
Surname VARCHAR(20),
Year_experience INTEGER
);


/

--------------------------------------------------------
--  DDL for Type LISTEXERCISES
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."LISTEXERCISES" as table of varchar(20)


/

--------------------------------------------------------
--  DDL for Type LISTREPETITIONS
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."LISTREPETITIONS" as table of integer


/

--------------------------------------------------------
--  DDL for Type LISTSERIE
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."LISTSERIE" as table of integer


/

--------------------------------------------------------
--  DDL for Type PERSONAL_CARD_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."PERSONAL_CARD_TY" AS OBJECT(
Id INTEGER,
Name VARCHAR(20),
Start_date DATE,
End_date DATE,
Customer REF customer_ty,
Exercises exercises_nt
);


/

--------------------------------------------------------
--  DDL for Type SPINNING_TY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "YELLOWCOM"."SPINNING_TY" UNDER course_ty(
Level_difficulty VARCHAR(20),
Limit_num_places INTEGER,
Num_places_available INTEGER
);


/


--------------------------------------------------------
--  DDL for Table BOOKINGS
--------------------------------------------------------

  CREATE TABLE "YELLOWCOM"."BOOKINGS" OF "YELLOWCOM"."BOOKING_TY" 
 ;
--------------------------------------------------------
--  DDL for Table COURSES
--------------------------------------------------------

  CREATE TABLE "YELLOWCOM"."COURSES" OF "YELLOWCOM"."COURSE_TY" 
 
 NESTED TABLE "ATTENDING_CUSTOMERS" STORE AS "ATTENDINGCUSTOMERSTAB"
 RETURN AS VALUE;
--------------------------------------------------------
--  DDL for Table CUSTOMERS
--------------------------------------------------------

  CREATE TABLE "YELLOWCOM"."CUSTOMERS" OF "YELLOWCOM"."CUSTOMER_TY" 
 ;
--------------------------------------------------------
--  DDL for Table EXERCISES
--------------------------------------------------------

  CREATE TABLE "YELLOWCOM"."EXERCISES" OF "YELLOWCOM"."EXERCISE_TY" 
 ;


--------------------------------------------------------
--  DDL for Table INSTRUCTORS
--------------------------------------------------------

  CREATE TABLE "YELLOWCOM"."INSTRUCTORS" OF "YELLOWCOM"."INSTRUCTOR_TY" 
 ;
--------------------------------------------------------
--  DDL for Table OLDPERSONALCARDS
--------------------------------------------------------

  CREATE TABLE "YELLOWCOM"."OLDPERSONALCARDS" OF "YELLOWCOM"."PERSONAL_CARD_TY" 
 
 NESTED TABLE "EXERCISES" STORE AS "EXERCISESOLDCARDTAB"
 RETURN AS VALUE;
--------------------------------------------------------
--  DDL for Table PERSONALCARDS
--------------------------------------------------------

  CREATE TABLE "YELLOWCOM"."PERSONALCARDS" OF "YELLOWCOM"."PERSONAL_CARD_TY" 
 
 NESTED TABLE "EXERCISES" STORE AS "EXERCISESCARDTAB"
 RETURN AS VALUE;

--------------------------------------------------------
--  Constraints for Table BOOKINGS
--------------------------------------------------------

  ALTER TABLE "YELLOWCOM"."BOOKINGS" MODIFY ("CUSTOMER" NOT NULL ENABLE);
 
  ALTER TABLE "YELLOWCOM"."BOOKINGS" MODIFY ("COURSE" NOT NULL ENABLE);
 
  ALTER TABLE "YELLOWCOM"."BOOKINGS" ADD PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."BOOKINGS" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table INSTRUCTORS
--------------------------------------------------------

  ALTER TABLE "YELLOWCOM"."INSTRUCTORS" ADD PRIMARY KEY ("TAX_CODE") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."INSTRUCTORS" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table OLDPERSONALCARDS
--------------------------------------------------------

  ALTER TABLE "YELLOWCOM"."OLDPERSONALCARDS" MODIFY ("CUSTOMER" NOT NULL ENABLE);
 
  ALTER TABLE "YELLOWCOM"."OLDPERSONALCARDS" ADD PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."OLDPERSONALCARDS" ADD UNIQUE ("EXERCISES") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."OLDPERSONALCARDS" ADD UNIQUE ("SYS_NC_OID$") ENABLE;

--------------------------------------------------------
--  Constraints for Table COURSES
--------------------------------------------------------

  ALTER TABLE "YELLOWCOM"."COURSES" ADD CHECK (day in ('lunedì', 'martedì', 'mercoledì', 'giovedì', 'venerdì', 'sabato', 'domenica')) ENABLE;
 
  ALTER TABLE "YELLOWCOM"."COURSES" MODIFY ("INSTRUCTOR" NOT NULL ENABLE);
 
  ALTER TABLE "YELLOWCOM"."COURSES" ADD PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."COURSES" ADD UNIQUE ("ATTENDING_CUSTOMERS") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."COURSES" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table CUSTOMERS
--------------------------------------------------------

  ALTER TABLE "YELLOWCOM"."CUSTOMERS" ADD PRIMARY KEY ("TAX_CODE") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."CUSTOMERS" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  Constraints for Table EXERCISES
--------------------------------------------------------

  ALTER TABLE "YELLOWCOM"."EXERCISES" ADD PRIMARY KEY ("TECHNICAL_NAME") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."EXERCISES" ADD UNIQUE ("SYS_NC_OID$") ENABLE;

--------------------------------------------------------
--  Constraints for Table PERSONALCARDS
--------------------------------------------------------

  ALTER TABLE "YELLOWCOM"."PERSONALCARDS" MODIFY ("CUSTOMER" NOT NULL ENABLE);
 
  ALTER TABLE "YELLOWCOM"."PERSONALCARDS" ADD PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."PERSONALCARDS" ADD UNIQUE ("EXERCISES") ENABLE;
 
  ALTER TABLE "YELLOWCOM"."PERSONALCARDS" ADD UNIQUE ("SYS_NC_OID$") ENABLE;
--------------------------------------------------------
--  DDL for Index CUSTOMER_INDEX
--------------------------------------------------------

  CREATE INDEX "YELLOWCOM"."CUSTOMER_INDEX" ON "YELLOWCOM"."CUSTOMERS" ("NAME", "SURNAME") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_FK0000080567N00008$
--------------------------------------------------------

  CREATE INDEX "YELLOWCOM"."SYS_FK0000080567N00008$" ON "YELLOWCOM"."EXERCISESCARDTAB" ("NESTED_TABLE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_FK0000080573N00008$
--------------------------------------------------------

  CREATE INDEX "YELLOWCOM"."SYS_FK0000080573N00008$" ON "YELLOWCOM"."EXERCISESOLDCARDTAB" ("NESTED_TABLE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_FK0000080514N00011$
--------------------------------------------------------

  CREATE INDEX "YELLOWCOM"."SYS_FK0000080514N00011$" ON "YELLOWCOM"."ATTENDINGCUSTOMERSTAB" ("NESTED_TABLE_ID") 
  ;










--------------------------------------------------------
--  DDL for Trigger CHECK_BOOKING
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "YELLOWCOM"."CHECK_BOOKING" 
before insert on bookings
for each row
declare exist number;
begin
select count(*) into exist from bookings where customer=:new.customer and course=:new.course;
if (exist>0) then
raise_application_error(-20999,'The customer has already booked to this course');
end if;
end;

/
ALTER TRIGGER "YELLOWCOM"."CHECK_BOOKING" ENABLE;
--------------------------------------------------------
--  DDL for Trigger UPDATE_ATTENDING_COURSE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "YELLOWCOM"."UPDATE_ATTENDING_COURSE" 
AFTER insert ON bookings
for each row
declare
cou course_TY;
cust customer_ty;
begin
insert into table(
select attending_customers
from courses 
where id=deref(:new.course).id
)values((select ref(c) from customers c where tax_code=deref(:new.customer).tax_code));
end;


/
ALTER TRIGGER "YELLOWCOM"."UPDATE_ATTENDING_COURSE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger UPDATE_NUM_PLACES_AVAILABLE
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "YELLOWCOM"."UPDATE_NUM_PLACES_AVAILABLE" 
AFTER INSERT OR DELETE ON bookings
FOR EACH ROW
DECLARE
spinningCourse spinning_ty;
BEGIN
IF INSERTING THEN
  select treat(value(c) as spinning_ty) into spinningCourse from courses c where c.id=deref(:new.course).id;
  spinningCourse.Num_places_available := spinningCourse.Num_places_available - 1;
  update courses c set value(c) = spinningCourse where c.id=deref(:new.course).id;
END IF;
IF DELETING THEN
  select treat(value(c) as spinning_ty) into spinningCourse from courses c where c.id=deref(:new.course).id;
  spinningCourse.Num_places_available := spinningCourse.Num_places_available + 1;
  update courses c set value(c) = spinningCourse where c.id=deref(:new.course).id;
END IF;
END;
/
ALTER TRIGGER "YELLOWCOM"."UPDATE_NUM_PLACES_AVAILABLE" ENABLE;
--------------------------------------------------------
--  DDL for Procedure BOOK_SPINNING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."BOOK_SPINNING" (taxCode varchar, nome varchar, cognome varchar, giorno varchar, ora varchar) as
existCustomer number;
existCourse number;
cursor c is (select * from courses c where value(c) is of (spinning_ty) and TREAT(value(c) as spinning_ty).num_places_available>1);
course c%rowtype;
id_booking number;
num_places number;
begin
select max(id)into id_booking from bookings;
select count(*) into existCustomer from customers where tax_code=TaxCode or (name=nome and surname=cognome);
if (existCustomer=0) then
  raise_application_error(-2000,'This customer does not exists');
else if (existCustomer>1) then
  raise_application_error(-2000,'Specify the tax code and try again');
else
  if((giorno is null) and (ora is null)) then
    open c;
    fetch c into course;
    insert into bookings values(id_booking+1, (select ref(c) from customers c where tax_code=TaxCode or (name=nome and surname=cognome)),
                            (select ref(co) from courses co where id=course.id));
  else
    select count(*) into existCourse from courses c where value(c) is of (spinning_ty) and day=giorno and time=ora;
    if (existCourse=0) then
    raise_application_error(-2000,'The course does not exist');
  else
    select TREAT(value(c) as spinning_ty).num_places_available into num_places from courses c where value(c) is of (spinning_ty) and day=giorno and time=ora;
    if (num_places>0) then
      insert into bookings values(id_booking+1, (select ref(c) from customers c where tax_code=TaxCode or (name=nome and surname=cognome)),
                            (select ref(co) from courses co where value(co) is of (spinning_ty) and day=giorno and time=ora ));
    else 
      raise_application_error(-2000,'The course is full');
    end if;
end if;
end if;
end if;
end if;
end; 

/

--------------------------------------------------------
--  DDL for Procedure CREATE_PERSONAL_CARD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."CREATE_PERSONAL_CARD" (taxCode VARCHAR2, nameCard VARCHAR2, startDate DATE, endDate DATE, NameExercises ListExercises, NumSer ListSerie, NumReps ListRepetitions) as
Cursor exercisesCursor IS (SELECT * from table(NameExercises));
Cursor numSerCursor IS (SELECT * from table(NumSer));
Cursor numRepsCursor IS (SELECT * from table(NumReps));
newExercise varchar(20);
numSerExercise number;
numRepsExercise number;
maxIDPersCard number;
ExistsCustWithTools number;
ExistsExercise number;
ExistsExercises number;
NumExercisesInserted number;
BEGIN
NumExercisesInserted :=0;
ExistsExercise :=0;
ExistsExercises :=0;
SELECT max(id) into maxIDPersCard from personalcards;
maxIDPersCard:=maxIDPersCard+1;
select count(*) into ExistsCustWithTools from customers c where value(c) is of (CustomerWithTools_TY) and c.tax_code=TaxCode;
OPEN exercisesCursor;
LOOP
FETCH exercisesCursor INTO newExercise;
NumExercisesInserted := NumExercisesInserted +1;
SELECT count(*) into existsExercise from exercises where technical_name=newExercise;
if (existsExercise=1) then
ExistsExercises := ExistsExercises +1;
end if;
existsExercise:=0;
EXIT WHEN exercisesCursor%NOTFOUND;
end loop;
CLOSE exercisesCursor;
IF(ExistsCustWithTools>0) THEN
IF (existsExercises=NumExercisesInserted) THEN
INSERT INTO personalcards VALUES (maxIDPersCard, nameCard, startdate, endDate, (select ref(c) from customers c where value(c) is of (customerWithTools_ty) and tax_code=taxCode), exercises_NT());
OPEN exercisesCursor;
OPEN numSerCursor;
OPEN numRepsCursor;
LOOP
FETCH exercisesCursor INTO newExercise;
FETCH numSerCursor INTO numSerExercise;
FETCH numRepsCursor INTO numRepsExercise;
EXIT WHEN exercisesCursor%NOTFOUND;
insert into table(
select exercises
from personalcards p
where p.id= maxidperscard
) values (exerciseForCard_ty( (select ref(e) from exercises e where technical_name=newExercise), numSerExercise, numRepsExercise));
END LOOP;
CLOSE exercisesCursor;
CLOSE numSerCursor;
CLOSE numRepsCursor;
ELSE
raise_application_error(-20002, 'Check if the exercises exist.');
END IF;
ELSE
raise_application_error(-20003, 'Impossible to insert a personal card for a customer who does not trains with tools weights. Check also if the exercises exist.');
end if;
END;

/

--------------------------------------------------------
--  DDL for Procedure INSERT_CUSTOMER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."INSERT_CUSTOMER" (taxCode varchar, name varchar, surname varchar, birth date, address varchar, price float) as
exist number;
begin
select count(*) into exist from customers c where c.tax_code= taxcode;
if (exist=0) then
if (price is null) then
INSERT into customers values(customer_ty(taxCode, name, surname, address, birth)); 
else 
INSERT into customers values(customerWithTools_ty(taxCode, name, surname, address, birth, price)); 
end if;
else 
raise_application_error(-2000, 'The customer already exist');
end if;
end;

/

--------------------------------------------------------
--  DDL for Procedure INSERT_EXERCISE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."INSERT_EXERCISE" (id_card integer, name varchar, numSeries INTEGER, numRep INTEGER) as
begin
insert into table(
select exercises 
from personalcards p
where p.id=id_card
) values ((select ref(e) from exercises e where technical_name=name), numseries, numrep);
end;

/

--------------------------------------------------------
--  DDL for Procedure INSERT_OLDPERSONALCARD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."INSERT_OLDPERSONALCARD" as
cursor c is (select * from personalcards where end_date<current_date);
cursor e (card number) is (select DEREF(value(ex).exercise).technical_name as techName, num_series, num_repetition 
from personalCards p, table(p.exercises) ex 
where p.id= card);
oldPersonalCard c%rowtype;
oldExercise e%rowtype;
newid number;
begin
open c;
loop
fetch c into oldpersonalcard;
exit when c%notfound;
select max(id) into newid from oldpersonalcards;
newid:=newid+1;
insert into oldpersonalcards values(newid, oldpersonalcard.name, oldpersonalcard.start_date, oldpersonalcard.end_date, oldpersonalcard.customer, exercises_NT());

open e(oldpersonalcard.id);
loop
fetch e into oldExercise;
exit when e%notfound;
insert into table(
select exercises 
from oldpersonalcards
where id=newid
) values(exerciseForCard_ty( (select ref(e) from exercises e where technical_name=oldExercise.techName), oldExercise.num_series, oldExercise.num_repetition));
end loop;
close e;
end loop;
close c;
delete from personalcards where end_date<current_date;
end;

/

--------------------------------------------------------
--  DDL for Procedure POPULATE_BOOKINGS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."POPULATE_BOOKINGS" AS 
iteration number; 
begin iteration := 1; 
LOOP 
INSERT INTO bookings VALUES (booking_ty(iteration, (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value )WHERE rownum = 1), 
                            (SELECT course FROM (SELECT ref(co) as course FROM courses co where value(co) is of (spinning_ty) ORDER BY dbms_random.value)WHERE rownum = 1) ) ); 
iteration := iteration +1; 
exit when iteration>30; 
end loop;
end;

/

--------------------------------------------------------
--  DDL for Procedure POPULATE_COURSES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."POPULATE_COURSES" AS
iteration number;
begin iteration := 1;
LOOP
INSERT INTO courses
VALUES (course_ty(iteration, DBMS_RANDOM.STRING('U', 15), null, (select trunc(dbms_random.value(0, 50),0) from dual), 
        case round(dbms_random.value(1,6))when 1 then 'lunedì' when 2 then 'martedì' when 3 then 'mercoledì' when 4 then 'giovedì' when 5 then 'venerdì' when 6 then 'sabato' end, 
        case round(dbms_random.value(15,20))when 15 then '15:00' when 16 then '16:00' when 17 then '17:00' when 18 then '18:00' when 19 then '19:00' when 20 then '20:00' end, 
        (SELECT instructor FROM (SELECT ref(i) as instructor FROM instructors i ORDER BY dbms_random.value) WHERE rownum = 1),
        customers_NT( (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1),
                    (SELECT customer FROM (SELECT ref(c) as customer FROM customers c where value(c) is not of (customerWithTools_ty) ORDER BY dbms_random.value) WHERE rownum = 1))
                      ));
iteration := iteration +1;
exit when iteration>17;
end loop;

INSERT INTO courses
VALUES (spinning_ty(iteration+1, 'spinning', null, (select trunc(dbms_random.value(0, 50),0) from dual), 'lunedì', '9:00',
        (SELECT instructor FROM (SELECT ref(i) as instructor FROM instructors i ORDER BY dbms_random.value) WHERE rownum = 1),
        customers_NT(), 'medio', 40, 40));

INSERT INTO courses
VALUES (spinning_ty(iteration+2, 'spinning', null, (select trunc(dbms_random.value(0, 50),0) from dual), 'mercoledì', '9:00',
        (SELECT instructor FROM (SELECT ref(i) as instructor FROM instructors i ORDER BY dbms_random.value) WHERE rownum = 1),
        customers_NT(), 'medio', 40, 40));

INSERT INTO courses
VALUES (spinning_ty(iteration+3, 'spinning', null, (select trunc(dbms_random.value(0, 50),0) from dual), 'venerdì', '9:00',
        (SELECT instructor FROM (SELECT ref(i) as instructor FROM instructors i ORDER BY dbms_random.value) WHERE rownum = 1),
        customers_NT(), 'medio', 40, 40));
end;

/

--------------------------------------------------------
--  DDL for Procedure POPULATE_CUSTOMERS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."POPULATE_CUSTOMERS" AS 
iteration number; 
begin iteration := 1; 
LOOP 
INSERT INTO customers VALUES (customer_ty( DBMS_RANDOM.STRING('U', 21), DBMS_RANDOM.STRING('U', 15), DBMS_RANDOM.STRING('U', 15),
                              null, (TRUNC(SYSDATE + DBMS_RANDOM.value(0,366))) )); 
iteration := iteration +1; 
exit when iteration>200; 
end loop;

LOOP 
INSERT INTO customers VALUES (customerWithTools_ty( DBMS_RANDOM.STRING('U', 21), DBMS_RANDOM.STRING('U', 15), DBMS_RANDOM.STRING('U', 15),
                              null, (TRUNC(SYSDATE + DBMS_RANDOM.value(0,366))), 50 )); 
iteration := iteration +1; 
exit when iteration>300; 
end loop;
end;

/

--------------------------------------------------------
--  DDL for Procedure POPULATE_EXERCISES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."POPULATE_EXERCISES" AS
iteration number;
begin iteration := 1;
LOOP
INSERT INTO exercises
VALUES (exercise_ty(DBMS_RANDOM.STRING('U', 15), null));
iteration := iteration +1;
exit when iteration>500;
end loop;
end;

/

--------------------------------------------------------
--  DDL for Procedure POPULATE_INSTRUCTORS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."POPULATE_INSTRUCTORS" AS
iteration number;
begin iteration := 1;
LOOP
INSERT INTO instructors
VALUES (instructor_ty(DBMS_RANDOM.STRING('U', 21), DBMS_RANDOM.STRING('U', 20), DBMS_RANDOM.STRING('U', 20),(select trunc(dbms_random.value(0, 20),0) from dual)));
iteration := iteration +1;
exit when iteration>50;
end loop;
end;

/

--------------------------------------------------------
--  DDL for Procedure POPULATE_OLDPERSONALCARDS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."POPULATE_OLDPERSONALCARDS" AS
iteration number;
begin iteration := 1;
LOOP
INSERT INTO oldPersonalCards
VALUES (personal_card_ty(iteration, DBMS_RANDOM.STRING('U', 15),
        TRUNC(SYSDATE + DBMS_RANDOM.value(0,366)), (TRUNC(SYSDATE + DBMS_RANDOM.value(0,366))),
        (SELECT customer FROM ( SELECT ref(c) as customer FROM customers c where value(c) is of (customerWithTools_ty) ORDER BY dbms_random.value ) WHERE rownum = 1), 
        exercises_NT( exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)) ) ) );
iteration := iteration +1;
exit when iteration>800;
end loop;
end;

/

--------------------------------------------------------
--  DDL for Procedure POPULATE_PERSONALCARDS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."POPULATE_PERSONALCARDS" AS
iteration number;
begin iteration := 1;
LOOP
INSERT INTO personalCards
VALUES (personal_card_ty(iteration, DBMS_RANDOM.STRING('U', 15),
        TRUNC(SYSDATE + DBMS_RANDOM.value(0,366)), (TRUNC(SYSDATE + DBMS_RANDOM.value(0,366))),
        (SELECT customer FROM ( SELECT ref(c) as customer FROM customers c where value(c) is of (customerWithTools_ty) ORDER BY dbms_random.value ) WHERE rownum = 1), 
        exercises_NT( exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)),
                      exerciseForCard_ty((SELECT exercise FROM ( SELECT ref(e) as exercise FROM exercises e ORDER BY dbms_random.value ) WHERE rownum = 1), (select trunc(dbms_random.value(0, 10),0) from dual), (select trunc(dbms_random.value(0, 20),0) from dual)) ) ) );
iteration := iteration +1;
exit when iteration>200;
end loop;
end;


/

--------------------------------------------------------
--  DDL for Procedure PRINT_CALENDAR_COURSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."PRINT_CALENDAR_COURSE" (nome varchar) as 
cursor c is (select * from courses where name=nome);
course c%rowtype;
exist number;
begin
select count(*) into exist from courses where name=nome;
if (exist=0) then
raise_application_error(-2000,'The course does not exist');
else
open c;
loop
fetch c into course;
exit when c%notfound;
dbms_output.put_line('Course: ' || course.name || 'Day: ' || course.day || 'Time: ' || course.time);
end loop;
end if;
end;

/

--------------------------------------------------------
--  DDL for Procedure PRINT_CALENDAR_INSTRUCTOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."PRINT_CALENDAR_INSTRUCTOR" (taxCode varchar, nome varchar, cognome varchar) as 
cursor c is (select * from courses where deref(instructor).tax_code = taxCode or (deref(instructor).name=nome and deref(instructor).surname=cognome));
course c%rowtype;
exist number;
begin
select count(*) into exist from instructors where tax_code= taxCode or (name=nome and surname=cognome);
if (exist=0) then
raise_application_error(-2000, 'The instructor does not exist');
else
open c;
loop
fetch c into course;
exit when c%notfound;
dbms_output.put_line('Course: ' || course.name || ' Day: ' || course.day || ' Time: ' || course.time);
end loop;
end if;
end;

/

--------------------------------------------------------
--  DDL for Procedure PRINT_NUM_PARTECIPANT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."PRINT_NUM_PARTECIPANT" (nome varchar, giorno varchar, ora varchar) as
num INTEGER;
exist integer;
begin 
select count(*) into exist from courses where name=nome and day=giorno and time=ora;
if (exist=0) then
raise_application_error(-2000,'The course does not exist');
else
select count(*) into num from (table(select attending_customers from courses where name=nome and day=giorno and time=ora));
dbms_output.put_line('The number of partecipant is ' || num);
end if;
end;

/

--------------------------------------------------------
--  DDL for Procedure PRINT_OLD_PERSONAL_CARD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."PRINT_OLD_PERSONAL_CARD" (taxCode VARCHAR2, nome VARCHAR2, cognome VARCHAR2) as
cursor c is (select p.name, DEREF(value(e).exercise).technical_name as techName, DEREF(value(e).exercise).description as descr, num_series, num_repetition 
from oldPersonalCards p, table(p.exercises) e 
where deref(customer).tax_code=taxCode or (deref(customer).name=nome and deref(customer).surname=cognome));
card c%rowtype;
begin
open c;
loop
fetch c into card;
exit when c%notfound;
dbms_output.put_line('Card name ' || card.name || ' Esercizio: ' || card.techName || ' Descrizione: ' || card.descr || ' Series: ' || card.num_series || ' Repetition: ' || card.num_repetition);
end loop;
end;

/

--------------------------------------------------------
--  DDL for Procedure PRINT_PERSONAL_CARD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."PRINT_PERSONAL_CARD" (taxCode VARCHAR2, nome VARCHAR2, cognome VARCHAR2) as
cursor c is (select p.name, DEREF(value(e).exercise).technical_name as techName, DEREF(value(e).exercise).description as descr, num_series, num_repetition 
from personalCards p, table(p.exercises) e 
where deref(customer).tax_code=taxCode or (deref(customer).name=nome and deref(customer).surname=cognome));
card c%rowtype;
begin
open c;
loop
fetch c into card;
exit when c%notfound;
dbms_output.put_line('Card name ' || card.name || ' Esercizio: ' || card.techName || ' Descrizione: ' || card.descr || ' Series: ' || card.num_series || ' Repetition: ' || card.num_repetition);
end loop;
end;

/

--------------------------------------------------------
--  DDL for Procedure PRINT_PLACES_AVAILABLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "YELLOWCOM"."PRINT_PLACES_AVAILABLE" (giorno varchar, ora varchar) as
exist number;
num_places number;
begin
select count(*) into exist from courses c where value(c) is of type (spinning_ty) and day=giorno and time=ora;
if (exist=1) then
select TREAT(value(c) as spinning_ty).num_places_available into num_places from courses c where value(c) is of (spinning_ty) and day=giorno and time=ora;
else 
raise_application_error(-2000,'Insert correct information about the course');
end if;
end;

/

