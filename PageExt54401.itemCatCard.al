pageextension 54401 PageExtension54401 extends "Item Category Card"
{
    layout
    {
        addafter("Parent Category")
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