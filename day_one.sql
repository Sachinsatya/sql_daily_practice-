
-- Write a sql query to eliminate the duplicate rows from the table and select only unique rows.

-- Table schema as below

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary INT NOT NULL )
    
INSERT INTO employees (emp_id, first_name,last_name, department, salary) VALUES 
    (1, 'Ashwini','sinha','sales', 60000),
    (2, 'Karan','kumar', 'HR', 90000),
    (3, 'Bhuvan','raj', 'IT', 60000),
    (4, 'Manoj','kumar','Fin', 25000),
    (5, 'Raaju','mani', 'IT', 80000),
    (8, 'Karan','kumar', 'HR', 90000),
    (7, 'Bhuvan','raj', 'IT', 60000);
    
    
--Solve


WITH duplicate_removal
AS (SELECT *,
           ROW_NUMBER() OVER (PARTITION BY first_name, department ORDER BY emp_id) AS row_num
    FROM employees
   )
SELECT emp_id,
       first_name,
       last_name,
       department,
       salary
FROM duplicate_removal
WHERE row_num = 1


-- Explanation
-- 1. ROW_NUMBER() function assigns a unique number to each row within a partition, in this case the partition is defined by the name, department columns. 
-- 2. ROW_NUMBER() function also allows us to specify an ORDER BY clause, which determines the order in which the rows are assigned numbers. In this query, the rows are ordered by the id column.
-- 3. The outer SELECT statement selects only the rows where the "row_num" is 1, effectively removing any duplicate rows with the same name and department.

-- Input Dataset

emp_id  first_name last_name  deportment   salary 
--1	    Ashwini	   sinha	  sales	        60000
--3	    Bhuvan	   raj	      IT	        60000
--2	    Karan	   kumar	  HR	        90000
--4	    Manoj	   kumar	  Fin	        25000
--5	    Raaju	   mani	      IT	        80000



-- Output Dataset

--1	    Ashwini	   sinha	  sales	        60000
--2	    Karan	   kumar	  HR	        90000
--3	    Bhuvan	   raj	      IT	        60000
--4	    Manoj	   kumar	  Fin	        25000
--5	    Raaju	   mani	      IT	        80000
--7	    Bhuvan	   raj	      IT	        60000
--8	    Karan	   kumar	  HR	        90000
