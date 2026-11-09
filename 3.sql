SELECT * FROM follow_up WHERE follow_up_id = 1;
UPDATE follow_up SET status = 'Completed' WHERE follow_up_id = 1;
SELECT * FROM follow_up WHERE follow_up_id = 1;

-- Controlled DELETE: insert a disposable patient, verify, delete, verify
INSERT INTO patient (patient_id, first_name, last_name, postcode)
VALUES ('TEST01', 'Test', 'Patient', 'ZZ1 1ZZ');
SELECT * FROM patient WHERE patient_id = 'TEST01';
DELETE FROM patient WHERE patient_id = 'TEST01';
SELECT * FROM patient WHERE patient_id = 'TEST01';

-- Rejected inserts (each should fail)
INSERT INTO appointment (patient_id, clinician_id, clinic_id, appointment_date, appointment_time, status)
VALUES ('XX999', 1, 1, '2026-12-01', '09:00:00', 'Scheduled');      -- foreign key, error 1452
INSERT INTO appointment (patient_id, clinician_id, clinic_id, appointment_date, appointment_time, status)
VALUES ('OP001', 1, 1, '2026-12-01', '09:00:00', 'Unknown');        -- CHECK constraint
INSERT INTO patient (patient_id, first_name, last_name, postcode, email)
VALUES ('TEST02', 'Test', 'Two', 'ZZ1 1ZZ', 'amina.yusuf@example.test')