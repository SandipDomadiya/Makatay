pageextension 50020 SalesReceivablesSetupPExt extends "Sales & Receivables Setup"
{
    layout
    {
        addbefore(Dimensions)
        {
            // group(CustomGroup)
            // {
            //     field("IEPS GLA/c"; Rec."IEPS GLA/c")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the IEPS GLA/c field.';
            //     }
            //     field("IVA GLA/c"; Rec."IVA GLA/c")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the IVA GLA/c field.';
            //     }
            // }
            group(JournalGroup)
            {
                field("IEPS Not Paid GLA/c"; Rec."IEPS Not Paid GLA/c")
                {
                    ToolTip = 'Specifies the value of the IEPS Not Paid GLA/c field.';
                    ApplicationArea = All;
                }
                field("IVA Not Paid GLA/c"; Rec."IVA Not Paid GLA/c")
                {
                    ToolTip = 'Specifies the value of the IVA Not Paid GLA/c field.';
                    ApplicationArea = All;
                }
                field("IEPS Paid GLA/c"; Rec."IEPS Paid GLA/c")
                {
                    ToolTip = 'Specifies the value of the IEPS Paid GLA/c field.';
                    ApplicationArea = All;
                }
                field("IVA Paid GLA/c"; Rec."IVA Paid GLA/c")
                {
                    ToolTip = 'Specifies the value of the IVA Paid GLA/c field.';
                    ApplicationArea = All;
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