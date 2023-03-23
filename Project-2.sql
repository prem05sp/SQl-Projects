/* 1. Create new schema as alumni*/

create database alumni;

/* 2.Import all .csv files into MySQL*/
-- sucessfully import all files

use alumni;

/* 3.Run SQL command to see the structure of six tables*/

desc college_a_hs;
desc college_a_se;
desc college_a_sj;
desc college_b_hs;
desc college_b_se;
desc college_b_sj;


/* 6.Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. */

select * from college_a_hs;
create view  College_A_HS_V as (select * from college_a_hs where RollNo is not null and LastUpdate is not null and
name is not null and FatherName is not null and MotherName is not null and Batch is not null and Degree is not null and
PresentStatus is not null and HSDegree is not null and EntranceExam is not null and Institute is not null and
 Location is not null);
 select * from college_a_hs_v;

/* 7.Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.*/

select * from college_a_se;
create view  College_A_SE_V as (select * from college_a_se where RollNo is not null and LastUpdate is not null and
name is not null and FatherName is not null and MotherName is not null and Batch is not null and Degree is not null and
PresentStatus is not null and Organization is not null and Location is not null );
 select * from college_a_se_v;
 
 /* 8.Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.*/
 
 select * from college_a_sj;
create view  College_A_SJ_V as (select * from college_a_sj where RollNo is not null and LastUpdate is not null and
name is not null and FatherName is not null and MotherName is not null and Batch is not null and Degree is not null and
PresentStatus is not null and Organization is not null and Designation is not null and Location is not null );
 select * from college_a_sj_v;
 
 /* 9.Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.*/
 
 select * from college_b_hs;
create view  College_B_HS_V as (select * from college_b_hs where RollNo is not null and LastUpdate is not null and
name is not null and FatherName is not null and MotherName is not null and Batch is not null and Degree is not null and
PresentStatus is not null and HSDegree is not null and EntranceExam is not null and Institute is not null and Location is not null );
 select * from college_b_hs_v;
 
 /* 10.Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.*/
 
 
 select * from college_b_se;
create view  College_B_SE_V as (select * from college_b_se where RollNo is not null and LastUpdate is not null and
name is not null and FatherName is not null and MotherName is not null and Branch is not null and Batch is not null and 
Degree is not null and PresentStatus is not null and Organization is not null and Location is not null );
 select * from college_b_se_v;
 
 /* 11.Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.*/
 
select * from college_b_sj;
create view  College_B_SJ_V as (select * from college_b_sj where RollNo is not null and LastUpdate is not null and
name is not null and FatherName is not null and MotherName is not null and Branch is not null and Batch is not null and 
Degree is not null and PresentStatus is not null and Organization is not null and Designation is not null and Location is not null );
 select * from college_b_sj_v;
 
 
 /* 12.Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case
 for views (College_A_HS_V,  College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) */
 
 select * from college_a_hs_v;
 select lower(Name),lower(FatherName),lower(MotherName) from college_a_hs_v;
 select lower(Name),lower(FatherName),lower(MotherName) from college_a_se_v;
 select lower(Name),lower(FatherName),lower(MotherName) from college_a_sj_v;
 select lower(Name),lower(FatherName),lower(MotherName) from college_b_hs_v;
 select lower(Name),lower(FatherName),lower(MotherName) from college_b_se_v;
 select lower(Name),lower(FatherName),lower(MotherName) from college_b_sj_v;
 
 
 /* 14.Write a query to create procedure get_name_collegeA using the cursor to fetch names 
 of all students from college A.*/

Delimiter //
Create procedure get_name_collegeA (inout name1 text(40000))
Begin
Declare na int Default 0;
Declare namelist varchar(16000) default "";
Declare namedetail cursor for				
select name from college_a_hs union select name from college_a_se union select name from college_a_sj;
Declare continue handler for not found set na = 1; 
open namedetail;
getame :
         loop 
         fetch from namedetail into namelist;
         if na = 1 then 
            leave getname;
         end if;
		set name1 = concat(namelist,";",name1);
        end loop getame;
        Close namedetail;
end //
Delimiter ;

Set @Name = "";
Call get_name_collegeA(@Name);
Select @Name Name;


/* 16.Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
Note: Approximate percentages are considered for career choices.*/

select "Higher studies" Present_status,
(count(college_a_hs.RollNo) /(college_a_hs.RollNo))*100 College_A_Persentage,
(count(college_b_hs.RollNo)/(college_b_hs.RollNo))*100 College_B_Persentage from college_a_hs cross join college_b_hs
union select "self Employment"Present_status,
(count(college_a_se.RollNo) /(college_a_se.RollNo))*100 College_A_Persentage,
(count(college_b_se.RollNo)/(college_b_se.RollNo))*100 College_B_Persentage from college_a_se cross join college_b_se
union select "Service Job" Present_status,
(count(college_a_sj.RollNo) /(college_a_sj.RollNo))*100 College_A_Persentage,
(count(college_b_sj.RollNo)/(college_b_sj.RollNo))*100 College_B_Persentage from college_a_sj cross join college_b_sj;



 