tableextension 50008 PurchInvHeaderExt extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Type of Invoice"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Type of Invoice";
        }
        field(50001; "Uso CFDI"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Uso CFDI";
        }
        field(50002; "UUID"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}