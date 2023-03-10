CREATE TABLE patients (
  id SERIAL,
  name varchar(100) NOT NULL,
  date_of_birth date NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
  id SERIAL,
  addmited_at timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
  patient_id INT REFERENCES patients(id) NOT NULL,
  status varchar(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE invoices (
  id SERIAL,
  total_amount DECIMAL(10,2) NOT NULL,
  generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  payed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  medical_history_id INT UNIQUE REFERENCES medical_histories(id) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE treatments(
  id SERIAL,
  type VARCHAR(100),
  name VARCHAR(100),
  PRIMARY KEY(id)
);

CREATE TABLE invoice_items(
  id SERIAL,
  unit_price DECIMAL(10,2) NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  invoice_id REFERENCES invoices(id) NOT NULL,
  treatment_id REFERENCES treatments(id) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE medical_histories_treatments(
  medical_histories_id INT REFERENCES medical_histories(id) NOT NULL,
  treatments_id INT REFERENCES treatments(id) NOT NULL
);

CREATE INDEX idx_patient_id ON medical_histories (patient_id);
CREATE INDEX idx_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_treatment_id ON invoice_items (treatment_id);
CREATE INDEX idx_medical_histories_id ON medical_histories_treatments (medical_histories_id);
CREATE INDEX idx_treatments_id ON medical_histories_treatments (treatments_id);
CREATE INDEX idx_medical_histories_id_invoice ON invoices(medical_histories_id);
