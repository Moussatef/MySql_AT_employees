# MySql_AT_employees

### - selectionner tout les employées

- select \*
  from employees;

### - selectionner les salaires de tous les employées

- select salary
  from employees;

### - selectionner tous les travail des employees sans répétition

- select distinct job_name
  from employees;

### - selectionner le nom des employés, augmenter leur salaire de 15 % et l'exprimer en nombre de dollars.

- select emp_name , salary+((salary \* 15 ) / 100 ) as "salary after increase"
  from employees;

### - selectionner sans répétition les noms des job et les noms des départements pour chaque job

- Select distinct job_name , dep_name
  from employees left join department on employees.dep_id = department.dep_id;

### - selectionner les employees qui sont pas dans la département (AUDIT)

- select \*
  from employees
  inner join department on employees.dep_id = department.dep_id
  where department.dep_name <> 'AUDIT';

### - selectionner les employees qui sont recrutées avant 1991.

- select \*
  from employees
  where DATEDIFF(hire_date,'1991-01-01') <= 0;

### - selectionner la moyenne des salaires pour les employees qui travaillent en tant que ANALYST

- select avg(salary) as "AVERAGE SALARY"
  from employees
  where job_name = "SALESMAN";

### - selectionner les employees qui vont dépasse 3000 après avoir donné une augmentation de 25 %.

- select _ from employees
  where salary < 3000 && (salary + ((salary _ 25) / 100) ) >= 3000 ;

### - selectionner les employees qui sont recrutées durant l'année 1991.

- select \*
  from employees
  where DATEDIFF(hire_date,'1991-01-01') >= 0 && DATEDIFF(hire_date,'1991-12-29') <=0 ;

### - selectionner les employees dans un ordre ascendant pour le nom du job, et déscendant pour le identifiants

- select \*
  from employees
  order by emp_name asc , emp_id desc
