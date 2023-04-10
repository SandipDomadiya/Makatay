pageextension 50010 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            group(Attachments)
            {
                field("CFDI PPD PDF"; Rec."CFDI PPD PDF FileName")
                {
                    ToolTip = 'Specifies the value of the CFDI PPD PDF field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'CFDI PPD PDF';
                    trigger OnDrillDown()
                    begin
                        if Rec."CFDI PPD PDF".HasValue then
                            Rec.Export(true, 1)
                    end;
                }
                field("CFDI PPD XML"; rec."CFDI PPD XML FileName")
                {
                    ToolTip = 'Specifies the value of the CFDI PPD XML field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'CFDI PPD XML';
                    trigger OnDrillDown()
                    begin
                        if Rec."CFDI PPD XML".HasValue then
                            Rec.Export(true, 2);

                    end;
                }
                field("Proof of Delivery"; Rec."Proof of Delivery FileName")
                {
                    ToolTip = 'Specifies the value of the Proof of Delivery field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Proof of Delivery';
                    trigger OnDrillDown()
                    begin
                        if Rec."Proof of Delivery".HasValue then
                            Rec.Export(true, 3)

                    end;
                }
                field("CFDI RP PDF"; Rec."CFDI RP PDF FileName")
                {
                    ToolTip = 'Specifies the value of the CFDI RP PDF field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'CFDI RP PDF';
                    trigger OnDrillDown()
                    begin
                        if Rec."CFDI RP PDF".HasValue then
                            Rec.Export(true, 4)

                    end;
                }
                field("CFDI RP XML"; Rec."CFDI RP XML FileName")
                {
                    ToolTip = 'Specifies the value of the CFDI RP XML field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'CFDI RP XML';
                    trigger OnDrillDown()
                    begin
                        if Rec."CFDI RP XML".HasValue then
                            Rec.Export(true, 5)

                    end;
                }
                field("Proof of Payment"; Rec."Proof of Payment FileName")
                {
                    ToolTip = 'Specifies the value of the Proof of Payment field.';
                    ApplicationArea = All;
                    Caption = 'Proof of Payment';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        if Rec."Proof of Payment".HasValue then
                            Rec.Export(true, 6)

                    end;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


    var
        SelectFileTxt: Label 'Attach File(s)...';


}