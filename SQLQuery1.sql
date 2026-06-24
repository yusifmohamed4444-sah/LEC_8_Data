create database business_scenario

go 

use  business_scenario

go 

create schema business_scenario_Lec8

go

create table business_scenario_Lec8.Doctor
(
Doctor_ID int IDENTITY primary key,
D_Name varchar (20),
D_specialty varchar (20),
D_years_of_experience int,
D_Email varchar(50)
)


create table business_scenario_Lec8.Company
(
c_name varchar (20) primary key,
c_address varchar (20),
c_phoneNumber varchar (20)
)


create table business_scenario_Lec8.Patient(
UR_Number int primary key,
Medicare_card_number int,
P_Name varchar (20),
P_Address varchar (20),
P_age int,
P_Email varchar(50),
Doctor_ID int FOREIGN KEY REFERENCES business_scenario_Lec8.Doctor(Doctor_ID)
)


create table business_scenario_Lec8.Drug(
Trade_Name varchar(20)primary key,
Strength varchar(20),
c_name varchar(20) FOREIGN KEY REFERENCES business_scenario_Lec8.Company(c_name) ON DELETE CASCADE
)



create table business_scenario_Lec8.Doctor_Phones(
Phone_Number varchar(20) ,
Doctor_ID int FOREIGN KEY REFERENCES business_scenario_Lec8.Doctor(Doctor_ID),

primary key(Phone_Number,Doctor_ID)
)



create table business_scenario_Lec8.Patient_Phones(
Phone_Number varchar(20) ,
UR_Number int FOREIGN KEY REFERENCES business_scenario_Lec8.Patient(UR_Number),

primary key(Phone_Number,UR_Number)
)


create table business_scenario_Lec8.Prescribes(
Date DATE,
Quantity varchar(20),
UR_Number int FOREIGN KEY REFERENCES business_scenario_Lec8.Patient(UR_Number),
Doctor_ID int FOREIGN KEY REFERENCES business_scenario_Lec8.Doctor(Doctor_ID),
Trade_Name varchar(20) FOREIGN KEY REFERENCES business_scenario_Lec8.Drug(Trade_Name),

primary key(Doctor_ID,UR_Number,Trade_Name)
)


--1.SELECT: Retrieve all columns from the Doctor table.

select * 
from business_scenario_Lec8.Doctor

--2.ORDER BY: List patients in the Patient table in ascending order of their ages.
select * 
from business_scenario_Lec8.Patient
order by P_age ASC


--3.OFFSET FETCH: Retrieve the first 10 patients from the Patient table, starting from the 5th record.
select * 
from business_scenario_Lec8.Patient
order by P_age ASC
OFFSET 4 ROWS
fetch NEXT 10 rows only


--4.SELECT TOP: Retrieve the top 5 doctors from the Doctor table.
select top 5 *
from business_scenario_Lec8.Doctor 

-- بس هنا علي حسب الخبره مثلا
select top 5 *
from business_scenario_Lec8.Doctor 
ORDER BY D_years_of_experience DESC


--5.SELECT DISTINCT: Get a list of unique address from the Patient table.
SELECT DISTINCT P_Address 
FROM business_scenario_Lec8.Patient


--6.WHERE: Retrieve patients from the Patient table who are aged 25.
SELECT  * 
FROM business_scenario_Lec8.Patient
where P_age = 24



--7.NULL: Retrieve patients from the Patient table whose email is not provided.
SELECT  * 
FROM business_scenario_Lec8.Patient
where P_Email is null



--8.AND: Retrieve doctors from the Doctor table who have experience greater than 5 years and specialize in 'Cardiology'.
select * 
from business_scenario_Lec8.Doctor
where D_years_of_experience > 5 and D_specialty = 'Cardiology'



--9.IN: Retrieve doctors from the Doctor table whose speciality is either 'Dermatology' or 'Oncology'.
select * 
from business_scenario_Lec8.Doctor
where D_specialty in ('Dermatology','Oncology')



--10.BETWEEN: Retrieve patients from the Patient table whose ages are between 18 and 30.
SELECT  * 
FROM business_scenario_Lec8.Patient
where P_age  between 18 and 30



--11.LIKE: Retrieve doctors from the Doctor table whose names start with 'Dr.'.
select * 
from business_scenario_Lec8.Doctor
where D_Name like 'Dr.%'



--12.Column & Table Aliases: Select the name and email of doctors, aliasing them as 'DoctorName' and 'DoctorEmail'.
select D.D_Name  DoctorName , D.D_Email  DoctorEmail
from business_scenario_Lec8.Doctor  D



--13.Joins: Retrieve all prescriptions with corresponding patient names.
select *
from business_scenario_Lec8.Prescribes pr
join business_scenario_Lec8.Patient pa 
on pr.UR_Number= pa.UR_Number




--14.GROUP BY: Retrieve the count of patients grouped by their cities.
select P_Address --,COUNT(*) AS PatientCount
FROM business_scenario_Lec8.Patient 
group by P_Address 





--15.HAVING: Retrieve cities with more than 3 patients.
select P_Address ,COUNT(*) AS PatientCount
FROM business_scenario_Lec8.Patient
group by P_Address 
HAVING COUNT(*) > 3;


--16.EXISTS: Retrieve patients who have at least one prescription.

SELECT *
FROM business_scenario_Lec8.Patient p
WHERE EXISTS
(
    SELECT 1
    FROM business_scenario_Lec8.Prescribes pr
    WHERE pr.UR_Number  = p.UR_Number
)



--17.UNION: Retrieve a combined list of doctors and patients.
SELECT Doctor_ID, D_Name, 'Doctor' as D_O_P
FROM business_scenario_Lec8.Doctor

UNION ALL

SELECT UR_Number, P_Name, 'Patient'
FROM business_scenario_Lec8.Patient;


--INSERT INTO business_scenario_Lec8.Doctor
--values(16, 'Dr.Esraa Medhat', 'Diochemistry',12,'esraam@gmail.com')





--18.INSERT: Insert a new doctor into the Doctor table.

INSERT INTO business_scenario_Lec8.Doctor
(D_Name, D_specialty, D_years_of_experience, D_Email)
VALUES
('Dr.Esraa Medhat', 'Diochemistry',12,'esraam@gmail.com');





--19.INSERT Multiple Rows: Insert multiple patients into the Patient table.
INSERT INTO business_scenario_Lec8.Patient
(UR_Number, Medicare_card_number, P_Name, P_Address, P_age, P_Email, Doctor_ID)
VALUES
(1, 12345, 'Ali', 'Fayoum', 25, 'ali@gmail.com', 1),
(2, 54321, 'Sara', 'Cairo', 30, 'sara@gmail.com', 2),
(3, 67890, 'Omar', 'Giza', 22, 'omar@gmail.com', 1);




--20.UPDATE: Update the phone number of a doctor.
INSERT INTO business_scenario_Lec8.Doctor_Phones
(Phone_Number, Doctor_ID)
VALUES
('01012345678', 1002);



UPDATE business_scenario_Lec8.Doctor_Phones
SET Phone_Number = '01095870216'
WHERE Doctor_ID = 1002
AND Phone_Number = '01012345678';


--21.UPDATE JOIN: Update the city of patients who have a prescription from a specific doctor.
INSERT INTO business_scenario_Lec8.Prescribes
(Date, Quantity, UR_Number, Doctor_ID, Trade_Name)
VALUES
('2026-06-24', '1', 1, 1001, 'Panadol'),
('2026-06-24', '3', 2, 1001, 'Aspirin'),
('2026-06-24', '1', 3, 1002, 'Brufen');

UPDATE p
set P_Address = 'fayoum'
from business_scenario_Lec8.Patient P
join business_scenario_Lec8.Prescribes pr
on p.UR_Number = pr.UR_Number
where pr.Doctor_ID = 1001;





--22.	DELETE: Delete a patient from the Patient table.
DELETE FROM business_scenario_Lec8.Prescribes
WHERE UR_Number = 3;

DELETE FROM business_scenario_Lec8.Patient
WHERE UR_Number = 3;



--23.Transaction: Insert a new doctor and a patient, ensuring both operations succeed or fail together.
BEGIN TRANSACTION;

INSERT INTO business_scenario_Lec8.Doctor
(D_Name, D_specialty, D_years_of_experience, D_Email)
VALUES
('Ahmed Ali', 'Cardiology', 10, 'ahmed@gmail.com');

INSERT INTO business_scenario_Lec8.Patient
(UR_Number, Medicare_card_number, P_Name, P_Address, P_age, P_Email, Doctor_ID)
VALUES
(10, 55555, 'Sara Mohamed', 'Fayoum', 25, 'sara@gmail.com', 1);

COMMIT;
