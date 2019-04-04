codeunit 50101 StopReservations
{
    trigger OnRun()
    var
        ParkingSpaces: Record ParkingSpace;
    begin
        ParkingSpaces.SetRange(IsReserved, true);

        if ParkingSpaces.FindSet() then begin
            repeat
                if ParkingSpaces.ReservedUntil < CurrentDateTime() then begin
                    ParkingSpaces.IsReserved := false;
                    ParkingSpaces.ReservedUntil := 0DT;
                    ParkingSpaces.ParkingLotUserID := '';
                    ParkingSpaces.Modify();
                end;
            until ParkingSpaces.Next() = 0;
        end;
    end;

}