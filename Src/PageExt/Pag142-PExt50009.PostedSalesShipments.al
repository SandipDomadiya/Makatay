pageextension 50009 PostedSalesShipmentsExt extends "Posted Sales Shipments"
{
    layout
    {

        addafter("Location Code")
        {
            field("CFDI PPD PDF"; Rec."CFDI PPD PDF FileName")
            {
                ToolTip = 'Specifies the value of the CFDI PPD PDF field.';
                ApplicationArea = All;
                Editable = false;
                Caption = 'CFDI PPD PDF';
            }
            field("CFDI PPD XML"; rec."CFDI PPD XML FileName")
            {
                ToolTip = 'Specifies the value of the CFDI PPD XML field.';
                ApplicationArea = All;
                Editable = false;
                Caption = 'CFDI PPD XML';
            }
            field("Proof of Delivery"; Rec."Proof of Delivery FileName")
            {
                ToolTip = 'Specifies the value of the Proof of Delivery field.';
                ApplicationArea = All;
                Editable = false;
                Caption = 'Proof of Delivery';
            }
            field("CFDI RP PDF"; Rec."CFDI RP PDF FileName")
            {
                ToolTip = 'Specifies the value of the CFDI RP PDF field.';
                ApplicationArea = All;
                Editable = false;
                Caption = 'CFDI RP PDF';

            }
            field("CFDI RP XML"; Rec."CFDI RP XML FileName")
            {
                ToolTip = 'Specifies the value of the CFDI RP XML field.';
                ApplicationArea = All;
                Editable = false;
                Caption = 'CFDI RP XML';
            }
            field("Proof of Payment"; Rec."Proof of Payment FileName")
            {
                ToolTip = 'Specifies the value of the Proof of Payment field.';
                ApplicationArea = All;
                Caption = 'Proof of Payment';
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

}