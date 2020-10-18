#1
select first_name from customer where customer_id IN (
select customer_id from prescription where medical_license_number = 
(select medical_license_number from doctor where first_name='sturgis')); 

#2
select supplier_name from drug_supplier where supplier_id IN (
select supplier_id from drug where drug_name IN (select
drug_name from drug_detail where contents='antibiotec'))
order by  supplier_name

#3
select count(*) as no_insurance
from customer
where customer_id NOT IN 
(select customer_id 
from health_insurance)

#4
select s.supplier_name, sum(price)
from drug as d, drug_supplier as s
where d.supplier_id=s.supplier_id
group by supplier_name

#5
select d.drug_name, s.supplier_name
from drug as d, drug_supplier as s
where drug_name IN (select drug_name from
drug_detail where contents='aceclofenac')
and s.supplier_id=d.supplier_id

#6
select d.first_name as doc, c.first_name as cust
from customer as c, doctor as d, prescription as p
where c.customer_id=p.customer_id and d.medical_license_number=p.medical_license_number

#7
select first_name,email,insurance_number,amount,company
from health_insurance as h
right join customer as c
on h.customer_id=c.customer_id; 
