--first program

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