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
        GenJnlLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        Clear(SalesReceivablesSetup);
        SalesReceivablesSetup.Get();
        If (SalesHeader.Invoice) and (SalesHeader."Tax Liable") then begin

            SalesHeader.CalcFields("IEPS Amt.", "IVA Amt.");
            If (SalesHeader."IEPS Amt." <> 0) and (SalesHeader."IVA Amt." <> 0) then begin
                SalesReceivablesSetup.TestField("IEPS Not Paid GLA/c");
                SalesReceivablesSetup.TestField("IVA Not Paid GLA/c");

                GenJnlLine.InitNewLine(
                  SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", SalesHeader."Posting Description",
                  SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code", SalesHeader."Dimension Set ID",
                  SalesHeader."Reason Code");

                GenJnlLine."Document Type" := GenJnlLineDocType;
                GenJnlLine."Document No." := GenJnlLineDocNo;
                GenJnlLine."External Document No." := GenJnlLineExtDocNo;
                GenJnlLine."System-Created Entry" := true;
                GenJnlLine."Account No." := SalesReceivablesSetup."IVA Not Paid GLA/c";
                GenJnlLine."Currency Code" := SalesHeader."Currency Code";
                GenJnlLine.Amount := -SalesHeader."IVA Amt.";
                GenJnlLine."Source Currency Code" := SalesHeader."Currency Code";
                GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
                GenJnlLine."Amount (LCY)" := -SalesHeader."IVA Amt.";
                if SalesHeader."Currency Code" = '' then
                    GenJnlLine."Currency Factor" := 1
                else
                    GenJnlLine."Currency Factor" := SalesHeader."Currency Factor";
                GenJnlLine.Correction := SalesHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJnlLine);

                GenJournalLine2.InitNewLine(
                  SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", SalesHeader."Posting Description",
                  SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code", SalesHeader."Dimension Set ID",
                  SalesHeader."Reason Code");
                GenJournalLine2."Document Type" := GenJnlLineDocType;
                GenJournalLine2."Document No." := GenJnlLineDocNo;
                GenJournalLine2."External Document No." := GenJnlLineExtDocNo;
                GenJournalLine2."System-Created Entry" := true;
                GenJournalLine2."Account No." := SalesReceivablesSetup."IEPS Not Paid GLA/c";
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
                  SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", SalesHeader."Posting Description",
                  SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code", SalesHeader."Dimension Set ID",
                  SalesHeader."Reason Code");
                GenJournalLine3."Document Type" := GenJnlLineDocType;
                GenJournalLine3."Document No." := GenJnlLineDocNo;
                GenJournalLine3."External Document No." := GenJnlLineExtDocNo;
                GenJournalLine3."System-Created Entry" := true;
                GenJournalLine3."Account No." := SalesReceivablesSetup."IEPS Not Paid GLA/c";
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
        GenJnlLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        GenJournalLine3: Record "Gen. Journal Line";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        If (PurchaseHeader.Invoice) and (PurchaseHeader."Tax Liable") then begin
            Clear(PurchasesPayablesSetup);
            PurchasesPayablesSetup.Get();

            PurchaseHeader.CalcFields("IEPS Amt.", "IVA Amt.");
            If (PurchaseHeader."IEPS Amt." <> 0) and (PurchaseHeader."IVA Amt." <> 0) then begin
                PurchasesPayablesSetup.TestField("IEPS Not Paid GLA/c");
                PurchasesPayablesSetup.TestField("IVA Not Paid GLA/c");

                GenJnlLine.InitNewLine(
                  PurchaseHeader."Posting Date", PurchaseHeader."Document Date", PurchaseHeader."VAT Reporting Date", PurchaseHeader."Posting Description",
                  PurchaseHeader."Shortcut Dimension 1 Code", PurchaseHeader."Shortcut Dimension 2 Code", PurchaseHeader."Dimension Set ID",
                  PurchaseHeader."Reason Code");
                GenJnlLine."Document Type" := GenJnlLineDocType;
                GenJnlLine."Document No." := GenJnlLineDocNo;
                GenJnlLine."External Document No." := GenJnlLineDocNo;
                GenJnlLine."System-Created Entry" := true;
                GenJnlLine."Account No." := PurchasesPayablesSetup."IVA Not Paid GLA/c";
                GenJnlLine."Currency Code" := PurchaseHeader."Currency Code";
                GenJnlLine.Amount := PurchaseHeader."IVA Amt.";
                GenJnlLine."Source Currency Code" := PurchaseHeader."Currency Code";
                GenJnlLine."Source Currency Amount" := GenJnlLine.Amount;
                GenJnlLine."Amount (LCY)" := PurchaseHeader."IVA Amt.";
                if PurchaseHeader."Currency Code" = '' then
                    GenJnlLine."Currency Factor" := 1
                else
                    GenJnlLine."Currency Factor" := PurchaseHeader."Currency Factor";
                GenJnlLine.Correction := PurchaseHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJnlLine);

                GenJournalLine2.InitNewLine(
                  PurchaseHeader."Posting Date", PurchaseHeader."Document Date", PurchaseHeader."VAT Reporting Date", PurchaseHeader."Posting Description",
                  PurchaseHeader."Shortcut Dimension 1 Code", PurchaseHeader."Shortcut Dimension 2 Code", PurchaseHeader."Dimension Set ID",
                  PurchaseHeader."Reason Code");
                GenJournalLine2."Document Type" := GenJnlLineDocType;
                GenJournalLine2."Document No." := GenJnlLineDocNo;
                GenJournalLine2."External Document No." := GenJnlLineDocNo;
                GenJournalLine2."System-Created Entry" := true;
                GenJournalLine2."Account No." := PurchasesPayablesSetup."IEPS Not Paid GLA/c";
                GenJournalLine2."Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine2.Amount := PurchaseHeader."IEPS Amt.";
                GenJournalLine2."Source Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine2."Source Currency Amount" := GenJournalLine2.Amount;
                GenJournalLine2."Amount (LCY)" := PurchaseHeader."IEPS Amt.";
                if PurchaseHeader."Currency Code" = '' then
                    GenJournalLine2."Currency Factor" := 1
                else
                    GenJournalLine2."Currency Factor" := PurchaseHeader."Currency Factor";
                GenJournalLine2.Correction := PurchaseHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJournalLine2);

                GenJournalLine3.InitNewLine(
                  PurchaseHeader."Posting Date", PurchaseHeader."Document Date", PurchaseHeader."VAT Reporting Date", PurchaseHeader."Posting Description",
                  PurchaseHeader."Shortcut Dimension 1 Code", PurchaseHeader."Shortcut Dimension 2 Code", PurchaseHeader."Dimension Set ID",
                  PurchaseHeader."Reason Code");
                GenJournalLine3."Document Type" := GenJnlLineDocType;
                GenJournalLine3."Document No." := GenJnlLineDocNo;
                GenJournalLine3."External Document No." := GenJnlLineDocNo;
                GenJournalLine3."System-Created Entry" := true;
                GenJournalLine3."Account No." := PurchasesPayablesSetup."IEPS Not Paid GLA/c";
                GenJournalLine3."Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine3.Amount := -(PurchaseHeader."IEPS Amt." + PurchaseHeader."IVA Amt.");
                GenJournalLine3."Source Currency Code" := PurchaseHeader."Currency Code";
                GenJournalLine3."Source Currency Amount" := GenJournalLine3.Amount;
                GenJournalLine3."Amount (LCY)" := -(PurchaseHeader."IEPS Amt." + PurchaseHeader."IVA Amt.");
                if PurchaseHeader."Currency Code" = '' then
                    GenJournalLine3."Currency Factor" := 1
                else
                    GenJournalLine3."Currency Factor" := PurchaseHeader."Currency Factor";
                GenJournalLine3.Correction := PurchaseHeader.Correction;
                GenJnlPostLine.RunWithCheck(GenJournalLine3);
            end;
        end;
    end;

    // Cod13 OnBeforePostGenJnlLine  
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnBeforePostGenJnlLine', '', false, true)]
    local procedure Cod13OnAfterPostAllocations(var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var PostingGenJournalLine: Record "Gen. Journal Line")
    var
        IVAAmts: Decimal;
        IEPSAmts: Decimal;
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        GenJnlLine4: Record "Gen. Journal Line";
        GenJnlLine5: Record "Gen. Journal Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        If PostingGenJournalLine."Applies-to ID" <> '' then begin
            IVAAmts := 0;
            IEPSAmts := 0;
            If PostingGenJournalLine."Account Type" = PostingGenJournalLine."Account Type"::Customer then Begin
                ToCheckCustomerInvoiceAmt(PostingGenJournalLine."Account No.", PostingGenJournalLine."Applies-to ID", IVAAmts, IEPSAmts);
                Clear(SalesReceivablesSetup);
                SalesReceivablesSetup.Get();
                SalesReceivablesSetup.TestField("IVA Not Paid GLA/c");
                SalesReceivablesSetup.TestField("IVA Paid GLA/c");
                SalesReceivablesSetup.TestField("IEPS Not Paid GLA/c");
                SalesReceivablesSetup.TestField("IEPS Paid GLA/c");
                IF IVAAmts < 0 then begin
                    Clear(GenJnlLine2);
                    GenJnlLine2.LockTable();
                    GenJnlLine2.Init();
                    GenJnlLine2."Posting Date" := PostingGenJournalLine."Posting Date";
                    GenJnlLine2."VAT Reporting Date" := PostingGenJournalLine."VAT Reporting Date";
                    GenJnlLine2."Document Type" := PostingGenJournalLine."Document Type";
                    GenJnlLine2."Document No." := PostingGenJournalLine."Document No.";
                    GenJnlLine2.Description := PostingGenJournalLine.Description;
                    GenJnlLine2."Account No." := SalesReceivablesSetup."IVA Paid GLA/c";
                    GenJnlLine2."Journal Batch Name" := PostingGenJournalLine."Journal Batch Name";
                    GenJnlLine2."Journal Template Name" := PostingGenJournalLine."Journal Template Name";
                    GenJnlLine2."Source Code" := PostingGenJournalLine."Source Code";
                    GenJnlLine2."Reason Code" := PostingGenJournalLine."Reason Code";
                    GenJnlLine2.Correction := PostingGenJournalLine.Correction;
                    GenJnlLine2."Recurring Method" := PostingGenJournalLine."Recurring Method";
                    GenJnlLine2."External Document No." := PostingGenJournalLine."External Document No.";
                    GenJnlLine2."System-Created Entry" := true;
                    GenJnlLine2.Amount := IVAAmts;
                    GenJnlLine2."Amount (LCY)" := IVAAmts;

                    GenJnlPostLine.RunWithCheck(GenJnlLine2);

                    Clear(GenJnlLine3);
                    GenJnlLine3.LockTable();
                    GenJnlLine3.Init();
                    GenJnlLine3."Posting Date" := PostingGenJournalLine."Posting Date";
                    GenJnlLine3."VAT Reporting Date" := PostingGenJournalLine."VAT Reporting Date";
                    GenJnlLine3."Document Type" := PostingGenJournalLine."Document Type";
                    GenJnlLine3."Document No." := PostingGenJournalLine."Document No.";
                    GenJnlLine3.Description := PostingGenJournalLine.Description;
                    GenJnlLine3."Account No." := SalesReceivablesSetup."IVA Not Paid GLA/c";
                    GenJnlLine3."Journal Batch Name" := PostingGenJournalLine."Journal Batch Name";
                    GenJnlLine3."Journal Template Name" := PostingGenJournalLine."Journal Template Name";
                    GenJnlLine3."Source Code" := PostingGenJournalLine."Source Code";
                    GenJnlLine3."Reason Code" := PostingGenJournalLine."Reason Code";
                    GenJnlLine3.Correction := PostingGenJournalLine.Correction;
                    GenJnlLine3."Recurring Method" := PostingGenJournalLine."Recurring Method";
                    GenJnlLine3."External Document No." := PostingGenJournalLine."External Document No.";
                    GenJnlLine3."System-Created Entry" := true;
                    GenJnlLine3.Amount := -IVAAmts;
                    GenJnlLine3."Amount (LCY)" := -IVAAmts;

                    GenJnlPostLine.RunWithCheck(GenJnlLine3);
                end;
                IF IEPSAmts < 0 then begin
                    Clear(GenJnlLine4);
                    GenJnlLine4.LockTable();
                    GenJnlLine4.Init();
                    GenJnlLine4."Posting Date" := PostingGenJournalLine."Posting Date";
                    GenJnlLine4."VAT Reporting Date" := PostingGenJournalLine."VAT Reporting Date";
                    GenJnlLine4."Document Type" := PostingGenJournalLine."Document Type";
                    GenJnlLine4."Document No." := PostingGenJournalLine."Document No.";
                    GenJnlLine4.Description := PostingGenJournalLine.Description;
                    GenJnlLine4."Account No." := SalesReceivablesSetup."IEPS Paid GLA/c";
                    GenJnlLine4."Journal Batch Name" := PostingGenJournalLine."Journal Batch Name";
                    GenJnlLine4."Journal Template Name" := PostingGenJournalLine."Journal Template Name";
                    GenJnlLine4."Source Code" := PostingGenJournalLine."Source Code";
                    GenJnlLine4."Reason Code" := PostingGenJournalLine."Reason Code";
                    GenJnlLine4.Correction := PostingGenJournalLine.Correction;
                    GenJnlLine4."Recurring Method" := PostingGenJournalLine."Recurring Method";
                    GenJnlLine4."External Document No." := PostingGenJournalLine."External Document No.";
                    GenJnlLine4."System-Created Entry" := true;
                    GenJnlLine4.Amount := IEPSAmts;
                    GenJnlLine4."Amount (LCY)" := IEPSAmts;

                    GenJnlPostLine.RunWithCheck(GenJnlLine4);

                    Clear(GenJnlLine5);
                    GenJnlLine5.LockTable();
                    GenJnlLine5.Init();
                    GenJnlLine5."Posting Date" := PostingGenJournalLine."Posting Date";
                    GenJnlLine5."VAT Reporting Date" := PostingGenJournalLine."VAT Reporting Date";
                    GenJnlLine5."Document Type" := PostingGenJournalLine."Document Type";
                    GenJnlLine5."Document No." := PostingGenJournalLine."Document No.";
                    GenJnlLine5.Description := PostingGenJournalLine.Description;
                    GenJnlLine5."Account No." := SalesReceivablesSetup."IEPS Not Paid GLA/c";
                    GenJnlLine5."Journal Batch Name" := PostingGenJournalLine."Journal Batch Name";
                    GenJnlLine5."Journal Template Name" := PostingGenJournalLine."Journal Template Name";
                    GenJnlLine5."Source Code" := PostingGenJournalLine."Source Code";
                    GenJnlLine5."Reason Code" := PostingGenJournalLine."Reason Code";
                    GenJnlLine5.Correction := PostingGenJournalLine.Correction;
                    GenJnlLine5."Recurring Method" := PostingGenJournalLine."Recurring Method";
                    GenJnlLine5."External Document No." := PostingGenJournalLine."External Document No.";
                    GenJnlLine5."System-Created Entry" := true;
                    GenJnlLine5.Amount := -IEPSAmts;
                    GenJnlLine5."Amount (LCY)" := -IEPSAmts;

                    GenJnlPostLine.RunWithCheck(GenJnlLine5);
                end;
            end;

            If PostingGenJournalLine."Account Type" = PostingGenJournalLine."Account Type"::Vendor then Begin
                ToCheckVendorInvoiceAmt(PostingGenJournalLine."Account No.", PostingGenJournalLine."Applies-to ID", IVAAmts, IEPSAmts);
                Clear(PurchasesPayablesSetup);
                PurchasesPayablesSetup.Get();
                PurchasesPayablesSetup.TestField("IVA Not Paid GLA/c");
                PurchasesPayablesSetup.TestField("IVA Paid GLA/c");
                PurchasesPayablesSetup.TestField("IEPS Not Paid GLA/c");
                PurchasesPayablesSetup.TestField("IEPS Paid GLA/c");
                IF IVAAmts < 0 then begin
                    Clear(GenJnlLine2);
                    GenJnlLine2.LockTable();
                    GenJnlLine2.Init();
                    GenJnlLine2."Posting Date" := PostingGenJournalLine."Posting Date";
                    GenJnlLine2."VAT Reporting Date" := PostingGenJournalLine."VAT Reporting Date";
                    GenJnlLine2."Document Type" := PostingGenJournalLine."Document Type";
                    GenJnlLine2."Document No." := PostingGenJournalLine."Document No.";
                    GenJnlLine2.Description := PostingGenJournalLine.Description;
                    GenJnlLine2."Account No." := PurchasesPayablesSetup."IVA Paid GLA/c";
                    GenJnlLine2."Journal Batch Name" := PostingGenJournalLine."Journal Batch Name";
                    GenJnlLine2."Journal Template Name" := PostingGenJournalLine."Journal Template Name";
                    GenJnlLine2."Source Code" := PostingGenJournalLine."Source Code";
                    GenJnlLine2."Reason Code" := PostingGenJournalLine."Reason Code";
                    GenJnlLine2.Correction := PostingGenJournalLine.Correction;
                    GenJnlLine2."Recurring Method" := PostingGenJournalLine."Recurring Method";
                    GenJnlLine2."External Document No." := PostingGenJournalLine."External Document No.";
                    GenJnlLine2."System-Created Entry" := true;
                    GenJnlLine2.Amount := -IVAAmts;
                    GenJnlLine2."Amount (LCY)" := -IVAAmts;

                    GenJnlPostLine.RunWithCheck(GenJnlLine2);

                    Clear(GenJnlLine3);
                    GenJnlLine3.LockTable();
                    GenJnlLine3.Init();
                    GenJnlLine3."Posting Date" := PostingGenJournalLine."Posting Date";
                    GenJnlLine3."VAT Reporting Date" := PostingGenJournalLine."VAT Reporting Date";
                    GenJnlLine3."Document Type" := PostingGenJournalLine."Document Type";
                    GenJnlLine3."Document No." := PostingGenJournalLine."Document No.";
                    GenJnlLine3.Description := PostingGenJournalLine.Description;
                    GenJnlLine3."Account No." := PurchasesPayablesSetup."IVA Not Paid GLA/c";
                    GenJnlLine3."Journal Batch Name" := PostingGenJournalLine."Journal Batch Name";
                    GenJnlLine3."Journal Template Name" := PostingGenJournalLine."Journal Template Name";
                    GenJnlLine3."Source Code" := PostingGenJournalLine."Source Code";
                    GenJnlLine3."Reason Code" := PostingGenJournalLine."Reason Code";
                    GenJnlLine3.Correction := PostingGenJournalLine.Correction;
                    GenJnlLine3."Recurring Method" := PostingGenJournalLine."Recurring Method";
                    GenJnlLine3."External Document No." := PostingGenJournalLine."External Document No.";
                    GenJnlLine3."System-Created Entry" := true;
                    GenJnlLine3.Amount := IVAAmts;
                    GenJnlLine3."Amount (LCY)" := IVAAmts;

                    GenJnlPostLine.RunWithCheck(GenJnlLine3);
                end;
                IF IEPSAmts < 0 then begin
                    Clear(GenJnlLine4);
                    GenJnlLine4.LockTable();
                    GenJnlLine4.Init();
                    GenJnlLine4."Posting Date" := PostingGenJournalLine."Posting Date";
                    GenJnlLine4."VAT Reporting Date" := PostingGenJournalLine."VAT Reporting Date";
                    GenJnlLine4."Document Type" := PostingGenJournalLine."Document Type";
                    GenJnlLine4."Document No." := PostingGenJournalLine."Document No.";
                    GenJnlLine4.Description := PostingGenJournalLine.Description;
                    GenJnlLine4."Account No." := PurchasesPayablesSetup."IEPS Paid GLA/c";
                    GenJnlLine4."Journal Batch Name" := PostingGenJournalLine."Journal Batch Name";
                    GenJnlLine4."Journal Template Name" := PostingGenJournalLine."Journal Template Name";
                    GenJnlLine4."Source Code" := PostingGenJournalLine."Source Code";
                    GenJnlLine4."Reason Code" := PostingGenJournalLine."Reason Code";
                    GenJnlLine4.Correction := PostingGenJournalLine.Correction;
                    GenJnlLine4."Recurring Method" := PostingGenJournalLine."Recurring Method";
                    GenJnlLine4."External Document No." := PostingGenJournalLine."External Document No.";
                    GenJnlLine4."System-Created Entry" := true;
                    GenJnlLine4.Amount := -IEPSAmts;
                    GenJnlLine4."Amount (LCY)" := -IEPSAmts;

                    GenJnlPostLine.RunWithCheck(GenJnlLine4);

                    Clear(GenJnlLine5);
                    GenJnlLine5.LockTable();
                    GenJnlLine5.Init();
                    GenJnlLine5."Posting Date" := PostingGenJournalLine."Posting Date";
                    GenJnlLine5."VAT Reporting Date" := PostingGenJournalLine."VAT Reporting Date";
                    GenJnlLine5."Document Type" := PostingGenJournalLine."Document Type";
                    GenJnlLine5."Document No." := PostingGenJournalLine."Document No.";
                    GenJnlLine5.Description := PostingGenJournalLine.Description;
                    GenJnlLine5."Account No." := PurchasesPayablesSetup."IEPS Not Paid GLA/c";
                    GenJnlLine5."Journal Batch Name" := PostingGenJournalLine."Journal Batch Name";
                    GenJnlLine5."Journal Template Name" := PostingGenJournalLine."Journal Template Name";
                    GenJnlLine5."Source Code" := PostingGenJournalLine."Source Code";
                    GenJnlLine5."Reason Code" := PostingGenJournalLine."Reason Code";
                    GenJnlLine5.Correction := PostingGenJournalLine.Correction;
                    GenJnlLine5."Recurring Method" := PostingGenJournalLine."Recurring Method";
                    GenJnlLine5."External Document No." := PostingGenJournalLine."External Document No.";
                    GenJnlLine5."System-Created Entry" := true;
                    GenJnlLine5.Amount := IEPSAmts;
                    GenJnlLine5."Amount (LCY)" := IEPSAmts;

                    GenJnlPostLine.RunWithCheck(GenJnlLine5);
                end;
            end;
        end;
    end;

    local procedure ToCheckCustomerInvoiceAmt(Cust: Code[20]; AppliestoID: Code[50]; var IVAAmt: Decimal; Var IEPSAmt: Decimal)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        GlEntry: Record "G/L Entry";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        IVAAmt := 0;
        IEPSAmt := 0;
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetCurrentKey("Document Type", "Customer No.", Open, "Applies-to ID");
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Customer No.", Cust);
        CustLedgerEntry.SetRange(Open, true);
        CustLedgerEntry.SetRange("Applies-to ID", AppliestoID);
        If CustLedgerEntry.FindFirst() then begin
            Clear(SalesReceivablesSetup);
            SalesReceivablesSetup.Get();
            SalesReceivablesSetup.TestField("IVA Paid GLA/c");
            SalesReceivablesSetup.TestField("IEPS Paid GLA/c");
            GlEntry.Reset();
            GlEntry.SetCurrentKey("Document Type", "Document No.", "Posting Date", "G/L Account No.");
            GlEntry.SetRange("Document Type", GlEntry."Document Type"::Invoice);
            GlEntry.SetRange("Document No.", CustLedgerEntry."Document No.");
            GlEntry.SetRange("Posting Date", CustLedgerEntry."Posting Date");
            GlEntry.SetFilter("G/L Account No.", SalesReceivablesSetup."IVA Paid GLA/c");
            GlEntry.SetFilter(Amount, '<%1', 0);
            If GlEntry.FindFirst() then
                IVAAmt := GlEntry.Amount;

            GlEntry.Reset();
            GlEntry.SetCurrentKey("Document Type", "Document No.", "Posting Date", "G/L Account No.");
            GlEntry.SetRange("Document Type", GlEntry."Document Type"::Invoice);
            GlEntry.SetRange("Document No.", CustLedgerEntry."Document No.");
            GlEntry.SetRange("Posting Date", CustLedgerEntry."Posting Date");
            GlEntry.SetFilter("G/L Account No.", SalesReceivablesSetup."IEPS Paid GLA/c");
            GlEntry.SetFilter(Amount, '<%1', 0);
            If GlEntry.FindFirst() then
                IEPSAmt := GlEntry.Amount;

        end;
    end;

    local procedure ToCheckVendorInvoiceAmt(Vend: Code[20]; AppliestoID: Code[50]; var IVAAmt: Decimal; Var IEPSAmt: Decimal)
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        GlEntry: Record "G/L Entry";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        IVAAmt := 0;
        IEPSAmt := 0;
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetCurrentKey("Document Type", "Vendor No.", Open, "Applies-to ID");
        VendorLedgerEntry.SetRange("Document Type", VendorLedgerEntry."Document Type"::Invoice);
        VendorLedgerEntry.SetRange("Vendor No.", Vend);
        VendorLedgerEntry.SetRange(Open, true);
        VendorLedgerEntry.SetRange("Applies-to ID", AppliestoID);
        If VendorLedgerEntry.FindFirst() then begin
            Clear(PurchasesPayablesSetup);
            PurchasesPayablesSetup.Get();
            PurchasesPayablesSetup.TestField("IVA Paid GLA/c");
            PurchasesPayablesSetup.TestField("IEPS Paid GLA/c");
            GlEntry.Reset();
            GlEntry.SetCurrentKey("Document Type", "Document No.", "Posting Date", "G/L Account No.");
            GlEntry.SetRange("Document Type", GlEntry."Document Type"::Invoice);
            GlEntry.SetRange("Document No.", VendorLedgerEntry."Document No.");
            GlEntry.SetRange("Posting Date", VendorLedgerEntry."Posting Date");
            GlEntry.SetFilter("G/L Account No.", PurchasesPayablesSetup."IVA Paid GLA/c");
            GlEntry.SetFilter(Amount, '<%1', 0);
            If GlEntry.FindFirst() then
                IVAAmt := GlEntry.Amount;

            GlEntry.Reset();
            GlEntry.SetCurrentKey("Document Type", "Document No.", "Posting Date", "G/L Account No.");
            GlEntry.SetRange("Document Type", GlEntry."Document Type"::Invoice);
            GlEntry.SetRange("Document No.", VendorLedgerEntry."Document No.");
            GlEntry.SetRange("Posting Date", VendorLedgerEntry."Posting Date");
            GlEntry.SetFilter("G/L Account No.", PurchasesPayablesSetup."IEPS Paid GLA/c");
            GlEntry.SetFilter(Amount, '<%1', 0);
            If GlEntry.FindFirst() then
                IEPSAmt := GlEntry.Amount;

        end;
    end;
}