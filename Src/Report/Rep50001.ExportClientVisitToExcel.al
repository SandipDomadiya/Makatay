report 50001 ExportClientVisitToExcel
{
    Caption = 'Export Client Visit To Excel';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            Var
                CurrDate: Date;
                ColByDate: Date;
                PreDate: Date;
                NoOfIntval: Integer;
                NoOfDay: Integer;
                DateFor: Text;
                PreFor: text;
                DisDate: Integer;
            begin
                CLEAR(ExcelBuffer);
                ExcelBuffer.AddColumn(Customer.Name.ToUpper(), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Customer."No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(StrSubstNo(Lbl001, Customer."Frequency (Days)"), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.NewRow();
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(Lbl002, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(Lbl003, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(Lbl004, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(Lbl005, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                Clear(NoOfIntval);
                Clear(NoOfDay);
                Clear(DateFor);
                Clear(ColByDate);
                NoOfIntval := Round(120 / Customer."Frequency (Days)", 1, '=');
                NoOfDay := NoOfIntval * Customer."Frequency (Days)";
                DateFor := '<' + Format(NoOfDay) + 'D>';
                ColByDate := CalcDate(DateFor, Today);
                DateFor := '<-' + Format(Customer."Frequency (Days)") + 'D>';
                repeat
                    Clear(DisDate);
                    DisDate := DATE2DMY(ColByDate, 3);
                    ExcelBuffer.AddColumn(DelStr(Format(DisDate), 2, 2), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ColByDate := CalcDate(DateFor, ColByDate);
                Until ColByDate < CalcDate('<-1D>', today);


                ExcelBuffer.NewRow();
                //ExcelBuffer.AddColumn(Customer.FieldCaption("First Appointment Date"), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                //ExcelBuffer.AddColumn(Customer."First Appointment Date", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                Clear(NoOfIntval);
                Clear(NoOfDay);
                Clear(DateFor);
                Clear(ColByDate);
                NoOfIntval := Round(120 / Customer."Frequency (Days)", 1, '=');
                NoOfDay := NoOfIntval * Customer."Frequency (Days)";
                DateFor := '<' + Format(NoOfDay) + 'D>';
                ColByDate := CalcDate(DateFor, Today);
                DateFor := '<-' + Format(Customer."Frequency (Days)") + 'D>';
                repeat
                    Clear(DisDate);
                    DisDate := DATE2DMY(ColByDate, 2);
                    ExcelBuffer.AddColumn(Format(DisDate), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ColByDate := CalcDate(DateFor, ColByDate);
                Until ColByDate < CalcDate('<-1D>', today);

                ExcelBuffer.NewRow();
                //ExcelBuffer.AddColumn(Customer.FieldCaption("Preferred Timings"), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                //ExcelBuffer.AddColumn(Customer."Preferred Timings", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Time);

                Clear(NoOfIntval);
                Clear(NoOfDay);
                Clear(DateFor);
                Clear(ColByDate);
                NoOfIntval := Round(120 / Customer."Frequency (Days)", 1, '=');
                NoOfDay := NoOfIntval * Customer."Frequency (Days)";
                DateFor := '<' + Format(NoOfDay) + 'D>';
                ColByDate := CalcDate(DateFor, Today);
                DateFor := '<-' + Format(Customer."Frequency (Days)") + 'D>';
                repeat
                    Clear(DisDate);
                    DisDate := Date2DMY(ColByDate, 1);
                    ExcelBuffer.AddColumn(Format(DisDate), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ColByDate := CalcDate(DateFor, ColByDate);
                Until ColByDate < CalcDate('<-1D>', today);

                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Lbl006, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.NewRow();

                Items.Reset();
                Items.SetFilter("No.", '%1|%2', '1896-S', '1900-S');
                If Items.FindSet() then
                    repeat
                        ExcelBuffer.AddColumn(Items."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                        Clear(NoOfIntval);
                        Clear(NoOfDay);
                        Clear(DateFor);
                        Clear(ColByDate);
                        NoOfIntval := Round(120 / Customer."Frequency (Days)", 1, '=');
                        NoOfDay := NoOfIntval * Customer."Frequency (Days)";
                        DateFor := '<' + Format(NoOfDay) + 'D>';
                        ColByDate := CalcDate(DateFor, Today);
                        DateFor := '<-' + Format(Customer."Frequency (Days)") + 'D>';
                        repeat
                            ExcelBuffer.AddColumn(Format(GetvalueTable(1, Customer."No.", Items."No.", ColByDate)), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                            ColByDate := CalcDate(DateFor, ColByDate);
                        Until ColByDate < CalcDate('<-1D>', today);
                        ExcelBuffer.NewRow();
                    until Items.Next() = 0;

                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Lbl007, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.NewRow();

                Items.Reset();
                Items.SetFilter("No.", '%1|%2', '1896-S', '1900-S');
                If Items.FindSet() then
                    repeat
                        ExcelBuffer.AddColumn(Items."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                        Clear(NoOfIntval);
                        Clear(NoOfDay);
                        Clear(DateFor);
                        Clear(ColByDate);
                        NoOfIntval := Round(120 / Customer."Frequency (Days)", 1, '=');
                        NoOfDay := NoOfIntval * Customer."Frequency (Days)";
                        DateFor := '<' + Format(NoOfDay) + 'D>';
                        ColByDate := CalcDate(DateFor, Today);
                        DateFor := '<-' + Format(Customer."Frequency (Days)") + 'D>';
                        repeat
                            ExcelBuffer.AddColumn(Format(GetvalueTable(2, Customer."No.", Items."No.", ColByDate)), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                            ColByDate := CalcDate(DateFor, ColByDate);
                        Until ColByDate < CalcDate('<-1D>', today);

                        ExcelBuffer.NewRow();
                    until Items.Next() = 0;

                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Lbl008, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

                Clear(NoOfIntval);
                Clear(NoOfDay);
                Clear(DateFor);
                Clear(ColByDate);
                NoOfIntval := Round(120 / Customer."Frequency (Days)", 1, '=');
                NoOfDay := NoOfIntval * Customer."Frequency (Days)";
                DateFor := '<' + Format(NoOfDay) + 'D>';
                ColByDate := CalcDate(DateFor, Today);
                DateFor := '<-' + Format(Customer."Frequency (Days)") + 'D>';
                repeat
                    ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ColByDate := CalcDate(DateFor, ColByDate);
                Until ColByDate < CalcDate('<-1D>', today);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(StrSubstNo(Lbl009, Customer."Frequency (Days)"), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.NewRow();

                Items.Reset();
                Items.SetFilter("No.", '%1|%2', '1896-S', '1900-S');
                If Items.FindSet() then
                    repeat
                        ExcelBuffer.AddColumn(Items."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(Format(Items."Maximum Inventory (SFP)"), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        //Data
                        J := 0;
                        Clear(NoOfIntval);
                        Clear(NoOfDay);
                        Clear(DateFor);
                        Clear(ColByDate);
                        NoOfIntval := Round(120 / Customer."Frequency (Days)", 1, '=');
                        NoOfDay := NoOfIntval * Customer."Frequency (Days)";
                        DateFor := '<' + Format(NoOfDay) + 'D>';
                        ColByDate := CalcDate(DateFor, Today);
                        PreDate := ColByDate;
                        DateFor := '<-' + Format(Customer."Frequency (Days)") + 'D>';
                        PreFor := '<-' + Format(Customer."Frequency (Days)") + 'D>';
                        repeat
                            PreDate := CalcDate(PreFor, PreDate);
                            I := +GetvalueTable(2, Customer."No.", Items."No.", PreDate) + GetvalueTable(1, Customer."No.", Items."No.", ColByDate) - GetvalueTable(2, Customer."No.", Items."No.", ColByDate);
                            ExcelBuffer.AddColumn(Format(I), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                            ColByDate := CalcDate(DateFor, ColByDate);
                            J += I;
                        Until ColByDate < CalcDate('<-1D>', today);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(Format(round(J / 15)), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(Format(J), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.NewRow();

                    until Items.Next() = 0;
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
    trigger OnPreReport()
    var
        FillLblErr: Label 'Customer No. is required.';
    begin
        If Customer.GetFilter("No.") = '' then
            Error(FillLblErr);
    end;

    trigger OnPostReport();
    begin
        ExcelBuffer.CreateNewBook('Data');
        ExcelBuffer.WriteSheet(FORMAT(WORKDATE), COMPANYNAME, USERID);
        ExcelBuffer.CloseBook;
        ExcelBuffer.OpenExcel;

        ExcelBuffer.DELETEALL;
        CLEAR(ExcelBuffer);
    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        Items: Record Item;
        HdDate: array[6] of Date;
        I: Decimal;
        J: Decimal;
        Lbl001: Label 'Client Visit Frequency Every %1 days';
        Lbl002: Label 'Sales Monthly Average one Year Back';
        Lbl003: Label 'Sales Monthly Average Last Year';
        Lbl004: Label 'Sales Monthly Average Last 4 Months';
        Lbl005: Label 'Sales Average Last Month';
        Lbl006: Label 'Suggested Sales';
        Lbl007: Label 'Consumer Inventory';
        Lbl008: Label 'Maximum Inventory';
        Lbl009: Label 'Customer %1 Day Average Sales';


    local procedure CalcMonthOfArray(Freq: Integer)
    var
        Expre: text;
    begin
        Expre := '<' + Format(Freq) + 'D>';
        HdDate[1] := CALCDATE('-CM', Today);
        HdDate[2] := CALCDATE(Expre, HdDate[1]);
        HdDate[3] := CALCDATE(Expre, HdDate[2]);
        HdDate[4] := CALCDATE(Expre, HdDate[3]);
        HdDate[5] := CALCDATE(Expre, HdDate[4]);

    end;

    local procedure GetvalueTable(i: Integer; CustNo: Code[20]; Itemno: Code[20]; SalesDate: Date): Decimal
    var
        SalesFreqPlanRec: Record "Sales Frequency Planning";
    begin
        If i = 1 then begin
            Clear(SalesFreqPlanRec);
            If SalesFreqPlanRec.Get(CustNo, Itemno, SalesDate) then
                exit(SalesFreqPlanRec."Sale Agreed")
        end else
            if I = 2 then begin
                Clear(SalesFreqPlanRec);
                If SalesFreqPlanRec.Get(CustNo, Itemno, SalesDate) then
                    exit(SalesFreqPlanRec."Consumer Inventory")
            end else
                If I = 3 then begin
                    Clear(SalesFreqPlanRec);
                    If SalesFreqPlanRec.Get(CustNo, Itemno, SalesDate) then
                        exit(SalesFreqPlanRec."Maximum Inventory")
                end;

    end;

}