pageextension 50000 CustomerCardExt extends "Customer Card"
{
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Sales Frequency Planning,Prices & Discounts,Navigate,Customer,Sales Process';

    layout
    {
        addafter("No.")
        {
            field(Since; Rec.Since)
            {
                ToolTip = 'Specifies the value of the Since field.';
                ApplicationArea = All;
                Editable = false;
            }
            field("Followup Every"; Rec."Followup Every")
            {
                ToolTip = 'Specifies the value of the Followup Every field.';
                ApplicationArea = All;
            }
            field("Espadín Monthly TurnOver"; Item1)
            {
                ToolTip = 'Specifies the value of the Espadín Monthly TurnOver field.';
                ApplicationArea = All;
                Editable = false;
                trigger OnDrillDown()
                begin
                    DrillDownOnItem1ValueEntry(Rec."No.")
                end;
            }
            field("Ensamble Monthly TurnOver"; Item2)
            {
                ToolTip = 'Specifies the value of the Ensamble Monthly TurnOver field.';
                ApplicationArea = All;
                Editable = false;
                trigger OnDrillDown()
                begin
                    DrillDownOnItem2ValueEntry(Rec."No.")
                end;
            }
            field("Total Monthly TurnOver"; TotalBothItems)
            {
                ToolTip = 'Specifies the value of the Total Monthly TurnOver field.';
                ApplicationArea = All;
                Editable = false;
            }
            field(Collections; Rec.Collections)
            {
                ToolTip = 'Specifies the value of the Collections field.';
                ApplicationArea = All;
            }
            field("No of Invoices Delivered"; NoOfInvoice)
            {
                ToolTip = 'Specifies the value of the No of Invoices Delivered field.';
                ApplicationArea = All;
                Editable = false;
                trigger OnDrillDown()
                begin
                    DrillDownOnPostedInvoices(Rec."No.")
                end;
            }
            field("Total Sales Units"; TotalSalesunits)
            {
                ToolTip = 'Specifies the value of the Total Sales Units field.';
                ApplicationArea = All;
                Editable = false;
                trigger OnDrillDown()
                begin
                    DrillDownOnPostedInvoicesTotalSalesunits(Rec."No.")
                end;
            }
            field("Sales Monthly Average"; Rec."Sales Monthly Average")
            {
                ToolTip = 'Specifies the value of the Sales Monthly Average field.';
                ApplicationArea = All;
            }
            field("Channel Customer Ranking"; Rec."Channel Customer Ranking")
            {
                ToolTip = 'Specifies the value of the Channel Customer Ranking field.';
                ApplicationArea = All;
            }
            field("Total Customers Channel"; Rec."Total Customers Channel")
            {
                ToolTip = 'Specifies the value of the Total Customers Channel field.';
                ApplicationArea = All;
            }
            field(Status; rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Status field.';
            }
            field("Created Date"; Rec."Created Date")
            {
                ToolTip = 'Specifies the value of the Created Date field.';
                ApplicationArea = All;
                Editable = false;
            }

        }
        movebefore("Sales Monthly Average"; TotalSales2)
        modify("No.")
        {
            Editable = false;
        }

        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify("SAT Tax Regime Classification")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }

        modify("CustSalesLCY - CustProfit - AdjmtCostLCY")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due")
        {
            Visible = false;
        }
        modify(BalanceAsVendor)
        {
            Visible = false;
        }
        modify(AdjCustProfit)
        {
            Visible = false;
        }
        modify(AdjProfitPct)
        {
            Visible = false;
        }
        modify(Payments)
        {
            Visible = false;
        }
        modify(Shipping)
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }
        modify("Fax No.")
        {
            Visible = false;
        }
        modify("Bill-to Customer No.")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        modify("Copy Sell-to Addr. to Qte From")
        {
            Visible = false;
        }
        modify("CFDI Export Code")
        {
            Visible = false;
        }
        modify("CFDI Purpose")
        { Visible = false; }
        modify("CFDI General Public")
        { Visible = false; }
        modify("CFDI Relation")
        { Visible = false; }

        modify(Name)
        {
            Caption = 'Nombre De Establecimiento';
            ShowMandatory = true;
        }
        modify(ContactDetails)
        {
            Visible = false;
        }
        modify("CFDI Customer Name")
        {
            Visible = false;
        }
        modify("CFDI Period")
        {
            Visible = false;
        }
        movebefore(Address; Name)
        addafter(Name)
        {
            field(Distintive; Rec.Distintive)
            {
                ToolTip = 'Specifies the value of the Distintive field.';
                ApplicationArea = All;
            }
            field(Cluster; Rec.Cluster)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cluster field.';
            }
            field(Channel; rec.Channel)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Channel field.';
                ShowMandatory = true;
            }
        }

        addafter("Home Page")
        {
            field("Sales Rep."; Rec."Sales Rep.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Rep. field.';
                DrillDown = false;

                trigger OnAssistEdit()
                var
                    User: Record User;
                    Users: Page Users;
                begin
                    Users.SetRecord(User);
                    Users.LookupMode := true;
                    if Users.RunModal = ACTION::LookupOK then begin
                        Users.GetRecord(User);
                        Rec.Validate("Sales Rep.", User."User Name");
                        CurrPage.Update(true);
                    end;
                end;
            }
            field("Collection Rep."; Rec."Collection Rep.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Collection Rep. field.';
                DrillDown = false;

                trigger OnAssistEdit()
                var
                    User: Record User;
                    Users: Page Users;
                begin
                    Users.SetRecord(User);
                    Users.LookupMode := true;
                    if Users.RunModal = ACTION::LookupOK then begin
                        Users.GetRecord(User);
                        Rec.Validate("Collection Rep.", User."User Name");
                        CurrPage.Update(true);
                    end;
                end;
            }
        }

        modify("Address & Contact")
        {
            Caption = 'Customer Information';
        }
        modify("Address 2")
        {
            Visible = false;
        }
        modify(Statistics)
        {
            Visible = false;
        }
        modify(Invoicing)
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

        addafter("Address & Contact")
        {
            group("Sales Process ")
            {

                field("Sales Process Status"; Rec."Sales Process Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Process Status field.';
                    Caption = 'Status';
                    Editable = false;
                }
                field("Completion Date 11"; Rec."Completion Date 11")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 11. Not Successful field.';
                    Caption = 'Customer Denied';
                    Editable = false;
                }
                field("Completion Date 1"; Rec."Completion Date 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 1. Contact and Information field.';
                    Visible = false;

                }
                field("Completion Status 1 Days"; Rec."Completion Status 1 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 1 Days field.';
                    Caption = '1. Contact and Information';
                    Editable = false;
                }
                field("Completion Date 2"; Rec."Completion Date 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 2. On-Site Visit field.';
                    Visible = false;
                }
                field("Completion Status 2 Days"; Rec."Completion Status 2 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 2 Days field.';
                    Caption = '2. On-Site Visit';
                    Editable = false;
                }
                field("Completion Date 3"; Rec."Completion Date 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 3. Listing field.';
                    Visible = false;
                }
                field("Completion Status 3 Days"; Rec."Completion Status 3 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 3 Days field.';
                    Caption = '3. Listing';
                    Editable = false;
                }
                field("Completion Date 4"; Rec."Completion Date 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 4. Invoiced field.';
                    Visible = false;
                }
                field("Completion Status 4 Days"; Rec."Completion Status 4 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 4 Days field.';
                    Caption = '4. Sales Order';
                    Editable = false;
                }
                field("Completion Date 5"; Rec."Completion Date 5")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 5. First Shipment Delivered field.';
                    Visible = false;
                }
                field("Completion Status 5 Days"; Rec."Completion Status 5 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 5 Days field.';
                    Caption = '5. First Shipment Delivered';
                    Editable = false;
                }
                field("Completion Date 6"; Rec."Completion Date 6")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 6. Staff Training field.';
                    Visible = false;
                }
                field("Completion Status 6 Days"; Rec."Completion Status 6 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 6 Days field.';
                    Caption = '6. Staff Training';
                    Editable = false;
                }
                field("Completion Date 7"; Rec."Completion Date 7")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 7. Second Shipment Delivered field.';
                    Visible = false;
                }
                field("Completion Status 7 Days"; Rec."Completion Status 7 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 7 Days field.';
                    Caption = '7. Second Shipment Delivered';
                    Editable = false;
                }
                field("Completion Date 8"; Rec."Completion Date 8")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 8. First Collection field.';
                    Visible = false;
                }
                field("Completion Status 8 Days"; Rec."Completion Status 8 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 8 Days field.';
                    Caption = '8. First Collection';
                    Editable = false;
                }
                field("Completion Date 9"; Rec."Completion Date 9")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 9. Makatay On Menu field.';
                    Visible = false;
                }
                field("Completion Status 9 Days"; Rec."Completion Status 9 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 9 Days field.';
                    Caption = '9. Makatay On Menu';
                    Editable = false;
                }
                field("Completion Date 10"; Rec."Completion Date 10")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Date 10. Complete field.';
                    Visible = false;
                }
                field("Completion Status 10 Days"; Rec."Completion Status 10 Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion 10 Days field.';
                    Caption = '10. Complete';
                    Editable = false;
                }
            }
            group("Key Desition Makers")
            {
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
                    field("FirstPercived Behavioral Style"; Rec."FirstPercived Behavioral Style")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Percived Behavioral Style field.';
                    }
                    field("First Preferred Contact Time"; Rec."First Preferred Contact Time")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Preferred Contact Time field.';
                    }
                    field("First Email"; Rec."First Email")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Email field.';
                    }
                    field("First Telephone"; Rec."First Telephone")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Telephone field.';
                    }
                    field("First Mobile No."; Rec."First Mobile No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Mobile No. field.';
                    }
                    field("First Note"; Rec."First Note")
                    {
                        ToolTip = 'Specifies the value of the Note field.';
                        ApplicationArea = All;
                    }
                }
                group("Next Hiearchy Needed")
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
                    field("SecPercived Behavioral Style"; Rec."Sec.Percived Behavioral Style")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Percived Behavioral Style field.';
                    }
                    field("Second Preferred Contact Time"; Rec."Second Preferred Contact Time")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Preferred Contact Time field.';
                    }
                    field("Second Email"; Rec."Second Email")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Email field.';
                    }
                    field("Second Telephone"; Rec."Second Telephone")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Telephone field.';
                    }
                    field("Second Mobile No."; Rec."Second Mobile No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Mobile No. field.';
                    }
                    field("Second Note"; Rec."Second Note")
                    {
                        ToolTip = 'Specifies the value of the Note field.';
                        ApplicationArea = All;
                    }
                }
                group("Next Hiearchy Needed ")
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
                    field("ThirdPercived Behavioral Style"; Rec."ThirdPercived Behavioral Style")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Percived Behavioral Style field.';
                    }
                    field("Third Preferred Contact Time"; Rec."Third Preferred Contact Time")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Preferred Contact Time field.';
                    }
                    field("Third Email"; Rec."Third Email")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Email field.';
                    }
                    field("Third Telephone"; Rec."Third Telephone")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Telephone field.';
                    }
                    field("Third Mobile No."; Rec."Third Mobile No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Mobile No. field.';
                    }
                    field("Third Note"; Rec."Third Note")
                    {
                        ToolTip = 'Specifies the value of the Note field.';
                        ApplicationArea = All;
                    }
                }
            }
            group("Customer Scoring")
            {
                field("No. Of Bartenders"; Rec."No. Of Bartenders")
                {
                    ToolTip = 'Specifies the value of the No. Of Bartenders field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ToCalclatRating;
                    end;
                }
                field("No. Of Waiters"; Rec."No. Of Waiters")
                {
                    ToolTip = 'Specifies the value of the No. Of Waiters field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ToCalclatRating;
                    end;
                }
                field("Mezcal Menu"; Rec."Mezcal Menu")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mezcal Menu field.';
                    trigger OnValidate()
                    begin
                        ToCalclatRating;
                    end;
                }
                field("Closing Hours"; Rec."Closing Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closing Hours field.';
                    trigger OnValidate()
                    begin
                        ToCalclatRating;
                    end;
                }
                field("It Factor"; Rec."It Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Factor field.';
                    trigger OnValidate()
                    begin
                        ToCalclatRating;
                    end;
                }
            }
            group("Sales Frequency Planning")
            {

                field("Follow-Up Every"; Rec."Followup Every")
                {
                    ToolTip = 'Specifies the value of the Customer Frequency Follow Up field.';
                    Caption = 'Customer Frequency Follow Up';
                    ApplicationArea = All;
                }
                field("Customer Preferred Day"; Rec."Customer Preferred Day")
                {
                    ToolTip = 'Specifies the value of the Customer Preferred Days field.';
                    ApplicationArea = All;
                }
                field("Last Save to Histroy Days"; Rec."Last Save to Histroy Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Save to Histroy Days field.';
                    StyleExpr = CustomStyleTxt;
                    Editable = false;
                }
                group("Maximum Inventory")
                {
                    field("Espadin de 40 Maximum Inventory"; Rec.Item1MaxInv)
                    {
                        ToolTip = 'Specifies the value of the Espadín Maximum Inventory field.';
                        ApplicationArea = All;
                        Caption = 'Espadin de 40';
                        //Editable = false;
                    }
                    field("Ensamble de 46 Maximum Inventory"; Rec.Item2MaxInv)
                    {
                        ToolTip = 'Specifies the value of the Ensamble Maximum Inventory field.';
                        ApplicationArea = All;
                        Caption = 'Ensamble de 46';
                        //Editable = false;
                    }
                }
                group("Average Turnover")
                {
                    field("Espadin de 40 Average Turnover"; Rec.Item1AveTurnover)
                    {
                        ApplicationArea = All;
                        Caption = 'Espadin de 40';
                        ToolTip = 'Specifies the value of the Item1AveTurnover field.';
                        Editable = false;
                    }
                    field("Ensamble de 46 Average Turnover"; Rec.Item2AveTurnover)
                    {
                        ApplicationArea = All;
                        Caption = 'Ensamble de 46';
                        ToolTip = 'Specifies the value of the Item2AveTurnover field.';
                        Editable = false;
                    }
                }
                group("Period Turnover")
                {
                    Visible = false;
                    field("Espadin de 40 Period Turnover"; Rec.Item1PerTurnover)
                    {
                        ApplicationArea = All;
                        Caption = 'Espadin de 40';
                        ToolTip = 'Specifies the value of the Item1AveTurnover field.';
                    }
                    field("Ensamble de 46 Period Turnover"; Rec.Item2PerTurnover)
                    {
                        ApplicationArea = All;
                        Caption = 'Ensamble de 46';
                        ToolTip = 'Specifies the value of the Item2AveTurnover field.';
                    }
                }
                group("Suggested Sale")
                {
                    field(Item1SuggSale; Rec.Item1SuggSale)
                    {
                        ApplicationArea = All;
                        Caption = 'Espadin de 40';
                        ToolTip = 'Specifies the value of the Item1SuggSale field.';
                    }
                    field(Item2SuggSale; Rec.Item2SuggSale)
                    {
                        ApplicationArea = All;
                        Caption = 'Ensamble de 46';
                        ToolTip = 'Specifies the value of the Item2SuggSale field.';
                    }
                }
                group("Inventory")
                {
                    field("Espadin de 40 Inventory"; Rec.Item1Inv)
                    {
                        ApplicationArea = All;
                        Caption = 'Espadin de 40';
                        ToolTip = 'Specifies the value of the Item1Inv field.';
                        ShowMandatory = true;
                    }
                    field("Ensamble de 46 Inventory"; Rec.Item2Inv)
                    {
                        ApplicationArea = All;
                        Caption = 'Ensamble de 46';
                        ToolTip = 'Specifies the value of the Item2Inv field.';
                        ShowMandatory = true;
                    }
                }

                group("Sale Agreed")
                {
                    field("Espadin de 40"; Rec.Item1AgreSale)
                    {
                        ApplicationArea = All;
                        Caption = 'Espadin de 40';
                        ToolTip = 'Specifies the value of the Item1AgreSale field.';
                        ShowMandatory = true;
                    }
                    field("Ensamble de 46"; Rec.Item2AgreSale)
                    {
                        ApplicationArea = All;
                        Caption = 'Ensamble de 46';
                        ToolTip = 'Specifies the value of the Item1AgreSale field.';
                        ShowMandatory = true;
                    }
                }
            }
            group("Invoice")
            {
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field(RFC; Rec.RFC)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RFC field.';
                }
                field("Address(Invoice)"; Rec."Address(Invoice)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Colonia(Invoice)"; Rec."Colonia(Invoice)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Colonia field.';
                }
                field(Alcaldia; Rec.Alcaldia)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Alcaldia field.';
                }
                field("Country/Region Code(Invoice)"; Rec."Country/Region Code(Invoice)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country/Region Code field.';
                }
                field("Post Code(Invoice)"; Rec."Post Code(Invoice)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field("Phone No.(Invoice)"; Rec."Phone No.(Invoice)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("E-Mail(Invoice)"; Rec."E-Mail(Invoice)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("CFDI Use"; Rec."CFDI Use")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CFDI Use field.';
                }
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank field.';
                }
                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Number field.';
                }

                field("Catalogo De Producyos Y Ser."; Rec."Catalogo De Producyos Y Ser.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Catalogo De Producyos Y Servicios field.';
                }
                field("Constancia De Sit"; Rec."Constancia De Sit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Constancia De Sit field.';
                }
                field("Forma De Pago"; Rec."Forma De Pago")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Forma De Pago field.';
                }

            }
            group("Purchase Contact")
            {
                field("Purch. Name"; Rec."Purch. Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Percived Behavioral Style"; Rec."Percived Behavioral Style")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percived Behavioral Style field.';
                }
                field("Preferred Contact Time"; Rec."Preferred Contact Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preferred Contact Time field.';
                }
                field("E-Mail(Purch.)"; Rec."E-Mail(Purch.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Phone No.(Purch.)"; Rec."Phone No.(Purch.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Mobile No.(Purch.)"; Rec."Mobile No.(Purch.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile No. field.';
                }
                field("Note(Purch.)"; Rec."Note(Purch.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Note field.';
                }
            }
            group("Account Payable Contact")
            {
                field("Acc Pay. Cont. Name"; Rec."Acc Pay. Cont. Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Rol/Job Title"; Rec."Rol/Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rol/Job Title field.';
                }
                field("Preferred Cont. Time(Acc.Pay)"; Rec."Preferred Cont. Time(Acc.Pay)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preferred Contact Time field.';
                }
                field("E-Mail(Acc.Pay)"; Rec."E-Mail(Acc.Pay)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("Phone No.(Acc.Pay)"; Rec."Phone No.(Acc.Pay)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Mobile No.(Acc.Pay)"; Rec."Mobile No.(Acc.Pay)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile No. field.';
                }
                field("Note(Acc.Pay)"; Rec."Note(Acc.Pay)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Note field.';
                }
            }

        }
        addafter(Control149)
        {
            part("CustomerRatingBox"; "CustomerRatingBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
                Visible = NOT IsOfficeAddin;
            }
        }
        modify(Control149)
        {
            Caption = 'Mezcal Menu Picture';
        }
    }
    actions
    {
        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
        }
        modify(CreateFlow)
        {
            Visible = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
        }
        addafter("&Customer")
        {
            group("Sales Process")
            {
                action("Create Customer Task")
                {
                    ApplicationArea = Basic;
                    Image = NewOpportunity;
                    Promoted = true;
                    PromotedCategory = Category10;
                    ToolTip = 'Executes the Create SalesProcess action.';
                    trigger OnAction()
                    begin
                        rec.TestField("First Cont. Name");
                        Rec.TestField("Sales Rep.");
                        If Rec."Sales Process Status" = rec."Sales Process Status"::"0. Customer Denied" then begin
                            rec."Sales Process Status" := rec."Sales Process Status"::"1. Contact and Information";
                            rec.Modify(false);
                            rec.CreateTask();
                        end else
                            rec.CreateTask();
                    end;
                }
                action("Customer Denied")
                {
                    ApplicationArea = All;
                    Image = DeleteRow;
                    Promoted = true;
                    PromotedCategory = Category10;
                    ToolTip = 'Executes the Customer Denied action.';
                    trigger OnAction()
                    var
                        confirmAsktxt: Label 'Are you sure to Customer Denied?';
                    begin
                        If Not Confirm(confirmAsktxt, true) then
                            exit;

                        case Rec."Sales Process Status" of
                            rec."Sales Process Status"::"1. Contact and Information":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            rec."Sales Process Status"::"2. On-Site Visit":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            rec."Sales Process Status"::"3. Listing":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            rec."Sales Process Status"::"4. Sales Order":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            rec."Sales Process Status"::"5. First Shipment Delivered":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            rec."Sales Process Status"::"6. Staff Training":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            rec."Sales Process Status"::"7. Second Shipment Delivered":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            rec."Sales Process Status"::"8. First Collection":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            rec."Sales Process Status"::"9. Makatay On Menu":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            rec."Sales Process Status"::"10. Complete":
                                begin
                                    If rec."Completion Date 11" = '' then
                                        rec."Completion Date 11" := format(WorkDate())
                                    else
                                        rec."Completion Date 11" += ' / ' + format(WorkDate());
                                    rec."Sales Process Status" := Rec."Sales Process Status"::"0. Customer Denied";
                                    Rec.Status := rec.Status::Denied;
                                    rec.Modify(false);
                                    rec.ClearCustomerDays();
                                    rec.CreateDeniedTask();
                                    rec.Modify(false);
                                end;
                            else
                                exit;

                        end;
                    end;
                }
                action("Previous Status")
                {
                    ApplicationArea = All;
                    Image = PreviousSet;
                    Promoted = true;
                    PromotedCategory = Category10;
                    ToolTip = 'Executes the Previous Status action.';

                    trigger OnAction()
                    begin
                        If Rec.ToCheckUserTaskList() then begin
                            rec.PreviousStatus();
                        end else
                            Message('Please make sure complate all Customer task then try it.');
                    end;
                }
                action("Forward Status")
                {
                    ApplicationArea = All;
                    Image = NextSet;
                    Promoted = true;
                    PromotedCategory = Category10;
                    ToolTip = 'Executes the Forward Status action.';

                    trigger OnAction()
                    begin
                        If Rec.ToCheckUserTaskList() then begin
                            rec.ForwardStatus();
                        end else
                            Message('Please make sure complate all Customer task then try it.');
                    end;
                }
                action("Customer Task List")
                {
                    ApplicationArea = All;
                    Image = TaskPage;
                    Promoted = true;
                    PromotedCategory = Category10;
                    ToolTip = 'Executes the Customer Task List action.';
                    trigger OnAction()
                    var
                        UserTask: Record "User Task";
                        UserTaskList: Page "Customer User Task List";
                    begin
                        Clear(UserTask);
                        UserTask.SetCurrentKey("Customer No.");
                        UserTask.SetRange("Customer No.", Rec."No.");
                        UserTaskList.SetTableView(UserTask);
                        UserTaskList.SetRecord(UserTask);
                        UserTaskList.Editable := false;
                        UserTaskList.Run();
                    end;
                }
            }
            group("Sales Frequency Planning ")
            {
                Image = SalesPurchaseTeam;
                action("Save To History")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Image = Process;
                    ToolTip = 'Executes the Save To History action.';
                    trigger OnAction()
                    var
                        ConfirmAskLbl: Label 'Are you sure to Save to History?';
                        replaceAskLbl: Label 'It is already exits Sales Frequency Planning record.\Are you sure continue?';
                        SaleFreqPlanRec: Record "Sales Frequency Planning";
                        Replcerec: Boolean;
                    begin
                        Replcerec := false;
                        If not Confirm(ConfirmAskLbl, true) then
                            exit;

                        If Rec.Item1Inv = 0 then
                            Error('You must enter Espadin de 40 Inventory.');
                        If Rec.Item2Inv = 0 then
                            Error('You must enter Ensamble de 46 Inventory.');

                        SaleFreqPlanRec.Reset();
                        SaleFreqPlanRec.SetCurrentKey("Customer No.", "Sales Date");
                        SaleFreqPlanRec.SetRange("Customer No.", Rec."No.");
                        SaleFreqPlanRec.SetRange("Sales Date", WorkDate());
                        If SaleFreqPlanRec.FindFirst() then begin
                            If not Confirm(replaceAskLbl, true) then begin
                                exit;
                            end else begin
                                Replcerec := true;
                                ToCreateSaleReqplan(Replcerec);
                            end;
                        end else
                            ToCreateSaleReqplan(Replcerec);

                    end;
                }
                action("Retrieve Last Saved History")
                {
                    ApplicationArea = All;
                    Image = Restore;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Executes the Retrieve Last Saved History action.';
                    trigger OnAction()
                    var
                        SaleFreqplanRec: Record "Sales Frequency Planning";
                        Items: Record Item;
                    begin
                        Items.Reset();
                        Items.SetCurrentKey("No.");
                        If Items.FindSet() then
                            repeat
                                SaleFreqplanRec.Reset();
                                SaleFreqplanRec.SetCurrentKey("Customer No.", "Sales Date");
                                SaleFreqplanRec.SetRange("Customer No.", Rec."No.");
                                SaleFreqplanRec.SetRange("Item No.", Items."No.");
                                SaleFreqplanRec.SetRange("Sales Date");
                                SaleFreqplanRec.Ascending(true);
                                If SaleFreqplanRec.FindLast() then begin
                                    If Items."No." = '1000' then
                                        rec.Item1Inv := SaleFreqPlanRec."Consumer Inventory";
                                    If Items."No." = '1002' then
                                        rec.Item2Inv := SaleFreqPlanRec."Consumer Inventory";
                                    If Items."No." = '1000' then
                                        rec.Item1MaxInv := SaleFreqPlanRec."Maximum Inventory";
                                    If Items."No." = '1002' then
                                        rec.Item2MaxInv := SaleFreqPlanRec."Maximum Inventory";
                                    If Items."No." = '1000' then
                                        rec.Item1SuggSale := SaleFreqPlanRec."Suggested Sale";
                                    If Items."No." = '1002' then
                                        rec.Item2SuggSale := SaleFreqPlanRec."Suggested Sale";
                                    If Items."No." = '1000' then
                                        rec.Item1AgreSale := SaleFreqPlanRec."Sale Agreed";
                                    If Items."No." = '1002' then
                                        rec.Item2AgreSale := SaleFreqPlanRec."Sale Agreed";
                                    Rec.Modify(false);
                                    SaleFreqplanRec.Delete();
                                end;
                            Until Items.Next() = 0;
                    end;
                }
                action("Frequency Planning History")
                {
                    ApplicationArea = All;
                    Image = SalesPurchaseTeam;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Executes the Sales Frequency Planning List action.';

                    trigger OnAction()
                    var
                        SalesFreqPlan: Record "Sales Frequency Planning";
                    begin
                        SalesFreqPlan.SetRange("Customer No.", Rec."No.");
                        Page.Run(Page::"Sales Frequency Planning", SalesFreqPlan);
                    end;
                }

                action("Export ClientVisit To Excel")
                {
                    ApplicationArea = All;
                    Image = ExportToExcel;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Visible = false;
                    ToolTip = 'Executes the Export ClientVisit To Excel action.';

                    trigger OnAction()
                    var
                        Cust: Record Customer;
                    begin
                        Cust.SetRange("No.", Rec."No.");
                        Report.RunModal(Report::ExportClientVisitToExcel, true, false, Cust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NoOfInvoice := 0;
        NoOfInvoice := NoOfinvoiceforCustomer(Rec."No.");
        TotalSalesunits := 0;
        TotalSalesunits := TotalSalesunitsforCustomer(Rec."No.");
        Item1 := 0;
        Item1 := Item1ForSalesMonthlyTurnover(Rec."No.");
        Item2 := 0;
        Item2 := Item2ForSalesMonthlyTurnover(Rec."No.");
        TotalBothItems := 0;
        TotalBothItems := Item1 + Item2;
        LastsaveDate := 0D;
        LastsaveDate := NoOfDayLastSavetoHistroyforCust(rec."No.");
        If LastsaveDate <> 0D then
            Rec."Last Save to Histroy Days" := WorkDate() - LastsaveDate
        else
            rec."Last Save to Histroy Days" := 0;
        CustomStyleTxt := Rec.LastHistroyDaysSetStyle();

    end;

    var
        NoOfInvoice: Integer;
        TotalSalesunits: Integer;
        Item1: Decimal;
        Item2: Decimal;
        TotalBothItems: Decimal;
        CustomStyleTxt: Text;
        LastsaveDate: Date;


    local procedure ToCalcPeriodTurnover(ItemNo: Code[20]; var Inventory: Decimal; var AgreedSale: Integer)
    var
        SaleFreqplanRec: Record "Sales Frequency Planning";
    begin
        SaleFreqplanRec.Reset();
        SaleFreqplanRec.SetCurrentKey("Customer No.", "Item No.", "Sales Date");
        SaleFreqplanRec.SetRange("Customer No.", Rec."No.");
        SaleFreqplanRec.SetRange("Item No.", ItemNo);
        SaleFreqplanRec.SetRange("Sales Date");
        SaleFreqplanRec.Ascending(true);
        If SaleFreqplanRec.FindLast() then begin
            Inventory := SaleFreqplanRec."Consumer Inventory";
            AgreedSale := SaleFreqplanRec."Sale Agreed";
        end;
    end;

    local procedure NoOfDayLastSavetoHistroyforCust(CustNo: Code[20]): Date
    var
        SaleFreqplanRec: Record "Sales Frequency Planning";
    begin
        SaleFreqplanRec.Reset();
        SaleFreqplanRec.SetCurrentKey("Customer No.", "Sales Date");
        SaleFreqplanRec.SetRange("Customer No.", Rec."No.");
        SaleFreqplanRec.SetRange("Sales Date");
        SaleFreqplanRec.Ascending(true);
        If SaleFreqplanRec.FindLast() then
            exit(SaleFreqplanRec."Sales Date");

        exit(0D);
    end;

    local procedure ToCalclatRating()
    var
        PoorAmt: Decimal;
        GoodAmt: Decimal;
        Clhr1: Decimal;
        Clhr2: Decimal;
    begin
        rec.Rating := (rec."No. Of Waiters" * 2) + (Rec."No. Of Bartenders" * 6);
        case rec."Mezcal Menu" of
            rec."Mezcal Menu"::Poor:
                ;
            rec."Mezcal Menu"::Average:
                begin
                    PoorAmt := 0;
                    PoorAmt := (Rec.Rating * 10) / 100;
                    Rec.Rating += PoorAmt;
                end;

            rec."Mezcal Menu"::Good:
                begin
                    GoodAmt := 0;
                    GoodAmt := (Rec.Rating * 20) / 100;
                    Rec.Rating += GoodAmt;
                end;
        end;

        case rec."Closing Hours" of
            rec."Closing Hours"::"12PM or Before":
                ;
            Rec."Closing Hours"::"11PM or Before":
                begin
                    Clhr1 := 0;
                    Clhr1 := (Rec.Rating * 20) / 100;
                    Rec.Rating -= Clhr1;
                end;
            Rec."Closing Hours"::"1AM or Before":
                begin
                    Clhr1 := 0;
                    Clhr1 := (Rec.Rating * 10) / 100;
                    Rec.Rating += Clhr1;
                end;
            Rec."Closing Hours"::"2AM or Before":
                begin
                    Clhr1 := 0;
                    Clhr1 := (Rec.Rating * 20) / 100;
                    Rec.Rating += Clhr1;
                end;
            Rec."Closing Hours"::"After 2AM":
                begin
                    Clhr1 := 0;
                    Clhr1 := (Rec.Rating * 30) / 100;
                    Rec.Rating += Clhr1;
                end;
        end;
        case rec."It Factor" of
            rec."It Factor"::"No IF":
                ;

            rec."It Factor"::"Good IF":
                begin
                    Clhr2 := 0;
                    Clhr2 := (Rec.Rating * 20) / 100;
                    Rec.Rating += Clhr2;
                end;
            rec."It Factor"::"Very Good IF":
                begin
                    Clhr2 := 0;
                    Clhr2 := (Rec.Rating * 40) / 100;
                    Rec.Rating += Clhr2;
                end;
        end;

        case Rec.Rating of
            0 .. 15:
                Rec."Rating ColorName" := 'Aqua';
            16 .. 25:
                Rec."Rating ColorName" := 'Blue';
            26 .. 40:
                Rec."Rating ColorName" := 'Purple';
            41 .. 60:
                Rec."Rating ColorName" := 'Red';
            61 .. 90:
                Rec."Rating ColorName" := 'Orange';
            91 .. 200:
                Rec."Rating ColorName" := 'Yellow';
        end;
        CurrPage.Update();
    end;

    local procedure NoOfinvoiceforCustomer(CustNo: Code[20]): Integer
    var
        SalesInvHrd: Record "Sales Invoice Header";
    begin
        Clear(SalesInvHrd);
        SalesInvHrd.Reset();
        SalesInvHrd.SetCurrentKey("Sell-to Customer No.");
        SalesInvHrd.SetRange("Sell-to Customer No.", CustNo);
        If SalesInvHrd.FindSet() then
            exit(SalesInvHrd.Count);

        exit(0);
    end;

    procedure DrillDownOnPostedInvoices(CustNo: Code[20])
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.SetRange("Bill-to Customer No.", CustNo);
        PAGE.Run(PAGE::"Posted Sales Invoices", SalesInvoiceHeader);
    end;

    local procedure TotalSalesunitsforCustomer(CustNo: Code[20]): Integer
    var
        SaleInvLine: Record "Sales Invoice Line";
    begin
        Clear(SaleInvLine);
        SaleInvLine.Reset();
        SaleInvLine.SetCurrentKey("Sell-to Customer No.");
        SaleInvLine.SetRange("Sell-to Customer No.", CustNo);
        SaleInvLine.SetFilter(Quantity, '<>%1', 0);
        If SaleInvLine.FindSet() then begin
            SaleInvLine.CalcSums(Quantity);
            exit(SaleInvLine.Quantity);
        end;

        exit(0);
    end;

    procedure DrillDownOnPostedInvoicesTotalSalesunits(CustNo: Code[20])
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetRange("Bill-to Customer No.", CustNo);
        PAGE.Run(PAGE::"Posted Sales Invoice Lines", SalesInvoiceLine);
    end;

    local procedure Item1ForSalesMonthlyTurnover(CustNo: Code[20]): Decimal
    var
        ValueEntry: Record "Value Entry";
    begin
        Clear(ValueEntry);
        ValueEntry.Reset();
        ValueEntry.SetCurrentKey("Source Type", "Source No.", "Item Ledger Entry Type", "Document Type");
        ValueEntry.SetRange("Source Type", ValueEntry."Source Type"::Customer);
        ValueEntry.SetRange("Source No.", CustNo);
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetFilter("Item No.", '%1', '1000');
        If ValueEntry.FindSet() then begin
            ValueEntry.CalcSums("Sales Amount (Actual)");
            exit(ValueEntry."Sales Amount (Actual)" / 12);
        end;

        exit(0);
    end;

    procedure DrillDownOnItem1ValueEntry(CustNo: Code[20])
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.Reset();
        ValueEntry.SetCurrentKey("Source Type", "Source No.", "Item Ledger Entry Type", "Document Type");
        ValueEntry.SetRange("Source Type", ValueEntry."Source Type"::Customer);
        ValueEntry.SetRange("Source No.", CustNo);
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetFilter("Item No.", '%1', '1000');
        PAGE.Run(PAGE::"Value Entries", ValueEntry);
    end;

    local procedure Item2ForSalesMonthlyTurnover(CustNo: Code[20]): Decimal
    var
        ValueEntry: Record "Value Entry";
    begin
        Clear(ValueEntry);
        ValueEntry.Reset();
        ValueEntry.SetCurrentKey("Source Type", "Source No.", "Item Ledger Entry Type", "Document Type");
        ValueEntry.SetRange("Source Type", ValueEntry."Source Type"::Customer);
        ValueEntry.SetRange("Source No.", CustNo);
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetFilter("Item No.", '%1', '1002');
        If ValueEntry.FindSet() then begin
            ValueEntry.CalcSums("Sales Amount (Actual)");
            exit(ValueEntry."Sales Amount (Actual)" / 12);
        end;

        exit(0);
    end;

    procedure DrillDownOnItem2ValueEntry(CustNo: Code[20])
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        ValueEntry: Record "Value Entry";
    begin
        ValueEntry.Reset();
        ValueEntry.SetCurrentKey("Source Type", "Source No.", "Item Ledger Entry Type", "Document Type");
        ValueEntry.SetRange("Source Type", ValueEntry."Source Type"::Customer);
        ValueEntry.SetRange("Source No.", CustNo);
        ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
        ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SetFilter("Item No.", '%1', '1002');
        PAGE.Run(PAGE::"Value Entries", ValueEntry);
    end;

    local procedure ToCreateSaleReqplan(IsModify: Boolean)
    var
        ConfirmAskLbl: Label 'Are you sure to Save to History?';
        replaceAskLbl: Label 'It is already exits Sales Frequency Planning record.\n Are you sure continue?';
        SaleFreqPlanRec2: Record "Sales Frequency Planning";
        Item: Record Item;
        I: Integer;
        PreInv: Decimal;
        PreAgreSale: Integer;
        Replcerec: Boolean;
    begin
        I := 0;
        Item.Reset();
        If Item.FindSet() then
            repeat
                I += 1;
                If not IsModify then
                    SaleFreqPlanRec2.Init();
                SaleFreqPlanRec2."Customer No." := Rec."No.";
                SaleFreqPlanRec2."Item No." := Item."No.";
                SaleFreqPlanRec2.Validate("Sales Date", WorkDate());
                If I = 1 then
                    SaleFreqPlanRec2."Consumer Inventory" := rec.Item1Inv;
                If I = 2 then
                    SaleFreqPlanRec2."Consumer Inventory" := rec.Item2Inv;
                If I = 1 then
                    SaleFreqPlanRec2."Maximum Inventory" := rec.Item1MaxInv;
                If I = 2 then
                    SaleFreqPlanRec2."Maximum Inventory" := rec.Item2MaxInv;
                If I = 1 then
                    SaleFreqPlanRec2."Suggested Sale" := rec.Item1SuggSale;
                If I = 2 then
                    SaleFreqPlanRec2."Suggested Sale" := rec.Item2SuggSale;
                If I = 1 then
                    SaleFreqPlanRec2."Sale Agreed" := rec.Item1AgreSale;
                If I = 2 then
                    SaleFreqPlanRec2."Sale Agreed" := rec.Item2AgreSale;
                If I = 1 then begin
                    Clear(PreInv);
                    Clear(PreAgreSale);
                    ToCalcPeriodTurnover(Item."No.", PreInv, PreAgreSale);
                    If (PreInv + PreAgreSale) <> 0 then
                        SaleFreqPlanRec2."Period Turnover" := (PreInv + PreAgreSale) - rec.Item1Inv
                    else
                        SaleFreqPlanRec2."Period Turnover" := 0;
                end;
                If I = 2 then begin
                    Clear(PreInv);
                    Clear(PreAgreSale);
                    ToCalcPeriodTurnover(Item."No.", PreInv, PreAgreSale);
                    If (PreInv + PreAgreSale) <> 0 then
                        SaleFreqPlanRec2."Period Turnover" := (PreInv + PreAgreSale) - rec.Item2Inv
                    else
                        SaleFreqPlanRec2."Period Turnover" := 0;
                end;
                If I = 1 then
                    SaleFreqPlanRec2."Average Turnover" := rec.Item1AveTurnover;
                If I = 2 then
                    SaleFreqPlanRec2."Average Turnover" := rec.Item2AveTurnover;

                If not IsModify then
                    SaleFreqPlanRec2.Insert()
                else
                    SaleFreqPlanRec2.Modify();
            Until Item.Next() = 0;
        // Make Order
        If (rec.Item1AgreSale <> 0) or (Rec.Item2AgreSale <> 0) then
            MakeCustToSalesOrder(Rec, Rec.Item1AgreSale, Rec.Item2AgreSale);

        // Clear Customer Fields
        rec.Item1PerTurnover := 0;
        Rec.Item2PerTurnover := 0;
        rec.Item1SuggSale := 0;
        rec.Item2SuggSale := 0;
        rec.Item1AgreSale := 0;
        rec.Item2AgreSale := 0;
        rec.Item1Inv := 0;
        rec.Item2Inv := 0;
        rec."Next Visit Date" := WorkDate();
        Rec.Modify(false);
        Message('Done');
    end;

    local procedure MakeCustToSalesOrder(Cust: Record Customer; Item1: Integer; Item2: Integer)
    var
        SalesHrd: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Items: Record Item;
        SalesOrder: Page "Sales Order";
        i: Integer;
    begin
        Clear(SalesHrd);
        SalesHrd.Init();
        SalesHrd.Validate("Document Type", SalesHrd."Document Type"::Order);
        SalesHrd."No." := '';
        SalesHrd.Insert(true);
        SalesHrd.Validate("Sell-to Customer No.", Cust."No.");
        SalesHrd.Validate("Posting Date", WorkDate());
        SalesHrd.Modify(true);

        Clear(i);
        Clear(Items);
        If Items.FindSet() then
            repeat
                i += 1;
                Clear(SalesLine);
                SalesLine.Init();
                SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                SalesLine.Validate("Document No.", SalesHrd."No.");
                If i = 1 then begin
                    SalesLine."Line No." := 10000;
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    SalesLine.Validate("No.", Items."No.");
                    SalesLine.Validate(Quantity, Item1);
                end else begin
                    SalesLine."Line No." := 20000;
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    SalesLine.Validate("No.", Items."No.");
                    SalesLine.Validate(Quantity, Item2);
                end;
                SalesLine.Insert(true);
            Until Items.Next() = 0;

        Commit();
        Page.RunModal(Page::"Sales Order", SalesHrd);
    end;
}