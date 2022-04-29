pageextension 54400 PageExtension54400 extends "Item Categories"
{
    layout
    {
        addafter("Description")
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