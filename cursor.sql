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