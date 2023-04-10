tableextension 50006 VendorExt extends Vendor
{
    fields
    {
        field(50000; Status; Enum "Vendor Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Colonia"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; Alcaldía; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "First Cont. Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(50022; "First Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rol / Job Title';
        }
        field(50023; "First Email"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }
        field(50024; "First Telephone"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Telephone';
        }
        field(50025; "First Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile No.';
        }
        field(50026; "First Note"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }

        field(50031; "Second Cont. Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(50032; "Second Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rol / Job Title';
        }
        field(50033; "Second Email"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }
        field(50034; "Second Telephone"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Telephone';
        }
        field(50035; "Second Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile No.';
        }
        field(50036; "Second Note"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }

        field(50041; "Third Cont. Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(50042; "Third Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rol / Job Title';
        }
        field(50043; "Third Email"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }
        field(50044; "Third Telephone"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Telephone';
        }
        field(50045; "Third Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile No.';
        }
        field(50046; "Third Note"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }

        field(50051; "First Company Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Company Name';
        }
        field(50052; "First Bank"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank';
        }
        field(50053; "First Bank Account"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account';
        }
        field(50054; "First CDFI Use"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'CDFI Use';
        }
        field(50055; "First RFC No."; Code[13])
        {
            Caption = 'RFC No.';

            // trigger OnValidate()
            // var
            //     Vendor: Record Vendor;
            // begin
            //     case "Tax Identification Type" of
            //         "Tax Identification Type"::"Legal Entity":
            //             ValidateRFCNo(12);
            //         "Tax Identification Type"::"Natural Person":
            //             ValidateRFCNo(13);
            //     end;
            //     Vendor.Reset();
            //     Vendor.SetRange("RFC No.", "RFC No.");
            //     Vendor.SetFilter("No.", '<>%1', "No.");
            //     if Vendor.FindFirst() then
            //         Message(Text10002, "RFC No.");
            // end;
        }
        field(50061; "Second Company Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Company Name';
        }
        field(50062; "Second Bank"; Text[150])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank';
        }
        field(50063; "Second Bank Account"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account';
        }
        field(50064; "Second CDFI Use"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'CDFI Use';
        }
        field(50065; "Second RFC No."; Code[13])
        {
            Caption = 'RFC No.';

            // trigger OnValidate()
            // var
            //     Vendor: Record Vendor;
            // begin
            //     case "Tax Identification Type" of
            //         "Tax Identification Type"::"Legal Entity":
            //             ValidateRFCNo(12);
            //         "Tax Identification Type"::"Natural Person":
            //             ValidateRFCNo(13);
            //     end;
            //     Vendor.Reset();
            //     Vendor.SetRange("RFC No.", "RFC No.");
            //     Vendor.SetFilter("No.", '<>%1', "No.");
            //     if Vendor.FindFirst() then
            //         Message(Text10002, "RFC No.");
            // end;
        }
    }

    var
        Text10002: Label 'The RFC No. %1 is used by another company.';
}