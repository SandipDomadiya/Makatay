tableextension 50003 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50000; "CFDI PPD PDF FileName"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "CFDI PPD PDF"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "CFDI PPD XML FileName"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "CFDI PPD XML"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Proof of Delivery FileName"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Proof of Delivery"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "CFDI RP PDF FileName"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "CFDI RP PDF"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "CFDI RP XML FileName"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "CFDI RP XML"; Media)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Proof of Payment FileName"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Proof of Payment"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(50020; Distintive; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; Cluster; Enum Cluster)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Channel"; Enum "Channel Type")
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Colonia"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; Alcaldía; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "IEPS Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."IEPS Amt." WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No.")));
            Caption = 'IEPS Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; "IVA Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."IVA Amt." WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No.")));
            Caption = 'IVA Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    var


    procedure Export(ShowFileDialog: Boolean; Refno: Integer): Text
    var
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DocumentStream: OutStream;
        FullFileName: Text;
    begin
        case Refno of
            1:
                begin
                    // Ensure document has value in DB
                    if not "CFDI PPD PDF".HasValue then
                        exit;

                    FullFileName := "CFDI PPD PDF FileName";
                    TempBlob.CreateOutStream(DocumentStream);
                    "CFDI PPD PDF".ExportStream(DocumentStream);
                    exit(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
                end;
            2:
                begin
                    // Ensure document has value in DB
                    if not "CFDI PPD XML".HasValue then
                        exit;

                    FullFileName := "CFDI PPD XML FileName";
                    TempBlob.CreateOutStream(DocumentStream);
                    "CFDI PPD XML".ExportStream(DocumentStream);
                    exit(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
                end;
            3:
                begin
                    // Ensure document has value in DB
                    if not "Proof of Delivery".HasValue then
                        exit;

                    FullFileName := "Proof of Delivery FileName";
                    TempBlob.CreateOutStream(DocumentStream);
                    "Proof of Delivery".ExportStream(DocumentStream);
                    exit(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
                end;
            4:
                begin
                    // Ensure document has value in DB
                    if not "CFDI RP PDF".HasValue then
                        exit;

                    FullFileName := "CFDI RP PDF FileName";
                    TempBlob.CreateOutStream(DocumentStream);
                    "CFDI RP PDF".ExportStream(DocumentStream);
                    exit(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
                end;
            5:
                begin
                    // Ensure document has value in DB
                    if not "CFDI RP XML".HasValue then
                        exit;

                    FullFileName := "CFDI RP XML FileName";
                    TempBlob.CreateOutStream(DocumentStream);
                    "CFDI RP XML".ExportStream(DocumentStream);
                    exit(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
                end;
            6:
                begin
                    // Ensure document has value in DB
                    if not "Proof of Payment".HasValue then
                        exit;

                    FullFileName := "Proof of Payment FileName";
                    TempBlob.CreateOutStream(DocumentStream);
                    "Proof of Payment".ExportStream(DocumentStream);
                    exit(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
                end;
        end;
    end;


}