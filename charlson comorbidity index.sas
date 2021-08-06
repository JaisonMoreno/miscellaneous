proc import datafile= "H:\Chris Woodrell\HCC Study\Work\Datasets\Derived\dxcodes.dta" out=problemlist dbms=DTA replace; run;

data charlson;
set problemlist; /* replace this with the name of your dataset after you import it from stata */
dx_code = compress(dx_icd9,.); /* create a variable called dx_icd9 */
comorbi_1=0;
comorbi_2=0;
comorbi_3=0;
comorbi_4=0;
comorbi_5=0;
comorbi_6=0;
comorbi_7=0;
comorbi_8=0;
comorbi_9=0;
comorbi_10=0;
comorbi_11=0;
comorbi_12=0;
comorbi_13=0;
comorbi_14=0;
comorbi_15=0;
comorbi_16=0;
comorbi_17=0;
array dx dx_code;
do over dx;
*Congestive Heart Failure;
   if(substr(dx,1,3)='428' or
   substr(dx,1,4)='I099' or
   substr(dx,1,4)='I110' or
   substr(dx,1,4)='I130' or
               substr(dx,1,4)='I132' or
               substr(dx,1,4)='I255' or
               substr(dx,1,4)='I420' or
               substr(dx,1,4)='I425' or
               substr(dx,1,4)='I426' or
               substr(dx,1,4)='I427' or
               substr(dx,1,4)='I428' or
               substr(dx,1,4)='I429' or
               substr(dx,1,4)='I43'  or
               substr(dx,1,4)='I50'  or
               substr(dx,1,4)='P290' )
		and comorbi_1=0 
		then comorbi_1=1; *add one binary variables here.;
 *Myocardial Infarction;
   if(substr(dx,1,3)='410' or
               substr(dx,1,3)='412')
			and comorbi_2=0 
		then comorbi_2=1;
*Periphral Vascular Disease;
    if(substr(dx,1,4)='0930' or
               substr(dx,1,4)='4373' or
               substr(dx,1,3)='440' or
               substr(dx,1,3)='441' or
               substr(dx,1,4)='4431' or
               substr(dx,1,4)='4432' or
               substr(dx,1,4)='4438' or
               substr(dx,1,4)='4439' or
               substr(dx,1,4)='4471' or
               substr(dx,1,4)='5571' or
               substr(dx,1,4)='5579' or
               substr(dx,1,4)='V434')
			and comorbi_3=0 
		then comorbi_3=1;
 *Cerebrovascular Disease ;
        if(substr(dx,1,5)='36234' or
               substr(dx,1,3)='430' or
               substr(dx,1,3)='431' or
               substr(dx,1,3)='432' or
               substr(dx,1,3)='433' or
               substr(dx,1,3)='434' or
               substr(dx,1,3)='435' or
               substr(dx,1,3)='436' or
               substr(dx,1,3)='437' or
               substr(dx,1,3)='438')
			and comorbi_4=0 
		then comorbi_4=1;
*Dementia ;
       if(substr(dx,1,3)='290' or
               substr(dx,1,4)='2941' or
               substr(dx,1,4)='3312')
			and comorbi_5=0 
		then comorbi_5=1;
	*Chronic Pulmonary Disease ;
        if(substr(dx,1,5)='4168' or
               substr(dx,1,4)='4169' or
               substr(dx,1,3)='490' or
               substr(dx,1,3)='491' or
               substr(dx,1,3)='492' or
               substr(dx,1,3)='493' or
               substr(dx,1,3)='494' or
               substr(dx,1,3)='495' or
               substr(dx,1,3)='496' or
               substr(dx,1,3)='500' or
               substr(dx,1,3)='501' or
               substr(dx,1,3)='502' or
               substr(dx,1,3)='503' or
               substr(dx,1,3)='504' or
               substr(dx,1,3)='505' or
               substr(dx,1,4)='5064' or
               substr(dx,1,4)='5081' or
               substr(dx,1,4)='5088')
			and comorbi_6=0 
		then comorbi_6=1;
*Connective Tissue Disease-Rheumatic Disease;
         if(substr(dx,1,4)='4465' or
               substr(dx,1,4)='7100' or
               substr(dx,1,4)='7101' or
               substr(dx,1,4)='7102' or
               substr(dx,1,4)='7103' or
               substr(dx,1,4)='7104' or
               substr(dx,1,4)='7140' or
               substr(dx,1,4)='7141' or
               substr(dx,1,4)='7142' or
               substr(dx,1,4)='7148' or
               substr(dx,1,3)='725')
			and comorbi_7=0 
		then comorbi_7=1;
*Peptic Ulcer Disease;
         if(substr(dx,1,3)='531' or
               substr(dx,1,3)='532' or
               substr(dx,1,3)='533' or
               substr(dx,1,3)='534')
			and comorbi_8=0 
		then comorbi_8=1;	
*Mild Liver Disease ;
         if(substr(dx,1,5)='07022' or
               substr(dx,1,5)='07023' or
               substr(dx,1,5)='07032' or
               substr(dx,1,5)='07033' or
               substr(dx,1,5)='07044' or
               substr(dx,1,5)='07054' or
               substr(dx,1,4)='0706' or
               substr(dx,1,4)='0709' or
               substr(dx,1,3)='570' or
               substr(dx,1,3)='571' or
               substr(dx,1,4)='5733' or
               substr(dx,1,4)='5734' or
               substr(dx,1,4)='5738' or
               substr(dx,1,4)='5739' or
               substr(dx,1,4)='V427')
			and comorbi_9=0 
		then comorbi_9=1;	
*Diabetes without complications ;
         if(substr(dx,1,4)='2500' or
               substr(dx,1,4)='2501' or
               substr(dx,1,4)='2502' or
               substr(dx,1,4)='2503' or
               substr(dx,1,4)='2508' or
               substr(dx,1,4)='2509')
			and comorbi_10=0 
		then comorbi_10=1;
*Diabetes, complicated;
	if (substr(dx,1,4)='2504' or
		substr(dx,1,4)='2505' or
		substr(dx,1,4)='2506' or
		substr(dx,1,4)='2507')
			and comorbi_11=0 
		then comorbi_11=1;
*Paraplegia and Hemiplegia ;
	if (substr(dx,1,4)='3341' or
		substr(dx,1,3)='342' or
		substr(dx,1,3)='343' or
		substr(dx,1,4)='3440' or
		substr(dx,1,4)='3441' or
		substr(dx,1,4)='3442' or
		substr(dx,1,4)='3443' or
                substr(dx,1,4)='3444' or
		substr(dx,1,4)='3445' or
		substr(dx,1,4)='3446' or
		substr(dx,1,4)='3449')
			and comorbi_12=0 
		then comorbi_12=1;
* Renal Disease ;
	if (substr(dx,1,5)='40301' or
		substr(dx,1,5)='40311' or
		substr(dx,1,5)='40391' or
		substr(dx,1,5)='40402' or
		substr(dx,1,5)='40403' or
		substr(dx,1,5)='40412' or
		substr(dx,1,5)='40413' or
                substr(dx,1,5)='40492' or
		substr(dx,1,5)='40493' or
		substr(dx,1,3)='582' or
		substr(dx,1,4)='5830' or
                substr(dx,1,4)='5831' or
                substr(dx,1,4)='5832' or
                substr(dx,1,4)='5834' or
                substr(dx,1,4)='5836' or
                substr(dx,1,4)='5837' or
                substr(dx,1,3)='585' or
                substr(dx,1,3)='586' or
                substr(dx,1,4)='5880' or
                substr(dx,1,4)='V420' or
                substr(dx,1,4)='V451' or
                substr(dx,1,3)='V56' )
			and comorbi_13=0 
		then comorbi_13=1;
*Cancer ;
	if (substr(dx,1,2)='14' or
		substr(dx,1,2)='15' or
		substr(dx,1,2)='16' or
		substr(dx,1,3)='170' or
		substr(dx,1,3)='171' or
		substr(dx,1,3)='172' or
		substr(dx,1,3)='174' or
		substr(dx,1,3)='175' or
		substr(dx,1,3)='176' or
		substr(dx,1,3)='179' or
		substr(dx,1,2)='18' or
		substr(dx,1,3)='190' or
		substr(dx,1,3)='191' or
		substr(dx,1,3)='192' or
		substr(dx,1,3)='193' or
		substr(dx,1,3)='194' or
		substr(dx,1,3)='195' or
                substr(dx,1,3)='200' or
                substr(dx,1,3)='201' or
                substr(dx,1,3)='202' or
                substr(dx,1,3)='203' or
                substr(dx,1,3)='204' or
                substr(dx,1,3)='205' or
                substr(dx,1,3)='206' or
                substr(dx,1,3)='207' or
                substr(dx,1,3)='208' or
                substr(dx,1,3)='2386' )
			and comorbi_14=0 
		then comorbi_14=1;
* Moderate or Severe Liver Disease ;
	if (substr(dx,1,4)='4560' or
		substr(dx,1,4)='4561' or
		substr(dx,1,4)='4562' or
		substr(dx,1,4)='5722' or
		substr(dx,1,4)='5723' or
		substr(dx,1,4)='5724' or
      		substr(dx,1,4)='5728' )
			and comorbi_15=0 
		then comorbi_15=1;
  * Metastatic Carcinoma ;
	if (substr(dx,1,3)='196' or
		substr(dx,1,3)='197' or
		substr(dx,1,3)='198' or
		substr(dx,1,3)='199' )
			and comorbi_16=0 
		then comorbi_16=1;
  * AIDS/HIV ;
	if (substr(dx,1,3)='042' or
		substr(dx,1,3)='043' or
		substr(dx,1,3)='044' )
			and comorbi_17=0 
		then comorbi_17=1;

end;
run;

/*check sums of each comorbidity for each id*/
proc sql;
create table charlson1 as
select distinct visit_id,
sum(comorbi_1) as com_1,
sum(comorbi_2) as com_2,
sum(comorbi_3) as com_3,
sum(comorbi_4) as com_4,
sum(comorbi_5) as com_5,
sum(comorbi_6) as com_6,
sum(comorbi_7) as com_7,
sum(comorbi_8) as com_8,
sum(comorbi_9) as com_9,
sum(comorbi_10) as com_10,
sum(comorbi_11) as com_11,
sum(comorbi_12) as com_12,
sum(comorbi_13) as com_13,
sum(comorbi_14) as com_14,
sum(comorbi_15) as com_15,
sum(comorbi_16) as com_16,
sum(comorbi_17) as com_17
from charlson
group by visit_id;
quit;

data charlson1;
set charlson1;
array list_com com_1-com_17;
array list_com_bin comorbi_1-comorbi_17;

do over list_com;
list_com_bin=0;
if list_com>0 then do;
list_com_bin=1;
end;
end;
comorb_all=comorbi_1+comorbi_2+comorbi_3+comorbi_4+comorbi_5+comorbi_6+
comorbi_7+comorbi_8+comorbi_9+comorbi_10+comorbi_11+comorbi_12+comorbi_13+
comorbi_14+comorbi_15+comorbi_16+comorbi_17;
where visit_id > .;
run;

data plist_charlson;
set charlson1;
label comorbi_1 ="Congestive Heart Failure";
label comorbi_2 ="Myocardial Infarction";
label comorbi_3 ="Peripheral Vascular Disease";
label comorbi_4 ="Cerebrovascular Disease";
label comorbi_5 ="Dementia";
label comorbi_6 ="Chronic Pulmonary Disease";
label comorbi_7 ="Rheumatic Disease";
label comorbi_8 ="Peptic Ulcer Disease";
label comorbi_9 ="Mild Liver Disease";
label comorbi_10 ="Diabetes, uncomplicated";
label comorbi_11 ="Diabetes, complicated";
label comorbi_12 ="Paraplegia and Hemiplegia";
label comorbi_13 ="Renal Disease";
label comorbi_14 ="Cancer";
label comorbi_15 ="Moderate or Severe Liver Disease";
label comorbi_16 ="Metastatic Carcinoma";
label comorbi_17 ="AIDS/HIV";
run;

/* ICD-10 Charlson */

data charlson_10;
set problemlist;
dx_code = compress(dx_icd10,.);
comorbi_1=0;
comorbi_2=0;
comorbi_3=0;
comorbi_4=0;
comorbi_5=0;
comorbi_6=0;
comorbi_7=0;
comorbi_8=0;
comorbi_9=0;
comorbi_10=0;
comorbi_11=0;
comorbi_12=0;
comorbi_13=0;
comorbi_14=0;
comorbi_15=0;
comorbi_16=0;
comorbi_17=0;
array dx dx_code;
do over dx;
*Congestive Heart Failure;
   if(substr(dx,1,4)='I099' or
               substr(dx,1,4)='I110' or
               substr(dx,1,4)='I130' or
               substr(dx,1,4)='I132' or
               substr(dx,1,4)='I255' or
               substr(dx,1,4)='I420' or
               substr(dx,1,4)='I425' or
               substr(dx,1,4)='I426' or
               substr(dx,1,4)='I427' or
               substr(dx,1,4)='I428' or
               substr(dx,1,4)='I429' or
               substr(dx,1,4)='I43'  or
               substr(dx,1,4)='I50'  or
               substr(dx,1,4)='P290')
		and comorbi_1=0 
		then comorbi_1=1;*add one binary variables here.;
 *Myocardial Infarction;
   if(substr(dx,1,3)='I21' or
               substr(dx,1,3)='I22' or
               substr(dx,1,4)='I252')
			and comorbi_2=0 
		then comorbi_2=1;
*Periphral Vascular Disease;
    if(substr(dx,1,3)='I70' or
               substr(dx,1,3)='I71' or
               substr(dx,1,4)='I731' or
               substr(dx,1,4)='I738' or
               substr(dx,1,4)='I739' or
               substr(dx,1,4)='I771' or
               substr(dx,1,4)='I790' or
               substr(dx,1,4)='I792' or
               substr(dx,1,4)='K551' or
               substr(dx,1,4)='K558' or
               substr(dx,1,4)='K559' or
			   substr(dx,1,4)='Z958' or
               substr(dx,1,4)='Z959')
			and comorbi_3=0 
		then comorbi_3=1;
 *Cerebrovascular Disease ;
        if(substr(dx,1,3)='G45' or
               substr(dx,1,3)='G46' or
               substr(dx,1,4)='H340' or
               substr(dx,1,3)='I60' or
               substr(dx,1,3)='I61' or
               substr(dx,1,3)='I62' or
               substr(dx,1,3)='I63' or
               substr(dx,1,3)='I64' or
               substr(dx,1,3)='I65' or
			   substr(dx,1,3)='I66' or
               substr(dx,1,3)='I67' or
               substr(dx,1,3)='I68' or
               substr(dx,1,3)='I69')
			and comorbi_4=0 
		then comorbi_4=1;
*Dementia ;
       if(substr(dx,1,3)='F00' or
               substr(dx,1,3)='F01' or
               substr(dx,1,3)='F02' or
               substr(dx,1,3)='F03' or
               substr(dx,1,4)='F051' or
               substr(dx,1,3)='G30' or
               substr(dx,1,4)='G311')
			and comorbi_5=0 
		then comorbi_5=1;
	*Chronic Pulmonary Disease ;
        if(substr(dx,1,4)='I278' or
               substr(dx,1,4)='I279' or
               substr(dx,1,3)='J40' or
               substr(dx,1,3)='J41' or
               substr(dx,1,3)='J42' or
               substr(dx,1,3)='J43' or
               substr(dx,1,3)='J44' or
               substr(dx,1,3)='J45' or
               substr(dx,1,3)='J46' or
               substr(dx,1,3)='J47' or
               substr(dx,1,3)='J60' or
               substr(dx,1,3)='J61' or
               substr(dx,1,3)='J62' or
               substr(dx,1,3)='J63' or
               substr(dx,1,3)='J64' or
               substr(dx,1,3)='J65' or
               substr(dx,1,3)='J66' or
			   substr(dx,1,3)='J67' or
               substr(dx,1,4)='J684' or
               substr(dx,1,4)='J701' or
               substr(dx,1,4)='J703')
			and comorbi_6=0 
		then comorbi_6=1;
*Connective Tissue Disease-Rheumatic Disease;
         if(substr(dx,1,3)='M05' or
               substr(dx,1,3)='M06' or
               substr(dx,1,4)='M315' or
               substr(dx,1,3)='M32' or
               substr(dx,1,3)='M33' or
               substr(dx,1,3)='M34' or
               substr(dx,1,4)='M351' or
               substr(dx,1,4)='M353' or
               substr(dx,1,4)='M360')
			and comorbi_7=0 
		then comorbi_7=1;
*Peptic Ulcer Disease;
         if(substr(dx,1,3)='K25' or
               substr(dx,1,3)='K26' or
               substr(dx,1,3)='K27' or
               substr(dx,1,3)='K28')
			and comorbi_8=0 
		then comorbi_8=1;	
*Mild Liver Disease ;
         if(substr(dx,1,3)='B18' or
               substr(dx,1,4)='K700' or
               substr(dx,1,4)='K701' or
               substr(dx,1,4)='K702' or
               substr(dx,1,4)='K703' or
               substr(dx,1,4)='K709' or
               substr(dx,1,4)='K713' or
               substr(dx,1,4)='K714' or
               substr(dx,1,4)='K715' or
               substr(dx,1,4)='K717' or
               substr(dx,1,3)='K73' or
               substr(dx,1,3)='K74' or
               substr(dx,1,4)='K76' or
               substr(dx,1,4)='K762' or
			   substr(dx,1,4)='K763' or
               substr(dx,1,4)='K764' or
               substr(dx,1,4)='K768' or
			   substr(dx,1,4)='K769' or
               substr(dx,1,4)='Z944')
			and comorbi_9=0 
		then comorbi_9=1;	
*Diabetes without complications ;
     if(substr(dx,1,4)='E100' or
		substr(dx,1,4)='E101' or
		substr(dx,1,4)='E106' or
		substr(dx,1,4)='E108' or
		substr(dx,1,4)='E109' or
		substr(dx,1,4)='E110' or
        substr(dx,1,4)='E111' or
		substr(dx,1,4)='E116' or
		substr(dx,1,4)='E118' or
		substr(dx,1,4)='E119' or
		substr(dx,1,4)='E120' or
		substr(dx,1,4)='E121' or
		substr(dx,1,4)='E126' or
		substr(dx,1,4)='E128' or
		substr(dx,1,4)='E129' or
		substr(dx,1,4)='E130' or
		substr(dx,1,4)='E131' or
		substr(dx,1,4)='E136' or
		substr(dx,1,4)='E138' or
        substr(dx,1,4)='E139' or
		substr(dx,1,4)='E140' or
		substr(dx,1,4)='E141' or
		substr(dx,1,4)='E146' or
		substr(dx,1,4)='E148' or
		substr(dx,1,4)='E149')
			and comorbi_10=0 
		then comorbi_10=1;
*Diabetes, complicated;
	if (substr(dx,1,4)='E102' or
		substr(dx,1,4)='E103' or
		substr(dx,1,4)='E104' or
		substr(dx,1,4)='E105' or
		substr(dx,1,4)='E107' or
		substr(dx,1,4)='E112' or
		substr(dx,1,4)='E113' or
		substr(dx,1,4)='E114' or
        substr(dx,1,4)='E115' or
		substr(dx,1,4)='E117' or
        substr(dx,1,4)='E122' or
		substr(dx,1,4)='E123' or
		substr(dx,1,4)='E124' or
		substr(dx,1,4)='E125' or
		substr(dx,1,4)='E127' or
		substr(dx,1,4)='E132' or
		substr(dx,1,4)='E133' or
		substr(dx,1,4)='E134' or
        substr(dx,1,4)='E135' or
		substr(dx,1,4)='E137' or
		substr(dx,1,4)='E142' or
		substr(dx,1,4)='E143' or
		substr(dx,1,4)='E144' or
        substr(dx,1,4)='E145' or
		substr(dx,1,4)='E147')
			and comorbi_11=0 
		then comorbi_11=1;
*Paraplegia and Hemiplegia ;
	if (substr(dx,1,4)='G041' or
		substr(dx,1,4)='G114' or
		substr(dx,1,4)='G801' or
		substr(dx,1,4)='G802' or
		substr(dx,1,3)='G81' or
		substr(dx,1,3)='G82' or
		substr(dx,1,4)='G830' or
        substr(dx,1,4)='G834' or
		substr(dx,1,4)='G839')
			and comorbi_12=0 
		then comorbi_12=1;
* Renal Disease ;
	if (substr(dx,1,4)='I120' or
		substr(dx,1,4)='I131' or
		substr(dx,1,4)='N032' or
		substr(dx,1,4)='N033' or
		substr(dx,1,4)='N034' or
		substr(dx,1,4)='N035' or
		substr(dx,1,4)='N036' or
        substr(dx,1,4)='N037' or
		substr(dx,1,4)='N052' or
		substr(dx,1,4)='N053' or
		substr(dx,1,4)='N054' or
                substr(dx,1,4)='N055' or
                substr(dx,1,4)='N056' or
                substr(dx,1,4)='N057' or
                substr(dx,1,3)='N18' or
                substr(dx,1,4)='N19' or
                substr(dx,1,4)='N250' or
                substr(dx,1,4)='Z490' or
                substr(dx,1,4)='Z491' or
                substr(dx,1,4)='Z492' or
                substr(dx,1,4)='Z940' or
                substr(dx,1,3)='Z992' )
			and comorbi_13=0 
		then comorbi_13=1;
*Cancer ;
	if (substr(dx,1,3)='C00' or
		substr(dx,1,3)='C01' or
		substr(dx,1,3)='C02' or
		substr(dx,1,3)='C03' or
		substr(dx,1,3)='C04' or
		substr(dx,1,3)='C05' or
		substr(dx,1,3)='C06' or
		substr(dx,1,3)='C07' or
		substr(dx,1,3)='C08' or
		substr(dx,1,3)='C09' or
		substr(dx,1,3)='C10' or
		substr(dx,1,3)='C11' or
		substr(dx,1,3)='C12' or
		substr(dx,1,3)='C13' or
		substr(dx,1,3)='C14' or
		substr(dx,1,3)='C15' or
		substr(dx,1,3)='C16' or
		substr(dx,1,3)='C17' or
		substr(dx,1,3)='C18' or
		substr(dx,1,3)='C19' or
		substr(dx,1,3)='C20' or
		substr(dx,1,3)='C21' or
		substr(dx,1,3)='C22' or
		substr(dx,1,3)='C23' or
		substr(dx,1,3)='C24' or
		substr(dx,1,3)='C25' or
		substr(dx,1,3)='C26' or
		substr(dx,1,3)='C30' or
		substr(dx,1,3)='C31' or
		substr(dx,1,3)='C32' or
		substr(dx,1,3)='C33' or
		substr(dx,1,3)='C34' or
		substr(dx,1,3)='C37' or
		substr(dx,1,3)='C38' or
		substr(dx,1,3)='C39' or
		substr(dx,1,3)='C40' or
		substr(dx,1,3)='C41' or
		substr(dx,1,3)='C43' or
		substr(dx,1,3)='C45' or
		substr(dx,1,3)='C46' or
		substr(dx,1,3)='C47' or
		substr(dx,1,3)='C48' or
		substr(dx,1,3)='C49' or
		substr(dx,1,3)='C50' or
		substr(dx,1,3)='C51' or
		substr(dx,1,3)='C52' or
		substr(dx,1,3)='C53' or
		substr(dx,1,3)='C54' or
		substr(dx,1,3)='C55' or
		substr(dx,1,3)='C56' or
		substr(dx,1,3)='C57' or
		substr(dx,1,3)='C58' or
		substr(dx,1,3)='C60' or
		substr(dx,1,3)='C61' or
		substr(dx,1,3)='C62' or
		substr(dx,1,3)='C63' or
		substr(dx,1,3)='C64' or
		substr(dx,1,3)='C65' or
		substr(dx,1,3)='C66' or
		substr(dx,1,3)='C67' or
		substr(dx,1,3)='C68' or
		substr(dx,1,3)='C69' or
		substr(dx,1,3)='C70' or
		substr(dx,1,3)='C71' or
		substr(dx,1,3)='C72' or
		substr(dx,1,3)='C73' or
		substr(dx,1,3)='C74' or
		substr(dx,1,3)='C75' or
		substr(dx,1,3)='C76' or
                substr(dx,1,3)='C81' or
                substr(dx,1,3)='C82' or
                substr(dx,1,3)='C83' or
                substr(dx,1,3)='C84' or
                substr(dx,1,3)='C85' or
                substr(dx,1,3)='C88' or
                substr(dx,1,3)='C90' or
                substr(dx,1,3)='C91' or
                substr(dx,1,3)='C92' or
                substr(dx,1,3)='C93' or
                substr(dx,1,3)='C94' or
                substr(dx,1,3)='C95' or
                substr(dx,1,3)='C96' or 
                substr(dx,1,3)='C97')
			and comorbi_14=0 
		then comorbi_14=1;
* Moderate or Severe Liver Disease ;
	if (substr(dx,1,4)='I850' or
		substr(dx,1,4)='I859' or
		substr(dx,1,4)='I864' or
		substr(dx,1,4)='I982' or
		substr(dx,1,4)='K704' or
		substr(dx,1,4)='K711' or
		substr(dx,1,4)='K721' or
        substr(dx,1,4)='K729' or
        substr(dx,1,3)='K765' or
        substr(dx,1,3)='K766' or
        substr(dx,1,3)='K767')
		and comorbi_15=0 
		then comorbi_15=1;
  * Metastatic Carcinoma ;
	if (substr(dx,1,3)='C77' or
		substr(dx,1,3)='C78' or
		substr(dx,1,3)='C79' or
		substr(dx,1,3)='C80' )
			and comorbi_16=0 
		then comorbi_16=1;
  * AIDS/HIV ;
	if (substr(dx,1,3)='B20' or
		substr(dx,1,3)='B21' or
        substr(dx,1,3)='B22' or
		substr(dx,1,3)='B24')
			and comorbi_17=0 
		then comorbi_17=1;

end;
run;

/*check sums of each comorbidity for each id*/
proc sql;
create table charlson_11 as
select distinct visit_id,
sum(comorbi_1) as com_1,
sum(comorbi_2) as com_2,
sum(comorbi_3) as com_3,
sum(comorbi_4) as com_4,
sum(comorbi_5) as com_5,
sum(comorbi_6) as com_6,
sum(comorbi_7) as com_7,
sum(comorbi_8) as com_8,
sum(comorbi_9) as com_9,
sum(comorbi_10) as com_10,
sum(comorbi_11) as com_11,
sum(comorbi_12) as com_12,
sum(comorbi_13) as com_13,
sum(comorbi_14) as com_14,
sum(comorbi_15) as com_15,
sum(comorbi_16) as com_16,
sum(comorbi_17) as com_17
from charlson_10
group by visit_id;
quit;

data charlson_11;
set charlson_11;
array list_com com_1-com_17;
array list_com_bin comorbi_1-comorbi_17;

do over list_com;
list_com_bin=0;
if list_com>0 then do;
list_com_bin=1;
end;
end;
comorb_all=comorbi_1+comorbi_2+comorbi_3+comorbi_4+comorbi_5+comorbi_6+
comorbi_7+comorbi_8+comorbi_9+comorbi_10+comorbi_11+comorbi_12+comorbi_13+
comorbi_14+comorbi_15+comorbi_16+comorbi_17;
where visit_id > .;
run;

data plist_charlson_10;
set charlson_11;
label comorbi_1 ="Congestive Heart Failure";
label comorbi_2 ="Myocardial Infarction";
label comorbi_3 ="Peripheral Vascular Disease";
label comorbi_4 ="Cerebrovascular Disease";
label comorbi_5 ="Dementia";
label comorbi_6 ="Chronic Pulmonary Disease";
label comorbi_7 ="Rheumatic Disease";
label comorbi_8 ="Peptic Ulcer Disease";
label comorbi_9 ="Mild Liver Disease";
label comorbi_10 ="Diabetes, uncomplicated";
label comorbi_11 ="Diabetes, complicated";
label comorbi_12 ="Paraplegia and Hemiplegia";
label comorbi_13 ="Renal Disease";
label comorbi_14 ="Cancer";
label comorbi_15 ="Moderate or Severe Liver Disease";
label comorbi_16 ="Metastatic Carcinoma";
label comorbi_17 ="AIDS/HIV";
run;

data plist_charlson_b;
set plist_charlson_10 (rename=(com_1-com_17 = comb_1-comb_17 comorbi_1-comorbi_17=com10_1-com10_17 comorb_all = com10_all)) ;
run;

data plist_charlson_b (keep = visit_id comb_1-comb_17 com10_1-com10_17 com10_all);
set plist_charlson_b;
run;

proc sql;
create table plist_charls as select a.*, b.*
from plist_charlson a
inner join plist_charlson_b b
on a.visit_id = b.visit_id;
quit;

proc export data=plist_charls outfile="H:\Chris Woodrell\HCC Study\Work\Datasets\Derived\dxcodes_v2.dta" dbms=stata replace; run;
