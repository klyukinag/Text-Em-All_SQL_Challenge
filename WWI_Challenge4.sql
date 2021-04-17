-- Challange 4
-- Q: Using "unit price" and "recommended retail price", which item in the warehouse has the lowest gross profit amount?
-- A: 3 kg Courier post bag (White) 300x190x95mm
-- Q: Which item has the highest?
-- A: Air cushion machine (Blue)
-- Q: What is the median gross profit across all items in the warehouse?
-- A: $8.91

-- Gross Profit = Revenue – Cost of Goods Sold
-- In this case Gross Profit = RecommendedRetailPrice-UnitPrice

-- Adding Profit_Margin column to Warehouse.StockItems
begin
if COL_LENGTH('Warehouse.StockItems','Gross_Profit') is Null
	alter table WideWorldImporters.Warehouse.StockItems
	add Gross_Profit as (RecommendedRetailPrice-UnitPrice)
end
go

-- Looking up the item with the highest profit margin
select 
Warehouse.StockItems.StockItemName,
Warehouse.StockItems.Gross_Profit as Item_With_Max_Gross_Profit
from Warehouse.StockItems
inner join(
select max(Warehouse.StockItems.Gross_Profit) as Query_Gross_Profit
from Warehouse.StockItems
)as Max_Gross_Profit
on Max_Gross_Profit.Query_Gross_Profit=Warehouse.StockItems.Gross_Profit

-- Looking up the item with the lowest profit margin
select 
Warehouse.StockItems.StockItemName,
Warehouse.StockItems.Gross_Profit as Item_With_Min_Gross_Profit
from Warehouse.StockItems
inner join(
select min(Warehouse.StockItems.Gross_Profit) as Query_Gross_Profit
from Warehouse.StockItems
)as Min_Gross_Profit
on Min_Gross_Profit.Query_Gross_Profit=Warehouse.StockItems.Gross_Profit

-- Looking up the median profit margin across all items in the warehouse - 
-- middle value separating the greater and lesser halves of a data set	
select
Gross_Profit as Median_Gross_Profit
from
	(
	select
	a.Gross_Profit as Gross_Profit,
	a.asc_Gross_Profit as asc_Gross_Profit,
	ROW_NUMBER() over (order by a.asc_Gross_Profit desc) as desc_Gross_Profit
	from
		(
		select
		Warehouse.StockItems.Gross_Profit,
		ROW_NUMBER() over (order by Warehouse.StockItems.Gross_Profit asc) as asc_Gross_Profit
		--ROW_NUMBER() over (order by Warehouse.StockItems.StockItemID asc) as asc_StockItemID
		from
		Warehouse.StockItems
		--order by Warehouse.StockItems.Gross_Profit
		) as a
	) as b
where b.asc_Gross_Profit in (b.desc_Gross_Profit,b.desc_Gross_Profit+1,b.desc_Gross_Profit-1)

-- == QA Section ==

-- Deleting Gross_Profit column
--alter table WideWorldImporters.Warehouse.StockItems
--drop column Gross_Profit

--select 
--Warehouse.StockItems.StockItemName,
--Warehouse.StockItems.Gross_Profit
--from Warehouse.StockItems

--order by Warehouse.StockItems.Gorss_Profit

