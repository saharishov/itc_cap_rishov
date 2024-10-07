using CatalogService as service from '../../srv/CatalogService';
annotate service.POs with @(
 
    UI: {
        SelectionFields  : [
            
            PO_ID,
            GROSS_AMOUNT,
            LIFECYCLE_STATUS,
            CURRENCY_code,
            PARTNER_GUID.COMPANY_NAME
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Label: 'Purchanse Order',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Label: 'boost',
                Action : 'CatalogService.boost',
                Inline: true
            },
 

            {
                $Type : 'UI.DataField',
                Label: 'Overall Status',
                Value : OverallStatus,
                Criticality:criticalityRishov,
            },

 
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Purchase Order',
            TypeNamePlural : 'Purchase Orders',
            Title: {
                $Type: 'UI.DataField',
                Value : PO_ID,
            },
            Description:{
                $Type: 'UI.DataField',
                Value: PARTNER_GUID.COMPANY_NAME,
            },
            ImageUrl:'https://tse4.mm.bing.net/th/id/OIP.PvWikjXSD5jq_G6SbeISFAHaNK?w=115&h=190&c=7&r=0&o=5&dpr=1.5&pid=1.7',
        },
        Facets : [
            {
                $Type : 'UI.CollectionFacet',
                Label : 'More Information',
                Facets : [
                    {
                        $Type: 'UI.ReferenceFacet',
                        Label: 'More Info',
                        Target : '@UI.Identification',
                    },
                   {
                        $Type : 'UI.ReferenceFacet',
                        Label: 'Prices',
                        Target : '@UI.FieldGroup#spiderman',
                     },
                     {
                        $Type : 'UI.ReferenceFacet',
                        Label : 'Status',
                        Target : '@UI.FieldGroup#batman',
                    },
                ],
             },
             {
                 $Type : 'UI.ReferenceFacet',
                 Label: 'Po Items',
                 Target : 'Items/@UI.LineItem',
             },
            
    ],
        Identification  : [
            {
             $Type: 'UI.DataField',
                Value : NODE_KEY,
            },
             {
             $Type: 'UI.DataField',
                Value : PO_ID,
            },
             {
             $Type: 'UI.DataField',
                Value : PARTNER_GUID_NODE_KEY,
            }
            ],
            FieldGroup #spiderman : {
                $Type : 'UI.FieldGroupType',
                Data : [
                        {
                            $Type : 'UI.DataField',
                            Value : GROSS_AMOUNT,
                        },
                        {
                            $Type : 'UI.DataField',
                            Value : NET_AMOUNT,
                        },
                        {
                            $Type : 'UI.DataField',
                            Value : TAX_AMOUNT,
                        },
                ],
            },
            FieldGroup #batman : {
                $Type : 'UI.FieldGroupType',
                Data : [
                    {
                        $Type : 'UI.DataField',
                        Value : CURRENCY_code,
                    },
                    {
                        $Type : 'UI.DataField',
                        Label: 'life cycle status',
                        Value : LIFECYCLE_STATUS,
                    },
                    {
                        $Type : 'UI.DataField',
                        Label: 'overall status',
                        Value : OVERALL_STATUS,
                    },
                ], 
            },
    },

    Common.DefaultValuesFunction: 'getOrderDefaults'
 
);
annotate service.PurchaseOrderItems with @(

    UI:{
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Po item',
            TypeNamePlural : 'PO Items',

                Title: {
                $Type: 'UI.DataField',
                Label : 'Po item number', 
                Value : PO_ITEM_POS,
            },
            Description:{
                $Type: 'UI.DataField',
                Label:'Item Amount',
                Value: PRODUCT_GUID.Category,
            },    

        },
        Facets : [
            {
                $Type : 'UI.CollectionFacet',
                Label : 'Item data',
                Facets : [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Label: 'More info',
                        Target : '@UI.Identification',
                    },
                ],
            },
        ],
        Identification  : [
            {
                $Type : 'UI.DataField',
                Value : NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : PARENT_KEY_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value :  GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value :  CURRENCY_code,
            },
        ],

        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.Description,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },

        ],
    }

);


// create 
annotate service.POs with{
    PARTNER_GUID @(
            Common: {
                Text: PARTNER_GUID.COMPANY_NAME
                    },

            ValueList.entity: 'service.BusinessPartnerSet'
)
};


//1st we need to create the value help depending on Some different CDS 
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification :[

        {
            $Type : 'UI.DataField',
            Label:  'Vendor',
            Value : COMPANY_NAME,
        },

    ]

) ;

annotate service.PurchaseOrderItems with{
    PRODUCT_GUID @(
            Common: {
                Text: PRODUCT_GUID.Description
                    },

            ValueList.entity: 'service.ProductView'
)
};

//1st we need to create the value help depending on Some different CDS 
@cds.odata.valuelist
annotate service.ProductView with @(
    UI.Identification :[

        {
            $Type : 'UI.DataField',
            Label:  'Vendor',
            Value : Description,
        },

    ]

) ;

