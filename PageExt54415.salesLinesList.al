pageextension 54415 salesLinesList extends "Sales Lines"
{
    layout
    {
        addafter("Location Code")
        {
            field("Invoice Start Date"; Rec."Invoice Start Date")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'The start date of Invoice Duration.';
            }
            field("Invoice End Date"; Rec."Invoice End Date")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'The end date of Invoice Duration.';
            }
        }
    }
}
