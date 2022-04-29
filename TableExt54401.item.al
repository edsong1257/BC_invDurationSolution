tableextension 54401 TableExtension54401 extends "Item"
{
    fields
    {
        field(54400; "Invoice Duration"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Item Category"."Invoice Duration" where(Code = field("Item Category Code")));
        }
    }
}