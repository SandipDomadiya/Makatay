report 50000 CustFollowUpTask
{
    UsageCategory = ReportsAndAnalysis;
    Permissions = TableData Customer = rim;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            trigger OnAfterGetRecord()
            var
                Expre: Text;
                PeriodName: Text[31];
                NewDate: Date;
                DateofWeek: Record Date;
            begin
                If (Customer."Followup Every" <> 0) then begin
                    If (Customer."Customer Preferred Day" <> "Customer Preferred Day"::" ") or (Customer."Next Visit Date" <> 0D) then begin
                        Clear(Expre);
                        Expre := '<' + Format(Customer."Followup Every") + 'D>';
                        NewDate := CALCDATE(Expre, Customer."Next Visit Date");

                        Clear(DateofWeek);
                        If DateofWeek.get(DateofWeek."Period Type"::Date, NewDate) then
                            If DateofWeek."Period Name" = Format(Customer."Customer Preferred Day") then
                                // Call Fun Create Task
                                CreateFollowupTask(Customer)
                            else begin
                                Clear(DateofWeek);
                                Clear(PeriodName);
                                If DateofWeek.get(DateofWeek."Period Type"::Date, WorkDate()) then
                                    PeriodName := DateofWeek."Period Name";
                            end;
                        case PeriodName of
                            'Monday':
                                begin
                                    If Customer."Customer Preferred Day" = Customer."Customer Preferred Day"::Monday then
                                        CreateFollowupTask(Customer);
                                end;
                            'Tuesday':
                                begin
                                    If Customer."Customer Preferred Day" = Customer."Customer Preferred Day"::Tuesday then
                                        CreateFollowupTask(Customer);
                                end;
                            'Wednesday':
                                begin
                                    If Customer."Customer Preferred Day" = Customer."Customer Preferred Day"::Wednesday then
                                        CreateFollowupTask(Customer);
                                end;
                            'Thursday':
                                begin
                                    If Customer."Customer Preferred Day" = Customer."Customer Preferred Day"::Thursday then
                                        CreateFollowupTask(Customer);
                                end;
                            'Friday':
                                begin
                                    If Customer."Customer Preferred Day" = Customer."Customer Preferred Day"::Friday then
                                        CreateFollowupTask(Customer);
                                end;
                            'Saturday':
                                begin
                                    If Customer."Customer Preferred Day" = Customer."Customer Preferred Day"::Saturday then
                                        CreateFollowupTask(Customer);
                                end;

                        end;
                    end else
                        CurrReport.Skip();
                end;
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

    }

    trigger OnPostReport()
    begin
        Message('Done..!!');
    end;


    var
        myInt: Integer;


    local procedure CreateFollowupTask(Cust: Record Customer)
    var
        UserTask: Record "User Task";
    begin
        UserTask.Reset();
        UserTask.Init();
        UserTask."Customer No." := Cust."No.";
        UserTask."Contact No" := Cust."First Cont. Name";
        UserTask."Sales Rep." := Cust."Sales Rep.";
        UserTask."Sales Status" := Cust."Sales Process Status";
        UserTask.Title := 'Follow up';
        UserTask.validate("Assigned To User Name", Cust."Collection Rep.");
        UserTask.TaskDate := WorkDate();
        UserTask.Insert(true);
    end;
}