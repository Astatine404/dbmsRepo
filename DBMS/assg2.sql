CREATE TABLE AIRPORT(AIRPORT_CODE CHAR(3) PRIMARY KEY, CITY VARCHAR(20), STATE VARCHAR(20), AIRPORT_NAME VARCHAR(50));
CREATE TABLE FLIGHT_LEG(LEG_NO INT, FNUMBER INT, PRIMARY KEY(LEG_NO, FNUMBER));
CREATE TABLE DEPARTURE_AIRPORT(AIRPORT_CODE CHAR(3), LEG_NO INT, FNUMBER INT, SCHEDULED_DEP_TIME DATE, FOREIGN KEY(AIRPORT_CODE) REFERENCES AIRPORT(AIRPORT_CODE), FOREIGN KEY(LEG_NO, FNUMBER) REFERENCES FLIGHT_LEG(LEG_NO, FNUMBER), FOREIGN KEY(FNUMBER) REFERENCES FLIGHT(FNUMBER));
CREATE TABLE ARRIVAL_AIRPORT(AIRPORT_CODE CHAR(3) REFERENCES AIRPORT(AIRPORT_CODE), LEG_NO INT, FNUMBER INT REFERENCES FLIGHT(FNUMBER), SCHEDULED_ARR_TIME DATE, FOREIGN KEY(LEG_NO, FNUMBER) REFERENCES FLIGHT_LEG(LEG_NO, FNUMBER));
CREATE TABLE AIRPLANE_TYPE(TYPE_NAME VARCHAR(20), MAX_SEATS INT, COMPANY VARCHAR(50), PRIMARY KEY(TYPE_NAME));
CREATE TABLE AIRPLANE(AIRPLANE_ID INT, TYPE_NAME VARCHAR(20) REFERENCES AIRPLANE_TYPE(TYPE_NAME), TOTAL_NO_OF_SEATS INT, PRIMARY KEY(AIRPLANE_ID));
CREATE TABLE FLIGHT(FNUMBER INT, AIRLINE VARCHAR(20), WEEKDAYS INT, PRIMARY KEY(FNUMBER));
CREATE TABLE FARE(FNUMBER INT REFERENCES FLIGHT(FNUMBER), CODE INT, AMOUNT INT, RESTRICTIONS VARCHAR(50), PRIMARY KEY(CODE, FNUMBER));
CREATE TABLE LEG_INSTANCE(LEG_NO INT, FNUMBER INT REFERENCES FLIGHT(FNUMBER), NO_OF_AVAIL_SEATS INT, LDATE DATE, FOREIGN KEY(LEG_NO, FNUMBER) REFERENCES FLIGHT_LEG(LEG_NO, FNUMBER), PRIMARY KEY(LEG_NO, FNUMBER, LDATE));
CREATE TABLE ASSIGNED(AIRPLANE_ID INT REFERENCES AIRPLANE(AIRPLANE_ID), LEG_NO INT, FNUMBER INT REFERENCES FLIGHT(FNUMBER), LDATE DATE, FOREIGN KEY(LEG_NO, FNUMBER, LDATE) REFERENCES LEG_INSTANCE(LEG_NO, FNUMBER, LDATE));
CREATE TABLE DEPARTS(AIRPORT_CODE CHAR(3) REFERENCES AIRPORT(AIRPORT_CODE), LEG_NO INT, FNUMBER INT REFERENCES FLIGHT(FNUMBER), LDATE DATE, FOREIGN KEY(LEG_NO, FNUMBER, LDATE) REFERENCES LEG_INSTANCE(LEG_NO, FNUMBER, LDATE));
CREATE TABLE ARRIVES(AIRPORT_CODE CHAR(3) REFERENCES AIRPORT(AIRPORT_CODE), LEG_NO INT, FNUMBER INT, LDATE DATE, FOREIGN KEY(LEG_NO, FNUMBER, LDATE) REFERENCES LEG_INSTANCE(LEG_NO, FNUMBER, LDATE));
CREATE TABLE SEAT(LEG_NO INT, FNUMBER INT, LDATE DATE, SEAT_NO INT, CUSTOMER_NAME VARCHAR(50), CPHONE NUMBER(5), FOREIGN KEY(LEG_NO, FNUMBER, LDATE) REFERENCES LEG_INSTANCE(LEG_NO, FNUMBER, LDATE), PRIMARY KEY(LEG_NO, FNUMBER, LDATE, SEAT_NO));
CREATE TABLE CAN_LAND(AIRPORT_CODE CHAR(3) REFERENCES AIRPORT(AIRPORT_CODE), TYPE_NAME VARCHAR(20) REFERENCES AIRPLANE_TYPE(TYPE_NAME)); 

SELECT CUSTOMER_NAME, N FROM (SELECT CUSTOMER_NAME, COUNT(CUSTOMER_NAME) AS N FROM SEAT GROUP BY CUSTOMER_NAME)
WHERE N=(SELECT MAX(N) FROM (SELECT CUSTOMER_NAME, COUNT(CUSTOMER_NAME) AS N FROM SEAT GROUP BY CUSTOMER_NAME));

SELECT DISTINCT DEPARTS.FNUMBER FROM DEPARTS, ARRIVES, AIRPORT WHERE DEPARTS.FNUMBER=ARRIVES.FNUMBER AND DEPARTS.leg_no=ARRIVES.LEG_NO AND DEPARTS.airport_code='NGP' AND ARRIVES.AIRPORT_CODE='DEL';

SELECT FARE.FNUMBER, AMOUNT FROM FARE, ARRIVES, DEPARTS WHERE DEPARTS.airport_code='NGP' AND ARRIVES.airport_code='DEL' AND FARE.FNUMBER=ARRIVES.FNUMBER AND FARE.FNUMBER=DEPARTS.FNUMBER AND AMOUNT=(SELECT MIN(AMOUNT) FROM FARE, ARRIVES, DEPARTS WHERE FARE.FNUMBER=ARRIVES.FNUMBER AND FARE.FNUMBER=DEPARTS.FNUMBER);

SELECT FLIGHT.FNUMBER FROM FLIGHT, ARRIVES, DEPARTS WHERE FLIGHT.FNUMBER=ARRIVES.FNUMBER AND FLIGHT.FNUMBER=DEPARTS.FNUMBER AND DEPARTS.airport_code='NGP' AND ARRIVES.airport_code='DEL' AND FLIGHT.weekdays=7;

SELECT FNUMBER FROM DEPARTS, AIRPORT WHERE AIRPORT.CITY='DEL' AND AIRPORT.airport_code=DEPARTS.AIRPORT_CODE;

SELECT FNUMBER FROM ASSIGNED, AIRPLANE_TYPE, AIRPLANE WHERE ASSIGNED.airplane_id = AIRPLANE.airplane_id AND AIRPLANE.type_name=AIRPLANE_TYPE.type_name AND AIRPLANE.total_no_of_seats>200;

SELECT COUNT(DISTINCT SEAT.CUSTOMER_NAME) FROM DEPARTS, AIRPORT, AIRPLANE, airplane_type, ASSIGNED, SEAT WHERE SEAT.FNUMBER=ASSIGNED.FNUMBER AND AIRPORT.CITY='DEL' AND AIRPORT.airport_code=DEPARTS.AIRPORT_CODE AND ASSIGNED.LDATE='01-JAN-14' AND DEPARTS.FNUMBER=ASSIGNED.FNUMBER AND ASSIGNED.airplane_id=AIRPLANE.airplane_id AND AIRPLANE.type_name=AIRPLANE_TYPE.type_name;

SELECT AIRPLANE_TYPE.TYPE_NAME FROM DEPARTS, AIRPORT, AIRPLANE, airplane_type, ASSIGNED, DEPARTURE_AIRPORT WHERE DEPARTURE_AIRPORT.FNUMBER = ASSIGNED.FNUMBER AND AIRPORT.CITY='DEL' AND AIRPORT.airport_code=DEPARTS.AIRPORT_CODE AND DEPARTS.FNUMBER=ASSIGNED.FNUMBER AND ASSIGNED.airplane_id=AIRPLANE.airplane_id AND AIRPLANE.type_name=AIRPLANE_TYPE.type_name;

SELECT TYPE_NAME, COMPANY FROM AIRPLANE_TYPE WHERE TYPE_NAME='AIRBUS123';

SELECT SUM(ARRIVAL_AIRPORT.SCHEDULED_ARR_TIME-DEPARTURE_AIRPORT.SCHEDULED_DEP_TIME) FROM ARRIVAL_AIRPORT, departure_airport, airplane, ASSIGNED WHERE AIRPLANE.TYPE_NAME=AIRPLANE.TYPE_NAME AND ASSIGNED.AIRPLANE_ID=AIRPLANE.AIRPLANE_ID AND ARRIVAL_AIRPORT;
