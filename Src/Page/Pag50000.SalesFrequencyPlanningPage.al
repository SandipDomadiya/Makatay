page 50000 "Sales Frequency Planning"
{
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Frequency Planning";
    SourceTableView = sorting("Customer No.", "Sales Date") order(descending);
    Caption = 'Frequency Planning History';


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("CustomerNo"; "CustomerFilter")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer No.';
                    ToolTip = 'Specifies the value of the Customer No. Filter field.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustList: Page "Customer List";
                    begin
                        CustList.LookupMode := true;
                        if CustList.RunModal = ACTION::LookupOK then
                            Text := CustList.GetSelectionFilter
                        else
                            exit(false);

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        CustomerNoFilterOnAfterValidate;
                    end;
                }

                field(ItemNoFilterCtrl; ItemNoFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item No.';
                    ToolTip = 'Specifies a filter for which sales to display.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page "Item List";
                    begin
                        ItemList.LookupMode := true;
                        if ItemList.RunModal = ACTION::LookupOK then
                            Text := ItemList.GetSelectionFilter
                        else
                            exit(false);

                        exit(true);
                    end;

                    trigger OnValidate()
                    begin
                        ItemNoFilterOnAfterValidate;
                    end;
                }
                field(SalesDateFilter; SalesDateFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Date Filter';
                    ToolTip = 'Specifies a filter for which sales to display.';

                    trigger OnValidate()
                    var
                        FilterTokens: Codeunit "Filter Tokens";
                    begin
                        FilterTokens.MakeDateFilter(SalesDateFilter);
                        SalesDateFilterOnAfterValid;
                    end;
                }

            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    Editable = false;
                    Visible = false;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                    Editable = false;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item for which the sales price is valid.';
                    Editable = false;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Sales Date"; rec."Sales Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date from which the sales is valid.';
                    Editable = false;
                }

                field("Maximum Inventory"; rec."Maximum Inventory")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Maximum Inventory field.';
                    Editable = false;
                }
                field("Period Turnover"; Rec."Period Turnover")
                {
                    ToolTip = 'Specifies the value of the Period Turnover field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Average Turnover"; Rec."Average Turnover")
                {
                    ToolTip = 'Specifies the value of the Average Turnover field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consumer Inventory"; Rec."Consumer Inventory")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Consumer Inventory field.';
                    Editable = false;
                }
                field("Suggested Sale"; Rec."Suggested Sale")
                {
                    ToolTip = 'Specifies the value of the Suggested Sale field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sale Agreed"; Rec."Sale Agreed")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Sale Agreed field.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Scheduler Generate")
            {
                ApplicationArea = All;
                ToolTip = 'Executes the Scheduler Generate action.';
                Image = SwitchCompanies;

                trigger OnAction()
                var
                    SalesFreqPlannRec: Record "Sales Frequency Planning";
                    SalesFreqPlannRec2: Record "Sales Frequency Planning";
                    Cust: Record Customer;
                    Item: Record Item;
                    Expre: Text;
                    TDate: Date;
                begin
                    SalesFreqPlannRec.Reset();
                    SalesFreqPlannRec.SetRange("Customer No.", CustomerFilter);
                    SalesFreqPlannRec.SetFilter("Sales Date", '<>%1', 0D);
                    If SalesFreqPlannRec.FindLast() then begin
                        Clear(SalesFreqPlannRec2);
                        SalesFreqPlannRec2.Init();
                        SalesFreqPlannRec2."Customer No." := CustomerFilter;
                        SalesFreqPlannRec2."Item No." := ItemNoFilter;
                        Clear(Cust);
                        Cust.get(SalesFreqPlannRec."Customer No.");
                        Expre := '<' + Format(Cust."Frequency (Days)") + 'D>';
                        TDate := CALCDATE(Expre, SalesFreqPlannRec."Sales Date");
                        SalesFreqPlannRec2.validate("Sales Date", TDate);
                        Clear(Item);
                        Item.get(ItemNoFilter);
                        SalesFreqPlannRec2."Maximum Inventory" := Item."Maximum Inventory (SFP)";
                        SalesFreqPlannRec2.Insert();
                        Message('Done!!');
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        IsOnMobile := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Phone;

        GetRecFilters;
        SetRecFilters;
    end;

    var
        SalesDateFilter: Text[30];
        IsOnMobile: Boolean;
        ClientTypeManagement: Codeunit "Client Type Management";

    protected var
        CustomerFilter: Text;
        ItemNoFilter: Text;

    local procedure CustomerNoFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;

    local procedure ItemNoFilterOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;

    local procedure SalesDateFilterOnAfterValid()
    begin
        CurrPage.SaveRecord;
        SetRecFilters;
    end;

    local procedure GetRecFilters()
    begin
        if rec.GetFilters <> '' then
            UpdateBasicRecFilters;

        Evaluate(SalesDateFilter, rec.GetFilter("Sales Date"));
    end;

    local procedure UpdateBasicRecFilters()
    begin
        CustomerFilter := rec.GetFilter("Customer No.");
        ItemNoFilter := rec.GetFilter("Item No.");
    end;

    procedure SetRecFilters()
    begin
        If CustomerFilter <> '' then
            rec.SetRange("Customer No.", CustomerFilter)
        else
            rec.SetRange("Customer No.");

        if SalesDateFilter <> '' then
            rec.SetFilter("Sales Date", SalesDateFilter)
        else
            rec.SetRange("Sales Date");

        if ItemNoFilter <> '' then begin
            rec.SetFilter("Item No.", ItemNoFilter);
        end else
            rec.SetRange("Item No.");

        CheckFilters(DATABASE::Customer, CustomerFilter);
        CheckFilters(DATABASE::Item, ItemNoFilter);

        CurrPage.Update(false);
    end;

    local procedure CheckFilters(TableNo: Integer; FilterTxt: Text)
    var
        FilterRecordRef: RecordRef;
        FilterFieldRef: FieldRef;
        Text001: Label 'No %1 within the filter %2.';
    begin
        if FilterTxt = '' then
            exit;
        Clear(FilterRecordRef);
        Clear(FilterFieldRef);
        FilterRecordRef.Open(TableNo);
        FilterFieldRef := FilterRecordRef.Field(1);
        FilterFieldRef.SetFilter(FilterTxt);
        if FilterRecordRef.IsEmpty() then
            Error(Text001, FilterRecordRef.Caption, FilterTxt);
    end;

}