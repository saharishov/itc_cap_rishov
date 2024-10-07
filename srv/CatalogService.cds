using { anubhav.db } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';
 
service CatalogService @(path:'CatalogService') {
 
    entity BusinessPartnerSet as projection on db.master.businesspartner;
    entity AddressSet as projection on db.master.address;
    entity EmployeeSet as projection on db.master.employees;
    entity POs @(
            odata.draft.enabled,
    )as projection on db.transaction.purchaseorder{
        *,
        case OVERALL_STATUS
        when 'P' then 'Pending'
        when 'A' then 'Approve'
        when 'D' then 'Delivered'
        when 'X' then 'Rejected'
        end as OverallStatus: String(10),
        case OVERALL_STATUS
        when 'P' then 2
        when 'A' then 3
        when 'D' then 1
        when 'X' then 1
        end as criticalityRishov: Integer,
        Items
    } actions{
        @cds.odata.bindingparameter.name: '_anubhav'
        @Common.SideEffects: {
            TargetProperties:['_anubhav/GROSS_AMOUNT']
        }
        action boost();
    };
    function getOrderDefaults() returns POs;

    entity PurchaseOrderItems @(
        odata.draft.enabled,
    ) as projection on db.transaction.poitems;
 
    entity ProductView as projection on cds.CDSViews.ProductView;
 
}