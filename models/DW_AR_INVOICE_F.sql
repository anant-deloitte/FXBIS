With DW_AR_INVOICE_F as (
	Select * from {{ ref('LoadDwArInvoiceF_TGT_DwArInvoiceF') }}
    )
select * from DW_AR_INVOICE_F
