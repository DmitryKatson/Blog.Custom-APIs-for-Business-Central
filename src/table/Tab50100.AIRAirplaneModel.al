table 50100 "AIR Airplane Model"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ICAO Code"; Code[20])
        {
            Caption = 'ICAO Code';
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(11; Popularity; Decimal)
        {

        }
        field(20; Id; Guid)
        {

        }
    }

    keys
    {
        key(PK; "ICAO Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Id := CreateGuid();
    end;

    procedure Update()
    var
        CallWebservice: Codeunit CallExternalWebService;
    begin
        CallWebservice.GetAirplanes();
    end;


}