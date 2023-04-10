tableextension 50007 PurchaseHeaderExt extends "Purchase Header"
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
        field(50010; "IEPS Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."IEPS Amt." WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No.")));
            Caption = 'IEPS Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "IVA Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."IVA Amt." WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No.")));
            Caption = 'IVA Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    var
        myInt: Integer;
}