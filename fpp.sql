--first program

CREATE OR REPLACE FUNCTION fact(n integer) RETURNS VOID AS $$
DECLARE
    c INTEGER := 1;
    prod INTEGER := 1;
BEGIN
    LOOP
        EXIT WHEN c = n+1;
        prod := prod * c;
        c := c + 1;
    END LOOP;
    RAISE NOTICE 'The factorial is : %',prod;
END;
$$ LANGUAGE plpgsql;

--second program

CREATE TABLE student_details(roll int,marks int, phone VARCHAR(30));
INSERT INTO student_details VALUES(1,70,'9496947423');
INSERT INTO student_details VALUES(2,85,'9495941358');
INSERT INTO student_details VALUES(3,78,'8281865009');

CREATE OR PROCEDURE FUNCTION pr1() AS $$
DECLARE
    c1 CURSOR FOR SELECT * FROM student_details;
    rec RECORD;
BEGIN
    OPEN c1;
    LOOP
        FETCH FROM c1 INTO rec;
        EXIT WHEN NOT FOUND;
        UPDATE student_details
        SET marks = marks * 1.05
        WHERE CURRENT OF c1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--third program

CREATE TABLE student(id int, name varchar(10), m1 int, m2 int, m3 int, total int, grade varchar(1) );
INSERT INTO student VALUES (1,'John',50,70,60,NULL,NULL);
INSERT INTO student VALUES (2,'Ann',30,40,35,NULL,NULL);
INSERT INTO student VALUES (3,'Ben',70,65,20,NULL,NULL);
INSERT INTO student VALUES (4,'Caly',10,15,45,NULL,NULL);


CREATE OR REPLACE PROCEDURE porf() AS $$
DECLARE
    sum INTEGER;
    c1 CURSOR FOR SELECT * FROM student;
    rec RECORD;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO rec;
        EXIT WHEN NOT FOUND;
        sum = (rec.m1 + rec.m2 + rec.m3)/3;
        IF sum > 40 THEN
            UPDATE student 
            SET total = m1+m2+m3, grade = 'P' 
            WHERE CURRENT OF c1;
        ELSE
            UPDATE student
            SET total = m1+m2+m3, grade = 'F' 
            WHERE CURRENT OF c1;
        END IF;
    END LOOP;
    CLOSE c1;
END;
$$ LANGUAGE plpgsql;

--fourth program

