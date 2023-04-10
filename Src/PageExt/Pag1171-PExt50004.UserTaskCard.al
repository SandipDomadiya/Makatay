pageextension 50004 UserTaskCardExt extends "User Task Card"
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
        modify("Task Item")
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
        modify("Start DateTime")
        {
            Visible = false;
        }
        modify(Title)
        {
            Caption = 'Task';
        }
        modify(MultiLineTextControl)
        {
            Caption = 'Note';
        }
        modify("Completed By User Name")
        {
            Visible = false;
        }
        modify("Completed DateTime")
        {
            Visible = false;
        }
        modify("Created By User Name")
        {
            Caption = 'User';
        }
        modify("Created DateTime")
        {
            Visible = false;
        }


        addbefore("Created By User Name")
        {
            field("Customer"; rec."Customer Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Name field.';
                Editable = false;
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
            field("Contact No"; Rec."Contact No")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Contact No field.';
                Editable = false;
                Visible = false;
            }
            field("Sales Rep."; Rec."Sales Rep.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Rep. field.';
                Editable = false;
                Visible = false;

            }
            field("Sales Status"; Rec."Sales Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Status field.';
                Editable = false;
            }
        }
        addbefore("Completed By User Name")
        {
            field("Completion Status"; rec."Completion Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Completion Status field.';
            }
        }
        addafter("Start DateTime")
        {
            field(TaskDate; Rec.TaskDate)
            {
                ToolTip = 'Specifies the value of the Date field.';
                ApplicationArea = All;
            }
            field("MAK Priority"; rec."MAK Priority")
            {
                ToolTip = 'Specifies the value of the Priority field.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        modify("Go To Task Item")
        {
            Visible = false;
        }
        addafter("Mark Completed")
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
        addbefore("Mark Completed")
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