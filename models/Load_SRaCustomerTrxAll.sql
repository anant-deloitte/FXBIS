With Load_To_RA_CUSTOMER_TRX_ALL as 
(
    select * from BIS.ITSS_AR.RA_CUSTOMER_TRX_ALL 
)
select * from Load_To_RA_CUSTOMER_TRX_ALL