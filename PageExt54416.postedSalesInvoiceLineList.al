pageextension 54416 postedSalesInvoiceLineList extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter(Description)
        {
            field("Invoice Start Date"; Rec."Invoice Start Date")
            {
                ApplicationArea = All;
                ToolTip = 'The start date of Invoice Duration.';
                Visible = false;
            }
            field("Invoice End Date"; Rec."Invoice End Date")
            {
                ApplicationArea = All;
                ToolTip = 'The end date of Invoice Duration.';
                Visible = false;
            }
        }
    }
}
