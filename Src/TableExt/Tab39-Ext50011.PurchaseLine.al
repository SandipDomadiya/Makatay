tableextension 50011 PurchaseLineExt extends "Purchase Line"
{
    fields
    {
        field(50000; "IEPS Amt."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "IVA Amt."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}