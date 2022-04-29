pageextension 54413 PageExtension54413 extends "Posted Sales Cr. Memo Subform"
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