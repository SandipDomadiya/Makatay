tableextension 50001 ItemExt extends Item
{
    fields
    {
        field(50000; "Maximum Inventory (SFP)"; Decimal)
        {
            Caption = 'Maximum Inventory (SFP)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
    }


}