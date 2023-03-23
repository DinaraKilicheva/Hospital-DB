CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS patients (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    date_of_birth DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doctors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    license_number VARCHAR(50) NOT NULL,
    years_of_experience INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS clinics (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS specialties (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS services (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS medical_procedures (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS appointments (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    clinic_id INT NOT NULL,
    date TIMESTAMP NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
    FOREIGN KEY (clinic_id) REFERENCES clinics(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doctor_notes (
    id SERIAL PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    note TEXT NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doctor_specialties (
    id SERIAL PRIMARY KEY,
    doctor_id INT NOT NULL,
    specialty_id INT NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
    FOREIGN KEY (specialty_id) REFERENCES specialties(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS clinic_services (
    id SERIAL PRIMARY KEY,
    clinic_id INT NOT NULL,
    service_id INT NOT NULL,
    FOREIGN KEY (clinic_id) REFERENCES clinics(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS patient_billing (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    paid BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS clinic_billing (
    id SERIAL PRIMARY KEY,
	clinic_id INT NOT NULL,
	appointment_id INT NOT NULL,
	amount DECIMAL(10, 2) NOT NULL,
	paid BOOLEAN NOT NULL DEFAULT FALSE,
	FOREIGN KEY (clinic_id) REFERENCES clinics(id) ON DELETE CASCADE,
	FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS appointment_services (
	id SERIAL PRIMARY KEY,
	appointment_id INT NOT NULL,
	service_id INT NOT NULL,
	FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE,
	FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doctor_availability (
	id SERIAL PRIMARY KEY,
	doctor_id INT NOT NULL,
	clinic_id INT NOT NULL,
	day_of_week VARCHAR(10) NOT NULL,
	start_time TIMESTAMP NOT NULL,
	end_time TIME NOT NULL,
	FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
	FOREIGN KEY (clinic_id) REFERENCES clinics(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doctor_ratings (
	id SERIAL PRIMARY KEY,
	doctor_id INT NOT NULL,
	patient_id INT NOT NULL,
	rating INT NOT NULL,
	FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
	FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS clinic_ratings (
	id SERIAL PRIMARY KEY,
	clinic_id INT NOT NULL,
	patient_id INT NOT NULL,
	rating INT NOT NULL,
	FOREIGN KEY (clinic_id) REFERENCES clinics(id) ON DELETE CASCADE,
	FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doctor_education (
    id SERIAL PRIMARY KEY,
    doctor_id INT NOT NULL,
    degree VARCHAR(10) NOT NULL,
    institution VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS doctor_certifications (
    id SERIAL PRIMARY KEY,
    doctor_id INT NOT NULL,
    certification VARCHAR(100) NOT NULL,
    institution VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS prescription_drugs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    instructions TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS prescriptions (
    id SERIAL PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    prescription_drug_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE,
    FOREIGN KEY (prescription_drug_id) REFERENCES prescription_drugs(id) ON DELETE CASCADE
);



CREATE TABLE IF NOT EXISTS payments (
    id SERIAL PRIMARY KEY,
    clinic_id INT NOT NULL,
    appointment_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    paid BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (clinic_id) REFERENCES clinics(id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS medical_procedure_history (
    id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    medical_procedure_id INT NOT NULL,
    date_of_procedure DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (medical_procedure_id) REFERENCES medical_procedures(id) ON DELETE CASCADE
);

