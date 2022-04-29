pageextension 54410 PageExtension54410 extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Invoice Details")
        {
            group("Invoice Duration")
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
                field("Invoice Period"; Rec."Invoice Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'The duration between invoice start date and invoice end date.';
                }
                field("Invoice Period Unit"; Rec."Invoice Period Unit")
                {
                    ApplicationArea = All;
                    ToolTip = 'The unit of invoice perid. You can self define invoice end date by selecting OTHER.';
                }
                field("Has Invoice Duration Item"; Rec."Has Invoice Duration Item")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}