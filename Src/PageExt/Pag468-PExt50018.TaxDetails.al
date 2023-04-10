pageextension 50018 TaxDetailsExt extends "Tax Details"
{
    layout
    {
        addlast(Control1)
        {
            field("Calculate Tax on Tax"; Rec."Calculate Tax on Tax")
            {
                ApplicationArea = SalesTax;
                ToolTip = 'Specifies the value of the Calculate Tax on Tax field.';
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