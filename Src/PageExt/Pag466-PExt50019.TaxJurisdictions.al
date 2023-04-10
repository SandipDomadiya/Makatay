pageextension 50019 TaxJurisdictionsExt extends "Tax Jurisdictions"
{
    layout
    {
        modify("Calculate Tax on Tax")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}