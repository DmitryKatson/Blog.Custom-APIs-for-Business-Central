page 50102 "AIR AirplaneModel Entity"
{
    PageType = API;
    Caption = 'airplaneModels';
    APIPublisher = 'DmitryKatson';
    APIVersion = 'beta';
    APIGroup = 'airplanes';
    EntityName = 'airplaneModel';
    EntitySetName = 'airplaneModels';
    SourceTable = "AIR Airplane Model";
    DelayedInsert = true;
    ODataKeyFields = Id;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Id)
                {
                    Caption = 'Id';
                    ApplicationArea = All;
                }
                field(icaoCode; "ICAO Code")
                {
                    Caption = 'icaoCode';
                    ApplicationArea = All;
                }
                field(description; Description)
                {
                    Caption = 'description';
                    ApplicationArea = All;
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Insert(true);

        Modify(true);
        exit(false);
    end;

    trigger OnModifyRecord(): Boolean
    var
        AirplaneModel: Record "AIR Airplane Model";
    begin
        AirplaneModel.SETRANGE(Id, Id);
        AirplaneModel.FINDFIRST;

        IF "ICAO Code" <> AirplaneModel."ICAO Code" THEN BEGIN
            AirplaneModel.TRANSFERFIELDS(Rec, FALSE);
            AirplaneModel.RENAME("ICAO Code");
            TRANSFERFIELDS(AirplaneModel);
        END;
    end;
}
