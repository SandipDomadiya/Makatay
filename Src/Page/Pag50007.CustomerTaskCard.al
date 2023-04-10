page 50007 "Customer Task Card"
{
    Caption = 'Customer Task';
    PageType = Card;
    SourceTable = "User Task";
    InsertAllowed = false;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Caption = 'Task';
                    ToolTip = 'Specifies the title of the task.';
                }
                field(MultiLineTextControl; MultiLineTextControl)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Note';
                    MultiLine = true;
                    ToolTip = 'Specifies what the task is about.';

                    trigger OnValidate()
                    begin
                        Rec.SetDescription(MultiLineTextControl);
                    end;
                }
                field("Assigned To User Name"; Rec."Assigned To User Name")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    ToolTip = 'Specifies who the task is assigned to.';
                    Caption = 'Task Assigned To';

                    trigger OnAssistEdit()
                    var
                        User: Record User;
                        Users: Page Users;
                    begin
                        if User.Get(Rec."Assigned To") then
                            Users.SetRecord(User);

                        Users.LookupMode := true;
                        if Users.RunModal = ACTION::LookupOK then begin
                            Users.GetRecord(User);
                            Rec.Validate("Assigned To", User."User Security ID");
                            CurrPage.Update(true);
                        end;
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sales Rep."; Rec."Sales Rep.")
                {
                    ToolTip = 'Specifies the value of the Sales Rep. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By User Name"; Rec."Created By User Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies who created the task.';
                    Caption = 'User';
                }

            }
            group(Status)
            {
                Caption = 'Status';
                field(TaskDate; Rec.TaskDate)
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = All;
                }
                field("MAK Priority"; Rec."MAK Priority")
                {
                    Caption = 'Priority';
                    ToolTip = 'Specifies the value of the Priority field.';
                    ApplicationArea = All;
                }
                field("Completion Status"; Rec."Completion Status")
                {
                    ToolTip = 'Specifies the value of the Completion Status field.';
                    ApplicationArea = All;
                }

            }

        }
    }

    actions
    {
        area(processing)
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
            action("Mark Completed")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Mark Completed';
                Enabled = IsMarkCompleteEnabled;
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Mark the task as completed.';

                trigger OnAction()
                begin
                    // Marks the current task as completed.
                    Rec.SetCompleted();
                    CurrPage.Update(true);
                end;
            }
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
            action(Recurrence)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Recurrence';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Make this a recurring task.';

                trigger OnAction()
                var
                    UserTaskRecurrence: Page "User Task Recurrence";
                begin
                    UserTaskRecurrence.SetInitialData(Rec);
                    UserTaskRecurrence.RunModal();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Clear(Cust);
        If Cust.get(Rec."Customer No.") then
            Rec."Customer Name" := Cust.Name + '-' + Cust.Distintive;
    end;

    trigger OnAfterGetRecord()
    begin
        MultiLineTextControl := Rec.GetDescription();
        IsMarkCompleteEnabled := not Rec.IsCompleted();
        Clear(Cust);
        If Cust.get(Rec."Customer No.") then
            Rec."Customer Name" := Cust.Name + '-' + Cust.Distintive;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := UserSecurityId();
        Rec.Validate("Created DateTime", CurrentDateTime());
        Rec.CalcFields("Created By User Name");

        Clear(MultiLineTextControl);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF Rec.Title = '' then
            Rec.Delete(true);
    end;


    var
        MultiLineTextControl: Text;
        IsMarkCompleteEnabled: Boolean;
        Cust: Record Customer;

    local procedure DisplayObjectName(): Text
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        AllObjWithCaption.SetRange("Object Type", Rec."Object Type");
        AllObjWithCaption.SetRange("Object ID", Rec."Object ID");
        if AllObjWithCaption.FindFirst() then
            exit(AllObjWithCaption."Object Name");
    end;

}

