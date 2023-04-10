pageextension 50005 UserTasksActivitiesExt extends "User Tasks Activities"
{
    layout
    {
        modify("My User Tasks")
        {
            Visible = false;
        }
        addafter("My User Tasks")
        {
            cuegroup("My User Tasks2")
            {
                Caption = 'My User Tasks';
                field("CustomCodeunit.GetMyPendingUserTasksCount"; CustomCodeunit.GetMyPendingUserTasksCount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Tasks Today';
                    Image = Checklist;
                    ToolTip = 'Specifies the number of pending tasks that are assigned to you or to a group that you are a member of.';

                    trigger OnDrillDown()
                    var
                        UserTaskList: Page "User Task List -MAK";
                    begin
                        UserTaskList.SetPageToShowMyPendingUserTasks;
                        UserTaskList.Run();
                    end;
                }
            }
            cuegroup("My User Tasks3")
            {
                Caption = 'User Tasks';
                field("CustomCodeunit.GetMyAllPendingTasksCount"; CustomCodeunit.GetMyAllPendingTasksCount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total Pending Tasks';
                    Image = Checklist;
                    ToolTip = 'Specifies the number of all pending tasks that are to a group that you are a member of.';

                    trigger OnDrillDown()
                    var
                        UserTaskList: Page "User Task List -MAK";
                    begin
                        UserTaskList.SetPageToShowAllPendingTasks();
                        UserTaskList.Run();
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
        CustomCodeunit: Codeunit "Customization Event";

}