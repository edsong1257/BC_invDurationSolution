pageextension 54412 salesHeaderList extends "Sales Order List"
{
    layout
    {
        addafter(Status)
        {
            field("Has Invoice Duration Item"; Rec."Has Invoice Duration Item")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'If any item in the sales order require inovice duration';
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
