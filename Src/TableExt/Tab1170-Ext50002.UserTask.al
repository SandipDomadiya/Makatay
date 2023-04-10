tableextension 50002 UserTaskExt extends "User Task"
{

    fields
    {
        field(50000; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Contact No"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Sales Rep."; Code[50])
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Editable = false;
            TableRelation = User."User Name";
        }
        field(50003; "Sales Status"; Enum "Sales Process Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Completion Status"; Enum "Completion Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "MAK Priority"; Enum "MAK Priority")
        {
            DataClassification = ToBeClassified;
            Caption = 'Priority';
        }
        field(50006; TaskDate; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date';
        }
        field(50007; "Customer Name"; Text[150])
        {
            //FieldClass = FlowField;
            //CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
        }
        field(50011; SalesProcessID; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;

    procedure SetCanceled()
    begin
        rec."Completion Status" := rec."Completion Status"::Cancelled;
        rec."Completed By" := UserSecurityId;
        rec."Completed DateTime" := CurrentDateTime;
        rec."Percent Complete" := 0;
        rec.Modify(false);
    end;

    procedure SetUnMark()
    begin
        rec."Completion Status" := rec."Completion Status"::" ";
        Rec."Completed By" := UserSecurityId;
        Rec."Completed DateTime" := CurrentDateTime;
        rec."Percent Complete" := 0;
        rec.Modify(false);
    end;

    procedure CustomSetStyle(): Text
    begin
        if Rec."Sales Status" = Rec."Sales Status"::"0. Customer Denied" then begin
            exit('Unfavorable')
        end;
        exit('');
    end;
}