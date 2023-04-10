pageextension 50020 SalesReceivablesSetupPExt extends "Sales & Receivables Setup"
{
    layout
    {
        addbefore(Dimensions)
        {
            group(CustomGroup)
            {
                field("IEPS GLA/c"; Rec."IEPS GLA/c")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IEPS GLA/c field.';
                }
                field("IVA GLA/c"; Rec."IVA GLA/c")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IVA GLA/c field.';
                }
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