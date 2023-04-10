pageextension 50012 VendorCardExt extends "Vendor Card"
{
    layout
    {
        modify(Blocked)
        {
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify(BalanceAsCustomer)
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }

        addafter(Name)
        {
            field(Status; rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Status field.';
            }
            field("No. of Invoices"; Rec."No. of Invoices")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of unposted purchase invoices that exist for the vendor.';
            }
            field("Total Units"; TotalUnits)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TotalUnits field.';
                Editable = false;
                trigger OnDrillDown()
                begin
                    DrillDownOnPostedInvoicesTotalunits(Rec."No.")
                end;
            }
            field("Total Amount"; TotalAmount)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TotalAmount field.';
                Editable = false;
                trigger OnDrillDown()
                begin
                    DrillDownOnPostedInvoicesTotalunits(Rec."No.")
                end;
            }
        }
        moveafter("Total Amount"; "Gen. Bus. Posting Group")
        modify("Address & Contact")
        {
            Caption = 'Vendor Information';
        }
        modify("Address 2")
        {
            Visible = false;
        }
        addafter("Address 2")
        {
            field(Colonia; Rec.Colonia)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Colonia field.';
            }
            field("Alcaldía"; Rec."Alcaldía")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Alcaldía field.';
            }
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify("Our Account No.")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }
        modify(Invoicing)
        {
            Visible = false;
        }
        modify(Payments)
        {
            Visible = false;
        }
        modify(Receiving)
        {
            Visible = false;
        }

        addafter("Address & Contact")
        {
            group("Contact Group")
            {
                Caption = 'Contact';
                group("First Contact")
                {
                    field("First Cont. Name"; Rec."First Cont. Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Name field.';
                    }

                    field("First Job Title"; Rec."First Job Title")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Rol / Job Title field.';
                    }
                    field("First Email"; Rec."First Email")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Email field.';
                    }
                    field("First Mobile No."; Rec."First Mobile No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Mobile No. field.';
                    }
                    field("First Telephone"; Rec."First Telephone")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Telephone field.';
                    }
                    field("First Note"; Rec."First Note")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Note field.';
                    }
                }
                group("Second Contact")
                {
                    field("Second Cont. Name"; Rec."Second Cont. Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Name field.';
                    }

                    field("Second Job Title"; Rec."Second Job Title")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Rol / Job Title field.';
                    }
                    field("Second Email"; Rec."Second Email")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Email field.';
                    }
                    field("Second Mobile No."; Rec."Second Mobile No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Mobile No. field.';
                    }
                    field("Second Telephone"; Rec."Second Telephone")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Telephone field.';
                    }
                    field("Second Note"; Rec."Second Note")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Note field.';
                    }
                }
                group("Third Contact")
                {
                    field("Third Cont. Name"; Rec."Third Cont. Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Name field.';
                    }
                    field("Third Job Title"; Rec."Third Job Title")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Rol / Job Title field.';
                    }
                    field("Third Email"; Rec."Third Email")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Email field.';
                    }
                    field("Third Mobile No."; Rec."Third Mobile No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Mobile No. field.';
                    }
                    field("Third Telephone"; Rec."Third Telephone")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Telephone field.';
                    }
                    field("Third Note"; Rec."Third Note")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Note field.';
                    }
                }

            }
            group("Payment Info")
            {
                group("First Info")
                {
                    field("First Company Name"; Rec."First Company Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Company Name field.';
                    }
                    field("First RFC No."; rec."First RFC No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the RFC No. field.';
                    }
                    field("First Bank"; Rec."First Bank")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bank field.';
                    }
                    field("First Bank Account"; Rec."First Bank Account")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bank Account field.';
                    }
                    field("First CDFI Use"; Rec."First CDFI Use")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the CDFI Use field.';
                    }
                }

                group("Second Info")
                {
                    field("Second Company Name"; Rec."Second Company Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Company Name field.';
                    }
                    field("Second RFC No."; rec."Second RFC No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the RFC No. field.';
                    }
                    field("Second Bank"; Rec."Second Bank")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bank field.';
                    }
                    field("Second Bank Account"; Rec."Second Bank Account")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bank Account field.';
                    }
                    field("Second CDFI Use"; Rec."Second CDFI Use")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the CDFI Use field.';
                    }
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        TotalUnits: Integer;
        TotalAmount: Decimal;

    trigger OnAfterGetRecord()
    begin
        TotalUnits := 0;
        TotalUnits := TotalunitsforVendor(Rec."No.");
        TotalAmount := 0;
        TotalAmount := TotalAmountforvendor(Rec."No.");
    end;

    local procedure TotalunitsforVendor(VendorNo: Code[20]): Integer
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        Clear(PurchInvLine);
        PurchInvLine.Reset();
        PurchInvLine.SetCurrentKey("Buy-from Vendor No.");
        PurchInvLine.SetRange("Buy-from Vendor No.", VendorNo);
        PurchInvLine.SetFilter(Quantity, '<>%1', 0);
        If PurchInvLine.FindSet() then begin
            PurchInvLine.CalcSums(Quantity);
            exit(PurchInvLine.Quantity);
        end;

        exit(0);
    end;

    procedure DrillDownOnPostedInvoicesTotalunits(VendNo: Code[20])
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        PurchInvoiceLine: Record "Purch. Inv. Line";
    begin
        PurchInvoiceLine.SetRange("Buy-from Vendor No.", VendNo);
        PAGE.Run(PAGE::"Posted Purchase Invoice Lines", PurchInvoiceLine);
    end;

    local procedure TotalAmountforvendor(VendorNo: Code[20]): Decimal
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        Clear(PurchInvLine);
        PurchInvLine.Reset();
        PurchInvLine.SetCurrentKey("Buy-from Vendor No.");
        PurchInvLine.SetRange("Buy-from Vendor No.", VendorNo);
        PurchInvLine.SetFilter(Quantity, '<>%1', 0);
        If PurchInvLine.FindSet() then begin
            PurchInvLine.CalcSums("Amount Including VAT");
            exit(PurchInvLine."Amount Including VAT");
        end;

        exit(0);
    end;
}