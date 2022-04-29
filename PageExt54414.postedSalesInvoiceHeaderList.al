pageextension 54414 postedSalesInvoiceHeaderList extends "Posted Sales Invoices"
{
    layout
    {
        addbefore(Amount)
        {
            field("Has Invoice Duration Item"; Rec."Has Invoice Duration Item")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'If any item in the posted sales invoice require inovice duration';
            }
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
