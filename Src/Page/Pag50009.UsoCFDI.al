page 50009 "UsoCFDI"
{
    PageType = List;
    SourceTable = "Uso CFDI";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    var
        myInt: Integer;
}