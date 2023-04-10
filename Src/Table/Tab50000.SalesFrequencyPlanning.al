table 50000 "Sales Frequency Planning"
{
    Caption = 'Sales Frequency Planning';

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(3; "Sales Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                // Clear(Cust);
                // If Cust.get("Customer No.") then
                //     If Cust."Next Visit Date" < Today then begin
                //         Cust."Next Visit Date" := "Sales Date";
                //         Cust.Modify(false);
                //     end;
            end;
        }
        field(5; "Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Customer".Name WHERE("No." = FIELD("Customer No.")));
        }
        field(6; Days; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Description"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description where("No." = field("Item No.")));
        }
        field(11; "Maximum Inventory"; Decimal)
        {
            Caption = 'Maximum Inventory';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(12; "Consumer Inventory"; Decimal)
        {
            Caption = 'Consumer Inventory';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(13; "Sale Agreed"; Decimal)
        {
            Caption = 'Sale Agreed';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(14; "Period Turnover"; Decimal)
        {
            Caption = 'Period Turnover';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(15; "Suggested Sale"; Decimal)
        {
            Caption = 'Suggested Sale';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(16; "Average Turnover"; Decimal)
        {
            Caption = 'Average Turnover';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Customer No.", "Item No.", "Sales Date")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}