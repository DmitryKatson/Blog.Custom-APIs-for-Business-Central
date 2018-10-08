codeunit 50104 "CallExternalWebService"
{
    procedure GetAirplanes();
    var
        uri: Text;
        ResponseInReadibleFormat: Text;
    begin
        uri := 'https://bridge.buddyweb.fr/api/icaoaircrafts/aircrafticaocodes';

        CallExternalWebService(uri, ResponseInReadibleFormat);
        SaveResultInAirplaneModelTable(ResponseInReadibleFormat);
    end;

    local procedure CallExternalWebService(uri: Text; var ResponseInReadibleFormat: Text)
    var
        RequestMessage: HttpRequestMessage;
        HttpClient: HttpClient;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
    begin
        //Constract Http Api
        RequestMessage.Method := 'GET';
        RequestMessage.SetRequestUri(uri);

        //Send Http Request
        HttpClient.Send(RequestMessage, ResponseMessage);

        //Receive Response
        Content := ResponseMessage.Content;
        Content.ReadAs(ResponseInReadibleFormat);
    end;

    local procedure SaveResultInAirplaneModelTable(var ResponseInReadableFormat: Text)
    var
        AirplaneModel: Record "AIR Airplane Model";
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        JsonValue: JsonValue;
        i: Integer;
    begin

        AirplaneModel.DeleteAll;

        If not JsonArray.ReadFrom(ResponseInReadableFormat) then
            error('Invalid response, expected an JSON array as root object');

        For i := 0 to JsonArray.Count - 1 do begin
            JsonArray.Get(i, JsonToken);
            JsonObject := JsonToken.AsObject;

            WITH AirplaneModel do begin
                INIT;

                //Get Airport Code
                JsonObject.Get('code', JsonToken);
                JsonValue := JsonToken.AsValue;
                "ICAO Code" := JsonValue.AsCode();

                //Get Airport Name 
                JsonObject.Get('aircraft_type', JsonToken);
                JsonValue := JsonToken.AsValue;
                Description := JsonValue.AsText();

                //Get Popularity 
                JsonObject.Get('popularity_percent', JsonToken);
                JsonValue := JsonToken.AsValue;
                Popularity := JsonValue.AsDecimal();

                INSERT(true);
            end;
        end;

    end;

}
