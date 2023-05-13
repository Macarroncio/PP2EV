CREATE SEQUENCE id;

CREATE TRIGGER custom_id_trgg
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
SELECT id.nextval
INTO :new.id
FROM dual;
END;


CREATE TABLE CUSTOMERS (
id VARCHAR2(6) CONSTRAINT PK_id PRIMARY KEY,
name VARCHAR2(30),
dni VARCHAR2(15),
phone_number VARCHAR2(12)
);

CREATE TABLE BOOKS (
isbn VARCHAR2(20) CONSTRAINT PK_isbn PRIMARY KEY,
title VARCHAR2(50),
author VARCHAR2(30),
genre VARCHAR2(20)
);
 
CREATE TABLE RENT (
id VARCHAR2(6) CONSTRAINT FK_id_RENT REFERENCES CUSTOMERS(id),
isbn VARCHAR2(20) CONSTRAINT FK_isbn_RENT REFERENCES BOOKS(isbn),
limit_date DATE
);

SET SERVEROUTPUT ON
    
    BEGIN
    	INSERT INTO BOOKS (isbn, title, author, genre)
    	VALUES ('9573156248654', 'La casa de las sombras', 'Adam Nevill', 'Terror');
    	INSERT INTO BOOKS (isbn, title, author, genre)
    	VALUES ('9701352467289', 'La guerra solar n01', 'John French', 'science fiction');
    	INSERT INTO BOOKS (isbn, title, author, genre)
   	VALUES ('6100496633334', 'La joven del pelo rojo', 'Buzzy Jackson', 'Romantic');
    	INSERT INTO BOOKS (isbn, title, author, genre)
   	VALUES ('7532159657201', 'Las crónicas de Mohs', 'Candela Escudero Torres', 'science fiction');
    	COMMIT;
 
	EXCEPTION
    	WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR EN LA TRANSACCION. SE DESHACEN LAS MODIFICACIONES.');
    	ROLLBACK;
 
	END;

	BEGIN
    	INSERT INTO CUSTOMERS (id, name, dni, phone_number)
    	VALUES ('258963', 'Juan Edo', '78965421A', '698741032');
    	INSERT INTO CUSTOMERS (id, name, dni, phone_number)
    	VALUES ('963214', 'María Deiguesca', '32186045B', '699703532');
    	INSERT INTO CUSTOMERS (id, name, dni, phone_number)
   	VALUES ('987032', 'Adrian Romero', '69852136C', '654000333');
    	INSERT INTO CUSTOMERS (id, name, dni, phone_number)
   	VALUES ('982103', 'Mar Andres', '96254785D', '699551230');
    	COMMIT;
 
	EXCEPTION
    	WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR EN LA TRANSACCION. SE DESHACEN LAS MODIFICACIONES.');
    	ROLLBACK;
 
	END;
    

   
