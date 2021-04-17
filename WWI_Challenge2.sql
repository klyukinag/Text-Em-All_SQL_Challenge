-- Challenge 2
-- Q: What is the fastest growing customer category in Q1 2016 (compared to same quarter sales in the previous year)?
-- A: Computer Store
-- Q: What is the growth rate?
-- A: ~20.2%

select

sales.CustomerCategories.CustomerCategoryName,

sum(case
	when (YEAR(Sales.Invoices.InvoiceDate)=2016 and MONTH(Sales.Invoices.InvoiceDate) in (1,2,3))
	then sales.InvoiceLines.Quantity*sales.InvoiceLines.UnitPrice
	else 0 end) as Sales_1Q16,

sum(case
	when (YEAR(Sales.Invoices.InvoiceDate)=2015 and MONTH(Sales.Invoices.InvoiceDate) in (1,2,3))
	then sales.InvoiceLines.Quantity*sales.InvoiceLines.UnitPrice
	else 0 end) as Sales_1Q15,

(sum(case
	when (YEAR(Sales.Invoices.InvoiceDate)=2016 and MONTH(Sales.Invoices.InvoiceDate) in (1,2,3))
	then sales.InvoiceLines.Quantity*sales.InvoiceLines.UnitPrice
	else 0 end) /
sum(case
	when (YEAR(Sales.Invoices.InvoiceDate)=2015 and MONTH(Sales.Invoices.InvoiceDate) in (1,2,3))
	then sales.InvoiceLines.Quantity*sales.InvoiceLines.UnitPrice
	else 0 end) - 1)*100 as Annual_Sales_Growth

from
sales.Invoices
inner join sales.InvoiceLines on sales.InvoiceLines.InvoiceID = sales.Invoices.InvoiceID
	inner join sales.Customers on sales.Customers.CustomerID = sales.Invoices.CustomerID
		inner join sales.CustomerCategories on sales.CustomerCategories.CustomerCategoryID = sales.Customers.CustomerCategoryID

group by sales.CustomerCategories.CustomerCategoryName


