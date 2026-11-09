INSERT INTO specialty (specialty_name) VALUES
('Glaucoma'),('Retina'),('Cornea'),('Cataract'),('Paediatric Ophthalmology'),
('Neuro-Ophthalmology'),('Oculoplastics'),('General Ophthalmology'),('Uveitis'),('Medical Retina');

INSERT INTO clinician (first_name, last_name, specialty_id, email) VALUES
('Maya','Shah',1,'maya.shah@crownfield.test'),('Leo','Grant',2,'leo.grant@crownfield.test'),
('Priya','Nair',3,'priya.nair@crownfield.test'),('James','Collins',4,'james.collins@crownfield.test'),
('Sarah','Ahmed',5,'sarah.ahmed@crownfield.test'),('Peter','Wong',6,'peter.wong@crownfield.test'),
('Helen','Brooks',7,'helen.brooks@crownfield.test'),('David','Okafor',8,'david.okafor@crownfield.test'),
('Nina','Patel',9,'nina.patel@crownfield.test'),('Grace','Morgan',10,'grace.morgan@crownfield.test');

INSERT INTO clinic (clinic_name, address) VALUES
('City Road','12 City Road'),('Bedford','5 Bedford Street'),('Croydon','18 High Street'),
('North Wing','Crownfield Hospital North Wing'),('South Wing','Crownfield Hospital South Wing'),
('Retina Centre','22 Medical Avenue'),('Glaucoma Suite','14 Vision Lane'),('Cornea Unit','7 Eye Care Road'),
('Paediatric Clinic','10 Children Way'),('Urgent Eye Clinic','1 Emergency Road');

INSERT INTO patient (patient_id, first_name, last_name, postcode, date_of_birth, phone, email) VALUES
('OP001','Amina','Yusuf','NE1 4AB','1981-03-15','07000000001','amina.yusuf@example.test'),
('OP002','Daniel','Reed','N16 7QP','1975-09-21','07000000002','daniel.reed@example.test'),
('OP003','Sofia','Bennett','E8 2LD','1990-06-12','07000000003','sofia.bennett@example.test'),
('OP004','Michael','Okoro','SE6 3RT','1986-11-02','07000000004','michael.okoro@example.test'),
('OP005','Grace','Taylor','B1 2AA','1968-01-28','07000000005','grace.taylor@example.test'),
('OP006','Ahmed','Khan','M1 4QT','1959-05-13','07000000006','ahmed.khan@example.test'),
('OP007','Lucy','Brown','LS1 3AF','2001-08-19','07000000007','lucy.brown@example.test'),
('OP008','Samuel','Green','S2 4BB','1984-04-08','07000000008','samuel.green@example.test'),
('OP009','Chloe','Wilson','CV1 5RT','1994-12-11','07000000009','chloe.wilson@example.test'),
('OP010','David','Mensah','NG1 1AB','1979-07-30','07000000010','david.mensah@example.test');

INSERT INTO appointment (patient_id, clinician_id, clinic_id, appointment_date, appointment_time, notes, status) VALUES
('OP001',1,1,'2026-10-05','09:00:00','Review IOP','Completed'),
('OP002',2,1,'2026-10-05','09:30:00','OCT before review','Completed'),
('OP001',1,2,'2026-11-16','10:15:00','Visual field test','Scheduled'),
('OP003',1,1,'2026-10-06','11:00:00','Monitor','Completed'),
('OP004',3,3,'2026-10-07','14:00:00','Corneal topography','Completed'),
('OP005',4,4,'2026-10-08','09:00:00','Cataract assessment','Completed'),
('OP006',8,5,'2026-10-09','11:30:00','General eye review','Completed'),
('OP007',5,9,'2026-10-10','10:00:00','Paediatric review','Completed'),
('OP008',2,6,'2026-10-11','13:00:00','Retina review','Completed'),
('OP009',9,4,'2026-10-12','15:30:00','Inflammation review','Completed'),
('OP010',6,1,'2026-10-13','10:30:00','Neurological visual assessment','Scheduled');

INSERT INTO diagnosis (appointment_id, diagnosis_name, diagnosis_notes) VALUES
(1,'Ocular hypertension','Raised intraocular pressure'),(2,'Diabetic macular oedema','OCT changes noted'),
(4,'Glaucoma suspect','Observation required'),(5,'Keratoconus','Corneal thinning confirmed'),
(6,'Cataract','Reduced lens clarity'),(7,'Dry eye syndrome','Moderate symptoms'),
(8,'Amblyopia','Reduced visual acuity'),(9,'Retinal vein occlusion','Retinal swelling'),
(10,'Anterior uveitis','Inflammation present'),(11,'Optic neuritis','Further investigation required');

INSERT INTO medicine (medicine_name) VALUES
('Latanoprost'),('Timolol'),('Aflibercept'),('Sodium chloride drops'),('Prednisolone eye drops'),
('Artificial tears'),('Cyclopentolate'),('Dorzolamide'),('Moxifloxacin'),('Acetazolamide');

INSERT INTO prescription (appointment_id, prescription_date) VALUES
(1,'2026-10-05'),(2,'2026-10-05'),(4,'2026-10-06'),(5,'2026-10-07'),(6,'2026-10-08'),
(7,'2026-10-09'),(8,'2026-10-10'),(9,'2026-10-11'),(10,'2026-10-12'),(11,'2026-10-13');

INSERT INTO prescription_item (prescription_id, medicine_id, dose, route, frequency, duration_days) VALUES
(1,1,'1 drop','Ocular','Once daily',30),(1,2,'1 drop','Ocular','Twice daily',30),
(2,3,'2 mg','Intravitreal','Single dose',1),(3,8,'1 drop','Ocular','Twice daily',30),
(4,4,'1 drop','Ocular','Four times daily',14),(5,9,'1 drop','Ocular','Four times daily',7),
(6,6,'1 drop','Ocular','As required',30),(7,7,'1 drop','Ocular','Twice daily',7),
(8,3,'2 mg','Intravitreal','Single dose',1),(9,5,'1 drop','Ocular','Four times daily',14),
(10,10,'250 mg','Oral','Twice daily',5);

INSERT INTO follow_up (appointment_id, due_date, priority, status) VALUES
(1,'2026-11-16','High','Booked'),(2,'2026-11-02','Urgent','Booked'),(4,'2027-04-06','Routine','Pending'),
(5,'2026-12-02','Routine','Pending'),(6,'2026-12-03','Routine','Pending'),(7,'2026-11-20','Routine','Pending'),
(8,'2026-12-01','High','Pending'),(9,'2026-11-08','Urgent','Pending'),(10,'2026-10-26','High','Pending'),
(11,'2026-11-10','High','Pending');