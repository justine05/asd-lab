--first program

CREATE OR REPLACE FUNCTION porf() RETURNS INTEGER AS $$
DECLARE
    sum INTEGER;
    c1 CURSOR FOR SELECT * FROM student;
    rec RECORD;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO rec;
        EXIT WHEN NOT FOUND;
        sum = ceil((rec.m1 + rec.m2 + rec.m3)/3);
        IF sum >= 80 THEN
            UPDATE student 
            SET grade = 'A' 
            WHERE CURRENT OF c1;
        ELSIF sum >= 70 AND sum < 80 THEN
            UPDATE student 
            SET grade = 'B' 
            WHERE CURRENT OF c1;
        ELSIF sum >= 60 AND sum < 70 THEN
            UPDATE student 
            SET grade = 'C' 
            WHERE CURRENT OF c1;
        ELSIF sum >= 50 AND sum < 60 THEN
            UPDATE student 
            SET grade = 'D' 
            WHERE CURRENT OF c1;
        ELSE
            UPDATE student 
            SET grade = 'F' 
            WHERE CURRENT OF c1;
        END IF;
    END LOOP;
    CLOSE c1;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

--second program

insert into bank_details values(1001,'aby',3005,'10-oct-15');
insert into bank_details values(1002,'alan',4000,'05-may-95');
insert into bank_details values(1003,'amal',5000,'16-mar-92');
insert into bank_details values(1004,'jeffin',3500,'01-apr-50');
insert into bank_details values(1005,'majo',6600,'01-jan-01');

CREATE OR REPLACE FUNCTION cal_int() RETURNS INTEGER AS $$
DECLARE
    c1 CURSOR FOR SELECT * FROM bank_details;
    rec RECORD;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO rec;
        EXIT WHEN NOT FOUND;
        INSERT INTO bank_new VALUES (rec.accno, rec.balance*0.08);
    END LOOP;      
    CLOSE c1;  CREATE OR REPLACE FUNCTION cal_exp() RETURNS INTEGER AS $$
DECLARE
    cd DATE := current_date;
    c1 CURSOR FOR SELECT * FROM people_list;
    rec RECORD;
    yd INT;
BEGIN
    OPEN c1;
    LOOP
        FETCH FROM c1 INTO rec;
        EXIT WHEN NOT FOUND;
        yd := date_part('year',age(rec.dt_joining));
        IF yd > 10 THEN
            INSERT INTO exp_list VALUES(rec.id,rec.name,yd);
        END IF; 
    END LOOP;
    CLOSE c1;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;
    RETURN 0;
END;
$$ LANGUAGE plpCREATE OR REPLACE FUNCTION cal_exp() RETURNS INTEGER AS $$
DECLARE
    cd DATE := current_date;
    c1 CURSOR FOR SELECT * FROM people_list;
    rec RECORD;
    yd INT;
BEGIN
    OPEN c1;
    LOOP
        FETCH FROM c1 INTO rec;
        EXIT WHEN NOT FOUND;
        yd := date_part('year',age(rec.dt_joining));
        IF yd > 10 THEN
            INSERT INTO exp_list VALUES(rec.id,rec.name,yd);
        END IF; 
    END LOOP;
    CLOSE c1;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

--third program
CREATE OR REPLACE FUNCTION cal_exp() RETURNS INTEGER AS $$
DECLARE
    cd DATE := current_date;
    c1 CURSOR FOR SELECT * FROM people_list;
    rec RECORD;
    yd INT;
BEGIN
    OPEN c1;
    LOOP
        FETCH FROM c1 INTO rec;
        EXIT WHEN NOT FOUND;
        yd := date_part('year',age(rec.dt_joining));
        IF yd > 10 THEN
            INSERT INTO exp_list VALUES(rec.id,rec.name,yd);
        END IF; 
    END LOOP;
    CLOSE c1;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

create table people_list(id INT, name varchar(20),dt_joining DATE,place varchar(20));
create table exp_list(id INT, name varchar(20),exp INT);

CREATE OR REPLACE FUNCTION cal_exp() RETURNS INTEGER AS $$
DECLARE
    cd DATE := current_date;
    c1 CURSOR FOR SELECT * FROM people_list;
    rec RECORD;
    yd INT;
BEGIN
    OPEN c1;
    LOOP
        FETCH FROM c1 INTO rec;
        EXIT WHEN NOT FOUND;
        yd := date_part('year',age(rec.dt_joining));
        IF yd > 10 THEN
            INSERT INTO exp_list VALUES(rec.id,rec.name,yd);
        END IF; 
    END LOOP;
    CLOSE c1;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

--fouth program

CREATE OR REPLACE FUNCTION updt_sal() RETURNS INTEGER AS $$
DECLARE
    c1 CURSOR FOR SELECT * FROM emp_list;
    rec RECORD;
BEGIN
    OPEN c1;
    LOOP
        FETCH FROM c1 INTO rec;
        EXIT WHEN NOT FOUND;
        IF rec.m_sal*12 < 60000 THEN
            UPDATE emp_list
            SET m_sal = m_sal*1.25
            WHERE CURRENT OF c1;
        ELSIF rec.m_sal*12 >= 60000 AND rec.m_sal*12 < 200000 THEN
            UPDATE emp_list
            SET m_sal = m_sal*1.20
            WHERE CURRENT OF c1;
        ELSIF rec.m_sal*12 >= 200000 AND rec.m_sal*12 < 500000 THEN
            UPDATE emp_list
            SET m_sal = m_sal*1.15
            WHERE CURRENT OF c1;
        ELSIF rec.m_sal*12 >= 500000 THEN
            UPDATE emp_list
            SET m_sal = m_sal*1.10
            WHERE CURRENT OF c1;
        END IF;
    END LOOP;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;