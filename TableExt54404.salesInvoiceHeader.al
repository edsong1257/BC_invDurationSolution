tableextension 54404 TableExtension54404 extends "Sales Invoice Header"
{
    fields
    {
        field(54400; "Invoice Start Date"; Date)
        {
            Caption = 'Invoice Start Date';
            DataClassification = ToBeClassified;
        }
        field(54401; "Invoice End Date"; Date)
        {
            Caption = 'Invoice End Date';
            DataClassification = ToBeClassified;
        }
        field(54402; "Invoice Period"; Integer)
        {
            Caption = 'Invoice Period';
            DataClassification = ToBeClassified;
        }
        field(54403; "Invoice Period Unit"; Option)
        {
            Caption = 'Invoice Period Unit';
            OptionMembers = YEAR,MONTH,QUARTER,OTHER;
        }
        field(54404; "Has Invoice Duration Item"; Boolean)
        {
            Caption = 'Has Invoice Duration Item';
            FieldClass = FlowField;
            CalcFormula = exist("Sales Invoice Line" where("Document No." = field("No."), "Invoice Duration" = const(true)));
        }
    }
}