-- Domain : Finance

-- Project: Bank loan of customers


Create database Project_Bank_Loan_P600;
Use Project_Bank_Loan_P600;

select count(*)from finance_1;
select count(*)from finance_2;

select * from finance_1;
select * from finance_2;

                -- KPI --

-- 1) Year wise loan amount Stats
-- 2) Grade and sub grade wise revol_bal
-- 3) Total Payment for Verified Status Vs Total Payment for Non Verified Status
-- 4) State wise and month wise loan status
-- 5) Home ownership Vs last payment date stats


-- 1) Year wise loan amount Stats

select year(issue_d) as year_of_issue_d,sum(loan_amnt) as total_loan_amount
from finance_1
group by year_of_issue_d
order by year_of_issue_d;

-- ORDER BY Organized Data Presentation
-- GROUP BY It's typically used with aggregate functions such as COUNT, SUM, AVG, MAX, or MIN to perform calculations on each group of data.


-- 2) Grade and sub grade wise revol_bal

select grade ,sub_grade ,sum(revol_bal) as total_revol_bal
from finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by grade ,sub_grade
order by grade ,sub_grade;

-- 3) Total Payment for Verified Status Vs Total Payment for Non Verified Status

select verification_status,sum(total_pymnt) as total_payment
from finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by verification_status ;


select verification_status,
concat ("$",format(round(sum(total_pymnt)/100000,2),2),"M") as total_pymnt
from finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by verification_status ;

-- CONCAT It's useful when you need to merge text from different columns or add custom text to column values.

-- 4) State wise and month wise loan status

Select addr_state as state,  DATE_FORMAT(issue_d, '%Y-%m') AS month_year, loan_status, COUNT(*) as Total_loans
from finance_1
group by state, month_year, loan_status 
Order by state,month_year;

-- %Y: Represents the year in a four-digit format (e.g., 2024).
-- %m: Represents the month in a two-digit format (e.g., 08 for August).


-- 5) Home ownership Vs last payment date stats

select home_ownership,last_pymnt_d,
concat("$",format(round(sum(last_pymnt_d)/10000,2),2),"k") as total_pymnt
from finance_1 inner join finance_2 on (finance_1.id =  finance_2.id)
group by home_ownership,last_pymnt_d
order by last_pymnt_d desc ,home_ownership desc;










