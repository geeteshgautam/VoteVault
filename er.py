import os
from eralchemy import render_er

# File path where the ER diagram will be saved
output_file = "healthcare_system_er_diagram.png"

# Here's the ER diagram data in text format.
# Replace with the actual details of your healthcare system entities and relationships.

erd_data = """
# Entities
Patient {
    patient_id int PK
    name varchar
    age int
    gender varchar
    contact_info varchar
    address varchar
}

Doctor {
    doctor_id int PK
    name varchar
    specialty varchar
    contact_info varchar
}

Appointment {
    appointment_id int PK
    patient_id int FK
    doctor_id int FK
    appointment_date date
    reason_for_visit varchar
}

MedicalRecord {
    record_id int PK
    patient_id int FK
    diagnosis varchar
    treatment varchar
    doctor_id int FK
    date_of_record date
}

Billing {
    billing_id int PK
    patient_id int FK
    amount_due decimal
    amount_paid decimal
    payment_status varchar
    billing_date date
}

Prescription {
    prescription_id int PK
    patient_id int FK
    doctor_id int FK
    medication varchar
    dosage varchar
    issue_date date
}

# Relationships
Patient ||--o{ Appointment : schedules
Doctor ||--o{ Appointment : attends
Patient ||--o{ MedicalRecord : has
Doctor ||--o{ MedicalRecord : creates
Patient ||--o{ Billing : pays
Patient ||--o{ Prescription : receives
Doctor ||--o{ Prescription : prescribes
"""

# Save the ER diagram data to a file
with open("healthcare_system.erl", "w") as er_file:
    er_file.write(erd_data)

# Render the ER diagram from the .erl file and save it as a PNG
render_er("healthcare_system.erl", output_file)

# Check if the file was created successfully
if os.path.exists(output_file):
    print(f"ER diagram generated successfully and saved as {output_file}")
else:
    print("Failed to generate the ER diagram.")
