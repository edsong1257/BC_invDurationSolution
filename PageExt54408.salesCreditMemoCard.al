pageextension 54408 PageExtension54408 extends "Sales Credit Memo"
{
    layout
    {
        addafter("Credit Memo Details")
        {
            group("Invoice Duration")
            {
                field("Invoice Start Date"; Rec."Invoice Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The start date of Invoice Duration.';
                    ShowMandatory = Rec."Has Invoice Duration Item";
                }
                field("Invoice End Date"; Rec."Invoice End Date")
                {
                    ApplicationArea = All;
                    Editable = IsEndDateEditable;
                    ToolTip = 'The end date of Invoice Duration.';
                    ShowMandatory = Rec."Has Invoice Duration Item";
                }
                field("Invoice Period"; Rec."Invoice Period")
                {
                    ApplicationArea = All;
                    Editable = IsPeriodEditable;
                    ToolTip = 'The duration between invoice start date and invoice end date.';
                }
                field("Invoice Period Unit"; Rec."Invoice Period Unit")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unit of invoice perid. You can self define invoice end date by selecting OTHER.';
                    trigger OnValidate()
                    begin
                        if (Rec."Invoice Period Unit" = Rec."Invoice Period Unit"::OTHER) then begin
                            IsEndDateEditable := true;
                            IsPeriodEditable := false;
                        end else begin
                            IsEndDateEditable := false;
                            IsPeriodEditable := true;
                        end;
                    end;
                }
                field("Has Invoice Duration Item"; Rec."Has Invoice Duration Item")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        IsEndDateEditable: Boolean;
        IsPeriodEditable: Boolean;
        FieldNoINS: Integer;
        HasInvoiceDuration: Boolean;

    trigger OnAfterGetRecord()
    begin
        // Rec.CalcFields("Has Invoice Duration Item");
        if (Rec."Invoice Period Unit" = Rec."Invoice Period Unit"::OTHER) then begin
            IsEndDateEditable := true;
            IsPeriodEditable := false;
        end else begin
            IsEndDateEditable := false;
            IsPeriodEditable := true;
        end;
    end;
}