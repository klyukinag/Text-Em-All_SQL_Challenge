-- Challange 1
-- (Please refer to the excel file to see the Total Monthly Revenue vs. time plot)

select

YEAR(Sales.Invoices.InvoiceDate) as YYYY,
MONTH(Sales.Invoices.InvoiceDate) as MM,
SUM(sales.InvoiceLines.Quantity*sales.InvoiceLines.UnitPrice) as Monthly_Revenue

from
sales.Invoices
inner join sales.InvoiceLines on sales.InvoiceLines.InvoiceID = sales.Invoices.InvoiceID

group by YEAR(Sales.Invoices.InvoiceDate), MONTH(Sales.Invoices.InvoiceDate)

order by YYYY, MM

