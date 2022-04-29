pageextension 54411 PageExtension54411 extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Line Amount")
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