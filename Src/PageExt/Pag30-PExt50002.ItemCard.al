pageextension 50002 ItemCardExt extends "Item Card"
{
    layout
    {
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("SAT Hazardous Material")
        {
            Visible = false;
        }
        modify("SAT Item Classification")
        {
            Visible = false;
        }
        modify("SAT Packaging Type")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify(ForeignTrade)
        {
            Visible = false;
        }
        modify(Reserve)
        {
            Visible = false;
        }
        modify("Dampener Period")
        {
            Visible = false;
        }
        modify("Dampener Quantity")
        {
            Visible = false;
        }
        modify(Critical)
        {
            Visible = false;
        }
        modify(ItemTracking)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        addafter("Search Description")
        {
            field("Maximum Inventory (SFP)"; rec."Maximum Inventory (SFP)")
            {
                ToolTip = 'Specifies the value of the Maximum Inventory (SFP) field.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}