pageextension 50001 CustomerListExt extends "Customer List"
{
    PromotedActionCategories = 'New,Process,Report,Approve,New Document,Request Approval,Customer,Navigate,Prices & Discounts,Sales Frequency Planning';
    layout
    {
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        addafter(Name)
        {
            field(Channel; rec.Channel)
            {
                ToolTip = 'Specifies the value of the Channel field.';
                ApplicationArea = All;
            }
            field("Sales Process Status"; Rec."Sales Process Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Process Status field.';
                Editable = false;
            }
        }
    }

    actions
    {
        addafter("&Customer")
        {
            group("Sales Frequency Planning ")
            {
                Image = SalesPurchaseTeam;
                action("Sales Frequency Planning List")
                {
                    ApplicationArea = All;
                    Image = SalesPurchaseTeam;
                    Promoted = true;
                    PromotedCategory = Category6;

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

}