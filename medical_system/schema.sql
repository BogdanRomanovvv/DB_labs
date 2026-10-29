BEGIN;

CREATE TABLE specialties(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE patients(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    birth_date DATE NOT NULL CHECK (birth_date <= CURRENT_DATE),
    phone VARCHAR(20) NOT NULL UNIQUE,
    policy_number VARCHAR(16) NOT NULL UNIQUE
);

CREATE TABLE doctors(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    specialty_id BIGINT NOT NULL REFERENCES specialties(id) ON DELETE RESTRICT,
    name TEXT NOT NULL,
    license_number VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE appointments(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    patient_id BIGINT NOT NULL REFERENCES patients(id) ON DELETE RESTRICT,
    doctor_id BIGINT NOT NULL REFERENCES doctors(id) ON DELETE RESTRICT,
    appointment_time TIMESTAMPTZ NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('planned', 'completed', 'cancelled')),
    fee NUMERIC(10, 2) NOT NULL CHECK (fee >= 0),
    notes TEXT,
    UNIQUE (doctor_id, appointment_time)
);

CREATE TABLE diagnoses(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE appointment_diagnoses(
    appointment_id BIGINT NOT NULL REFERENCES appointments(id) ON DELETE CASCADE,
    diagnosis_id BIGINT NOT NULL REFERENCES diagnoses(id) ON DELETE RESTRICT,
    PRIMARY KEY (appointment_id, diagnosis_id)
);

COMMIT;
