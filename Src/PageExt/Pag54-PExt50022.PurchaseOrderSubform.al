pageextension 50022 PurchaseOrderSubformExt extends "Purchase Order Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("IEPS Amt."; Rec."IEPS Amt.")
            {
                ToolTip = 'Specifies the value of the IEPS Amt. field.';
                ApplicationArea = All;
                Editable = false;
            }
            field("IVA Amt."; Rec."IVA Amt.")
            {
                ToolTip = 'Specifies the value of the IVA Amt. field.';
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        // addafter("VAT Prod. Posting Group")
        // {
        //     field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
        //     {
        //         ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
        //         ApplicationArea = All;
        //     }
        // }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}