tableextension 50000 CustomerExt extends Customer
{
    DataCaptionFields = "No.", Name, Distintive;
    fields
    {
        field(50000; "Channel"; Enum "Channel Type")
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Franchise Location"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Cluster; Enum Cluster)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Sales Rep."; Code[50])
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Editable = false;
            TableRelation = User."User Name";
        }
        field(50004; "Collection Rep."; Code[50])
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Editable = false;
            TableRelation = User."User Name";
        }
        field(50006; "Frequency (Days)"; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                If ("Frequency (Days)" < 1) OR ("Frequency (Days)" > 31) then
                    Error('This is not valid Frequency.');
            end;
        }
        field(50007; "Next Visit Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Last Save to Histroy Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Customer Preferred Day"; Enum "Customer Preferred Day")
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
        field(50012; Status; Enum CustStatus)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Sales Process Status"; Enum "Sales Process Status")
        {
        }
        field(50014; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Completion Date 1"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '1. Contact & Information Finish Date';
        }
        field(50016; "Completion Date 2"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '2. On-Site Visit Finish Date';
        }
        field(50017; "Completion Date 3"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '3. Listing Finish Date';
        }
        field(50018; "Completion Date 4"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '4. Invoiced Finish Date';
        }
        field(50019; "Completion Date 5"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '5. First Shipment Delivered Finish Date';
        }
        field(50020; "Completion Date 6"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '6. Staff Training Finish Date';
        }
        field(50021; "Completion Date 7"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '7. Second Shipment Delivered Finish Date';
        }
        field(50022; "Completion Date 8"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '8. First Collection Finish Date';
        }
        field(50023; "Completion Date 9"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '9. Makatay On Menu Finish Date';
        }
        field(50024; "Completion Date 10"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = '10. Complete Finish Date';
        }
        field(50025; "Completion Date 11"; Text[2024])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Denied';
        }
        field(50026; Since; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Followup Every"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; Collections; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "Sales Monthly Average"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Channel Customer Ranking"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Total Customers Channel"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; Distintive; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Rating ColorName"; Text[80])
        {
            DataClassification = ToBeClassified;
        }

        field(50035; "First Cont. Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(50036; "First Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rol / Job Title';
        }
        field(50037; "FirstPercived Behavioral Style"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Percived Behavioral Style';
        }
        field(50038; "First Preferred Contact Time"; Time)
        {
            DataClassification = ToBeClassified;
            Caption = 'Preferred Contact Time';
        }
        field(50039; "First Email"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }
        field(50040; "First Telephone"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Telephone';
        }
        field(50041; "First Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile No.';
        }
        field(50042; "First Note"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }

        field(50045; "Second Cont. Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(50046; "Second Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rol / Job Title';
        }
        field(50047; "Sec.Percived Behavioral Style"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Percived Behavioral Style';
        }
        field(50048; "Second Preferred Contact Time"; Time)
        {
            DataClassification = ToBeClassified;
            Caption = 'Preferred Contact Time';
        }
        field(50049; "Second Email"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }
        field(50050; "Second Telephone"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Telephone';
        }
        field(50051; "Second Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile No.';
        }
        field(50052; "Second Note"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }

        field(50055; "Third Cont. Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(50056; "Third Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Rol / Job Title';
        }
        field(50057; "ThirdPercived Behavioral Style"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Percived Behavioral Style';
        }
        field(50058; "Third Preferred Contact Time"; Time)
        {
            DataClassification = ToBeClassified;
            Caption = 'Preferred Contact Time';
        }
        field(50059; "Third Email"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Email';
        }
        field(50060; "Third Telephone"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Telephone';
        }
        field(50061; "Third Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile No.';
        }
        field(50062; "Third Note"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }

        field(50065; "No. Of Waiters"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "No. Of Bartenders"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Mezcal Menu"; Enum MezcalMenu)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Closing Hours"; Enum ClosingHours)
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "It Factor"; Enum Factor)
        {
            DataClassification = ToBeClassified;
        }
        field(50070; "Completion Status 1 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50071; "Completion Status 2 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Completion Status 3 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "Completion Status 4 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50074; "Completion Status 5 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50075; "Completion Status 6 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Completion Status 7 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Completion Status 8 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50078; "Completion Status 9 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50079; "Completion Status 10 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Completion Status 11 Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(50085; Item1MaxInv; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50086; Item2MaxInv; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50087; Item1AveTurnover; Decimal)
        {
            DataClassification = ToBeClassified;
            //DecimalPlaces = 0 : 5;
        }
        field(50088; Item2AveTurnover; Decimal)
        {
            DataClassification = ToBeClassified;
            //DecimalPlaces = 0 : 5;
        }
        field(50089; Item1PerTurnover; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50090; Item2PerTurnover; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50091; Item1Inv; Decimal)
        {
            DecimalPlaces = 1;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PreInv: Decimal;
                PreAgreSale: Integer;
            begin
                If Item1Inv <> 0 then begin
                    ToCalcAvgTurnover('1000', PreInv, PreAgreSale);
                    If (PreInv <> 0) and (PreAgreSale <> 0) then
                        rec.Item1AveTurnover := Round(((PreInv * Rec."Followup Every") / PreAgreSale), 1, '=')
                    else
                        rec.Item1AveTurnover := 0.0;
                    Item1MaxInv := Round(Item1AveTurnover * 1.5, 1, '=');
                    Item1SuggSale := Round(Item1MaxInv - Item1Inv, 1, '=');
                end;
            end;
        }
        field(50092; Item2Inv; Decimal)
        {
            DecimalPlaces = 1;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PreInv: Decimal;
                PreAgreSale: Integer;
            begin
                If Item2Inv <> 0 then begin
                    ToCalcAvgTurnover('1002', PreInv, PreAgreSale);
                    If (PreInv <> 0) and (PreAgreSale <> 0) then
                        rec.Item2AveTurnover := Round(((PreInv * Rec."Followup Every") / PreAgreSale), 1, '=')
                    else
                        rec.Item2AveTurnover := 0.0;
                    Item2MaxInv := Round(Item2AveTurnover * 1.5, 1, '=');
                    Item2SuggSale := Round(Item2MaxInv - Item2Inv, 1, '=');
                end;
            end;
        }
        field(50093; Item1SuggSale; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50094; Item2SuggSale; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50095; Item1AgreSale; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50096; Item2AgreSale; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(50100; "Company Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; RFC; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "Address(Invoice)"; text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Address';
        }
        field(50103; "Colonia(Invoice)"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Colonia';
        }
        field(50104; "Alcaldia"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "Country/Region Code(Invoice)"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50106; "Post Code(Invoice)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code(Invoice)" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code(Invoice)" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code(Invoice)"));
            ValidateTableRelation = false;

            trigger OnLookup()
            Var
                CountyIn: Text[30];
                PostCode: Record "Post Code";
            begin
                PostCode.LookupPostCode(City, "Post Code(Invoice)", CountyIn, "Country/Region Code(Invoice)");
            end;

            trigger OnValidate()
            Var
                CountyIn: Text[30];
                PostCode: Record "Post Code";
            begin
                PostCode.ValidatePostCode(City, "Post Code(Invoice)", CountyIn, "Country/Region Code(Invoice)", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(50107; "Phone No.(Invoice)"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Phone No.';
        }
        field(50108; "E-Mail(Invoice)"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "E-Mail(Invoice)" = '' then
                    exit;
                MailManagement.CheckValidEmailAddresses("E-Mail(Invoice)");
            end;
        }
        field(50109; "CFDI Use"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50110; Bank; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50111; "Account Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account"."No.";
        }
        field(50113; "Catalogo De Producyos Y Ser."; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Catalogo De Producyos Y Servicios';
        }
        field(50114; "Constancia De Sit"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50115; "Forma De Pago"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50120; "Purch. Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(50121; "Percived Behavioral Style"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50122; "Preferred Contact Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50123; "E-Mail(Purch.)"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "E-Mail(Purch.)" = '' then
                    exit;
                MailManagement.CheckValidEmailAddresses("E-Mail(Purch.)");
            end;
        }
        field(50124; "Phone No.(Purch.)"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Phone No.';
        }
        field(50125; "Mobile No.(Purch.)"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile No.';
        }
        field(50126; "Note(Purch.)"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }

        field(50130; "Acc Pay. Cont. Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(50131; "Rol/Job Title"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50132; "Preferred Cont. Time(Acc.Pay)"; Time)
        {
            DataClassification = ToBeClassified;
            Caption = 'Preferred Contact Time';
        }
        field(50133; "E-Mail(Acc.Pay)"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "E-Mail(Acc.Pay)" = '' then
                    exit;
                MailManagement.CheckValidEmailAddresses("E-Mail(Acc.Pay)");
            end;
        }
        field(50134; "Phone No.(Acc.Pay)"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Phone No.';
        }
        field(50135; "Mobile No.(Acc.Pay)"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Mobile No.';
        }
        field(50136; "Note(Acc.Pay)"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Note';
        }

    }

    procedure CreateTask()
    var
        UserTask: Record "User Task";
        UserTaskpage: page "Customer Task Card";
    begin
        UserTask.Reset();
        UserTask.Init();
        UserTask."Customer No." := Rec."No.";
        UserTask."Contact No" := Rec."First Cont. Name";
        UserTask."Sales Rep." := Rec."Sales Rep.";
        UserTask."Sales Status" := Rec."Sales Process Status";
        UserTask.Validate("Assigned To", UserSecurityId());
        UserTask.TaskDate := Today;
        UserTask.Insert(true);

        Commit();
        Clear(UserTaskpage);
        UserTaskpage.SetTableView(UserTask);
        UserTaskpage.SetRecord(UserTask);
        if UserTaskpage.RunModal = Action::LookupOK then
            UserTaskpage.GetRecord(UserTask);

    end;

    procedure CreateDeniedTask()
    var
        UserTask: Record "User Task";
        UserTaskpage: page "Customer Task Card";
    begin
        UserTask.Reset();
        UserTask.Init();
        UserTask."Customer No." := Rec."No.";
        UserTask."Contact No" := Rec."First Cont. Name";
        UserTask."Sales Rep." := Rec."Sales Rep.";
        UserTask."Sales Status" := Rec."Sales Process Status";
        UserTask.Validate("Assigned To", UserSecurityId());
        UserTask.TaskDate := Today;
        UserTask.validate("Completion Status", UserTask."Completion Status"::Completed);
        UserTask.Title := 'Customer DeniedTask';
        UserTask.Insert(true);
    end;

    procedure PreviousStatus()
    var
        confirmAsktxt: Label 'Are you sure to Previous Status?';
        Customer: Record Customer;
    begin
        //If Not Confirm(confirmAsktxt, true) then
        //    exit;

        Clear(Customer);
        If Customer.get(Rec."No.") then begin
            case rec."Sales Process Status" of
                rec."Sales Process Status"::"1. Contact and Information":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"0. Customer Denied";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"2. On-Site Visit":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"1. Contact and Information";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"3. Listing":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"2. On-Site Visit";
                        //Customer."Completion Date 2" := WorkDate;
                        //Customer."Completion Status 2 Days" := Customer."Completion Date 1" - Customer."Completion Date 2";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"4. Sales Order":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"3. Listing";
                        //Customer."Completion Date 3" := WorkDate;
                        //Customer."Completion Status 3 Days" := Customer."Completion Date 2" - Customer."Completion Date 3";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"5. First Shipment Delivered":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"4. Sales Order";
                        //Customer."Completion Date 4" := WorkDate;
                        //Customer."Completion Status 4 Days" := Customer."Completion Date 3" - Customer."Completion Date 4";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"6. Staff Training":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"5. First Shipment Delivered";
                        //Customer."Completion Date 5" := WorkDate;
                        //Customer."Completion Status 5 Days" := Customer."Completion Date 4" - Customer."Completion Date 5";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"7. Second Shipment Delivered":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"6. Staff Training";
                        //Customer."Completion Date 6" := WorkDate;
                        //Customer."Completion Status 6 Days" := Customer."Completion Date 5" - Customer."Completion Date 6";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"8. First Collection":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"7. Second Shipment Delivered";
                        //Customer."Completion Date 7" := WorkDate;
                        //Customer."Completion Status 7 Days" := Customer."Completion Date 6" - Customer."Completion Date 7";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"9. Makatay On Menu":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"8. First Collection";
                        //Customer."Completion Date 8" := WorkDate;
                        //Customer."Completion Status 8 Days" := Customer."Completion Date 7" - Customer."Completion Date 8";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"10. Complete":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"9. Makatay On Menu";
                        //Customer."Completion Date 9" := WorkDate;
                        //Customer."Completion Status 9 Days" := Customer."Completion Date 8" - Customer."Completion Date 9";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                else
                    exit;
            end;
        end;

    end;

    procedure ForwardStatus()
    var
        confirmAsktxt: Label 'Are you sure to Forward Status?';
        Customer: Record Customer;
    begin
        //If Not Confirm(confirmAsktxt, true) then
        //    exit;

        Clear(Customer);
        If Customer.get(Rec."No.") then begin
            case rec."Sales Process Status" of
                rec."Sales Process Status"::"0. Customer Denied":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"1. Contact and Information";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"1. Contact and Information":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"2. On-Site Visit";
                        Customer."Completion Date 1" := WorkDate();
                        Customer."Completion Status 1 Days" := Customer."Completion Date 1" - Customer."Created Date";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"2. On-Site Visit":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"3. Listing";
                        Customer."Completion Date 2" := WorkDate;
                        Customer."Completion Status 2 Days" := Customer."Completion Date 1" - Customer."Completion Date 2";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"3. Listing":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"4. Sales Order";
                        Customer."Completion Date 3" := WorkDate;
                        Customer."Completion Status 3 Days" := Customer."Completion Date 2" - Customer."Completion Date 3";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"4. Sales Order":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"5. First Shipment Delivered";
                        Customer."Completion Date 4" := WorkDate;
                        Customer."Completion Status 4 Days" := Customer."Completion Date 3" - Customer."Completion Date 4";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"5. First Shipment Delivered":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"6. Staff Training";
                        Customer."Completion Date 5" := WorkDate;
                        Customer."Completion Status 5 Days" := Customer."Completion Date 4" - Customer."Completion Date 5";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"6. Staff Training":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"7. Second Shipment Delivered";
                        Customer."Completion Date 6" := WorkDate;
                        Customer."Completion Status 6 Days" := Customer."Completion Date 5" - Customer."Completion Date 6";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"7. Second Shipment Delivered":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"8. First Collection";
                        Customer."Completion Date 7" := WorkDate;
                        Customer."Completion Status 7 Days" := Customer."Completion Date 6" - Customer."Completion Date 7";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"8. First Collection":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"9. Makatay On Menu";
                        Customer."Completion Date 8" := WorkDate;
                        Customer."Completion Status 8 Days" := Customer."Completion Date 7" - Customer."Completion Date 8";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                rec."Sales Process Status"::"9. Makatay On Menu":
                    begin
                        Customer."Sales Process Status" := Customer."Sales Process Status"::"10. Complete";
                        Customer."Completion Date 9" := WorkDate;
                        Customer."Completion Status 9 Days" := Customer."Completion Date 8" - Customer."Completion Date 9";
                        Customer.Status := Customer.Status::"Sales Process";
                        Customer.Modify(false);
                    end;
                else
                    exit;
            end;
        end;

    end;

    procedure ToCheckUserTaskList(): Boolean
    var
        UserTask: Record "User Task";
    begin
        UserTask.Reset();
        UserTask.SetCurrentKey("Customer No.", "Completion Status");
        UserTask.SetRange("Customer No.", rec."No.");
        UserTask.Setrange("Completion Status", UserTask."Completion Status"::" ");
        exit(UserTask.IsEmpty);

    end;

    procedure ClearCustomerDays()
    begin
        Clear(rec."Completion Status 1 Days");
        Clear(Rec."Completion Status 2 Days");
        Clear(Rec."Completion Status 3 Days");
        Clear(Rec."Completion Status 4 Days");
        Clear(Rec."Completion Status 5 Days");
        Clear(Rec."Completion Status 6 Days");
        Clear(Rec."Completion Status 7 Days");
        Clear(Rec."Completion Status 8 Days");
        Clear(Rec."Completion Status 9 Days");
        Clear(Rec."Completion Status 10 Days");
    end;

    local procedure ToCalcAvgTurnover(ItemNo: Code[20]; var PerTurnover: Decimal; var Day: Integer)
    var
        SaleFreqplanRec: Record "Sales Frequency Planning";
        i: Integer;
        FirstDate: Date;
        EndDate: Date;
    begin
        i := 0;
        SaleFreqplanRec.Reset();
        SaleFreqplanRec.SetCurrentKey("Customer No.", "Item No.", "Sales Date");
        SaleFreqplanRec.SetRange("Customer No.", Rec."No.");
        SaleFreqplanRec.SetRange("Item No.", ItemNo);
        SaleFreqplanRec.SetRange("Sales Date");
        SaleFreqplanRec.Ascending(true);
        If SaleFreqplanRec.FindSet() then begin
            FirstDate := SaleFreqplanRec."Sales Date";
            repeat
                i += 1;
                PerTurnover += SaleFreqplanRec."Period Turnover";
                EndDate := SaleFreqplanRec."Sales Date";
            until (SaleFreqplanRec.Next() = 0) or (i > 10);
            Day := EndDate - FirstDate;
        end;
    end;

    procedure LastHistroyDaysSetStyle(): Text
    begin
        if "Last Save to Histroy Days" <> 0 then begin
            if ("Last Save to Histroy Days" > "Followup Every") then
                exit('Unfavorable')
        end;
        exit('');
    end;

}