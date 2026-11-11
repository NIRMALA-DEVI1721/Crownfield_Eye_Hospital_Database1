CREATE ROLE 'role_admin', 'role_doctor', 'role_receptionist', 'role_patient';
GRANT ALL PRIVILEGES ON crownfield_eye_hospital.* TO 'role_admin';

GRANT SELECT (patient_id, first_name, last_name, date_of_birth) ON crownfield_eye_hospital.patient TO 'role_doctor';
GRANT SELECT ON crownfield_eye_hospital.appointment TO 'role_doctor';
GRANT UPDATE (status, notes) ON crownfield_eye_hospital.appointment TO 'role_doctor';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.diagnosis TO 'role_doctor';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.prescription TO 'role_doctor';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.prescription_item TO 'role_doctor';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.follow_up TO 'role_doctor';

GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.patient TO 'role_receptionist';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.appointment TO 'role_receptionist';
GRANT SELECT ON crownfield_eye_hospital.follow_up TO 'role_receptionist';
GRANT UPDATE (status) ON crownfield_eye_hospital.follow_up TO 'role_receptionist';

-- Patient access through a filtered view
CREATE TABLE patient_account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id VARCHAR(10) NOT NULL UNIQUE,
    db_username VARCHAR(32) NOT NULL UNIQUE,
    salt VARBINARY(16) NOT NULL,
    password_hash CHAR(64) NOT NULL,
    CONSTRAINT fk_account_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);
CREATE VIEW v_my_appointments AS
SELECT a.appointment_id, a.appointment_date, a.appointment_time,
       CONCAT(c.first_name, ' ', c.last_name) AS clinician_name, cl.clinic_name, a.status
FROM appointment a
JOIN patient_account pa ON pa.patient_id = a.patient_id
JOIN clinician c ON c.clinician_id = a.clinician_id
JOIN clinic cl ON cl.clinic_id = a.clinic_id
WHERE pa.db_username = SUBSTRING_INDEX(USER(), '@', 1);
GRANT SELECT ON crownfield_eye_hospital.v_my_appointments TO 'role_patient';

-- Salted password hash
SET @salt = RANDOM_BYTES(16);
INSERT INTO patient_account (patient_id, db_username, salt, password_hash)
VALUES ('OP001', 'pat_op001', @salt, SHA2(CONCAT(HEX(@salt), 'Patient#2026!'), 256));

-- AES-256 encryption of diagnosis notes, inside a transaction
ALTER TABLE diagnosis ADD COLUMN notes_enc VARBINARY(512), ADD COLUMN notes_iv VARBINARY(16);
SET @@session.block_encryption_mode = 'aes-256-cbc';
SET @key = UNHEX(SHA2('replace-with-a-secret-kept-outside-the-database', 256));
START TRANSACTION;
UPDATE diagnosis SET notes_iv = RANDOM_BYTES(16) WHERE diagnosis_id > 0;
UPDATE diagnosis SET notes_enc = AES_ENCRYPT(diagnosis_notes, @key, notes_iv)
WHERE diagnosis_id > 0 AND diagnosis_notes IS NOT NULL;
UPDATE diagnosis SET diagnosis_notes = NULL WHERE diagnosis_id > 0;
COMMIT;

-- SQL injection: vulnerable and secure versions
SET @pid = "OP001' OR '1'='1";
SET @sql = CONCAT("SELECT patient_id, first_name, last_name FROM patient WHERE patient_id = '", @pid, "'");
PREPARE vulnerable FROM @sql;  EXECUTE vulnerable;  DEALLOCATE PREPARE vulnerable;
PREPARE secure FROM 'SELECT patient_id, first_name, last_name FROM patient WHERE patient_id = ?';
EXECUTE secure USING @pid;     DEALLOCATE PREPARE secure;
