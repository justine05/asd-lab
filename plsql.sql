--first program

CREATE OR REPLACE FUNCTION prime(n integer) RETURNS INTEGER AS $$
DECLARE
    num integer := 0;
    c integer := 2;
    flag integer := 0;
    temp integer;
    prime integer := 0;
BEGIN
    LOOP
        EXIT WHEN prime = n;
        temp := 2;
        flag = 0;
        LOOP
            EXIT WHEN temp = c/2+1;
            IF c % temp = 0 THEN
                flag := 1;
                EXIT;
            END IF;
            temp := temp +1;
        END LOOP;
        IF flag = 0 THEN
                prime := prime + 1;
            RAISE NOTICE '% is prime',c;
        END IF;
        c := c+1;
    END LOOP;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

--second program

CREATE FUNCTION fib(n integer) RETURNS INTEGER AS $$
DECLARE
    num INTEGER := n;
    cnt INTEGER := 0;
    a INTEGER := 0;
    b INTEGER := 1;
    c INTEGER := 0;
BEGIN
    RAISE NOTICE '%',a;
    RAISE NOTICE '%',b;
    LOOP
        EXIT WHEN cnt = n-1;        
        c := a + b;
        RAISE NOTICE '%',c;
        a := b;
        b := c;
        cnt := cnt+1;
    END LOOP;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

--thrid program with cursor

create table student_marks(
roll int,
name varchar(5),
mark1 int,
mark2 int,
mark3 int,
grade char(4));


INSERT INTO student_marks VALUES(1, 'Anu', 50, 45, 48, NULL);
INSERT INTO student_marks VALUES(2, 'Manu', 50, 50, 50, NULL);
INSERT INTO student_marks VALUES(3, 'Manu', 35, 40, 40, NULL);

CREATE OR REPLACE FUNCTION porf() RETURNS INTEGER AS $$
DECLARE
    sum INTEGER;
    c1 CURSOR FOR SELECT * FROM student_marks;
    rec RECORD;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO rec;
        EXIT WHEN NOT FOUND;
        sum = (rec.mark1 + rec.mark2 + rec.mark3)/3;
        IF sum > 40 THEN
            UPDATE student_marks 
            SET grade = 'PASS' 
            WHERE CURRENT OF c1;
        ELSE
            UPDATE student_marks 
            SET grade = 'FAIL' 
            WHERE CURRENT OF c1;
        END IF;
    END LOOP;
    CLOSE c1;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

--third program

CREATE OR REPLACE FUNCTION porf(rn integer, name varchar(5), mark1 INTEGER, mark2 integer, mark3 integer) RETURNS INTEGER AS $$
DECLARE
    r integer := rn;
    nm VARCHAR(5) := name;
    m1 INTEGER := mark1;
    m2 INTEGER := mark2;
    m3 INTEGER := mark3;
    grade CHAR(4);
    sum INTEGER;
BEGIN
    sum = (m1 + m2 + m3)/3;
    IF sum > 40 THEN
            grade := 'PASS'; 
        ELSE
            grade := 'FAIL';
    END IF;
    INSERT INTO student_marks VALUES (r,nm,m1,m2,m3,grade);
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

--fourth problem

CREATE TABLE circle_area(
    raduis INTEGER,
    area FLOAT
);


CREATE OR REPLACE FUNCTION calc_area(n integer) RETURNS INTEGER AS $$
DECLARE
    nu integer := n;
    count INTEGER := 0;
    r INTEGER;
BEGIN
    LOOP
        EXIT WHEN count = n;
        r := 5*(count+1);
        INSERT INTO circle_area VALUES(r, 3.14*r*r);
        count := count +1;
    END LOOP;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

--fifth problem

CREATE TABLE stud (
    name VARCHAR(30),
    mark INTEGER
);

CREATE OR REPLACE FUNCTION add_stud() RETURNS INTEGER AS $$
DECLARE
    name VARCHAR(30)[10] := array['ARUN','AMAL','PETER','JOSE','ANNIE','MARY','JOSEPH','MARK','MIDHUN','KEVIN'];
    mark INTEGER[10] := array['25','76','43','45','67','57','97','56','89','8'];
    count INTEGER := 1;
    nu INTEGER := 10; 
BEGIN
    LOOP
        EXIT WHEN count = nu+1;
            INSERT INTO stud VALUES(name[count],mark[count]);
        count := count+1;        
    END LOOP;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE class_cse (
    roll INTEGER,
    name VARCHAR(30),
    phone VARCHAR(30)
);

--sixth problem

CREATE SEQUENCE ai
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE FUNCTION add_data(name VARCHAR(30), ph VARCHAR(30)) RETURNS INTEGER AS $$
DECLARE
    
BEGIN
    INSERT INTO class_cse VALUES(nextval('ai'),name, ph);
    RETURN 0;
END;
$$ LANGUAGE plpgsql;