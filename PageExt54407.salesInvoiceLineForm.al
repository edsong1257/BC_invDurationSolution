pageextension 54407 PageExtension54407 extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Qty. to Assign")
        {
            field("Invoice Start Date"; Rec."Invoice Start Date")
            {
                ApplicationArea = All;
                ToolTip = 'The start date of Invoice Duration.';
            }
            field("Invoice End Date"; Rec."Invoice End Date")
            {
                ApplicationArea = All;
                ToolTip = 'The end date of Invoice Duration.';
            }
        }
    }
}