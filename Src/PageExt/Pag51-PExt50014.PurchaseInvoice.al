pageextension 50014 PurchaseInvoiceExt extends "Purchase Invoice"
{
    layout
    {
        modify("Purchaser Code")
        { Visible = false; }
        modify("Campaign No.")
        { Visible = false; }
        modify("Order Address Code")
        { Visible = false; }
        modify("Responsibility Center")
        { Visible = false; }
        modify("Assigned User ID")
        { Visible = false; }
        addafter(Status)
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