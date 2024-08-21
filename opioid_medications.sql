CREATE TABLE opioid_medications (
    subject_id INTEGER, 
    hadm_id INTEGER, 
    opioid_flag INTEGER
);

INSERT INTO opioid_medications (subject_id, hadm_id, opioid_flag)

select subject_id, hadm_id, max(opioid_flag) as opioid_flag
from (

select pr.*, 
 CASE 
        WHEN UPPER(drug) IN (
            'HYDROMORPHONE (DILAUDID)',
            'OXYCODONE (IMMEDIATE RELEASE)',
            'FENTANYL CITRATE',
            'FENTANYL PATCH',
            'FENTANYL PCA',
            'FENTANYL INFUSION – COMFORT CARE GUIDELINES',
            'FENTANYL',
            'FENTANYL 2.5MG 50ML BAG',
            'FENTANYL CITRATE (PF)'
        ) THEN 1
        ELSE 0
    END AS opioid_flag

 from prescriptions pr 
) a

group by 1, 2;

select * from opioid_medications
limit 10;

create INDEX "ix_opioid_medication" on "opioid_medications"("index")