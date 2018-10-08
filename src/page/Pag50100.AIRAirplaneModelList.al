page 50100 "AIR Airplane Model List"
{

    PageType = List;
    SourceTable = "AIR Airplane Model";
    Caption = 'AIR Airplane Model List';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ICAO Code"; "ICAO Code")
                {
                    ApplicationArea = All;
                }
                field("Description"; "Description")
                {
                    ApplicationArea = All;
                }
                field("Popularity"; "Popularity")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Update)
            {
                ApplicationArea = All;
                Image = UpdateXML;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Update();
                end;
            }
        }
    }

}
