/*Created by Daniel Forsling */

/*  CREATING THE TABLES  */

CREATE TABLE instructor (
 instructor_id SERIAL NOT NULL,
 first_name VARCHAR(100),
 last_name VARCHAR(100),
 person_number   VARCHAR(12) UNIQUE,
 holds_ensemble BOOLEAN
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instructor_address (
 instructor_id INT NOT NULL,
 street VARCHAR(500),
 city VARCHAR(100),
 zip VARCHAR(15)
);

ALTER TABLE instructor_address ADD CONSTRAINT PK_instructor_address PRIMARY KEY (instructor_id);


CREATE TABLE instructor_contact_details (
 instructor_id INT NOT NULL,
 phone_number VARCHAR(20) NOT NULL,
 email VARCHAR(254) NOT NULL
);

ALTER TABLE instructor_contact_details ADD CONSTRAINT PK_instructor_contact_details PRIMARY KEY (instructor_id);


CREATE TABLE instructor_payment (
 instructor_id INT NOT NULL,
 amount INT
);

ALTER TABLE instructor_payment ADD CONSTRAINT PK_instructor_payment PRIMARY KEY (instructor_id);


CREATE TABLE instrument_type (
 instrument_type_id SERIAL NOT NULL,
 type VARCHAR(50) NOT NULL
);

ALTER TABLE instrument_type ADD CONSTRAINT PK_instrument_type PRIMARY KEY (instrument_type_id);


CREATE TABLE s_m_school (
 school_id SERIAL NOT NULL,
 phone_number VARCHAR(20),
 email VARCHAR(254)
);

ALTER TABLE s_m_school ADD CONSTRAINT PK_s_m_school PRIMARY KEY (school_id);


CREATE TABLE schedule (
 date DATE,
 timeslot TIME(0),
 school_id INT NOT NULL
);

ALTER TABLE schedule ADD CONSTRAINT PK_schedule PRIMARY KEY (date, timeslot);


CREATE TABLE student (
 student_id  SERIAL NOT NULL UNIQUE,
 first_name VARCHAR(100),
 last_name VARCHAR(100),
 person_number VARCHAR(12) NOT NULL UNIQUE,
 school_id INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_address (
 student_id INT NOT NULL,
 street VARCHAR(500),
 city VARCHAR(100),
 zip VARCHAR(15)
);

ALTER TABLE student_address ADD CONSTRAINT PK_student_address PRIMARY KEY (student_id);


CREATE TABLE student_contact_details (
 student_id INT NOT NULL,
 phone_number VARCHAR(20),
 email_adress VARCHAR(254),
 parent_phone_number VARCHAR(20) NOT NULL,
 parent_email CHAR(254) NOT NULL
);

ALTER TABLE student_contact_details ADD CONSTRAINT PK_student_contact_details PRIMARY KEY (student_id);


CREATE TABLE application (
 application_id SERIAL NOT NULL,
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 street VARCHAR(500),
 city VARCHAR(100),
 zip VARCHAR(15),
 skill_level VARCHAR(10),
 siblings INT,
 school_id INT NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (application_id);

CREATE TABLE audition (
 student_id SERIAL NOT NULL,
 hasPassed BOOLEAN,
 date DATE NOT NULL,
 timeslot TIME(0)
);

ALTER TABLE audition ADD CONSTRAINT PK_audition PRIMARY KEY (student_id);


CREATE TABLE available_instruments (
 school_instrument_id SERIAL NOT NULL UNIQUE,
 brand VARCHAR(50),
 instrument_type_id INT NOT NULL,
 price_per_month INT,
 available BOOLEAN
);

ALTER TABLE available_instruments ADD CONSTRAINT PK_available_instruments PRIMARY KEY (school_instrument_id);


CREATE TABLE instructor_instruments (
 instructor_id SERIAL NOT NULL,
 instrument_type_id INT NOT NULL
);

ALTER TABLE instructor_instruments ADD CONSTRAINT PK_instructor_instruments PRIMARY KEY (instructor_id,instrument_type_id);


CREATE TABLE music_lesson (
 lesson_id SERIAL NOT NULL,
 weekend_price INT,
 instructor_id INT NOT NULL,
 type VARCHAR(10) NOT NULL,
 date DATE NOT NULL,
 timeslot TIME
);

ALTER TABLE music_lesson ADD CONSTRAINT PK_music_lesson PRIMARY KEY (lesson_id);


CREATE TABLE rental (
 rental_id SERIAL NOT NULL,
 student_id INT NOT NULL,
 lease_start DATE,
 lease_end DATE,
 school_instrument_id INT NOT NULL
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (rental_id,student_id);


CREATE TABLE sibling_discount (
 student_id INT NOT NULL,   
 no_of_sibilings INT,
 discount INT,
 discount_id INT NOT NULL
);

ALTER TABLE sibling_discount ADD CONSTRAINT PK_sibling_discount PRIMARY KEY (student_id);


CREATE TABLE student_lesson (
 student_id INT NOT NULL,
 lesson_id INT NOT NULL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (student_id,lesson_id);


CREATE TABLE student_payment (
 student_id  NOT NULL,
 amount INT,
 discount_id INT NOT NULL
);

ALTER TABLE student_payment ADD CONSTRAINT PK_student_payment PRIMARY KEY (student_id);


CREATE TABLE student_payment_lessons (
 student_id NOT NULL,
 lesson_id NOT NULL,
 no_of_lessons INT
);

ALTER TABLE student_payment_lessons ADD CONSTRAINT PK_student_payment_lessons PRIMARY KEY (student_id,lesson_id);


CREATE TABLE available_room (
 lesson_id INT NOT NULL,
 available_slots INT
);

ALTER TABLE available_room ADD CONSTRAINT PK_available_room PRIMARY KEY (lesson_id);


CREATE TABLE ensemble (
 lesson_id INT NOT NULL,
 genre VARCHAR(50),
 min_attendance INT,
 max_attendance INT,
 price INT
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 skill_level VARCHAR(12),
 min_attendance INT,
 max_attendance INT,
 price INT,
 instrument_type_id INT NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 skill_level VARCHAR(12),
 price INT,
 instrument_type_id INT NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE instructor_payment_lessons (
 instructor_id INT NOT NULL,
 no_of_lessons INT,
 lesson_id INT NOT NULL
);

ALTER TABLE instructor_payment_lessons ADD CONSTRAINT PK_instructor_payment_lessons PRIMARY KEY (instructor_id);

/* ADDING FK-CONSTRAINTS AND RELATIONS  */

ALTER TABLE instructor_address ADD CONSTRAINT FK_instructor_address_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) ON DELETE CASCADE;


ALTER TABLE instructor_contact_details ADD CONSTRAINT FK_instructor_contact_details_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) ON DELETE CASCADE;


ALTER TABLE instructor_payment ADD CONSTRAINT FK_instructor_payment_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) ON DELETE CASCADE;


ALTER TABLE schedule ADD CONSTRAINT FK_schedule_0 FOREIGN KEY (school_id) REFERENCES s_m_school (school_id) ON DELETE CASCADE;


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (school_id) REFERENCES s_m_school (school_id ) ON DELETE CASCADE;


ALTER TABLE student_address ADD CONSTRAINT FK_student_address_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;


ALTER TABLE student_contact_details ADD CONSTRAINT FK_student_contact_details_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (school_id ) REFERENCES s_m_school (school_id ) ON DELETE CASCADE;
ALTER TABLE application ADD CONSTRAINT FK_application_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (instrument_type_id) ON DELETE CASCADE;

ALTER TABLE audition ADD CONSTRAINT FK_audition_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;
ALTER TABLE audition ADD CONSTRAINT FK_audition_1 FOREIGN KEY (date, timeslot) REFERENCES schedule (date, timeslot) ON DELETE CASCADE;

ALTER TABLE available_instruments ADD CONSTRAINT FK_available_instruments_0 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (instrument_type_id) ON DELETE CASCADE;


ALTER TABLE instructor_instruments ADD CONSTRAINT FK_instructor_instruments_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) ON DELETE CASCADE;
ALTER TABLE instructor_instruments ADD CONSTRAINT FK_instructor_instruments_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (instrument_type_id) ON DELETE CASCADE;


ALTER TABLE music_lesson ADD CONSTRAINT FK_music_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) ON DELETE CASCADE;
ALTER TABLE music_lesson ADD CONSTRAINT FK_music_lesson_1 FOREIGN KEY (date, timeslot) REFERENCES schedule (date, timeslot) ON DELETE CASCADE;
ALTER TABLE music_lesson ADD CONSTRAINT CHK_type CHECK (type IN ('group', 'individual', 'ensemble'));

ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;
ALTER TABLE rental ADD CONSTRAINT FK_rental_1 FOREIGN KEY (school_instrument_id) REFERENCES available_instruments (school_instrument_id) ON DELETE CASCADE;


ALTER TABLE sibling_discount ADD CONSTRAINT FK_sibling_discount_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (lesson_id) REFERENCES music_lesson (lesson_id) ON DELETE CASCADE;


ALTER TABLE student_payment ADD CONSTRAINT FK_student_payment_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;


ALTER TABLE student_payment_lessons ADD CONSTRAINT FK_student_payment_lessons_0 FOREIGN KEY (student_id,lesson_id) REFERENCES student_lesson (student_id,lesson_id) ON DELETE CASCADE;
ALTER TABLE student_payment_lessons ADD CONSTRAINT FK_student_payment_lessons_1 FOREIGN KEY (student_id) REFERENCES student_payment (student_id ) ON DELETE CASCADE;


ALTER TABLE available_room ADD CONSTRAINT FK_available_room_0 FOREIGN KEY (lesson_id) REFERENCES music_lesson (lesson_id) ON DELETE CASCADE;


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (lesson_id) REFERENCES music_lesson (lesson_id) ON DELETE CASCADE;


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES music_lesson (lesson_id) ON DELETE CASCADE;
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (instrument_type_id) ON DELETE CASCADE;
ALTER TABLE group_lesson ADD CONSTRAINT CHK_Skill_level_group CHECK (skill_level IN ('beginner', 'intermediate', 'advanced'));

ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES music_lesson (lesson_id) ON DELETE CASCADE;
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (instrument_type_id) REFERENCES instrument_type (instrument_type_id) ON DELETE CASCADE;
ALTER TABLE individual_lesson ADD CONSTRAINT CHK_Skill_level_individual CHECK (skill_level IN ('beginner', 'intermediate', 'advanced'));


ALTER TABLE instructor_payment_lessons ADD CONSTRAINT FK_instructor_payment_lessons_0 FOREIGN KEY (instructor_id) REFERENCES instructor_payment (instructor_id) ON DELETE CASCADE;
ALTER TABLE instructor_payment_lessons ADD CONSTRAINT FK_instructor_payment_lessons_1 FOREIGN KEY (lesson_id) REFERENCES music_lesson (lesson_id) ON DELETE CASCADE;


