BEGIN;

CREATE TABLE referrals(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    appointment_id BIGINT NOT NULL
        REFERENCES appointments(id) ON DELETE RESTRICT,
    examination TEXT NOT NULL,
    issued_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status TEXT NOT NULL DEFAULT 'issued'
        CHECK (status IN ('issued', 'completed', 'cancelled')),
    UNIQUE (appointment_id, examination)
);

INSERT INTO referrals (appointment_id, examination, status)
VALUES (1, 'Флюорография', 'issued');

COMMIT;
