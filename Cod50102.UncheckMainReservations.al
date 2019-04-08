codeunit 50102 UncheckAndUndoAllReservations
{
    trigger OnRun()
    var
        ParkingSpaces: Record ParkingSpace;
    begin
        with ParkingSpaces do begin
            if FindSet() then begin
                repeat begin
                    IsReserved := false;
                    ReservedUntil := 0DT;
                    isApprovedByMainUser := false;
                end until next = 0;
            end;
        end;
    end;

    var
        myInt: Integer;
}