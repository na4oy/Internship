CREATE TABLE ROLE
(
	ROLE_NAME CHAR(32),
	DESCRIPTION VARCHAR2(256),
	CONSTRAINT ROLE_PK PRIMARY KEY (ROLE_NAME)
);

CREATE TABLE EMPLOYEE
(
	UCN CHAR(10),
	NAME VARCHAR2(256) NOT NULL, 
	USER_NAME VARCHAR2(32),
	PASSWORD VARCHAR2(32),
	PREVIOUS_WORK_EXPERIENCE NUMBER(4) DEFAULT 0 NOT NULL,
	CONTRACT_TYPE CHAR(10) NOT NULL,
	WORK_HOURS NUMBER(2) DEFAULT 0 NOT NULL,
	TEAM_LEAD_UCN CHAR(10),
	ROLE_NAME CHAR(32),
	CONSTRAINT EMPLOYEE_PK PRIMARY KEY (UCN),
	CONSTRAINT FK_EMPLOYEE
    FOREIGN KEY (TEAM_LEAD_UCN)
    REFERENCES EMPLOYEE(UCN),
	CONSTRAINT FK_EMPLOYEE_ROLE
    FOREIGN KEY (ROLE_NAME)
    REFERENCES ROLE(ROLE_NAME)
    ON DELETE CASCADE
);

CREATE TABLE USER_RIGHT
(
	TYPE_OF_RIGHT CHAR(32),
	DESCRIPTION VARCHAR2(256),
	CONSTRAINT USER_RIGHT_PK PRIMARY KEY (TYPE_OF_RIGHT)
);

CREATE TABLE ROLE_RIGHT
(
	ROLE_NAME CHAR(32),
	TYPE_OF_RIGHT CHAR(32),
	CONSTRAINT ROLE_RIGHT_PK PRIMARY KEY (ROLE_NAME, TYPE_OF_RIGHT),
	CONSTRAINT FK_USER_ROLE_RIGHT
	FOREIGN KEY (TYPE_OF_RIGHT)
    REFERENCES USER_RIGHT(TYPE_OF_RIGHT),
	CONSTRAINT FK_ROLE_RIGHT
	FOREIGN KEY (ROLE_NAME)
    REFERENCES ROLE(ROLE_NAME)
);

CREATE TABLE JOB
(
	JOB_TITLE CHAR(32),
	JOB_DEGREE CHAR(20),
	PRECEDENSE_NUMBER NUMBER(10) NOT NULL,
	MIN_SALARY NUMBER(8,2) NOT NULL,
	MAX_SALARY NUMBER(8,2) NOT NULL,
	CONSTRAINT JOB_PK PRIMARY KEY (JOB_TITLE, JOB_DEGREE)
);

CREATE TABLE POSITION
(
	JOB_TITLE CHAR(32),
	JOB_DEGREE CHAR(20),
	JOB_LEVEL NUMBER(2),
	BASE_SALARY NUMBER(8,2) NOT NULL,
	CONSTRAINT POSITION_PK PRIMARY KEY (JOB_TITLE, JOB_DEGREE, JOB_LEVEL),
    CONSTRAINT FK_POSITION
    FOREIGN KEY (JOB_TITLE, JOB_DEGREE)
    REFERENCES JOB(JOB_TITLE, JOB_DEGREE)
);

CREATE TABLE POSITION_PERIOD
(
	UCN CHAR(10),
	START_DATE DATE, 
	END_DATE DATE,
	BASE_SALARY NUMBER(8,2) NOT NULL,
	JOB_TITLE CHAR(32) NOT NULL,
	JOB_DEGREE CHAR(20) NOT NULL,
	JOB_LEVEL NUMBER(2) NOT NULL,
	CONSTRAINT POSITION_HISTORY_PK PRIMARY KEY (UCN, START_DATE),
	CONSTRAINT FK_POSITION_HISTORY_UCN
    FOREIGN KEY (UCN)
    REFERENCES EMPLOYEE(UCN),
	CONSTRAINT FK_POSITION_HISTORY
    FOREIGN KEY (JOB_TITLE, JOB_DEGREE, JOB_LEVEL)
    REFERENCES POSITION(JOB_TITLE, JOB_DEGREE, JOB_LEVEL)
);

CREATE TABLE TAX
(
	TYPE_OF_TAX CHAR(32),
	START_DATE DATE, 
	END_DATE DATE,
	PERCENTAGE_EMPLOYEE NUMBER(13, 10) DEFAULT 0 NOT NULL,
	PERCENTAGE_COMPANY NUMBER(13, 10) DEFAULT 0 NOT NULL,
	CONSTRAINT TAX_PK PRIMARY KEY (TYPE_OF_TAX, START_DATE)
);

CREATE TABLE RESTRICTION
(
	TYPE_OF_RESTRICTION CHAR(50),
	START_DATE DATE, 
	END_DATE DATE,
	AMOUNT NUMBER(8,2) NOT NULL,
	CONSTRAINT RESTRICTION_PK PRIMARY KEY (TYPE_OF_RESTRICTION, START_DATE)
);

CREATE TABLE INDEXATION
(
	DATE_OF_INDEXATION DATE, 
	JOB_TITLE CHAR(32),
	JOB_DEGREE CHAR(20) NOT NULL,
	JOB_LEVEL NUMBER(2) NOT NULL,
	PERCENTAGE NUMBER(13, 10) NOT NULL,
	CONSTRAINT INDEXATION_PK PRIMARY KEY (DATE_OF_INDEXATION, JOB_TITLE, JOB_DEGREE, JOB_LEVEL),
	CONSTRAINT FK_INDEXATION
    FOREIGN KEY (JOB_TITLE, JOB_DEGREE, JOB_LEVEL)
    REFERENCES POSITION(JOB_TITLE, JOB_DEGREE, JOB_LEVEL)
);

CREATE TABLE PAYCHECK
(
	UCN CHAR(10),
	DATE_OF_PAYCHECK DATE,
	HOURS_WORKED NUMBER(3) DEFAULT 0 NOT NULL,
	BASE_SALARY NUMBER(8,2) NOT NULL,
	GROSS_SALARY NUMBER(8,2) NOT NULL,
	TAX_RATE NUMBER(8,2) NOT NULL,
	NET_SALARY NUMBER(8,2) NOT NULL,
	CONSTRAINT PAYCHECK_PK PRIMARY KEY (UCN, DATE_OF_PAYCHECK),
	CONSTRAINT FK_PAYCHECK
    FOREIGN KEY (UCN)
    REFERENCES EMPLOYEE(UCN)
);
