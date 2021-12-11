use database_test;


--
-- Base de données : `testbase`
--

-- --------------------------------------------------------

--
-- Structure de la table `bonus`
--

CREATE TABLE `bonus` (
  `emp_name` varchar(15) DEFAULT NULL,
  `job_name` varchar(10) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `commission` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `department`
--

CREATE TABLE `department` (
  `dep_id` int(11) NOT NULL,
  `dep_name` varchar(20) DEFAULT NULL,
  `dep_location` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `department`
--

INSERT INTO `department` (`dep_id`, `dep_name`, `dep_location`) VALUES
(1001, 'FINANCE', 'SYDNEY'),
(2001, 'AUDIT', 'MELBOURNE'),
(3001, 'MARKETING', 'PERTH'),
(4001, 'PRODUCTION', 'BRISBANE');

-- --------------------------------------------------------

--
-- Structure de la table `employees`
--

CREATE TABLE `employees` (
  `emp_id` int(11) NOT NULL,
  `emp_name` varchar(15) DEFAULT NULL,
  `job_name` varchar(10) DEFAULT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `commission` decimal(7,2) DEFAULT NULL,
  `dep_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `employees`
--

INSERT INTO `employees` (`emp_id`, `emp_name`, `job_name`, `manager_id`, `hire_date`, `salary`, `commission`, `dep_id`) VALUES
(63679, 'SANDRINE', 'CLERK', 69062, '1990-12-18', '900.00', '212.00', 2001),
(64989, 'ADELYN', 'SALESMAN', 66928, '1991-02-20', '1700.00', '98.00', 3001),
(65271, 'WADE', 'SALESMAN', 66928, '1991-02-22', '1350.00', '76.00', 3001),
(65646, 'JONAS', 'MANAGER', 68319, '1991-04-02', '2957.00', '33.00', 2001),
(66564, 'MADDEN', 'SALESMAN', 66928, '1991-09-28', '1350.00', '22.00', 3001),
(66928, 'BLAZE', 'MANAGER', 68319, '1991-05-01', '2750.00', '22.00', 3001),
(67832, 'CLARE', 'MANAGER', 68319, '1991-06-09', '2550.00', '11.00', 1001),
(67858, 'SCARLET', 'ANALYST', 65646, '1997-04-19', '3100.00', '4432.00', 2001),
(68319, 'KAYLING', 'PRESIDENT', 1, '1991-11-18', '6000.00', '23.00', 1001),
(68454, 'TUCKER', 'SALESMAN', 66928, '1991-09-08', '1600.00', '11.00', 3001),
(68736, 'ADNRES', 'CLERK', 67858, '1997-05-23', '1200.00', '87.00', 2001),
(69000, 'JULIUS', 'CLERK', 66928, '1991-12-03', '1050.00', '980.00', 3001),
(69062, 'FRANK', 'ANALYST', 65646, '1991-12-03', '3100.00', '2221.00', 2001),
(69324, 'MARKER', 'CLERK', 67832, '1992-01-23', '1400.00', '456.00', 1001);

-- --------------------------------------------------------

--
-- Structure de la table `salary_grade`
--

CREATE TABLE `salary_grade` (
  `grade` int(11) DEFAULT NULL,
  `min_sal` int(11) DEFAULT NULL,
  `max_sal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `salary_grade`
--

INSERT INTO `salary_grade` (`grade`, `min_sal`, `max_sal`) VALUES
(1, 800, 1300),
(2, 1301, 1500),
(3, 1501, 2100),
(4, 2101, 3100),
(5, 3101, 9999);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dep_id`);

--
-- Index pour la table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `fk_dep_id` (`dep_id`);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `fk_dep_id` FOREIGN KEY (`dep_id`) REFERENCES `department` (`dep_id`);
COMMIT;


-- selectionner tout les employées

select * from employees;

select salary from employees;

-- selectionner tous les travail des employees sans répétition
select distinct job_name from employees;

-- selectionner le nom des employés, augmenter leur salaire de 15 % et l'exprimer en nombre de dollars.
select emp_name ,( salary +((salary * 15 ) / 100 ))+'$' as "salary after increase"  from employees ;
-- #######

-- selectionner sans répétition les noms des job et les noms des départements pour chaque job 

Select distinct job_name ,  dep_name 
from employees left join department on employees.dep_id = department.dep_id;

-- selectionner les employees qui sont pas dans la département (AUDIT)

select * from employees 
inner join  department on employees.dep_id = department.dep_id
where department.dep_name <> 'AUDIT';

-- selectionner les employees qui sont recrutées avant 1991. 

select * from employees 
where  DATEDIFF(hire_date,'1991-01-01') <= 0;

-- selectionner la moyenne des salaires pour les employees qui travaillent en tant que ANALYST 

select avg(salary) as "AVERAGE SALARY" 
 from employees 
 where job_name = "SALESMAN";
 
 -- selectionner les employees qui vont dépasse 3000 après avoir donné une augmentation de 25 %.
 select * from employees
 where salary < 3000 && (salary + ((salary * 25) / 100) ) >= 3000 ;
 
-- selectionner les employees qui sont recrutées durant l'année 1991.
select * from employees 
where   DATEDIFF(hire_date,'1991-01-01') >= 0 && DATEDIFF(hire_date,'1991-12-29') <=0  ;

-- selectionner les employees dans un ordre ascendant pour le nom du job, et déscendant pour le identifiants

select * from employees 
order by emp_name asc , emp_id desc