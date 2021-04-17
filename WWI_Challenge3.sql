-- Challange 3
-- Write a query to return the list of suppliers that WWI has purchased from,
-- along with # of invoices paid, # of invoices still outstanding, and average invoice amount.

select

Purchasing.Suppliers.SupplierName,
count(case when Purchasing.SupplierTransactions.OutstandingBalance=0 then Purchasing.SupplierTransactions.OutstandingBalance else Null end) as #_Invoices_Paid,
count(case when Purchasing.SupplierTransactions.OutstandingBalance>0 then Purchasing.SupplierTransactions.OutstandingBalance else Null end) as #_Outstanding_Invoices,
avg(Purchasing.SupplierTransactions.AmountExcludingTax) as Average_Invoice_Amount

from
Purchasing.Suppliers
inner join Purchasing.SupplierTransactions on Purchasing.Suppliers.SupplierID = Purchasing.SupplierTransactions.SupplierID

where Purchasing.SupplierTransactions.AmountExcludingTax>0 
	
group by Purchasing.Suppliers.SupplierName


