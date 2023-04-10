tableextension 50009 SalesLineExt extends "Sales Line"
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