
CREATE TABLE discharge_patient_details (
"index" INTEGER,
  "note_id" TEXT,
  "subject_id" INTEGER,
  "hadm_id" INTEGER,
  "note_type" TEXT,
  "note_seq" INTEGER,
  "charttime" TEXT,
  "storetime" TEXT,
  "text" TEXT,
  "admittime" TEXT,
  "dischtime" TEXT,
  "deathtime" TEXT,
  "admission_type" TEXT,
  "admission_location" TEXT,
  "discharge_location" TEXT,
  "marital_status" TEXT,
  "race" TEXT,
   "gender" TEXT,
  "anchor_age" INTEGER,
  "opioid_flag" INTEGER
  
)

INSERT INTO discharge_patient_details ("index", "note_id" ,
  "subject_id" ,
  "hadm_id" ,
  "note_type" ,
  "note_seq" ,
  "charttime" ,
  "storetime" ,
  "text" ,
  "admittime" ,
  "dischtime" ,
  "deathtime" ,
  "admission_type" ,
  "admission_location" ,
  "discharge_location" ,
  "marital_status" ,
  "race" ,
   "gender" ,
  "anchor_age" ,
  "opioid_flag" )

SELECT ds.*,  ad. "admittime" ,
 ad."dischtime" ,
ad. "deathtime" ,
  ad."admission_type" ,
 ad. "admission_location" ,
ad. "discharge_location" ,
  ad."marital_status" ,
  ad."race" ,
 pt. "gender" ,
  pt."anchor_age" ,
  pr."opioid_flag"
  
FROM discharge  ds 
inner join admissions ad
on ds.subject_id = ad.subject_id
and ds.hadm_id = ad.hadm_id

left join  patients pt
on ad.subject_id = pt.subject_id
left join opioid_medications pr 
on  ad.subject_id = pr.subject_id
and ad.hadm_id = pr.hadm_id 

where  ds.subject_id not in (select distinct hadm_id from icustays where stay_id is not null)


select *  from discharge_patient_details
limit 5


create INDEX "ix_discharge_patient_details" on "discharge_patient_details"("index")