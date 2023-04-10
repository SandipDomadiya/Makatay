pageextension 50017 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Quantity Shipped")
        {
            Visible = false;
        }
        modify("Qty. to Ship")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. to Invoice")
        {
            Visible = false;
        }
        modify("Quantity Invoiced")
        {
            Visible = false;
        }
        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Planned Shipment Date")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        addafter("Amount Including VAT")
        {
            field("IEPS Amt."; Rec."IEPS Amt.")
            {
                ToolTip = 'Specifies the value of the IEPS Amt. field.';
                ApplicationArea = All;
                Editable = false;
            }
            field("IVA Amt."; Rec."IVA Amt.")
            {
                ToolTip = 'Specifies the value of the IVA Amt. field.';
                ApplicationArea = All;
                Editable = false;
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