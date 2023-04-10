codeunit 50000 "Customization Event"
{

    // TAB18
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterOnInsert', '', true, false)]
    local procedure Tab18OnAfterOnInsert(var Customer: Record Customer)
    begin
        Customer."Created Date" := WorkDate();
    end;

    // TAB36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', true, false)]
    local procedure Tab36OnAfterCopySellToCustomerAddressFieldsFromCustomer(SellToCustomer: Record Customer; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.Distintive := SellToCustomer.Distintive;
        SalesHeader.Cluster := SellToCustomer.Cluster;
        SalesHeader.Channel := SellToCustomer.Channel;
        SalesHeader.Colonia := SellToCustomer.Colonia;
        SalesHeader.Alcaldía := SellToCustomer.Alcaldía;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Tax Liable', true, false)]
    local procedure Tab36TaxLiableOnAfterValidateEvent(var Rec: Record "Sales Header")
    var
        SaleLine: Record "Sales Line";
        DocumentTotals: Codeunit "Document Totals";
    begin
        If (Rec."Tax Liable" = false) and (Rec."Document Type" = rec."Document Type"::Order) then begin
            SaleLine.Reset();
            SaleLine.SetCurrentKey("Document Type", "Document No.");
            SaleLine.SetRange("Document Type", SaleLine."Document Type"::Order);
            SaleLine.SetRange("Document No.", Rec."No.");
            If SaleLine.FindSet() then
                repeat
                    SaleLine."IEPS Amt." := 0;
                    SaleLine."IVA Amt." := 0;
                    SaleLine.Modify(false);
                until SaleLine.Next() = 0;
        end else begin
            DocumentTotals.SalesRedistributeInvoiceDiscountAmountsOnDocument(Rec);
            SaleLine.Reset();
            SaleLine.SetCurrentKey("Document Type", "Document No.");
            SaleLine.SetRange("Document Type", SaleLine."Document Type"::Order);
            SaleLine.SetRange("Document No.", Rec."No.");
            If SaleLine.FindSet() then
                repeat
                    SaleLine.Validate(Quantity);
                    SaleLine.Modify(false);
                until SaleLine.Next() = 0;

        end;
    end;

    // TAB37
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Unit Price', true, false)]
    local procedure Tab37UnitPriceOnAfterValidateEvent(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        SalesHrd: Record "Sales Header";
        SalesHrdEn: Record "Sales Header";
        TaxJuri: Record "Tax Jurisdiction";
        TaxDetail: Record "Tax Detail";
        TaxArea: Record "Tax Area";
        TaxAreaLine: Record "Tax Area Line";
    begin
        Clear(SalesHrdEn);
        If SalesHrdEn.get(SalesHrdEn."Document Type"::Order, Rec."Document No.") and (SalesHrdEn."Tax Liable") Then begin
            Clear(TaxDetail);
            Clear(TaxArea);
            Clear(TaxAreaLine);
            If (Rec."Tax Area Code" <> '') and (Rec."VAT %" <> 0) then begin
                TaxArea.Get(Rec."Tax Area Code");
                TaxAreaLine.Reset();
                TaxAreaLine.SetCurrentKey("Tax Area", "Calculation Order");
                TaxAreaLine.SetRange("Tax Area", TaxArea.Code);
                TaxAreaLine.Ascending(false);
                If TaxAreaLine.FindSet() then
                    repeat
                        Clear(SalesHrd);
                        SalesHrd.get(SalesHrd."Document Type"::Order, Rec."Document No.");
                        TaxDetail.Reset();
                        TaxDetail.SetCurrentKey("Tax Group Code", "Tax Jurisdiction Code");
                        TaxDetail.SetRange("Tax Group Code", rec."Tax Group Code");
                        TaxDetail.SetRange("Tax Jurisdiction Code", TaxAreaLine."Tax Jurisdiction Code");
                        TaxDetail.Setfilter("Effective Date", '<=%1', SalesHrd."Document Date");
                        TaxDetail.SetFilter("Tax Below Maximum", '<>%1', 0);
                        If TaxDetail.FindFirst() then begin
                            If TaxDetail."Tax Jurisdiction Code" = 'IEPS' then begin
                                Clear(Rec."IEPS Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IEPS Amt." := (Rec.Amount * TaxDetail."Tax Below Maximum") / 100;
                            end;
                            If TaxDetail."Tax Jurisdiction Code" = 'IVA' then begin
                                Clear(Rec."IVA Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IVA Amt." := ((Rec.Amount + Rec."IEPS Amt.") * TaxDetail."Tax Below Maximum") / 100;
                            end;
                        end;
                    until TaxAreaLine.Next() = 0;
            end;
        end else begin
            Rec."IEPS Amt." := 0;
            rec."IVA Amt." := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', true, false)]
    local procedure Tab37QuantityOnAfterValidateEvent(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        SalesHrd: Record "Sales Header";
        SalesHrdEn: Record "Sales Header";
        TaxJuri: Record "Tax Jurisdiction";
        TaxDetail: Record "Tax Detail";
        TaxArea: Record "Tax Area";
        TaxAreaLine: Record "Tax Area Line";
    begin
        Clear(SalesHrdEn);
        If SalesHrdEn.get(SalesHrdEn."Document Type"::Order, Rec."Document No.") and (SalesHrdEn."Tax Liable") Then begin
            Clear(TaxDetail);
            Clear(TaxArea);
            Clear(TaxAreaLine);
            If (Rec."Tax Area Code" <> '') and (Rec."VAT %" <> 0) then begin
                TaxArea.Get(Rec."Tax Area Code");
                TaxAreaLine.Reset();
                TaxAreaLine.SetCurrentKey("Tax Area", "Calculation Order");
                TaxAreaLine.SetRange("Tax Area", TaxArea.Code);
                TaxAreaLine.Ascending(false);
                If TaxAreaLine.FindSet() then
                    repeat
                        TaxDetail.Reset();
                        Clear(SalesHrd);
                        SalesHrd.get(SalesHrd."Document Type"::Order, Rec."Document No.");
                        TaxDetail.SetCurrentKey("Tax Group Code", "Tax Jurisdiction Code");
                        TaxDetail.SetRange("Tax Group Code", rec."Tax Group Code");
                        TaxDetail.SetRange("Tax Jurisdiction Code", TaxAreaLine."Tax Jurisdiction Code");
                        TaxDetail.Setfilter("Effective Date", '<=%1', SalesHrd."Document Date");
                        TaxDetail.SetFilter("Tax Below Maximum", '<>%1', 0);
                        If TaxDetail.FindFirst() then begin
                            If TaxDetail."Tax Jurisdiction Code" = 'IEPS' then begin
                                Clear(Rec."IEPS Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IEPS Amt." := (Rec.Amount * TaxDetail."Tax Below Maximum") / 100;
                            end;
                            If TaxDetail."Tax Jurisdiction Code" = 'IVA' then begin
                                Clear(Rec."IVA Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IVA Amt." := ((Rec.Amount + Rec."IEPS Amt.") * TaxDetail."Tax Below Maximum") / 100;
                            end;
                        end;
                    until TaxAreaLine.Next() = 0;
            end;
        end else begin
            Rec."IEPS Amt." := 0;
            rec."IVA Amt." := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Tax Group Code', true, false)]
    local procedure Tab37TaxGroupOnAfterValidateEvent(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        SalesHrd: Record "Sales Header";
        SalesHrdEn: Record "Sales Header";
        TaxJuri: Record "Tax Jurisdiction";
        TaxDetail: Record "Tax Detail";
        TaxArea: Record "Tax Area";
        TaxAreaLine: Record "Tax Area Line";
    begin
        Clear(SalesHrdEn);
        If SalesHrdEn.get(SalesHrdEn."Document Type"::Order, Rec."Document No.") and (SalesHrdEn."Tax Liable") Then begin
            Clear(TaxDetail);
            Clear(TaxArea);
            Clear(TaxAreaLine);
            If (Rec."Tax Area Code" <> '') and (Rec."VAT %" <> 0) then begin
                TaxArea.Get(Rec."Tax Area Code");
                TaxAreaLine.Reset();
                TaxAreaLine.SetCurrentKey("Tax Area", "Calculation Order");
                TaxAreaLine.SetRange("Tax Area", TaxArea.Code);
                TaxAreaLine.Ascending(false);
                If TaxAreaLine.FindSet() then
                    repeat
                        TaxDetail.Reset();
                        Clear(SalesHrd);
                        SalesHrd.get(SalesHrd."Document Type"::Order, Rec."Document No.");
                        TaxDetail.SetCurrentKey("Tax Group Code", "Tax Jurisdiction Code");
                        TaxDetail.SetRange("Tax Group Code", rec."Tax Group Code");
                        TaxDetail.SetRange("Tax Jurisdiction Code", TaxAreaLine."Tax Jurisdiction Code");
                        TaxDetail.Setfilter("Effective Date", '<=%1', SalesHrd."Document Date");
                        TaxDetail.SetFilter("Tax Below Maximum", '<>%1', 0);
                        If TaxDetail.FindFirst() then begin
                            If TaxDetail."Tax Jurisdiction Code" = 'IEPS' then begin
                                Clear(Rec."IEPS Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IEPS Amt." := (Rec.Amount * TaxDetail."Tax Below Maximum") / 100;
                            end;
                            If TaxDetail."Tax Jurisdiction Code" = 'IVA' then begin
                                Clear(Rec."IVA Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IVA Amt." := ((Rec.Amount + Rec."IEPS Amt.") * TaxDetail."Tax Below Maximum") / 100;
                            end;
                        end;
                    until TaxAreaLine.Next() = 0;
            end;
        end else begin
            Rec."IEPS Amt." := 0;
            rec."IVA Amt." := 0;
        end;
    end;

    // TAB38
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Tax Liable', true, false)]
    local procedure Tab38TaxLiableOnAfterValidateEvent(var Rec: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        DocumentTotals: Codeunit "Document Totals";
    begin
        If (Rec."Tax Liable" = false) and (Rec."Document Type" = rec."Document Type"::Order) then begin
            PurchaseLine.Reset();
            PurchaseLine.SetCurrentKey("Document Type", "Document No.");
            PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
            PurchaseLine.SetRange("Document No.", Rec."No.");
            If PurchaseLine.FindSet() then
                repeat
                    PurchaseLine."IEPS Amt." := 0;
                    PurchaseLine."IVA Amt." := 0;
                    PurchaseLine.Modify(false);
                until PurchaseLine.Next() = 0;
        end else begin
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
            PurchaseLine.Reset();
            PurchaseLine.SetCurrentKey("Document Type", "Document No.");
            PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
            PurchaseLine.SetRange("Document No.", Rec."No.");
            If PurchaseLine.FindSet() then
                repeat
                    PurchaseLine.Validate(Quantity);
                    PurchaseLine.Modify(false);
                until PurchaseLine.Next() = 0;

        end;
    end;

    // TAB39
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Direct Unit Cost', true, false)]
    local procedure Tab39DirectUnitCostOnAfterValidateEvent(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var
        PurchaseHrd: Record "Purchase Header";
        PurchaseHrdEn: Record "Purchase Header";
        TaxJuri: Record "Tax Jurisdiction";
        TaxDetail: Record "Tax Detail";
        TaxArea: Record "Tax Area";
        TaxAreaLine: Record "Tax Area Line";
    begin
        Clear(PurchaseHrdEn);
        If PurchaseHrdEn.get(PurchaseHrdEn."Document Type"::Order, Rec."Document No.") and (PurchaseHrdEn."Tax Liable") Then begin
            Clear(TaxDetail);
            Clear(TaxArea);
            Clear(TaxAreaLine);
            If (Rec."Tax Area Code" <> '') and (Rec."Tax Group Code" <> '') Then begin//and (Rec."VAT %" <> 0) then begin
                TaxArea.Get(Rec."Tax Area Code");
                TaxAreaLine.Reset();
                TaxAreaLine.SetCurrentKey("Tax Area", "Calculation Order");
                TaxAreaLine.SetRange("Tax Area", TaxArea.Code);
                TaxAreaLine.Ascending(false);
                If TaxAreaLine.FindSet() then
                    repeat
                        Clear(PurchaseHrd);
                        PurchaseHrd.get(PurchaseHrd."Document Type"::Order, Rec."Document No.");
                        TaxDetail.Reset();
                        TaxDetail.SetCurrentKey("Tax Group Code", "Tax Jurisdiction Code");
                        TaxDetail.SetRange("Tax Group Code", rec."Tax Group Code");
                        TaxDetail.SetRange("Tax Jurisdiction Code", TaxAreaLine."Tax Jurisdiction Code");
                        TaxDetail.Setfilter("Effective Date", '<=%1', PurchaseHrd."Document Date");
                        TaxDetail.SetFilter("Tax Below Maximum", '<>%1', 0);
                        If TaxDetail.FindFirst() then begin
                            If TaxDetail."Tax Jurisdiction Code" = 'IEPS' then begin
                                Clear(Rec."IEPS Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IEPS Amt." := (Rec.Amount * TaxDetail."Tax Below Maximum") / 100;
                            end;
                            If TaxDetail."Tax Jurisdiction Code" = 'IVA' then begin
                                Clear(Rec."IVA Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IVA Amt." := ((Rec.Amount + Rec."IEPS Amt.") * TaxDetail."Tax Below Maximum") / 100;
                            end;
                        end;
                    until TaxAreaLine.Next() = 0;
            end else begin
                Rec."IEPS Amt." := 0;
                Rec."IVA Amt." := 0;
            end;
        end else begin
            Rec."IEPS Amt." := 0;
            rec."IVA Amt." := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Quantity', true, false)]
    local procedure Tab39QuantityOnAfterValidateEvent(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var
        PurchaseHrd: Record "Purchase Header";
        PurchaseHrdEn: Record "Purchase Header";
        TaxJuri: Record "Tax Jurisdiction";
        TaxDetail: Record "Tax Detail";
        TaxArea: Record "Tax Area";
        TaxAreaLine: Record "Tax Area Line";
    begin
        Clear(PurchaseHrdEn);
        If PurchaseHrdEn.get(PurchaseHrdEn."Document Type"::Order, Rec."Document No.") and (PurchaseHrdEn."Tax Liable") Then begin
            Clear(TaxDetail);
            Clear(TaxArea);
            Clear(TaxAreaLine);
            If (Rec."Tax Area Code" <> '') and (Rec."Tax Group Code" <> '') Then Begin//and (Rec."VAT %" <> 0) then begin
                TaxArea.Get(Rec."Tax Area Code");
                TaxAreaLine.Reset();
                TaxAreaLine.SetCurrentKey("Tax Area", "Calculation Order");
                TaxAreaLine.SetRange("Tax Area", TaxArea.Code);
                TaxAreaLine.Ascending(false);
                If TaxAreaLine.FindSet() then
                    repeat
                        Clear(PurchaseHrd);
                        PurchaseHrd.get(PurchaseHrd."Document Type"::Order, Rec."Document No.");
                        TaxDetail.Reset();
                        TaxDetail.SetCurrentKey("Tax Group Code", "Tax Jurisdiction Code");
                        TaxDetail.SetRange("Tax Group Code", rec."Tax Group Code");
                        TaxDetail.SetRange("Tax Jurisdiction Code", TaxAreaLine."Tax Jurisdiction Code");
                        TaxDetail.Setfilter("Effective Date", '<=%1', PurchaseHrd."Document Date");
                        TaxDetail.SetFilter("Tax Below Maximum", '<>%1', 0);
                        If TaxDetail.FindFirst() then begin
                            If TaxDetail."Tax Jurisdiction Code" = 'IEPS' then begin
                                Clear(Rec."IEPS Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IEPS Amt." := (Rec.Amount * TaxDetail."Tax Below Maximum") / 100;
                            end;
                            If TaxDetail."Tax Jurisdiction Code" = 'IVA' then begin
                                Clear(Rec."IVA Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IVA Amt." := ((Rec.Amount + Rec."IEPS Amt.") * TaxDetail."Tax Below Maximum") / 100;
                            end;
                        end;
                    until TaxAreaLine.Next() = 0;
            end else begin
                Rec."IEPS Amt." := 0;
                Rec."IVA Amt." := 0;
            end;
        end else begin
            Rec."IEPS Amt." := 0;
            rec."IVA Amt." := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Tax Group Code', true, false)]
    local procedure Tab39TaxGroupCodeOnAfterValidateEvent(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var
        PurchaseHrd: Record "Purchase Header";
        PurchaseHrdEn: Record "Purchase Header";
        TaxJuri: Record "Tax Jurisdiction";
        TaxDetail: Record "Tax Detail";
        TaxArea: Record "Tax Area";
        TaxAreaLine: Record "Tax Area Line";
    begin
        Clear(PurchaseHrdEn);
        If PurchaseHrdEn.get(PurchaseHrdEn."Document Type"::Order, Rec."Document No.") and (PurchaseHrdEn."Tax Liable") Then begin
            Clear(TaxDetail);
            Clear(TaxArea);
            Clear(TaxAreaLine);
            If (Rec."Tax Area Code" <> '') and (Rec."Tax Group Code" <> '') Then begin//and (Rec."VAT %" <> 0) then begin
                TaxArea.Get(Rec."Tax Area Code");
                TaxAreaLine.Reset();
                TaxAreaLine.SetCurrentKey("Tax Area", "Calculation Order");
                TaxAreaLine.SetRange("Tax Area", TaxArea.Code);
                TaxAreaLine.Ascending(false);
                If TaxAreaLine.FindSet() then
                    repeat
                        Clear(PurchaseHrd);
                        PurchaseHrd.get(PurchaseHrd."Document Type"::Order, Rec."Document No.");
                        TaxDetail.Reset();
                        TaxDetail.SetCurrentKey("Tax Group Code", "Tax Jurisdiction Code");
                        TaxDetail.SetRange("Tax Group Code", rec."Tax Group Code");
                        TaxDetail.SetRange("Tax Jurisdiction Code", TaxAreaLine."Tax Jurisdiction Code");
                        TaxDetail.Setfilter("Effective Date", '<=%1', PurchaseHrd."Document Date");
                        TaxDetail.SetFilter("Tax Below Maximum", '<>%1', 0);
                        If TaxDetail.FindFirst() then begin
                            If TaxDetail."Tax Jurisdiction Code" = 'IEPS' then begin
                                Clear(Rec."IEPS Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IEPS Amt." := (Rec.Amount * TaxDetail."Tax Below Maximum") / 100;
                            end;
                            If TaxDetail."Tax Jurisdiction Code" = 'IVA' then begin
                                Clear(Rec."IVA Amt.");
                                If TaxDetail."Tax Below Maximum" <> 0 then
                                    Rec."IVA Amt." := ((Rec.Amount + Rec."IEPS Amt.") * TaxDetail."Tax Below Maximum") / 100;
                            end;
                        end;
                    until TaxAreaLine.Next() = 0;
            end else begin
                Rec."IEPS Amt." := 0;
                Rec."IVA Amt." := 0;
            end;
        end else begin
            Rec."IEPS Amt." := 0;
            rec."IVA Amt." := 0;
        end;
    end;

    //PAG1171
    [EventSubscriber(ObjectType::Page, Page::"User Task Card", 'OnBeforeActionEvent', 'Mark Completed', true, false)]
    local procedure Pag1171MarkCompletedOnBeforeActionEvent(var Rec: Record "User Task")
    begin
        If rec.Title = '' then
            Error('Please must enter Task.');
        rec.TestField(Rec."Assigned To User Name");

        rec."Completion Status" := rec."Completion Status"::Completed;
    end;

    [EventSubscriber(ObjectType::Page, Page::"User Task List", 'OnBeforeActionEvent', 'Mark Complete', true, false)]
    local procedure Pag1170MarkCompletedOnBeforeActionEvent(var Rec: Record "User Task")
    begin
        If rec.Title = '' then
            Error('Please must enter Task.');
        rec.TestField(Rec."Assigned To User Name");

        rec."Completion Status" := rec."Completion Status"::Completed;
    end;

    procedure GetMyPendingUserTasksCount(): Integer
    var
        UserTask: Record "User Task";
    begin
        UserTask.Reset();
        UserTask.SetFilter("Assigned To", UserSecurityId);
        UserTask.SetFilter(TaskDate, '=%1', Today);
        exit(UserTask.Count());
    end;

    procedure SetFiltersToShowMyUserTasks(var UserTask: Record "User Task")
    begin
        UserTask.SetFilter("Assigned To", UserSecurityId);
        UserTask.SetFilter(TaskDate, '=%1', Today);
    end;

    procedure GetMyAllPendingTasksCount(): Integer
    var
        UserTask: Record "User Task";
    begin
        UserTask.Reset();
        UserTask.SetFilter("Assigned To", UserSecurityId);
        UserTask.SetFilter("Completion Status", '%1', UserTask."Completion Status"::" ");
        exit(UserTask.Count());
    end;

    procedure SetFiltersToShowAllTasks(var UserTask: Record "User Task")
    begin
        UserTask.SetFilter("Assigned To", UserSecurityId);
        UserTask.SetFilter("Completion Status", '%1', UserTask."Completion Status"::" ");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, true)]
    local procedure Cod80OnAfterPostSalesDoc(SalesInvHdrNo: Code[20])
    var
        Customer: Record Customer;
        SalesInoiceHrd: Record "Sales Invoice Header";
    begin
        Clear(SalesInoiceHrd);
        Clear(Customer);
        If SalesInoiceHrd.get(SalesInvHdrNo) then
            If (SalesInvHdrNo <> '') and (Customer.get(SalesInoiceHrd."Sell-to Customer No.")) and (Customer.Since = '') then begin
                Customer.Since := Format(Today);
                Customer.Modify(false);
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', false, true)]
    local procedure Cod80OnBeforeSalesShptHeaderInsert(SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header")
    var
        TempBlob: Codeunit "Temp Blob";
        TempBlob2: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DocumentStream: OutStream;
        DocStream: InStream;
        TenantMedia: Record "Tenant Media";
    begin
        If SalesHeader."CFDI PPD PDF".HasValue then begin
            SalesShptHeader."CFDI PPD PDF" := SalesHeader."CFDI PPD PDF";
            // TempBlob.CreateOutStream(DocumentStream);
            // SalesHeader."CFDI PPD PDF".ExportStream(DocumentStream);
            // TempBlob2.CreateInStream(DocStream);
            // SalesShptHeader."CFDI PPD PDF".ImportStream(DocStream, '');
            //SalesShptHeader."CFDI PPD PDF".ExportStream(DocumentStream);
        end;
        If SalesHeader."CFDI PPD XML".HasValue then
            SalesShptHeader."CFDI PPD XML" := SalesHeader."CFDI PPD XML";

        If SalesHeader."Proof of Delivery".HasValue then
            SalesShptHeader."Proof of Delivery" := SalesHeader."Proof of Delivery";
        If SalesHeader."CFDI RP PDF".HasValue then
            SalesShptHeader."CFDI RP PDF" := SalesHeader."CFDI RP PDF";
        If SalesHeader."CFDI RP XML".HasValue then
            SalesShptHeader."CFDI RP XML" := SalesHeader."CFDI RP XML";
        If SalesHeader."Proof of Payment".HasValue then
            SalesShptHeader."Proof of Payment" := SalesHeader."Proof of Payment";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, true)]
    local procedure Cod80OnBeforeSalesInvHeaderInsert(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    begin
        If SalesHeader."CFDI PPD PDF".HasValue then
            SalesInvHeader."CFDI PPD PDF" := SalesHeader."CFDI PPD PDF";
        If SalesHeader."CFDI PPD XML".HasValue then
            SalesInvHeader."CFDI PPD XML" := SalesHeader."CFDI PPD XML";
        If SalesHeader."Proof of Delivery".HasValue then
            SalesInvHeader."Proof of Delivery" := SalesHeader."Proof of Delivery";
        If SalesHeader."CFDI RP PDF".HasValue then
            SalesInvHeader."CFDI RP PDF" := SalesHeader."CFDI RP PDF";
        If SalesHeader."CFDI RP XML".HasValue then
            SalesInvHeader."CFDI RP XML" := SalesHeader."CFDI RP XML";
        If SalesHeader."Proof of Payment".HasValue then
            SalesInvHeader."Proof of Payment" := SalesHeader."Proof of Payment";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostGLAndCustomer', '', false, true)]
    local procedure Cod80OnAfterPostGLAndCustomer(SalesHeader: Record "Sales Header"; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocNo: Code[20]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var GenJnlLineDocType: Enum "Gen. Journal Document Type"; TotalSalesLine: Record "Sales Line")
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        Clear(SalesReceivablesSetup);
        SalesReceivablesSetup.Get();
        If (SalesHeader.Invoice) and (SalesHeader."Tax Liable") then begin

            SalesHeader.CalcFields("IEPS Amt.", "IVA Amt.");
            If (SalesHeader."IEPS Amt." <> 0) and (SalesHeader."IVA Amt." <> 0) then begin
                SalesReceivablesSetup.TestField("IEPS GLA/c");
                SalesReceivablesSetup.TestField("IVA GLA/c");

                GenJournalLine.InitNewLine(
                  SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."Posting Description",
                  SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code", SalesHeader."Dimension Set ID",
                  SalesHeader."Reason Code");
                GenJournalLine."Document Type" := GenJnlLineDocType;
                GenJournalLine."Document No." := GenJnlLineDocNo;
                GenJournalLine."External Document No." := GenJnlLineExtDocNo;
                GenJournalLine."System-Created Entry" := true;
                GenJournalLine."Account No." := SalesReceivablesSetup."IVA GLA/c";
                GenJournalLine."Currency Code" := SalesHeader."Currency Code";
                GenJournalLine.Amount := -SalesHeader."IVA Amt.";
                GenJournalLine."Source Currency Code" := SalesHeader."Currency Code";
                GenJournalLine."Source Currency Amount" := GenJournalLine.Amount;
                GenJournalLine."Amount (LCY)" := -SalesHeader."IVA Amt.";
                if SalesHeader."Currency Code" = '' then
                    GenJournalLine."Currency Factor" := 1
                else
                    GenJournalLine."Currency Factor" := SalesHeader."Currency Factor";
                GenJournalLine.Correction := SalesHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJournalLine);

                GenJournalLine2.InitNewLine(
                  SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."Posting Description",
                  SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code", SalesHeader."Dimension Set ID",
                  SalesHeader."Reason Code");
                GenJournalLine2."Document Type" := GenJnlLineDocType;
                GenJournalLine2."Document No." := GenJnlLineDocNo;
                GenJournalLine2."External Document No." := GenJnlLineExtDocNo;
                GenJournalLine2."System-Created Entry" := true;
                GenJournalLine2."Account No." := SalesReceivablesSetup."IEPS GLA/c";
                GenJournalLine2."Currency Code" := SalesHeader."Currency Code";
                GenJournalLine2.Amount := -SalesHeader."IEPS Amt.";
                GenJournalLine2."Source Currency Code" := SalesHeader."Currency Code";
                GenJournalLine2."Source Currency Amount" := GenJournalLine2.Amount;
                GenJournalLine2."Amount (LCY)" := -SalesHeader."IEPS Amt.";
                if SalesHeader."Currency Code" = '' then
                    GenJournalLine2."Currency Factor" := 1
                else
                    GenJournalLine2."Currency Factor" := SalesHeader."Currency Factor";
                GenJournalLine2.Correction := SalesHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJournalLine2);

                GenJournalLine3.InitNewLine(
                  SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."Posting Description",
                  SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code", SalesHeader."Dimension Set ID",
                  SalesHeader."Reason Code");
                GenJournalLine3."Document Type" := GenJnlLineDocType;
                GenJournalLine3."Document No." := GenJnlLineDocNo;
                GenJournalLine3."External Document No." := GenJnlLineExtDocNo;
                GenJournalLine3."System-Created Entry" := true;
                GenJournalLine3."Account No." := SalesReceivablesSetup."IEPS GLA/c";
                GenJournalLine3."Currency Code" := SalesHeader."Currency Code";
                GenJournalLine3.Amount := (SalesHeader."IEPS Amt." + SalesHeader."IVA Amt.");
                GenJournalLine3."Source Currency Code" := SalesHeader."Currency Code";
                GenJournalLine3."Source Currency Amount" := GenJournalLine3.Amount;
                GenJournalLine3."Amount (LCY)" := (SalesHeader."IEPS Amt." + SalesHeader."IVA Amt.");
                if SalesHeader."Currency Code" = '' then
                    GenJournalLine3."Currency Factor" := 1
                else
                    GenJournalLine3."Currency Factor" := SalesHeader."Currency Factor";
                GenJournalLine3.Correction := SalesHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJournalLine3);
            end;
        end;
    end;


    // Cod90
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnAfterPostInvoice', '', false, true)]
    local procedure Cod90OnRunOnAfterPostInvoice(var PurchaseHeader: Record "Purchase Header"; GenJnlLineDocNo: Code[20]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        If (PurchaseHeader.Invoice) and (PurchaseHeader."Tax Liable") then begin
            Clear(SalesReceivablesSetup);
            SalesReceivablesSetup.Get();

            PurchaseHeader.CalcFields("IEPS Amt.", "IVA Amt.");
            If (PurchaseHeader."IEPS Amt." <> 0) and (PurchaseHeader."IVA Amt." <> 0) then begin
                SalesReceivablesSetup.TestField("IEPS GLA/c");
                SalesReceivablesSetup.TestField("IVA GLA/c");

                GenJournalLine.InitNewLine(
                  PurchaseHeader."Posting Date", PurchaseHeader."Document Date", PurchaseHeader."Posting Description",
                  PurchaseHeader."Shortcut Dimension 1 Code", PurchaseHeader."Shortcut Dimension 2 Code", PurchaseHeader."Dimension Set ID",
                  PurchaseHeader."Reason Code");
                GenJournalLine."Document Type" := GenJnlLineDocType;
                GenJournalLine."Document No." := GenJnlLineDocNo;
                GenJournalLine."External Document No." := GenJnlLineDocNo;
                GenJournalLine."System-Created Entry" := true;
                GenJournalLine."Account No." := SalesReceivablesSetup."IVA GLA/c";
                GenJournalLine."Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine.Amount := -PurchaseHeader."IVA Amt.";
                GenJournalLine."Source Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine."Source Currency Amount" := GenJournalLine.Amount;
                GenJournalLine."Amount (LCY)" := -PurchaseHeader."IVA Amt.";
                if PurchaseHeader."Currency Code" = '' then
                    GenJournalLine."Currency Factor" := 1
                else
                    GenJournalLine."Currency Factor" := PurchaseHeader."Currency Factor";
                GenJournalLine.Correction := PurchaseHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJournalLine);

                GenJournalLine2.InitNewLine(
                  PurchaseHeader."Posting Date", PurchaseHeader."Document Date", PurchaseHeader."Posting Description",
                  PurchaseHeader."Shortcut Dimension 1 Code", PurchaseHeader."Shortcut Dimension 2 Code", PurchaseHeader."Dimension Set ID",
                  PurchaseHeader."Reason Code");
                GenJournalLine2."Document Type" := GenJnlLineDocType;
                GenJournalLine2."Document No." := GenJnlLineDocNo;
                GenJournalLine2."External Document No." := GenJnlLineDocNo;
                GenJournalLine2."System-Created Entry" := true;
                GenJournalLine2."Account No." := SalesReceivablesSetup."IEPS GLA/c";
                GenJournalLine2."Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine2.Amount := -PurchaseHeader."IEPS Amt.";
                GenJournalLine2."Source Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine2."Source Currency Amount" := GenJournalLine2.Amount;
                GenJournalLine2."Amount (LCY)" := -PurchaseHeader."IEPS Amt.";
                if PurchaseHeader."Currency Code" = '' then
                    GenJournalLine2."Currency Factor" := 1
                else
                    GenJournalLine2."Currency Factor" := PurchaseHeader."Currency Factor";
                GenJournalLine2.Correction := PurchaseHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJournalLine2);

                GenJournalLine3.InitNewLine(
                  PurchaseHeader."Posting Date", PurchaseHeader."Document Date", PurchaseHeader."Posting Description",
                  PurchaseHeader."Shortcut Dimension 1 Code", PurchaseHeader."Shortcut Dimension 2 Code", PurchaseHeader."Dimension Set ID",
                  PurchaseHeader."Reason Code");
                GenJournalLine3."Document Type" := GenJnlLineDocType;
                GenJournalLine3."Document No." := GenJnlLineDocNo;
                GenJournalLine3."External Document No." := GenJnlLineDocNo;
                GenJournalLine3."System-Created Entry" := true;
                GenJournalLine3."Account No." := SalesReceivablesSetup."IEPS GLA/c";
                GenJournalLine3."Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine3.Amount := (PurchaseHeader."IEPS Amt." + PurchaseHeader."IVA Amt.");
                GenJournalLine3."Source Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine3."Source Currency Amount" := GenJournalLine3.Amount;
                GenJournalLine3."Amount (LCY)" := (PurchaseHeader."IEPS Amt." + PurchaseHeader."IVA Amt.");
                if PurchaseHeader."Currency Code" = '' then
                    GenJournalLine3."Currency Factor" := 1
                else
                    GenJournalLine3."Currency Factor" := PurchaseHeader."Currency Factor";
                GenJournalLine3.Correction := PurchaseHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJournalLine3);
            end;
        end;
    end;

    // Cod57
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterSalesRedistributeInvoiceDiscountAmounts', '', false, true)]
    // local procedure Cod57OnAfterSalesRedistributeInvoiceDiscountAmounts(var TempSalesLine: Record "Sales Line"; var TempTotalSalesLine: Record "Sales Line"; var VATAmount: Decimal)
    // var
    //     SalesHrd: Record "Sales Header";
    //     SalesHrdEn: Record "Sales Header";
    //     TaxJuri: Record "Tax Jurisdiction";
    //     TaxDetail: Record "Tax Detail";
    //     TaxArea: Record "Tax Area";
    //     TaxAreaLine: Record "Tax Area Line";
    // begin
    //     Clear(SalesHrdEn);
    //     If SalesHrdEn.get(SalesHrdEn."Document Type"::Order, Rec."Document No.") and (SalesHrdEn."Tax Liable") Then begin
    //         Clear(TaxDetail);
    //         Clear(TaxArea);
    //         Clear(TaxAreaLine);
    //         If (Rec."Tax Area Code" <> '') and (Rec."VAT %" <> 0) then begin
    //             TaxArea.Get(Rec."Tax Area Code");
    //             TaxAreaLine.Reset();
    //             TaxAreaLine.SetCurrentKey("Tax Area", "Calculation Order");
    //             TaxAreaLine.SetRange("Tax Area", TaxArea.Code);
    //             TaxAreaLine.Ascending(false);
    //             If TaxAreaLine.FindSet() then
    //                 repeat
    //                     TaxDetail.Reset();
    //                     Clear(SalesHrd);
    //                     SalesHrd.get(SalesHrd."Document Type"::Order, Rec."Document No.");
    //                     TaxDetail.SetCurrentKey("Tax Group Code", "Tax Jurisdiction Code");
    //                     TaxDetail.SetRange("Tax Group Code", rec."Tax Group Code");
    //                     TaxDetail.SetRange("Tax Jurisdiction Code", TaxAreaLine."Tax Jurisdiction Code");
    //                     TaxDetail.Setfilter("Effective Date", '<=%1', SalesHrd."Document Date");
    //                     TaxDetail.SetFilter("Tax Below Maximum", '<>%1', 0);
    //                     If TaxDetail.FindFirst() then begin
    //                         If TaxDetail."Tax Jurisdiction Code" = 'IEPS' then begin
    //                             Clear(Rec."IEPS Amt.");
    //                             If TaxDetail."Tax Below Maximum" <> 0 then
    //                                 Rec."IEPS Amt." := (Rec.Amount * TaxDetail."Tax Below Maximum") / 100;
    //                         end;
    //                         If TaxDetail."Tax Jurisdiction Code" = 'IVA' then begin
    //                             Clear(Rec."IVA Amt.");
    //                             If TaxDetail."Tax Below Maximum" <> 0 then
    //                                 Rec."IVA Amt." := ((Rec.Amount + Rec."IEPS Amt.") * TaxDetail."Tax Below Maximum") / 100;
    //                         end;
    //                     end;
    //                 until TaxAreaLine.Next() = 0;
    //         end;
    //     end else begin
    //         Rec."IEPS Amt." := 0;
    //         rec."IVA Amt." := 0;
    //     end;
    // end;
}