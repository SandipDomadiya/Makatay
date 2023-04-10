page 50001 "CustomerRatingBox"
{
    Caption = 'Customer Rating';
    DeleteAllowed = false;
    InsertAllowed = false;
    //LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            field(Rating; Rec.Rating)
            {
                ApplicationArea = All;
                ShowCaption = false;
                MultiLine = true;
                Style = Unfavorable;
                DecimalPlaces = 0;
            }
            field("Rating ColorName"; Rec."Rating ColorName")
            {
                ShowCaption = false;
                Style = Strong;
                ApplicationArea = All;
            }
        }
    }


}