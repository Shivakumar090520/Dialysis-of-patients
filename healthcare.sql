create database Healthcare_Data;

use healthcare_data;

show tables;

select * from dialysis_1;

select * from dialysis_2;

#-------------------------------------------------------------------------------KPIS----------------------------------------------------------------------------------------------------------

#1 - Number of Patients across various summaries

select format(sum(Number_of_patients_included_in_the_transfusion_summary),0) as Number_of_patients_included_in_the_transfusion_summary, 
format(sum(Number_of_patients_in_hypercalcemia_summary),0) as Number_of_patients_in_hypercalcemia_summary,
format(sum(Number_of_patients_in_Serum_phosphorus_summary),0) as Number_of_patients_in_Serum_phosphorus_summary,
format(sum(Number_of_patients_included_in_hospitalization_summary),0) as Number_of_patients_included_in_hospitalization_summary,
format(sum(Number_of_hsp_included_in_hospital_readmission_summary),0) as Number_of_hospitalizaiton_included_in_hospital_readmission_summary,
format(sum(Number_of_Patients_included_iin_survival_summary),0) as Number_of_Patients_included_iin_survival_summary,
format(sum(Number_of_Patients_included_in_fistula_summary),0) as Number_of_Patients_included_in_fistula_summary,
format(sum(Number_of_patients_in_long_term_catheter_summary),0) as Number_of_patients_in_long_term_catheter_summary,
format(sum(Number_of_patients_in_nPCR_summary),0) as Number_of_patients_in_nPCR_summary from dialysis_1;

#2 - Profit Vs Non-Profit Stats

select concat(round((count(*)/(select count(*) from dialysis_1))*100,2),"%") as percentage,Profit_or_Non_Profit from dialysis_1 
group by Profit_or_Non_Profit having Profit_or_Non_Profit = "Profit" or Profit_or_Non_Profit = "Non-Profit";

#3 - Chain Organizations w.r.t. Total Performance Score as No Score

select Provider_Number,chain_organization, sum(total_performance_score) as Total_Performance_Score from dialysis_1 as d1 
left join dialysis_2 as d2 on d1.provider_number=d2.CCN group by chain_organization order by Total_performance_score desc;

#4 - Dialysis Stations Stats

select chain_organization,sum(No_of_Dialysis_Stations) as No_Of_Dialysis_Stations from dialysis_1 group by chain_organization;
select chain_organization,city,sum(No_of_dialysis_stations) as No_of_Dialysis_Stations from dialysis_1 
group by chain_organization,city order by No_of_Dialysis_Stations desc;

#5 - No of Category Text  - As Expected

select chain_organization,count(Patient_transfusion_category_text) as Patient_transfusion_category_text from dialysis_1 where patient_transfusion_category_text = "As Expected" group by chain_organization order by patient_transfusion_category_text desc;
select count(Patient_hospitalization_category_text) as Patient_hospitalization_category_text from dialysis_1 where Patient_hospitalization_category_text = "As Expected";
select count(Patient_Hospital_Readmission_Category) as Patient_Hospital_Readmission_Category from dialysis_1 where Patient_Hospital_Readmission_Category = "As Expected";
select count(Patient_Survival_Category_Text) as Patient_Survival_Category_Text from dialysis_1 where Patient_Survival_Category_Text = "As Expected";
select count(Patient_Infection_category_text) as Patient_Infection_category_text from dialysis_1 where Patient_Infection_category_text = "As Expected";
select count(Fistula_Category_Text) as Fistula_Category_Text from dialysis_1 where Fistula_Category_Text = "As Expected";
select count(SWR_category_text) as SWR_category_text from dialysis_1 where SWR_category_text = "As Expected";
select count(PPPW_category_text) as PPPW_category_text from dialysis_1 where PPPW_category_text = "As Expected";

#6 - Average Payment Reduction Rate

select concat(round(avg(PY2020_Payment_Reduction_Percentage),2),"%") as Average_Payment_Reduction_Rate from dialysis_2;

#Average Rates w.r.t Chain Organization
select Chain_Organization,round(avg(Mortality_Rate),2) as Average_mortality_Rate,round(avg(Readmission_Rate),2) as Average_Readmission_Rate,
round(avg(Transfusion_Rate),2) as Average_Transfusion_Rate,round(avg(Fistula_Rate),2) as Average_Fistula_Rate,
round(avg(Hospitalization_Rate),2) as Average_Hospitalization_Rate from dialysis_1 group by chain_organization;