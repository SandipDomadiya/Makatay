pageextension 50003 UserTaskListExt extends "User Task List"
{
    layout
    {
        modify("Due DateTime")
        {
            Visible = false;
        }
        modify("Percent Complete")
        {
            Visible = false;
        }
        modify(Priority)
        {
            Visible = false;
        }
        modify("User Task Group Assigned To")
        {
            Visible = false;
        }
        modify(Title)
        {
            Caption = 'Task';
        }

        addafter(Priority)
        {
            field("Customer"; Rec."Customer Name")
            {
                ToolTip = 'Specifies the value of the Customer Name field.';
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                    Cust: Record Customer;
                    CustPage: Page "Customer Card";
                begin
                    Clear(Cust);
                    Cust.get(Rec."Customer No.");
                    CustPage.SetRecord(Cust);

                    CustPage.LookupMode := true;
                    if CustPage.RunModal = ACTION::LookupOK then begin
                        CustPage.GetRecord(Cust);
                        CurrPage.Update(true);
                    end;
                end;
            }
            field("Contact"; Rec."Contact No")
            {
                ToolTip = 'Specifies the value of the Contact No field.';
                ApplicationArea = All;
            }
            field("Sales Rep."; Rec."Sales Rep.")
            {
                ToolTip = 'Specifies the value of the Sales Rep. field.';
                ApplicationArea = All;
            }
            field("MAK Priority"; rec."MAK Priority")
            {
                ToolTip = 'Specifies the value of the Priority field.';
                ApplicationArea = All;
            }
            field("Status"; rec."Sales Status")
            {
                ToolTip = 'Specifies the value of the Sales Status field.';
                ApplicationArea = All;
            }
            field(TaskDate; Rec.TaskDate)
            {
                ToolTip = 'Specifies the value of the Date field.';
                ApplicationArea = All;
            }
            field("Completion Status"; rec."Completion Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Completion Status field.';
            }
        }
    }

    actions
    {
        modify("Go To Task Item")
        {
            Visible = false;
        }
        addafter("Mark Complete")
        {
            action("Mark Cancelled")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Mark Cancelled';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Mark the task as Cancelled.';

                trigger OnAction()
                begin
                    // Marks the current task as Canceled.
                    Rec.SetCanceled();
                    CurrPage.Update(true);
                end;
            }
        }
        addbefore("Mark Complete")
        {
            action("Unmark")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Unmark';
                Image = SelectField;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Unmark the task';

                trigger OnAction()
                begin
                    // Marks the current task as Canceled.
                    Rec.SetUnMark();
                    CurrPage.Update(true);
                end;
            }
        }
    }

    var
        Cust: Record Customer;

    trigger OnOpenPage()
    begin
        Clear(Cust);
        If Cust.get(Rec."Customer No.") then
            Rec."Customer Name" := Cust.Name + '-' + Cust.Distintive;
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(Cust);
        If Cust.get(Rec."Customer No.") then
            Rec."Customer Name" := Cust.Name + '-' + Cust.Distintive;
    end;
}