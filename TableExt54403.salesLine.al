tableextension 54403 TableExtension54403 extends "Sales Line"
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
        field(54402; "Invoice Duration"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Item Category"."Invoice Duration" where(Code = field("Item Category Code")));
        }
    }
}