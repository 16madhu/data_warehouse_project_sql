/* stored procedure: load bronze layer
this includes the stored procedure which loads data into the bronze schema from csv files.
also include the bulk insertion rather than manually inserting every row using insert into---- (sql syntax).
*/

create or alter procedure bronze.load_bronze as
begin
declare @start_time datetime,@end_time datetime,@batch_start_time datetime,@batch_end_time datetime;
begin try
set @batch_start_time=getdate();
print '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';
print 'loading Bronze Layer';
print '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++';

print'-----------------------------------------------------------';
print'Loading CRM tables';
print '---------------------------------------------------------';
set @start_time=getdate();
print'Inserting data into:customer_info table';
bulk insert bronze.crm_cust_info
from 'C:\Users\Admin.DESKTOP-IAELC5G.000\Documents\DBS\source\cust_info.csv'
with (
 firstrow=2,
 fieldterminator=',',
 tablock 
 )
 set @end_time=getdate();
 print'--> insert duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
 print '-----------------------------------------------------';

 set @start_time=getdate();
 print'Inserting data into:product_info table';
 bulk insert bronze.crm_prd_info
from 'C:\Users\Admin.DESKTOP-IAELC5G.000\Documents\DBS\source\prd_info.csv'
with (
 firstrow=2,
 fieldterminator=',',
 tablock 
 )
 set @end_time=getdate();
 print'--> insert duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
 print '-----------------------------------------------------';

 set @start_time=getdate();
 print'Inserting data into:sales_details table';
 truncate table bronze.crm_sales_details;
 bulk insert bronze.crm_sales_details
from 'C:\Users\Admin.DESKTOP-IAELC5G.000\Documents\DBS\source\sales_details.csv'
with (
 firstrow=2,
 fieldterminator=',',
 tablock 
 )
 set @end_time=getdate();
 print'--> insert duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
 print '-----------------------------------------------------';

 set @start_time=getdate();
 print '---------------------------------------------------------';
 print'Loading ERP files';
 print '---------------------------------------------------------';
 print'Inserting data into:erp_customer table';
 bulk insert bronze.erp_cust_az12
from 'C:\Users\Admin.DESKTOP-IAELC5G.000\Documents\DBS\src_erp\CUST_AZ12.csv'
with (
 firstrow=2,
 fieldterminator=',',
 tablock 
 )
 set @end_time=getdate();
 print'--> insert duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
 print '-----------------------------------------------------';

 set @start_time=getdate();
 print'Inserting data into:erp_location table';
 bulk insert bronze.erp_loca101
from 'C:\Users\Admin.DESKTOP-IAELC5G.000\Documents\DBS\src_erp\LOC_A101.csv'
with (
 firstrow=2,
 fieldterminator=',',
 tablock 
 )
 set @end_time=getdate();
 print'--> insert duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
 print '-----------------------------------------------------';
 set @start_time=getdate();
 print'Inserting data into:erp_category table';
 bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\Admin.DESKTOP-IAELC5G.000\Documents\DBS\src_erp\PX_CAT_G1V2.csv'
with (
 firstrow=2,
 fieldterminator=',',
 tablock
 )
 set @end_time=getdate();
 print'--> insert duration:'+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
 print'-------------------------------------------------------';
 set @batch_end_time=getdate();
 print'==========================================================';
 print 'Loading bonze layer is completed';
 print 'total load duration:'+cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar)+'seconds';
 print'==========================================================';
 end try
 begin catch
 print '----------------------------------------';
 print 'Error Occured during loading bronze layer'
 print 'Error Message'+cast(error_message() as nvarchar);
 print 'Error Message'+cast(error_number() as nvarchar);
 print '----------------------------------------';
 end catch
 end
 exec bronze.load_bronze

