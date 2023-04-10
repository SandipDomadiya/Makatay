pageextension 50016 PostedPurchaseInvoiceExt extends "Posted Purchase Invoice"
{
    layout
    {

        addlast(General)
        {
            field("Type of Invoice"; Rec."Type of Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Type of Invoice field.';
            }
            field("Uso CFDI"; Rec."Uso CFDI")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Uso CFDI field.';
            }
            field(UUID; Rec.UUID)
            {
                ToolTip = 'Specifies the value of the UUID field.';
                ApplicationArea = All;
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