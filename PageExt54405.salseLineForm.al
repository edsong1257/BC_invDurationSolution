pageextension 54405 PageExtension54405 extends "Sales Order Subform"
{
    layout
    {
        addafter("Shipment Date")
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