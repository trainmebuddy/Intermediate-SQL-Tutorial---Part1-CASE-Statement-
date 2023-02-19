USE MyStoreDB
go
--CASE STATEMENT
SELECT * FROM Employee

--USING CASE STATEMENT TO CHECK EMPLOYEE SALARY AND RETURN CATEGORY BASED ON DEFINED RESULTS
SELECT 
 EmployeeID
,FirstName
,LastName 
,Email
,Salary
,CASE 
	WHEN Salary > 45000 THEN 'Salary Greater than 45k'
	WHEN Salary = 45000 THEN 'Salary Equel to 45k'
	ELSE 'Salary Less than 45k'
END AS SalaryCategory
FROM Employee

--USING CASE WHEN ON A COLUMN SalaryType to convert M to Monthly an W to Weekly
SELECT 
 EmployeeID
,FirstName
,LastName 
,Email
,CASE 
	WHEN SalaryType = 'W' THEN 'Weekly'
	WHEN SalaryType = 'M' THEN 'Monthly'
END AS SalaryType
FROM Employee

--Get Employee salary divided by 4 if SalaryType is W Oterwise no action
SELECT 
 EmployeeID
,FirstName
,LastName 
,Email
,CASE 
	WHEN SalaryType = 'W' THEN Salary/4
	WHEN SalaryType = 'M' THEN Salary
END AS Salary
FROM Employee

--CASE statement with GROUP BY
--Below query will get how many employees are Weekly and Monthly paid
SELECT 
CASE 
	WHEN SalaryType = 'W' THEN 'Weekly'
	WHEN SalaryType = 'M' THEN 'Monthly'
END AS SalaryType
,Count(1) EmployeeCount
FROM Employee
GROUP BY  
	CASE 
		WHEN SalaryType = 'W' THEN 'Weekly'
		WHEN SalaryType = 'M' THEN 'Monthly'
	END

--CASE statement with ORDER BY
SELECT * 
FROM Customer
ORDER BY (CASE WHEN City IS NULL THEN State ELSE City END)

--REALTIME EXAMPLES OF USING CASE WHEN: 
--1.GET THE SALES TRANSACTION BY GIVEING 20% DISCOUNT TO THE CUSTOMER WHO ARE EMPLOYEES
--  AND 5% TO OTHER CUSTOMERS
SELECT S.InvoiceID
,S.CustomerID
,C.FirstName +' '+C.FirstName AS CustomerName
,S.SalesDate
,S.SalesAmount
,E.Email EmployeeEmail
,CASE 
	WHEN E.Email IS NULL THEN 'Customer'
	WHEN E.Email IS NOT NULL THEN 'Employee'
	ELSE ''
END AS CustomerType
,CASE 
	WHEN E.Email IS NULL THEN S.SalesAmount - (S.SalesAmount * .05)
	WHEN E.Email IS NOT NULL THEN S.SalesAmount - (S.SalesAmount * .2)
	ELSE S.SalesAmount
END AS FinalAmount
FROM Sales AS S
INNER JOIN Customer AS C on S.CustomerID = c.CustomerID
LEFT JOIN Employee as E on e.Email = C.Email

/*--2.ADD % BONUS TO EMPLOYEE SALARY BASED ON DEPARTMENT
Executive		:10%
Finance			:8%
Human Resources	:5%
Marketing		:4%
Purchasing		:3%
*/
SELECT * FROM Employee
SELECT * FROM Department

SELECT 
 E.EmployeeID
,E.FirstName
,E.LastName 
,D.DepartmentName
,E.Salary
,CASE 
	WHEN D.DepartmentName = 'Executive'			THEN E.Salary * .1
	WHEN D.DepartmentName = 'Finance'			THEN E.Salary * .08
	WHEN D.DepartmentName = 'Human Resources'	THEN E.Salary * .05
	WHEN D.DepartmentName = 'Marketing'			THEN E.Salary * .04
	WHEN D.DepartmentName = 'Purchasing'		THEN E.Salary * .03
	ELSE Salary
END Bonus
FROM Employee AS E
LEFT JOIN Department AS D
ON E.DepartmentID = D.DepartmentID