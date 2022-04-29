pageextension 54402 PageExtension54402 extends "Item Card"
{
    layout
    {
        addafter("Sales Blocked")
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