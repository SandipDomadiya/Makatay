pageextension 50006 SalesOrderExt extends "Sales Order"
{
    layout
    {
        modify("Sell-to Address 2")
        {
            Visible = false;
        }
        modify("Sell-to County")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        modify("Promised Delivery Date")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Invoice Details")
        {
            Visible = false;
        }
        modify("Shipping and Billing")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify(Control1900201301)
        {
            Visible = false;
        }
        modify(ElectronicDocument)
        {
            Visible = false;
        }
        moveafter("External Document No."; "Location Code")
        addafter("Sell-to Customer Name")
        {
            field(Distintive; Rec.Distintive)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Distintive field.';
            }
        }
        moveafter(Status; "Tax Liable")
        moveafter("Tax Liable"; "Tax Area Code")
        addbefore("Sell-to Address")
        {
            field(Cluster; Rec.Cluster)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Cluster field.';
            }
            field(Channel; Rec.Channel)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Channel field.';
            }

        }
        addafter("Sell-to Address")
        {
            field(Colonia; Rec.Colonia)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Colonia field.';
            }
            field("Alcaldía"; Rec."Alcaldía")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Alcaldía field.';
            }

        }
        addlast(General)
        {
            group(Attachments)
            {
                field("CFDI PPD PDF"; Rec."CFDI PPD PDF FileName")
                {
                    ToolTip = 'Specifies the value of the CFDI PPD PDF field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'CFDI PPD PDF';
                    trigger OnDrillDown()
                    begin
                        if Rec."CFDI PPD PDF".HasValue then
                            Rec.Export(true, 1)
                        else
                            InitiateUploadFile(1)

                    end;
                }
                field("CFDI PPD XML"; rec."CFDI PPD XML FileName")
                {
                    ToolTip = 'Specifies the value of the CFDI PPD XML field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'CFDI PPD XML';
                    trigger OnDrillDown()
                    begin
                        if Rec."CFDI PPD XML".HasValue then
                            Rec.Export(true, 2)
                        else
                            InitiateUploadFile(2)

                    end;
                }
                field("Proof of Delivery"; Rec."Proof of Delivery FileName")
                {
                    ToolTip = 'Specifies the value of the Proof of Delivery field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Proof of Delivery';
                    trigger OnDrillDown()
                    begin
                        if Rec."Proof of Delivery".HasValue then
                            Rec.Export(true, 3)
                        else
                            InitiateUploadFile(3)

                    end;
                }
                field("CFDI RP PDF"; Rec."CFDI RP PDF FileName")
                {
                    ToolTip = 'Specifies the value of the CFDI RP PDF field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'CFDI RP PDF';
                    trigger OnDrillDown()
                    begin
                        if Rec."CFDI RP PDF".HasValue then
                            Rec.Export(true, 4)
                        else
                            InitiateUploadFile(4)

                    end;
                }
                field("CFDI RP XML"; Rec."CFDI RP XML FileName")
                {
                    ToolTip = 'Specifies the value of the CFDI RP XML field.';
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'CFDI RP XML';
                    trigger OnDrillDown()
                    begin
                        if Rec."CFDI RP XML".HasValue then
                            Rec.Export(true, 5)
                        else
                            InitiateUploadFile(5)

                    end;
                }
                field("Proof of Payment"; Rec."Proof of Payment FileName")
                {
                    ToolTip = 'Specifies the value of the Proof of Payment field.';
                    ApplicationArea = All;
                    Caption = 'Proof of Payment';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        if Rec."Proof of Payment".HasValue then
                            Rec.Export(true, 6)
                        else
                            InitiateUploadFile(6)

                    end;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }



    var
        SelectFileTxt: Label 'Attach File(s)...';
        ImportTxt: Label 'Attach a document.';
        FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        EmptyFileNameErr: Label 'Please choose a file to attach.';
        NoContentErr: Label 'The selected file has no content. Please choose another file.';


    trigger OnAfterGetRecord()
    begin
        // IF Rec."CFDI PPD PDF FileName" = '' then
        //     Rec."CFDI PPD PDF FileName" := SelectFileTxt;
        // If Rec."CFDI PPD XML FileName" = '' then
        //     Rec."CFDI PPD XML FileName" := SelectFileTxt;
        // If Rec."Proof of Delivery FileName" = '' then
        //     Rec."Proof of Delivery FileName" := SelectFileTxt;
        // If Rec."CFDI RP PDF FileName" = '' then
        //     Rec."CFDI RP PDF FileName" := SelectFileTxt;
        // If Rec."CFDI RP XML FileName" = '' then
        //     Rec."CFDI RP XML FileName" := SelectFileTxt;
        // If Rec."Proof of Payment FileName" = '' then
        //     Rec."Proof of Payment FileName" := SelectFileTxt;
    end;

    local procedure InitiateUploadFile(FromRec: Integer)
    var
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
    begin
        ImportWithFilter(TempBlob, FileName);
        if FileName <> '' then
            SaveAttachment(FromRec, FileName, TempBlob);
        CurrPage.Update(true);
    end;

    local procedure ImportWithFilter(var TempBlob: Codeunit "Temp Blob"; var FileName: Text)
    var
        FileManagement: Codeunit "File Management";
    begin
        FileName := FileManagement.BLOBImportWithFilter(
            TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
    end;

    procedure SaveAttachment(Ref: Integer; FileName: Text; TempBlob: Codeunit "Temp Blob")
    var
        DocStream: InStream;
        FileManagement: Codeunit "File Management";
    begin
        if FileName = '' then
            Error(EmptyFileNameErr);
        // Validate file/media is not empty
        if not TempBlob.HasValue then
            Error(NoContentErr);

        TempBlob.CreateInStream(DocStream);
        case Ref of
            1:
                begin
                    //Rec.Validate("CFDI PPD PDF FileName", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(Rec."CFDI PPD PDF FileName")));
                    Rec."CFDI PPD PDF FileName" := FileName;
                    Rec."CFDI PPD PDF".ImportStream(DocStream, '');
                end;
            2:
                begin
                    //Rec.Validate("CFDI PPD XML FileName", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(Rec."CFDI PPD XML FileName")));
                    Rec."CFDI PPD XML FileName" := FileName;
                    Rec."CFDI PPD XML".ImportStream(DocStream, '');
                end;
            3:
                begin
                    //Rec.Validate("Proof of Delivery FileName", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(Rec."Proof of Delivery FileName")));
                    Rec."Proof of Delivery FileName" := FileName;
                    Rec."Proof of Delivery".ImportStream(DocStream, '');
                end;
            4:
                begin
                    //Rec.Validate("CFDI RP PDF FileName", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(Rec."CFDI RP PDF FileName")));
                    Rec."CFDI RP PDF FileName" := FileName;
                    Rec."CFDI RP PDF".ImportStream(DocStream, '');
                end;
            5:
                begin
                    //Rec.Validate("CFDI RP XML FileName", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(Rec."CFDI RP XML FileName")));
                    Rec."CFDI RP XML FileName" := FileName;
                    Rec."CFDI RP XML".ImportStream(DocStream, '');
                end;
            6:
                begin
                    //Rec.Validate("Proof of Payment FileName", CopyStr(FileManagement.GetFileNameWithoutExtension(FileName), 1, MaxStrLen(Rec."Proof of Payment FileName")));
                    Rec."Proof of Payment FileName" := FileName;
                    Rec."Proof of Payment".ImportStream(DocStream, '');
                end;

        end;
    end;

}