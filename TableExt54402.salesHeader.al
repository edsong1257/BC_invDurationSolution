tableextension 54402 TableExtension54402 extends "Sales Header"
{
    fields
    {
        field(54400; "Invoice Start Date"; Date)
        {
            Caption = 'Invoice Start Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CheckEndDateCalcuable();
                UpdateSalesLinesByFieldNoCustomField(FieldNo("Invoice Start Date"), true);
                FieldNoINS := CurrFieldNo;
            end;
        }
        field(54401; "Invoice End Date"; Date)
        {
            Caption = 'Invoice End Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if FieldNoINS = 0 then
                    if Rec."Invoice End Date" < Rec."Invoice Start Date" then
                        Error(InvoiceDateError)
                    else
                        UpdateSalesLinesByFieldNoCustomField(FieldNo("Invoice End Date"), CurrFieldNo <> 0)
            end;
        }
        field(54402; "Invoice Period"; Integer)
        {
            Caption = 'Invoice Period';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Rec."Invoice Period" < 0 then
                    Error(InvoiceDateError)
                else begin
                    CheckEndDateCalcuable();
                    UpdateSalesLinesByFieldNoCustomField(FieldNo("Invoice End Date"), true);
                end;
            end;
        }
        field(54403; "Invoice Period Unit"; Option)
        {
            Caption = 'Invoice Period Unit';
            OptionMembers = YEAR,MONTH,QUARTER,OTHER;
            InitValue = YEAR;
            trigger OnValidate()
            begin
                CheckEndDateCalcuable();
                if ("Invoice Period Unit" <> Rec."Invoice Period Unit"::OTHER) and ("Invoice Start Date" <> 0D) then
                    UpdateSalesLinesByFieldNoCustomField(FieldNo("Invoice End Date"), true)
            end;
        }
        field(54404; "Has Invoice Duration Item"; Boolean)
        {
            Caption = 'Has Invoice Duration Item';
            FieldClass = FlowField;
            CalcFormula = exist("Sales Line" where("Document No." = field("No."), "Invoice Duration" = const(true)));
        }
    }


    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        FieldNoINS: Integer;
        SalesLineReserve: Codeunit "Sales Line-Reserve";
        Text031: Label 'You have modified %1.\\Do you want to update the lines?', Comment = 'You have modified Shipment Date.\\Do you want to update the lines?';
        SalesHeaderIsTemporaryLbl: Label 'Sales Header must be not temporary.', Locked = true;
        SalesHeaderDoesNotExistLbl: Label 'Sales Header must exist.', Locked = true;
        SalesLinesCategoryLbl: Label 'Sales Lines', Locked = true;
        SalesHeaderCannotModifyLbl: Label 'Cannot modify Sales Header.', Locked = true;
        InvoiceDateError: Label 'Invoice End Date cannot be eariler than Invoice Start Date.', Locked = true;

    procedure CalculateInvoiceEndDate()
    var
        Period: Text[100];
        PeriodUnit: Text[2];
    begin
        case "Invoice Period Unit" of
            "Invoice Period Unit"::YEAR:
                PeriodUnit := 'Y';
            "Invoice Period Unit"::QUARTER:
                PeriodUnit := 'Q';
            "Invoice Period Unit"::MONTH:
                PeriodUnit := 'M';
        end;
        Period := '<' + Format("Invoice Period") + PeriodUnit + '-1D >';
        "Invoice End Date" := CalcDate(Period, "Invoice Start Date");
        //  UpdateSalesLinesByFieldNo(FieldNo("Invoice Start Date"), true);
        //  UpdateSalesLinesByFieldNo(FieldNo("Invoice End Date"), true);
    end;

    procedure CheckEndDateCalcuable()
    begin
        if ("Invoice Start Date" <> 0D) and ("Invoice Period" <> 0) and ("Invoice Period Unit" <> "Invoice Period Unit"::"OTHER") then
            CalculateInvoiceEndDate()
        else
            if ("Invoice Period" = 0) then
                "Invoice End Date" := "Invoice Start Date";
    end;

    procedure UpdateSalesLinesByFieldNoCustomField(ChangedFieldNo: Integer; AskQuestion: Boolean)
    var
        "Field": Record "Field";
        JobTransferLine: Codeunit "Job Transfer Line";
        Question: Text[250];
        IsHandled: Boolean;
        ShouldConfirmReservationDateConflict: Boolean;
    begin
        if Rec.IsTemporary() then begin
            Session.LogMessage('0000G95', SalesHeaderIsTemporaryLbl, Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', SalesLinesCategoryLbl);
            exit;
        end;

        if IsNullGuid(Rec.SystemId) then begin
            Session.LogMessage('0000G96', SalesHeaderDoesNotExistLbl, Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', SalesLinesCategoryLbl);
            exit;
        end;

        IsHandled := false;
        OnBeforeUpdateSalesLinesByFieldNo(Rec, ChangedFieldNo, AskQuestion, IsHandled, xRec);
        if IsHandled then
            exit;

        if not SalesLinesExist then
            exit;

        if not Field.Get(DATABASE::"Sales Header", ChangedFieldNo) then
            Field.Get(DATABASE::"Sales Line", ChangedFieldNo);

        if AskQuestion then begin
            Question := StrSubstNo(Text031, Field."Field Caption");
            if GuiAllowed and not GetHideValidationDialog then
                if DIALOG.Confirm(Question, true) then begin
                    ShouldConfirmReservationDateConflict := false;
                    OnUpdateSalesLinesByFieldNoOnAfterCalcShouldConfirmReservationDateConflict(Rec, ChangedFieldNo, ShouldConfirmReservationDateConflict);
                end else
                    exit
        end;

        SalesLine.LockTable();
        if not Rec.Modify() then begin
            Session.LogMessage('0000G97', SalesHeaderCannotModifyLbl, Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', SalesLinesCategoryLbl);
            exit;
        end;

        SalesLine.Reset();
        SalesLine.SetRange("Document Type", "Document Type");
        SalesLine.SetRange("Document No.", "No.");
        if SalesLine.FindSet then
            repeat
                IsHandled := false;
                OnBeforeSalesLineByChangedFieldNo(Rec, SalesLine, ChangedFieldNo, IsHandled, xRec);
                if not IsHandled then
                    case ChangedFieldNo of
                        FieldNo("Invoice Start Date"):
                            if SalesLine."No." <> '' then begin
                                SalesLine.Validate("Invoice Start Date", "Invoice Start Date");
                                SalesLine.Validate("Invoice End Date", "Invoice End Date");
                            end;
                        FieldNo("Invoice End Date"):
                            if SalesLine."No." <> '' then
                                SalesLine.Validate("Invoice End Date", "Invoice End Date");
                        else
                            OnUpdateSalesLineByChangedFieldName(Rec, SalesLine, Field.FieldName, ChangedFieldNo);
                    end;
                SalesLineReserve.AssignForPlanning(SalesLine);
                OnUpdateSalesLinesByFieldNoOnBeforeSalesLineModify(SalesLine, ChangedFieldNo, CurrFieldNo);
                SalesLine.Modify(true);
            until SalesLine.Next() = 0;

        OnAfterUpdateSalesLinesByFieldNo(Rec, xRec, ChangedFieldNo);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpdateSalesLinesByFieldNo(var SalesHeader: Record "Sales Header"; ChangedFieldNo: Integer; var AskQuestion: Boolean; var IsHandled: Boolean; xSalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateSalesLinesByFieldNoOnAfterCalcShouldConfirmReservationDateConflict(var SalesHeader: Record "Sales Header"; ChangedFieldNo: Integer; var ShouldConfirmReservationDateConflict: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSalesLineByChangedFieldNo(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldNo: Integer; var IsHandled: Boolean; xSalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateSalesLineByChangedFieldName(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnUpdateSalesLinesByFieldNoOnBeforeSalesLineModify(var SalesLine: Record "Sales Line"; ChangedFieldNo: Integer; CurrentFieldNo: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterUpdateSalesLinesByFieldNo(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; ChangedFieldNo: Integer)
    begin
    end;

}