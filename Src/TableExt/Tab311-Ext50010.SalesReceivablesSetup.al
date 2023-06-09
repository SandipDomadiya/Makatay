tableextension 50010 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "IEPS GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ObsoleteState = Removed;
            ObsoleteReason = 'Removed';
        }
        field(50001; "IVA GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
            ObsoleteState = Removed;
            ObsoleteReason = 'Removed';
        }
        field(50002; "IEPS Paid GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50003; "IVA Paid GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50004; "IEPS Not Paid GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50005; "IVA Not Paid GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

    var
        myInt: Integer;
}