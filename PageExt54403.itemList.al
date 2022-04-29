pageextension 54403 PageExtension54403 extends "Item List"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("Invoice Duratio"; Rec."Invoice Duration")
            {
                ApplicationArea = All;
                ToolTip = 'Invoices contain this item category requires Invoice Duration.';
                Visible = true;
            }
        }
    }
}