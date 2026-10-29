-- Каждая операция ниже должна завершиться ошибкой ограничения.

-- Номер полиса пациента должен быть уникальным.
INSERT INTO patients (name, birth_date, phone, policy_number)
VALUES ('Дубликат', '1990-01-01', '+79009999991', '100000000001');

-- Дата рождения не может быть в будущем.
INSERT INTO patients (name, birth_date, phone, policy_number)
VALUES ('Будущий пациент', '2030-01-01', '+79009999992', '100000000006');

-- Специализация врача должна существовать.
INSERT INTO doctors (specialty_id, name, license_number)
VALUES (999999, 'Несуществующий врач', 'MED-9999');

-- Стоимость приема не может быть отрицательной.
INSERT INTO appointments
    (patient_id, doctor_id, appointment_time, status, fee)
VALUES
    (1, 1, '2026-09-07 09:00:00+03', 'planned', -100.00);

-- Статус приема может иметь только одно из трех значений.
INSERT INTO appointments
    (patient_id, doctor_id, appointment_time, status, fee)
VALUES
    (2, 2, '2026-09-07 10:00:00+03', 'waiting', 1000.00);

-- Один врач не может иметь два приема в одно и то же время.
INSERT INTO appointments
    (patient_id, doctor_id, appointment_time, status, fee)
VALUES
    (2, 2, '2026-09-02 11:30:00+03', 'planned', 1000.00);

-- docker compose cp .\constraints_test.sql db:/tmp/constraints_test.sql
-- docker compose exec db psql -U medical -d medical -v ON_ERROR_STOP=0 -f /tmp/constraints_test.sql
