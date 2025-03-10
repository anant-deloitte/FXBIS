{{
	config(
		materialized='incremental',
		table='TGT_DwArInvoiceF',
		schema='',
		unique_key=['ARINV_TRX_ID','ARINV_LN_LINE_ID'] ,
		incremental_strategy='Merge'
		
	)
}}

With HashDwBillingTypeD_2_newDSSourceOut as (
	Select BILLING_TYPE_ORG_ID, 
		BILLING_TYPE_ARINV_TP_NAME, 
		ACCT_CODE, 
		BILLING_TYPE_SKEY, 
		BILLING_TYPE_L3_DESC
 from (SELECT BILLING_TYPE_ORG_ID,BILLING_TYPE_ARINV_TP_NAME,B.ACCT_CODE,BILLING_TYPE_SKEY,BILLING_TYPE_L3_DESC FROM ITSS_AR.DW_BILLING_TYPE_D, ITSS_AR.DW_ACCOUNT_D as B WHERE ( (BILLING_TYPE_RULE_ACCTCODE_NOT IS NULL AND BILLING_TYPE_RULE_ACCTCODE IS NULL) OR (BILLING_TYPE_RULE_ACCTCODE IS NOT NULL AND BILLING_TYPE_RULE_ACCTCODE_NOT IS NULL AND BILLING_TYPE_RULE_ACCTCODE = B.ACCT_CODE ) OR ( BILLING_TYPE_RULE_ACCTCODE IS NOT NULL AND BILLING_TYPE_RULE_ACCTCODE_NOT IS NOT NULL AND BILLING_TYPE_RULE_ACCTCODE <> B.ACCT_CODE ) ) )
 ),
S_RA_CUST_TRX_TYPES_ALLout as (
	select * from
	ITSS_AR.S_RA_CUST_TRX_TYPES_ALL
	) ,
SRC_SRaCustomerTrxAllOut as (
	Select * 
	from(
		SELECT COALESCE (rctl.customer_trx_line_id, -999) customer_trx_line_id, rctl.line_number, rctl.reason_code, rctl.inventory_item_id, replace (replace (replace (replace (rctl.description, chr (10), ''), chr (13), ''), ',', ' '), chr (9), ' ') description, rctl.previous_customer_trx_id, rctl.previous_customer_trx_line_id, rctl.quantity_ordered, rctl.quantity_credited, rctl.quantity_invoiced, rctl.unit_selling_price, rctl.sales_order, rctl.sales_order_line, rctl.sales_order_date, rctl.accounting_rule_id, rctl.accounting_rule_duration, rctl.attribute_category, replace (replace (rctl.attribute1, chr (10), ''), chr (13), '') attribute1, replace (replace (rctl.attribute2, chr (10), ''), chr (13), '') attribute2, replace (replace (rctl.attribute3, chr (10), ''), chr (13), '') attribute3, replace (replace (rctl.attribute4, chr (10), ''), chr (13), '') attribute4, replace (replace (rctl.attribute5, chr (10), ''), chr (13), '') attribute5, replace (replace (rctl.attribute6, chr (10), ''), chr (13), '') attribute6, replace (replace (rctl.attribute7, chr (10), ''), chr (13), '') attribute7, replace (replace (rctl.attribute8, chr (10), ''), chr (13), '') attribute8, replace (replace (rctl.attribute9, chr (10), ''), chr (13), '') attribute9, replace (replace (rctl.attribute10, chr (10), ''), chr (13), '') attribute10, rctl.rule_start_date, rctl.interface_line_context, rctl.interface_line_attribute1, rctl.interface_line_attribute2, rctl.interface_line_attribute3, rctl.interface_line_attribute4, rctl.interface_line_attribute5, rctl.interface_line_attribute6, rctl.interface_line_attribute7, rctl.interface_line_attribute8, rctl.revenue_amount, replace (replace (rctl.attribute11, chr (10), ''), chr (13), '') attribute11, replace (replace (rctl.attribute12, chr (10), ''), chr (13), '') attribute12, replace (replace (rctl.attribute13, chr (10), ''), chr (13), '') attribute13, replace (replace (rctl.attribute14, chr (10), ''), chr (13), '') attribute14, replace (replace (rctl.attribute15, chr (10), ''), chr (13), '') attribute15, rctl.memo_line_id, rctl.interface_line_attribute10, rctl.interface_line_attribute11, rctl.interface_line_attribute12, rctl.interface_line_attribute13, rctl.interface_line_attribute14, rctl.interface_line_attribute15, rctl.interface_line_attribute9, rctl.org_id, rbsa.name, rbsa.batch_source_type, rcta.customer_trx_id, rcta.trx_number, rcta.cust_trx_type_id, rcta.trx_date, rcta.bill_to_contact_id, rcta.batch_id, rcta.batch_source_id, rcta.reason_code, rcta.sold_to_customer_id, rcta.sold_to_contact_id, rcta.sold_to_site_use_id, rcta.bill_to_customer_id, rcta.bill_to_site_use_id, rcta.ship_to_customer_id, rcta.ship_to_contact_id, rcta.term_id, rcta.term_due_date, rcta.previous_customer_trx_id, rcta.primary_salesrep_id, rcta.territory_id, rcta.invoice_currency_code, rcta.attribute_category, replace (replace (rcta.attribute1, chr (10), ''), chr (13), '') attribute1, replace (replace (rcta.attribute2, chr (10), ''), chr (13), '') attribute2, replace (replace (rcta.attribute3, chr (10), ''), chr (13), '') attribute3, replace (replace (rcta.attribute4, chr (10), ''), chr (13), '') attribute4, replace (replace (rcta.attribute5, chr (10), ''), chr (13), '') attribute5, replace (replace (rcta.attribute6, chr (10), ''), chr (13), '') attribute6, replace (replace (rcta.attribute7, chr (10), ''), chr (13), '') attribute7, replace (replace (rcta.attribute8, chr (10), ''), chr (13), '') attribute8, replace (replace (rcta.attribute9, chr (10), ''), chr (13), '') attribute9, replace (replace (rcta.attribute10, chr (10), ''), chr (13), '') attribute10, rcta.finance_charges, rcta.complete_flag, replace (replace (rcta.attribute11, chr (10), ''), chr (13), '') attribute11, replace (replace (rcta.attribute12, chr (10), ''), chr (13), '') attribute12, replace (replace (rcta.attribute13, chr (10), ''), chr (13), '') attribute13, replace (replace (rcta.attribute14, chr (10), ''), chr (13), '') attribute14, replace (replace (rcta.attribute15, chr (10), ''), chr (13), '') attribute15, rcta.interface_header_attribute1, rcta.interface_header_attribute2, rcta.interface_header_attribute3, rcta.interface_header_attribute4, rcta.interface_header_attribute5, rcta.interface_header_attribute6, rcta.interface_header_attribute7, rcta.interface_header_attribute8, rcta.interface_header_context, rcta.interface_header_attribute10, rcta.interface_header_attribute11, rcta.interface_header_attribute12, rcta.interface_header_attribute13, rcta.interface_header_attribute14, rcta.interface_header_attribute15, rcta.interface_header_attribute9, rcta.org_id, rcta.global_attribute3, rctl.warehouse_id, rctl.extended_amount, rcta.exchange_date, rcta.exchange_rate, rcta.ship_to_site_use_id, rcta.ct_reference, rcta.last_update_date, rcta.last_updated_by, rcta.creation_date, rcta.created_by, rctl.last_update_date, rctl.last_updated_by, rctl.creation_date, rctl.created_by, rctl.line_type, rctl.taxable_flag, rctl.tax_precedence, rctl.tax_rate, rctl.tax_exemption_id, rctl.tax_exempt_flag, rctl.tax_exempt_number, rctl.tax_exempt_reason_code, rctl.tax_vendor_return_code, rctl.taxable_amount FROM ITSS_AR.s_ra_customer_trx_all rcta LEFT JOIN  ITSS_AR.s_ra_customer_trx_lines_all rctl ON rcta.customer_trx_id = rctl.customer_trx_id 
		LEFT JOIN ITSS_AR.s_ra_batch_sources_all rbsa ON rcta.batch_source_id = rbsa.batch_source_id  AND rcta.org_id = rbsa.org_id )) ,
		
SRC_SUsersROut as (
	/* SubQuery from Source ==>SRC_SUsersR */
Select 
user_id as user_id,
user_name as user_name
 from 
(SELECT
    user_id,
    user_name
 FROM
    ITSS_AR.S_USERS_R)
 ) ,
 LKP_DwCustAccountROut as (
	/* SubQuery from Source ==>LKP_DwCustAccountR */
Select 
CUST_ID as CUST_ID,
CUST_ORGID as CUST_ORGID,
CUST_NO as CUST_NO,
CUST_NAME as CUST_NAME
 from (
SELECT DW_CUST_ACCOUNT_R.CUST_ID,DW_CUST_ACCOUNT_R.CUST_ORGID,DW_CUST_ACCOUNT_R.CUST_NO,DW_CUST_ACCOUNT_R.CUST_NAME 
FROM ITSS_AR.DW_CUST_ACCOUNT_R 
WHERE (cust_orgid, cust_id) IN (
SELECT DISTINCT org_id, bill_to_customer_id FROM ITSS_AR.s_ra_customer_trx_all
))
) ,
LKP_DwArInvoiceTypeLkOut as (
	/* SubQuery from Source ==>LKP_DwArInvoiceTypeLk */
Select 
ORG_ID,
INVOICE_BATCH_SOURCE_ID,
BIS_INVOICE_TP
 from 
(SELECT
    *
 FROM
    ITSS_AR.DW_AR_INVOICE_TYPE_LK)
 ) ,
TMP_SRaCustTrxAll_newDSSourceOut3 as (
	Select CUSTOMER_TRX_LINE_ID as L_CUSTOMER_TRX_LINE_ID, 
		LINE_NUMBER as L_LINE_NUMBER, 
		REASON_CODE as L_REASON_CODE, 
		INVENTORY_ITEM_ID as L_INVENTORY_ITEM_ID, 
		DESCRIPTION as L_DESCRIPTION, 
		PREVIOUS_CUSTOMER_TRX_ID as L_PREVIOUS_CUSTOMER_TRX_ID, 
		PREVIOUS_CUSTOMER_TRX_LINE_ID as L_PREVIOUS_CUSTOMER_TRX_LINE_ID, 
		QUANTITY_ORDERED as L_QUANTITY_ORDERED, 
		QUANTITY_CREDITED as L_QUANTITY_CREDITED, 
		QUANTITY_INVOICED as L_QUANTITY_INVOICED, 
		UNIT_SELLING_PRICE as L_UNIT_SELLING_PRICE, 
		SALES_ORDER as L_SALES_ORDER, 
		SALES_ORDER_LINE as L_SALES_ORDER_LINE, 
		SALES_ORDER_DATE as L_SALES_ORDER_DATE, 
		ACCOUNTING_RULE_ID as L_ACCOUNTING_RULE_ID, 
		ACCOUNTING_RULE_DURATION as L_ACCOUNTING_RULE_DURATION, 
		ATTRIBUTE_CATEGORY as L_ATTRIBUTE_CATEGORY, 
		ATTRIBUTE1 as L_ATTRIBUTE1, 
		ATTRIBUTE2 as L_ATTRIBUTE2, 
		ATTRIBUTE3 as L_ATTRIBUTE3, 
		ATTRIBUTE4 as L_ATTRIBUTE4, 
		ATTRIBUTE5 as L_ATTRIBUTE5, 
		ATTRIBUTE6 as L_ATTRIBUTE6, 
		ATTRIBUTE7 as L_ATTRIBUTE7, 
		ATTRIBUTE8 as L_ATTRIBUTE8, 
		ATTRIBUTE9 as L_ATTRIBUTE9, 
		ATTRIBUTE10 as L_ATTRIBUTE10, 
		RULE_START_DATE as L_RULE_START_DATE, 
		INTERFACE_LINE_CONTEXT as L_INTERFACE_LINE_CONTEXT, 
		INTERFACE_LINE_ATTRIBUTE1 as L_INTERFACE_LINE_ATTRIBUTE1, 
		INTERFACE_LINE_ATTRIBUTE2 as L_INTERFACE_LINE_ATTRIBUTE2, 
		INTERFACE_LINE_ATTRIBUTE3 as L_INTERFACE_LINE_ATTRIBUTE3, 
		INTERFACE_LINE_ATTRIBUTE4 as L_INTERFACE_LINE_ATTRIBUTE4, 
		INTERFACE_LINE_ATTRIBUTE5 as L_INTERFACE_LINE_ATTRIBUTE5, 
		INTERFACE_LINE_ATTRIBUTE6 as L_INTERFACE_LINE_ATTRIBUTE6, 
		INTERFACE_LINE_ATTRIBUTE7 as L_INTERFACE_LINE_ATTRIBUTE7, 
		INTERFACE_LINE_ATTRIBUTE8 as L_INTERFACE_LINE_ATTRIBUTE8, 
		REVENUE_AMOUNT as L_REVENUE_AMOUNT, 
		ATTRIBUTE11 as L_ATTRIBUTE11, 
		ATTRIBUTE12 as L_ATTRIBUTE12, 
		ATTRIBUTE13 as L_ATTRIBUTE13, 
		ATTRIBUTE14 as L_ATTRIBUTE14, 
		ATTRIBUTE15 as L_ATTRIBUTE15, 
		MEMO_LINE_ID as L_MEMO_LINE_ID, 
		INTERFACE_LINE_ATTRIBUTE10 as L_INTERFACE_LINE_ATTRIBUTE10, 
		INTERFACE_LINE_ATTRIBUTE11 as L_INTERFACE_LINE_ATTRIBUTE11, 
		INTERFACE_LINE_ATTRIBUTE12 as L_INTERFACE_LINE_ATTRIBUTE12, 
		INTERFACE_LINE_ATTRIBUTE13 as L_INTERFACE_LINE_ATTRIBUTE13, 
		INTERFACE_LINE_ATTRIBUTE14 as L_INTERFACE_LINE_ATTRIBUTE14, 
		INTERFACE_LINE_ATTRIBUTE15 as L_INTERFACE_LINE_ATTRIBUTE15, 
		INTERFACE_LINE_ATTRIBUTE9 as L_INTERFACE_LINE_ATTRIBUTE9, 
		ORG_ID as L_ORG_ID, 
		NAME as B_NAME, 
		BATCH_SOURCE_TYPE as B_BATCH_SOURCE_TYPE, 
		CUSTOMER_TRX_ID ,
		TRX_NUMBER, 
		CUST_TRX_TYPE_ID, 
		TRX_DATE, 
		BILL_TO_CONTACT_ID, 
		BATCH_ID, 
		BATCH_SOURCE_ID, 
		REASON_CODE ,
		SOLD_TO_CUSTOMER_ID, 
		SOLD_TO_CONTACT_ID, 
		SOLD_TO_SITE_USE_ID, 
		BILL_TO_CUSTOMER_ID, 
		BILL_TO_SITE_USE_ID, 
		SHIP_TO_CUSTOMER_ID, 
		SHIP_TO_CONTACT_ID, 
		TERM_ID, 
		TERM_DUE_DATE, 
		PREVIOUS_CUSTOMER_TRX_ID ,
		PRIMARY_SALESREP_ID, 
		TERRITORY_ID, 
		INVOICE_CURRENCY_CODE, 
		ATTRIBUTE_CATEGORY ,
		ATTRIBUTE1 ,
		ATTRIBUTE2 ,
		ATTRIBUTE3 ,
		ATTRIBUTE4 ,
		ATTRIBUTE5 ,
		ATTRIBUTE6 ,
		ATTRIBUTE7 ,
		ATTRIBUTE8 ,
		ATTRIBUTE9 ,
		ATTRIBUTE10 ,
		FINANCE_CHARGES, 
		COMPLETE_FLAG, 
		ATTRIBUTE11 ,
		ATTRIBUTE12 ,
		ATTRIBUTE13 ,
		ATTRIBUTE14 ,
		ATTRIBUTE15 ,
		INTERFACE_HEADER_ATTRIBUTE1, 
		INTERFACE_HEADER_ATTRIBUTE2, 
		INTERFACE_HEADER_ATTRIBUTE3, 
		INTERFACE_HEADER_ATTRIBUTE4, 
		INTERFACE_HEADER_ATTRIBUTE5, 
		INTERFACE_HEADER_ATTRIBUTE6, 
		INTERFACE_HEADER_ATTRIBUTE7, 
		INTERFACE_HEADER_ATTRIBUTE8, 
		INTERFACE_HEADER_CONTEXT, 
		INTERFACE_HEADER_ATTRIBUTE10, 
		INTERFACE_HEADER_ATTRIBUTE11, 
		INTERFACE_HEADER_ATTRIBUTE12, 
		INTERFACE_HEADER_ATTRIBUTE13, 
		INTERFACE_HEADER_ATTRIBUTE14, 
		INTERFACE_HEADER_ATTRIBUTE15, 
		INTERFACE_HEADER_ATTRIBUTE9, 
		ORG_ID ,
		GLOBAL_ATTRIBUTE3, 
		WAREHOUSE_ID as L_WAREHOUSE_ID, 
		EXTENDED_AMOUNT as L_EXTENDED_AMOUNT, 
		EXCHANGE_DATE, 
		EXCHANGE_RATE, 
		SHIP_TO_SITE_USE_ID, 
		CT_REFERENCE, 
		LAST_UPDATE_DATE as HDR_LAST_UPDATE_DATE, 
		LAST_UPDATED_BY as HDR_LAST_UPDATED_BY, 
		CREATION_DATE as HDR_CREATION_DATE, 
		CREATED_BY as HDR_CREATED_BY, 
		LAST_UPDATE_DATE as LN_LAST_UPDATE_DATE, 
		LAST_UPDATED_BY as LN_LAST_UPDATED_BY, 
		CREATION_DATE as LN_CREATION_DATE, 
		CREATED_BY as LN_CREATED_BY, 
		LINE_TYPE as LN_LINE_TYPE, 
		TAXABLE_FLAG as LN_TAXABLE_FLAG, 
		TAX_PRECEDENCE as LN_TAX_PRECEDENCE, 
		TAX_RATE as LN_TAX_RATE, 
		TAX_EXEMPTION_ID as LN_TAX_EXEMPTION_ID, 
		TAX_EXEMPT_FLAG as LN_TAX_EXEMPT_FLAG, 
		TAX_EXEMPT_NUMBER as LN_TAX_EXEMPT_NUMBER, 
		TAX_EXEMPT_REASON_CODE as LN_TAX_EXEMPT_REASON_CODE, 
		TAX_VENDOR_RETURN_CODE as LN_TAX_VENDOR_RETURN_CODE, 
		TAXABLE_AMOUNT as LN_TAXABLE_AMOUNT
 from 
SRC_SRaCustomerTrxAllOut
 ),

HashDwArInvGLDistROut as (
	Select  * 
 from 
LoadDwArInvoiceF_DwArInvoiceGlDistR
 ),
HashDwConsInvLkROut as (
	select * 
from 
HashDwConsInvLkR 
),
DSstgVar_TFM_GetGlSegOut as (
	Select 
	from_tmp.* ,
	S_RA_CUST_TRX_TYPES_ALLout.* ,
	SRC_SUsersROut.* ,
	LKP_DwCustAccountROut.* ,
	LKP_DwArInvoiceTypeLkOut.* ,
	HashGLDist.* ,
	HashDwConsInvLkR.* ,
	COALESCE(HashGLDist.SEGMENT1, 'UNKNOWN') AS COY ,
	COALESCE(HashGLDist.SEGMENT2, 'UNKNOWN') AS CCTR ,
	COALESCE(HashGLDist.SEGMENT4, 'UNKNOWN') AS SUPPBR , 
	COALESCE(HashGLDist.SEGMENT5, 'UNKNOWN') AS GLPROD ,
	COALESCE(HashGLDist.SEGMENT3, 'UNKNOWN') AS ACCT ,
	COALESCE(HashGLDist.SEGMENT4, 'UNKNOWN') AS SUPPBR ,
	CASE  WHEN from_tmp.L_EXTENDED_AMOUNT IS NULL THEN NULL WHEN from_tmp.EXCHANGE_RATE IS NULL THEN COALESCE(from_tmp.L_EXTENDED_AMOUNT, 0) * 1
        ELSE COALESCE(from_tmp.L_EXTENDED_AMOUNT, 0) * from_tmp.EXCHANGE_RATE
    END AS	stgFuncCurrAmount
FROM
	 TMP_SRaCustTrxAll_newDSSourceOut3 as from_tmp 
 LEFT JOIN S_RA_CUST_TRX_TYPES_ALLout as S_RA_CUST_TRX_TYPES_ALLout 
ON from_tmp.ORG_ID = S_RA_CUST_TRX_TYPES_ALLout.ORG_ID 
	 
 LEFT JOIN SRC_SUsersROut as SRC_SUsersROut 
ON from_tmp.HDR_LAST_UPDATED_BY =SRC_SUsersROut.user_id 

 LEFT JOIN LKP_DwCustAccountROut as LKP_DwCustAccountROut 
ON from_tmp.BILL_TO_CUSTOMER_ID = LKP_DwCustAccountROut.CUST_ID AND  from_tmp.ORG_ID = LKP_DwCustAccountROut.CUST_ORGID

 LEFT JOIN LKP_DwArInvoiceTypeLkOut as LKP_DwArInvoiceTypeLkOut 
ON from_tmp.BATCH_SOURCE_ID = LKP_DwArInvoiceTypeLkOut.INVOICE_BATCH_SOURCE_ID  AND from_tmp.ORG_ID = LKP_DwArInvoiceTypeLkOut.ORG_ID

 LEFT JOIN HashDwArInvGLDistROut as HashGLDist 
ON from_tmp.CUSTOMER_TRX_ID = HashGLDist.CUSTOMER_TRX_ID AND from_tmp.L_CUSTOMER_TRX_LINE_ID = HashGLDist.CUSTOMER_TRX_LINE_ID

  LEFT JOIN HashDwConsInvLkR as HashDwConsInvLkR 
ON from_tmp.CUSTOMER_TRX_ID = HashDwConsInvLkR.CUSTOMER_TRX_ID AND from_tmp.TRX_NUMBER = HashDwConsInvLkR.TXN_NUMBER AND from_tmp.ORG_ID = HashDwConsInvLkR.ORG_ID
 
 ),


TFM_GetGlSegOut as (
	Select 
	 ORG_ID as ARINV_ORG_ID,
	 CUSTOMER_TRX_ID as ARINV_TRX_ID,
	 L_CUSTOMER_TRX_LINE_ID as ARINV_LN_LINE_ID,
	 TRX_DATE as ARINV_BUSDATE,
	 COY as ARINV_COY_CODE,
	 CCTR as ARINV_CCTR_CODE,
	 SUPPBR as ARINV_SUPP_BR_CODE,
	 GLPROD as ARINV_GL_PROD_CODE,
	 B_BATCH_SOURCE_TYPE as ARINV_BATCH_SRC_TP,
	 B_NAME as ARINV_BATCH_SRC_NAME,
	 BIS_INVOICE_TP as ARINV_BIS_INV_TP,
	 ACCOUNTING_AFFECT_FLAG as ARINV_TP_ACCT_AFFECT_FLG,
	 ALLOW_FREIGHT_FLAG as ARINV_TP_ALLOW_FREIGHT_FLG,
	 ALLOW_OVERAPPLICATION_FLAG as ARINV_TP_ALLOW_OVRAPPN_FLG,
	 ATTRIBUTE_CATEGORY as ARINV_TP_ATTR_CAT,
	 ATTRIBUTE1 as ARINV_TP_ATTR1,
	 ATTRIBUTE10 as ARINV_TP_ATTR10,
	 ATTRIBUTE11 as ARINV_TP_ATTR11,
	 ATTRIBUTE12 as ARINV_TP_ATTR12,
	 ATTRIBUTE13 as ARINV_TP_ATTR13,
	 ATTRIBUTE14 as ARINV_TP_ATTR14,
	 ATTRIBUTE15 as ARINV_TP_ATTR15,
	 ATTRIBUTE2 as ARINV_TP_ATTR2,
	 ATTRIBUTE3 as ARINV_TP_ATTR3,
	 ATTRIBUTE4 as ARINV_TP_ATTR4,
	 ATTRIBUTE5 as ARINV_TP_ATTR5,
	 ATTRIBUTE6 as ARINV_TP_ATTR6,
	 ATTRIBUTE7 as ARINV_TP_ATTR7,
	 ATTRIBUTE8 as ARINV_TP_ATTR8,
	 ATTRIBUTE9 as ARINV_TP_ATTR9,
	 CREATION_SIGN as ARINV_TP_CREATION_SIGN,
	 CREDIT_MEMO_TYPE_ID as ARINV_TP_CREDIT_MEMO_TYPE_ID,
	 DESCRIPTION as ARINV_TP_DESC,
	 END_DATE as ARINV_TP_END_DATE,
	 GL_ID_CLEARING as ARINV_TP_GLID_CLEARING,
	 GL_ID_REC as ARINV_TP_GLID_REC,
	 GL_ID_REV as ARINV_TP_GLID_REV,
	 GL_ID_TAX as ARINV_TP_GLID_TAX,
	 GL_ID_UNBILLED as ARINV_TP_GLID_UNBILLED,
	 GL_ID_UNEARNED as ARINV_TP_GLID_UNEARNED,
	 NAME as ARINV_TP_NAME,
	 ORG_ID as ARINV_TP_ORG_ID,
	 POST_TO_GL as ARINV_TP_POST_TO_GL,
	 START_DATE as ARINV_TP_START_DATE,
	 TYPE as ARINV_TP_TP,
	 ATTRIBUTE_CATEGORY as ARINV_ATTR_CAT,
	 ATTRIBUTE1 as ARINV_ATTR1,
	 ATTRIBUTE10 as ARINV_ATTR10,
	 ATTRIBUTE11 as ARINV_ATTR11,
	 ATTRIBUTE12 as ARINV_ATTR12,
	 ATTRIBUTE13 as ARINV_ATTR13,
	 ATTRIBUTE14 as ARINV_ATTR14,
	 ATTRIBUTE15 as ARINV_ATTR15,
	 ATTRIBUTE2 as ARINV_ATTR2,
	 ATTRIBUTE3 as ARINV_ATTR3,
	 ATTRIBUTE4 as ARINV_ATTR4,
	 ATTRIBUTE5 as ARINV_ATTR5,
	 ATTRIBUTE6 as ARINV_ATTR6,
	 ATTRIBUTE7 as ARINV_ATTR7,
	 ATTRIBUTE8 as ARINV_ATTR8,
	 ATTRIBUTE9 as ARINV_ATTR9,
	 BATCH_ID as ARINV_BATCH_ID,
	 BATCH_SOURCE_ID as ARINV_BATCH_SOURCE_ID,
	 BILL_TO_CONTACT_ID as ARINV_BILL_TO_CONTACT_ID,
	 BILL_TO_CUSTOMER_ID as ARINV_BILL_TO_CUST_ID,
	 BILL_TO_SITE_USE_ID as ARINV_BILL_TO_SITE_USE_ID,
	 COMPLETE_FLAG as ARINV_COMPLETE_FLG,
	 CUST_TRX_TYPE_ID as ARINV_TYPE_ID,
	 FINANCE_CHARGES as ARINV_FINANCE_CHARGES,
	 INTERFACE_HEADER_ATTRIBUTE1 as ARINV_ITF_HEADER_ATTR1,
	 INTERFACE_HEADER_ATTRIBUTE10 as ARINV_ITF_HEADER_ATTR10,
	 INTERFACE_HEADER_ATTRIBUTE11 as ARINV_ITF_HEADER_ATTR11,
	 INTERFACE_HEADER_ATTRIBUTE12 as ARINV_ITF_HEADER_ATTR12,
	 INTERFACE_HEADER_ATTRIBUTE13 as ARINV_ITF_HEADER_ATTR13,
	 INTERFACE_HEADER_ATTRIBUTE14 as ARINV_ITF_HEADER_ATTR14,
	 INTERFACE_HEADER_ATTRIBUTE15 as ARINV_ITF_HEADER_ATTR15,
	 INTERFACE_HEADER_ATTRIBUTE2 as ARINV_ITF_HEADER_ATTR2,
	 INTERFACE_HEADER_ATTRIBUTE3 as ARINV_ITF_HEADER_ATTR3,
	 INTERFACE_HEADER_ATTRIBUTE4 as ARINV_ITF_HEADER_ATTR4,
	 INTERFACE_HEADER_ATTRIBUTE5 as ARINV_ITF_HEADER_ATTR5,
	 INTERFACE_HEADER_ATTRIBUTE6 as ARINV_ITF_HEADER_ATTR6,
	 INTERFACE_HEADER_ATTRIBUTE7 as ARINV_ITF_HEADER_ATTR7,
	 INTERFACE_HEADER_ATTRIBUTE8 as ARINV_ITF_HEADER_ATTR8,
	 INTERFACE_HEADER_ATTRIBUTE9 as ARINV_ITF_HEADER_ATTR9,
	 INTERFACE_HEADER_CONTEXT as ARINV_ITF_HEADER_CT,
	 INVOICE_CURRENCY_CODE as ARINV_INV_CURRENCY_CD,
	 PREVIOUS_CUSTOMER_TRX_ID as ARINV_PREV_CUST_TXN_ID,
	 PRIMARY_SALESREP_ID as ARINV_PRI_SALESREP_ID,
	 REASON_CODE as ARINV_REASON_CD,
	 SHIP_TO_CONTACT_ID as ARINV_SHIP_TO_CONTACT_ID,
	 SHIP_TO_CUSTOMER_ID as ARINV_SHIP_TO_CUST_ID,
	 SHIP_TO_SITE_USE_ID as ARINV_SHIP_TO_SITE_USE_ID,
	 SOLD_TO_CONTACT_ID as ARINV_SOLD_TO_CONTACT_ID,
	 SOLD_TO_CUSTOMER_ID as ARINV_SOLD_TO_CUST_ID,
	 SOLD_TO_SITE_USE_ID as ARINV_SOLD_TO_SITE_USE_ID,
	 TERM_DUE_DATE as ARINV_TERM_DUE_DATE,
	 TERM_ID as ARINV_TERM_ID,
	 TERRITORY_ID as ARINV_TERRITORY_ID,
	 TRX_DATE as ARINV_TXN_DATE,
	 TRX_NUMBER as ARINV_TXN_NUMBER,
	 L_ACCOUNTING_RULE_DURATION as ARINV_LN_ACCT_RULE_DURATION,
	 L_ACCOUNTING_RULE_ID as ARINV_LN_ACCT_RULE_ID,
	 L_ATTRIBUTE_CATEGORY as ARINV_LN_ATTR_CAT,
	 L_ATTRIBUTE1 as ARINV_LN_ATTR1,
	 L_ATTRIBUTE10 as ARINV_LN_ATTR10,
	 L_ATTRIBUTE11 as ARINV_LN_ATTR11,
	 L_ATTRIBUTE12 as ARINV_LN_ATTR12,
	 L_ATTRIBUTE13 as ARINV_LN_ATTR13,
	 L_ATTRIBUTE14 as ARINV_LN_ATTR14,
	 L_ATTRIBUTE15 as ARINV_LN_ATTR15,
	 L_ATTRIBUTE2 as ARINV_LN_ATTR2,
	 L_ATTRIBUTE3 as ARINV_LN_ATTR3,
	 L_ATTRIBUTE4 as ARINV_LN_ATTR4,
	 L_ATTRIBUTE5 as ARINV_LN_ATTR5,
	 L_ATTRIBUTE6 as ARINV_LN_ATTR6,
	 L_ATTRIBUTE7 as ARINV_LN_ATTR7,
	 L_ATTRIBUTE8 as ARINV_LN_ATTR8,
	 L_ATTRIBUTE9 as ARINV_LN_ATTR9,
	 L_DESCRIPTION as ARINV_LN_DESC,
	 L_INTERFACE_LINE_ATTRIBUTE1 as ARINV_LN_ITF_LN_ATTR1,
	 L_INTERFACE_LINE_ATTRIBUTE10 as ARINV_LN_ITF_LN_ATTR10,
	 L_INTERFACE_LINE_ATTRIBUTE11 as ARINV_LN_ITF_LN_ATTR11,
	 L_INTERFACE_LINE_ATTRIBUTE12 as ARINV_LN_ITF_LN_ATTR12,
	 L_INTERFACE_LINE_ATTRIBUTE13 as ARINV_LN_ITF_LN_ATTR13,
	 L_INTERFACE_LINE_ATTRIBUTE14 as ARINV_LN_ITF_LN_ATTR14,
	 L_INTERFACE_LINE_ATTRIBUTE15 as ARINV_LN_ITF_LN_ATTR15,
	 L_INTERFACE_LINE_ATTRIBUTE2 as ARINV_LN_ITF_LN_ATTR2,
	 L_INTERFACE_LINE_ATTRIBUTE3 as ARINV_LN_ITF_LN_ATTR3,
	 L_INTERFACE_LINE_ATTRIBUTE4 as ARINV_LN_ITF_LN_ATTR4,
	 L_INTERFACE_LINE_ATTRIBUTE5 as ARINV_LN_ITF_LN_ATTR5,
	 L_INTERFACE_LINE_ATTRIBUTE6 as ARINV_LN_ITF_LN_ATTR6,
	 L_INTERFACE_LINE_ATTRIBUTE7 as ARINV_LN_ITF_LN_ATTR7,
	 L_INTERFACE_LINE_ATTRIBUTE8 as ARINV_LN_ITF_LN_ATTR8,
	 L_INTERFACE_LINE_ATTRIBUTE9 as ARINV_LN_ITF_LN_ATTR9,
	 L_INTERFACE_LINE_CONTEXT as ARINV_LN_ITF_LN_CT,
	 L_INVENTORY_ITEM_ID as ARINV_LN_INVEN_ITEM_ID,
	 L_MEMO_LINE_ID as ARINV_LN_MEMO_LN_ID,
	 L_ORG_ID as ARINV_LN_ORG_ID,
	 L_PREVIOUS_CUSTOMER_TRX_ID as ARINV_LN_PREV_CUST_TXN_ID,
	 L_PREVIOUS_CUSTOMER_TRX_LINE_ID as ARINV_LN_PREV_CUST_TXN_LN_ID,
	 L_QUANTITY_CREDITED as ARINV_LN_QTY_CREDITED,
	 L_QUANTITY_INVOICED as ARINV_LN_QTY_INVOICED,
	 L_QUANTITY_ORDERED as ARINV_LN_QTY_ORDERED,
	 L_REASON_CODE as ARINV_LN_REASON_CD,
	 L_REVENUE_AMOUNT as ARINV_LN_REVENUE_AMT,
	 L_RULE_START_DATE as ARINV_LN_RULE_START_DATE,
	 L_SALES_ORDER as ARINV_LN_SALES_ORDER,
	 L_SALES_ORDER_DATE as ARINV_LN_SALES_ORDER_DATE,
	 L_SALES_ORDER_LINE as ARINV_LN_SALES_ORDER_LN,
	 L_UNIT_SELLING_PRICE as ARINV_LN_UNIT_SELLING_PRICE,
	 TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD') || ' ' || TO_CHAR(CURRENT_TIME, 'HH24:MI:SS')  as LAST_UPD_DATE,
	 L_LINE_NUMBER as ARINV_LN_LINE_NUMBER,
	 GLOBAL_ATTRIBUTE3 as PRINT_DATE,
	 GL_POSTED_DATE as GL_POSTED_DATE,
	 CASE  WHEN CONS_BILLING_NUMBER IS NULL THEN TRX_NUMBER ELSE CONS_BILLING_NUMBER END as INV_NUMBER,
	 ACCT as ARINV_ACCT_CODE,
	 CUST_NO as ARINV_BILL_TO_CUST_NO,
	 CUST_NAME as ARINV_BILL_TO_CUST_NAME,
	 ACCTD_AMOUNT as ACCTD_AMOUNT,
	 L_WAREHOUSE_ID as ARINV_LN_WAREHOUSE_ID,
	 EXCHANGE_DATE as ARINV_EXCHANGE_DATE,
	 EXCHANGE_RATE as ARINV_EXCHANGE_RATE,
	 L_EXTENDED_AMOUNT as ARINV_INV_CURR_AMOUNT,
	 ROUND(stgFuncCurrAmount, 3) as ARINV_FUNC_CURR_AMOUNT,
	 CT_REFERENCE as ARINV_CT_REFERENCE,
	 HDR_LAST_UPDATE_DATE as HDR_LAST_UPDATE_DATE,
	 user_name as HDR_LAST_UPDATED_BY,
	 HDR_CREATION_DATE as HDR_CREATION_DATE,
	 user_name as HDR_CREATED_BY,
	 LN_LAST_UPDATE_DATE as LN_LAST_UPDATE_DATE,
	 user_name as LN_LAST_UPDATED_BY,
	 LN_CREATION_DATE as LN_CREATION_DATE,
	 user_name as LN_CREATED_BY,
	 LN_LINE_TYPE as LN_LINE_TYPE,
	 LN_TAXABLE_FLAG as LN_TAXABLE_FLAG,
	 LN_TAX_PRECEDENCE as LN_TAX_PRECEDENCE,
	 LN_TAX_RATE as LN_TAX_RATE,
	 LN_TAX_EXEMPTION_ID as LN_TAX_EXEMPTION_ID,
	 LN_TAX_EXEMPT_FLAG as LN_TAX_EXEMPT_FLAG,
	 LN_TAX_EXEMPT_NUMBER as LN_TAX_EXEMPT_NUMBER,
	 LN_TAX_EXEMPT_REASON_CODE as LN_TAX_EXEMPT_REASON_CODE,
	 LN_TAX_VENDOR_RETURN_CODE as LN_TAX_VENDOR_RETURN_CODE,
	 LN_TAXABLE_AMOUNT as LN_TAXABLE_AMOUNT
From DSstgVar_TFM_GetGlSegOut as DSstgVar_TFM_GetGlSegOut),

DSstgVar_TFM_GetBillingRepOut as (
	select 
		from_TFM1.* ,
		CASE WHEN from_TFM1.ARINV_INV_CURR_AMOUNT IS NULL THEN NULL  WHEN from_TFM1.ARINV_EXCHANGE_RATE IS NULL THEN COALESCE(from_TFM1.ARINV_INV_CURR_AMOUNT, 0) * 1
        ELSE COALESCE(from_TFM1.ARINV_INV_CURR_AMOUNT, 0) * from_TFM1.ARINV_EXCHANGE_RATE END AS stgFuncCurrAmount ,
		HashDwBillingTypeD.* 
		from TFM_GetGlSegOut as from_TFM1 
		LEFT JOIN HashDwBillingTypeD_2_newDSSourceOut as HashDwBillingTypeD
		ON from_TFM1.ARINV_ORG_ID = HashDwBillingTypeD.BILLING_TYPE_ORG_ID AND from_TFM1.ARINV_TP_NAME = HashDwBillingTypeD.BILLING_TYPE_ARINV_TP_NAME AND from_TFM1.ARINV_COY_CODE = HashDwBillingTypeD.ACCT_CODE
),

TFM_GetBillingRepOut as (
select 
	ARINV_ORG_ID
	,ARINV_TRX_ID
	,ARINV_LN_LINE_ID
	,ARINV_BUSDATE
	,ARINV_COY_CODE
	,ARINV_CCTR_CODE
	,ARINV_SUPP_BR_CODE
	,ARINV_GL_PROD_CODE
	,ARINV_BATCH_SRC_TP
	,ARINV_BATCH_SRC_NAME
	,ARINV_BIS_INV_TP
	,ARINV_TP_ACCT_AFFECT_FLG
	,ARINV_TP_ALLOW_FREIGHT_FLG
	,ARINV_TP_ALLOW_OVRAPPN_FLG
	,ARINV_TP_ATTR_CAT
	,ARINV_TP_ATTR1
	,ARINV_TP_ATTR10
	,ARINV_TP_ATTR11
	,ARINV_TP_ATTR12
	,ARINV_TP_ATTR13
	,ARINV_TP_ATTR14
	,ARINV_TP_ATTR15
	,ARINV_TP_ATTR2
	,ARINV_TP_ATTR3
	,ARINV_TP_ATTR4
	,ARINV_TP_ATTR5
	,ARINV_TP_ATTR6
	,ARINV_TP_ATTR7
	,ARINV_TP_ATTR8
	,ARINV_TP_ATTR9
	,ARINV_TP_CREATION_SIGN
	,ARINV_TP_CREDIT_MEMO_TYPE_ID
	,ARINV_TP_DESC
	,ARINV_TP_END_DATE
	,ARINV_TP_GLID_CLEARING
	,ARINV_TP_GLID_REC
	,ARINV_TP_GLID_REV
	,ARINV_TP_GLID_TAX
	,ARINV_TP_GLID_UNBILLED
	,ARINV_TP_GLID_UNEARNED
	,ARINV_TP_NAME
	,ARINV_TP_ORG_ID
	,ARINV_TP_POST_TO_GL
	,ARINV_TP_START_DATE
	,ARINV_TP_TP
	,ARINV_ATTR_CAT
	,ARINV_ATTR1
	,ARINV_ATTR10
	,ARINV_ATTR11
	,ARINV_ATTR12
	,ARINV_ATTR13
	,ARINV_ATTR14
	,ARINV_ATTR15
	,ARINV_ATTR2
	,ARINV_ATTR3
	,ARINV_ATTR4
	,ARINV_ATTR5
	,ARINV_ATTR6
	,ARINV_ATTR7
	,ARINV_ATTR8
	,ARINV_ATTR9
	,ARINV_BATCH_ID
	,ARINV_BATCH_SOURCE_ID
	,ARINV_BILL_TO_CONTACT_ID
	,ARINV_BILL_TO_CUST_ID
	,ARINV_BILL_TO_SITE_USE_ID
	,ARINV_COMPLETE_FLG
	,ARINV_TYPE_ID
	,ARINV_FINANCE_CHARGES
	,ARINV_ITF_HEADER_ATTR1
	,ARINV_ITF_HEADER_ATTR10
	,ARINV_ITF_HEADER_ATTR11
	,ARINV_ITF_HEADER_ATTR12
	,ARINV_ITF_HEADER_ATTR13
	,ARINV_ITF_HEADER_ATTR14
	,ARINV_ITF_HEADER_ATTR15
	,ARINV_ITF_HEADER_ATTR2
	,ARINV_ITF_HEADER_ATTR3
	,ARINV_ITF_HEADER_ATTR4
	,ARINV_ITF_HEADER_ATTR5
	,ARINV_ITF_HEADER_ATTR6
	,ARINV_ITF_HEADER_ATTR7
	,ARINV_ITF_HEADER_ATTR8
	,ARINV_ITF_HEADER_ATTR9
	,ARINV_ITF_HEADER_CT
	,ARINV_INV_CURRENCY_CD
	,ARINV_PREV_CUST_TXN_ID
	,ARINV_PRI_SALESREP_ID
	,ARINV_REASON_CD
	,ARINV_SHIP_TO_CONTACT_ID
	,ARINV_SHIP_TO_CUST_ID
	,ARINV_SHIP_TO_SITE_USE_ID
	,ARINV_SOLD_TO_CONTACT_ID
	,ARINV_SOLD_TO_CUST_ID
	,ARINV_SOLD_TO_SITE_USE_ID
	,ARINV_TERM_DUE_DATE
	,ARINV_TERM_ID
	,ARINV_TERRITORY_ID
	,ARINV_TXN_DATE
	,ARINV_TXN_NUMBER
	,ARINV_LN_ACCT_RULE_DURATION
	,ARINV_LN_ACCT_RULE_ID
	,ARINV_LN_ATTR_CAT
	,ARINV_LN_ATTR1
	,ARINV_LN_ATTR10
	,ARINV_LN_ATTR11
	,ARINV_LN_ATTR12
	,ARINV_LN_ATTR13
	,ARINV_LN_ATTR14
	,ARINV_LN_ATTR15
	,ARINV_LN_ATTR2
	,ARINV_LN_ATTR3
	,ARINV_LN_ATTR4
	,ARINV_LN_ATTR5
	,ARINV_LN_ATTR6
	,ARINV_LN_ATTR7
	,ARINV_LN_ATTR8
	,ARINV_LN_ATTR9
	,ARINV_LN_DESC
	,ARINV_LN_ITF_LN_ATTR1
	,ARINV_LN_ITF_LN_ATTR10
	,ARINV_LN_ITF_LN_ATTR11
	,ARINV_LN_ITF_LN_ATTR12
	,ARINV_LN_ITF_LN_ATTR13
	,ARINV_LN_ITF_LN_ATTR14
	,ARINV_LN_ITF_LN_ATTR15
	,ARINV_LN_ITF_LN_ATTR2
	,ARINV_LN_ITF_LN_ATTR3
	,ARINV_LN_ITF_LN_ATTR4
	,ARINV_LN_ITF_LN_ATTR5
	,ARINV_LN_ITF_LN_ATTR6
	,ARINV_LN_ITF_LN_ATTR7
	,ARINV_LN_ITF_LN_ATTR8
	,ARINV_LN_ITF_LN_ATTR9
	,ARINV_LN_ITF_LN_CT
	,ARINV_LN_INVEN_ITEM_ID
	,ARINV_LN_MEMO_LN_ID
	,ARINV_LN_ORG_ID
	,ARINV_LN_PREV_CUST_TXN_ID
	,ARINV_LN_PREV_CUST_TXN_LN_ID
	,ARINV_LN_QTY_CREDITED
	,ARINV_LN_QTY_INVOICED
	,ARINV_LN_QTY_ORDERED
	,ARINV_LN_REASON_CD
	,ARINV_LN_REVENUE_AMT
	,ARINV_LN_RULE_START_DATE
	,ARINV_LN_SALES_ORDER
	,ARINV_LN_SALES_ORDER_DATE
	,ARINV_LN_SALES_ORDER_LN
	,ARINV_LN_UNIT_SELLING_PRICE
	,LAST_UPD_DATE
	,ARINV_LN_LINE_NUMBER
	,PRINT_DATE
	,GL_POSTED_DATE
	,INV_NUMBER
	,ARINV_ACCT_CODE
	,ARINV_BILL_TO_CUST_NO
	,ARINV_BILL_TO_CUST_NAME
	,ACCTD_AMOUNT
	,ARINV_LN_WAREHOUSE_ID
	,ARINV_EXCHANGE_DATE
	,ARINV_EXCHANGE_RATE
	,ARINV_INV_CURR_AMOUNT
	,ROUND(stgFuncCurrAmount, 3) as ARINV_FUNC_CURR_AMOUNT
	,CASE WHEN ARINV_COMPLETE_FLG = 'N' THEN NULL ELSE BILLING_TYPE_SKEY END AS BILLING_TYPE_SKEY
	,CASE  WHEN ARINV_COMPLETE_FLG = 'N' THEN NULL  ELSE BILLING_TYPE_L3_DESC END AS BILLING_TYPE_L3_DESC
	,ARINV_CT_REFERENCE
	,ARINV_HDR_LAST_UPDATE_DATE
	,ARINV_HDR_LAST_UPDATED_BY
	,ARINV_HDR_CREATION_DATE
	,ARINV_HDR_CREATED_BY
	,ARINV_LN_LAST_UPDATE_DATE
	,ARINV_LN_LAST_UPDATED_BY
	,ARINV_LN_CREATION_DATE
	,ARINV_LN_CREATED_BY
	,ARINV_LN_LINE_TYPE
	,ARINV_LN_TAXABLE_FLAG
	,ARINV_LN_TAX_PRECEDENCE
	,ARINV_LN_TAX_RATE
	,ARINV_LN_TAX_EXEMPTION_ID
	,ARINV_LN_TAX_EXEMPT_FLAG
	,ARINV_LN_TAX_EXEMPT_NUMBER
	,ARINV_LN_TAX_EXEMPT_REASONCODE
	,ARINV_LN_TAX_VENDOR_RETURNCODE
	,ARINV_LN_TAXABLE_AMOUNT
from DSstgVar_TFM_GetBillingRepOut
)
select 
	ARINV_ORG_ID
	,ARINV_TRX_ID
	,ARINV_LN_LINE_ID
	,ARINV_BUSDATE
	,ARINV_COY_CODE
	,ARINV_CCTR_CODE
	,ARINV_SUPP_BR_CODE
	,ARINV_GL_PROD_CODE
	,ARINV_BATCH_SRC_TP
	,ARINV_BATCH_SRC_NAME
	,ARINV_BIS_INV_TP
	,ARINV_TP_ACCT_AFFECT_FLG
	,ARINV_TP_ALLOW_FREIGHT_FLG
	,ARINV_TP_ALLOW_OVRAPPN_FLG
	,ARINV_TP_ATTR_CAT
	,ARINV_TP_ATTR1
	,ARINV_TP_ATTR10
	,ARINV_TP_ATTR11
	,ARINV_TP_ATTR12
	,ARINV_TP_ATTR13
	,ARINV_TP_ATTR14
	,ARINV_TP_ATTR15
	,ARINV_TP_ATTR2
	,ARINV_TP_ATTR3
	,ARINV_TP_ATTR4
	,ARINV_TP_ATTR5
	,ARINV_TP_ATTR6
	,ARINV_TP_ATTR7
	,ARINV_TP_ATTR8
	,ARINV_TP_ATTR9
	,ARINV_TP_CREATION_SIGN
	,ARINV_TP_CREDIT_MEMO_TYPE_ID
	,ARINV_TP_DESC
	,ARINV_TP_END_DATE
	,ARINV_TP_GLID_CLEARING
	,ARINV_TP_GLID_REC
	,ARINV_TP_GLID_REV
	,ARINV_TP_GLID_TAX
	,ARINV_TP_GLID_UNBILLED
	,ARINV_TP_GLID_UNEARNED
	,ARINV_TP_NAME
	,ARINV_TP_ORG_ID
	,ARINV_TP_POST_TO_GL
	,ARINV_TP_START_DATE
	,ARINV_TP_TP
	,ARINV_ATTR_CAT
	,ARINV_ATTR1
	,ARINV_ATTR10
	,ARINV_ATTR11
	,ARINV_ATTR12
	,ARINV_ATTR13
	,ARINV_ATTR14
	,ARINV_ATTR15
	,ARINV_ATTR2
	,ARINV_ATTR3
	,ARINV_ATTR4
	,ARINV_ATTR5
	,ARINV_ATTR6
	,ARINV_ATTR7
	,ARINV_ATTR8
	,ARINV_ATTR9
	,ARINV_BATCH_ID
	,ARINV_BATCH_SOURCE_ID
	,ARINV_BILL_TO_CONTACT_ID
	,ARINV_BILL_TO_CUST_ID
	,ARINV_BILL_TO_SITE_USE_ID
	,ARINV_COMPLETE_FLG
	,ARINV_TYPE_ID
	,ARINV_FINANCE_CHARGES
	,ARINV_ITF_HEADER_ATTR1
	,ARINV_ITF_HEADER_ATTR10
	,ARINV_ITF_HEADER_ATTR11
	,ARINV_ITF_HEADER_ATTR12
	,ARINV_ITF_HEADER_ATTR13
	,ARINV_ITF_HEADER_ATTR14
	,ARINV_ITF_HEADER_ATTR15
	,ARINV_ITF_HEADER_ATTR2
	,ARINV_ITF_HEADER_ATTR3
	,ARINV_ITF_HEADER_ATTR4
	,ARINV_ITF_HEADER_ATTR5
	,ARINV_ITF_HEADER_ATTR6
	,ARINV_ITF_HEADER_ATTR7
	,ARINV_ITF_HEADER_ATTR8
	,ARINV_ITF_HEADER_ATTR9
	,ARINV_ITF_HEADER_CT
	,ARINV_INV_CURRENCY_CD
	,ARINV_PREV_CUST_TXN_ID
	,ARINV_PRI_SALESREP_ID
	,ARINV_REASON_CD
	,ARINV_SHIP_TO_CONTACT_ID
	,ARINV_SHIP_TO_CUST_ID
	,ARINV_SHIP_TO_SITE_USE_ID
	,ARINV_SOLD_TO_CONTACT_ID
	,ARINV_SOLD_TO_CUST_ID
	,ARINV_SOLD_TO_SITE_USE_ID
	,ARINV_TERM_DUE_DATE
	,ARINV_TERM_ID
	,ARINV_TERRITORY_ID
	,ARINV_TXN_DATE
	,ARINV_TXN_NUMBER
	,ARINV_LN_ACCT_RULE_DURATION
	,ARINV_LN_ACCT_RULE_ID
	,ARINV_LN_ATTR_CAT
	,ARINV_LN_ATTR1
	,ARINV_LN_ATTR10
	,ARINV_LN_ATTR11
	,ARINV_LN_ATTR12
	,ARINV_LN_ATTR13
	,ARINV_LN_ATTR14
	,ARINV_LN_ATTR15
	,ARINV_LN_ATTR2
	,ARINV_LN_ATTR3
	,ARINV_LN_ATTR4
	,ARINV_LN_ATTR5
	,ARINV_LN_ATTR6
	,ARINV_LN_ATTR7
	,ARINV_LN_ATTR8
	,ARINV_LN_ATTR9
	,ARINV_LN_DESC
	,ARINV_LN_ITF_LN_ATTR1
	,ARINV_LN_ITF_LN_ATTR10
	,ARINV_LN_ITF_LN_ATTR11
	,ARINV_LN_ITF_LN_ATTR12
	,ARINV_LN_ITF_LN_ATTR13
	,ARINV_LN_ITF_LN_ATTR14
	,ARINV_LN_ITF_LN_ATTR15
	,ARINV_LN_ITF_LN_ATTR2
	,ARINV_LN_ITF_LN_ATTR3
	,ARINV_LN_ITF_LN_ATTR4
	,ARINV_LN_ITF_LN_ATTR5
	,ARINV_LN_ITF_LN_ATTR6
	,ARINV_LN_ITF_LN_ATTR7
	,ARINV_LN_ITF_LN_ATTR8
	,ARINV_LN_ITF_LN_ATTR9
	,ARINV_LN_ITF_LN_CT
	,ARINV_LN_INVEN_ITEM_ID
	,ARINV_LN_MEMO_LN_ID
	,ARINV_LN_ORG_ID
	,ARINV_LN_PREV_CUST_TXN_ID
	,ARINV_LN_PREV_CUST_TXN_LN_ID
	,ARINV_LN_QTY_CREDITED
	,ARINV_LN_QTY_INVOICED
	,ARINV_LN_QTY_ORDERED
	,ARINV_LN_REASON_CD
	,ARINV_LN_REVENUE_AMT
	,ARINV_LN_RULE_START_DATE
	,ARINV_LN_SALES_ORDER
	,ARINV_LN_SALES_ORDER_DATE
	,ARINV_LN_SALES_ORDER_LN
	,ARINV_LN_UNIT_SELLING_PRICE
	,LAST_UPD_DATE
	,ARINV_LN_LINE_NUMBER
	,PRINT_DATE
	,GL_POSTED_DATE
	,INV_NUMBER
	,ARINV_ACCT_CODE
	,ARINV_BILL_TO_CUST_NO
	,ARINV_BILL_TO_CUST_NAME
	,ACCTD_AMOUNT
	,ARINV_LN_WAREHOUSE_ID
	,ARINV_EXCHANGE_DATE
	,ARINV_EXCHANGE_RATE
	,ARINV_FUNC_CURR_AMOUNT
	,BILLING_TYPE_SKEY
	,BILLING_TYPE_L3_DESC
	,ARINV_INV_CURR_AMOUNT
	,ARINV_CT_REFERENCE
	,ARINV_HDR_LAST_UPDATE_DATE
	,ARINV_HDR_LAST_UPDATED_BY
	,ARINV_HDR_CREATION_DATE
	,ARINV_HDR_CREATED_BY
	,ARINV_LN_LAST_UPDATE_DATE
	,ARINV_LN_LAST_UPDATED_BY
	,ARINV_LN_CREATION_DATE
	,ARINV_LN_CREATED_BY
	,ARINV_LN_LINE_TYPE
	,ARINV_LN_TAXABLE_FLAG
	,ARINV_LN_TAX_PRECEDENCE
	,ARINV_LN_TAX_RATE
	,ARINV_LN_TAX_EXEMPTION_ID
	,ARINV_LN_TAX_EXEMPT_FLAG
	,ARINV_LN_TAX_EXEMPT_NUMBER
	,ARINV_LN_TAX_EXEMPT_REASONCODE
	,ARINV_LN_TAX_VENDOR_RETURNCODE
	,ARINV_LN_TAXABLE_AMOUNT
from TFM_GetBillingRepOut
