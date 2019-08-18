--first program

CREATE OR REPLACE FUNCTION show_ins() RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'A row is inserted';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t1 
AFTER INSERT 
ON customer_details
FOR EACH ROW
EXECUTE PROCEDURE show_ins();

--second program

CREATE OR REPLACE FUNCTION sal_check() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.salary > 20000 THEN
        RAISE NOTICE 'Employee has salary greater than 20000/-';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t2
AFTER INSERT 
ON emp_details
FOR EACH ROW
EXECUTE PROCEDURE sal_check();

--third program

CREATE OR REPLACE FUNCTION inc_count() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE cust_count
        SET count_row = count_row+1;
    ELSE
        UPDATE cust_count
        SET count_row = count_row-1;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t3
AFTER INSERT OR DELETE
ON customer_details
FOR EACH ROW
EXECUTE PROCEDURE inc_count();

--fourth problem

CREATE OR REPLACE FUNCTION del_upd() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO del VALUES(old.empid, old.empname, old.salary);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO upd VALUES(new.empid, new.empname, new.salary);
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t4
AFTER UPDATE OR DELETE
ON emp_details
FOR EACH ROW
EXECUTE PROCEDURE del_upd();

--fifth problem

CREATE OR REPLACE FUNCTION div(a integer, b integer) RETURNS INTEGER AS $$