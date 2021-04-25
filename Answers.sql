
--Question 1
/*a) What are the top 5 most common valid procedure codes?*/
Select top 5 ppd.procedure_code,count(procedure_code) cnt_codes
from patient_procedure_dates ppd
inner join valid_cpt_codes vcc
on ppd.procedure_code=vcc.code
group by ppd.procedure_code
order by 2 desc

/*b) How many patients are associated with at least one of those procedures?
Please do not use the result values from 1a - provide code that will find
the answer without specifying explicitly those code values*/
Select count (distinct pdc.patient_id) number_patients
from patient_diagnosis_codes pdc
inner join
(Select ppd.claim_id from 
patient_procedure_dates ppd
inner join
(Select  top 5 ppd.procedure_code,count(procedure_code) cnt_codes
from patient_procedure_dates ppd
inner join valid_cpt_codes vcc
on ppd.procedure_code=vcc.code
group by ppd.procedure_code
order by 2 desc) i
on ppd.procedure_code = i.procedure_code) o
on o.claim_id=pdc.claim_id

--Question 2
/*What are the top 5 most common valid diagnosis codes?*/
Select  top 5 count (pdc.diagnosis_codes) cnt_codes
,pdc.diagnosis_codes
from patient_diagnosis_codes pdc
inner join valid_icd_10_codes vi
on pdc.diagnosis_codes = vi.code
group by pdc.diagnosis_codes
order by 1 desc
