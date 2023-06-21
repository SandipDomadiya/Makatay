tableextension 50012 PurchasesPayablesSetupExt extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "IEPS Paid GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50001; "IVA Paid GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50002; "IEPS Not Paid GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50003; "IVA Not Paid GLA/c"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

    var
        myInt: Integer;
}