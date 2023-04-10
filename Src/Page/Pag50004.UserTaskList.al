page 50004 "User Task List -MAK"
{
    Caption = 'User Tasks';
    CardPageID = "User Task Card - MAK";
    DelayedInsert = true;
    DeleteAllowed = true;
    Editable = true;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "User Task";
    SourceTableView = sorting(ID)
    order(descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the title of the task.';
                    Caption = 'Task';
                    StyleExpr = StyleTxt;
                }
                field("Customer"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
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
                    ToolTip = 'Specifies the value of the Contact No field.';
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleTxt;
                }
                field("Sales Rep."; Rec."Sales Rep.")
                {
                    ToolTip = 'Specifies the value of the Sales Rep. field.';
                    ApplicationArea = All;
                    Visible = false;
                    StyleExpr = StyleTxt;
                }
                field("MAK Priority"; rec."MAK Priority")
                {
                    ToolTip = 'Specifies the value of the Priority field.';
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Status"; rec."Sales Status")
                {
                    ToolTip = 'Specifies the value of the Sales Status field.';
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }

                field(TaskDate; Rec.TaskDate)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Assigned To User Name"; Rec."Assigned To User Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies who the task is assigned to.';
                    StyleExpr = StyleTxt;
                }
                field("Completion Status"; rec."Completion Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion Status field.';
                    StyleExpr = StyleTxt;
                }
                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the task was created.';
                    Visible = false;
                    StyleExpr = StyleTxt;
                }
                field("Completed DateTime"; Rec."Completed DateTime")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies when the task was completed.';
                    Visible = false;
                    StyleExpr = StyleTxt;
                }

                field("Created By User Name"; Rec."Created By User Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies who created the task.';
                    Visible = false;
                    StyleExpr = StyleTxt;
                }

            }
        }
    }

    actions
    {
        area(creation)
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
            action("Mark Complete")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Mark as Completed';
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Indicate that the task is completed. The % Complete field is set to 100.';

                trigger OnAction()
                var
                    UserTask: Record "User Task";
                begin
                    CurrPage.SetSelectionFilter(UserTask);
                    if UserTask.FindSet(true) then
                        repeat
                            UserTask."Completion Status" := UserTask."Completion Status"::Completed;
                            UserTask.SetCompleted;
                            UserTask.Modify();
                        until UserTask.Next() = 0;
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

        }
        area(processing)
        {
            action("Delete User Tasks")
            {
                ApplicationArea = All;
                Caption = 'Delete User Tasks';
                Image = Delete;
                RunObject = Report "User Task Utility";
                ToolTip = 'Find and delete user tasks.';
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.CustomSetStyle();
        Clear(Cust);
        If Cust.get(Rec."Customer No.") then
            Rec."Customer Name" := Cust.Name + '-' + Cust.Distintive;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        FilterUserTasks();
        exit(Rec.Find(Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        FilterUserTasks();
        exit(Rec.Next(Steps));
    end;

    trigger OnOpenPage()
    var
        ShouldOpenToViewPendingTasks: Boolean;
    begin
        if Evaluate(ShouldOpenToViewPendingTasks, rec.GetFilter(ShouldShowPendingTasks)) and ShouldOpenToViewPendingTasks then
            SetPageToShowMyPendingUserTasks;

        Clear(Cust);
        If Cust.get(Rec."Customer No.") then
            Rec."Customer Name" := Cust.Name + '-' + Cust.Distintive;
    end;

    var
        UserTaskManagement: Codeunit "Customization Event";
        StyleTxt: Text;
        IsShowingMyPendingTasks: Boolean;
        IsShowingAllPendingTasks: Boolean;
        Cust: Record Customer;


    [ServiceEnabled]
    procedure SetComplete()
    begin
        Rec.SetCompleted();
        Rec.Modify();
    end;

    local procedure FilterUserTasks()
    begin
        if IsShowingMyPendingTasks then
            UserTaskManagement.SetFiltersToShowMyUserTasks(Rec);
        If IsShowingAllPendingTasks then
            UserTaskManagement.SetFiltersToShowAllTasks(Rec);
    end;

    procedure SetPageToShowMyPendingUserTasks()
    begin
        // This functions sets up this page to show pending tasks assigned to current user
        IsShowingMyPendingTasks := true;
    end;

    procedure SetPageToShowAllPendingTasks()
    begin
        // This functions sets up this page to show pending tasks assigned to current user
        IsShowingAllPendingTasks := true;
    end;
}

