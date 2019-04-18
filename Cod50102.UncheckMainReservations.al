codeunit 50102 UncheckAndUndoAllReservations
{
    trigger OnRun()
    var
        ParkingSpaces: Record ParkingSpace;
        ParkingLotManagement: Codeunit ParkingLotManagement;
    begin
        with ParkingSpaces do begin
            if FindSet() then begin
                repeat begin
                    IsReserved := false;
                    ReservedUntil := 0DT;
                    if MainUserID <> '' then begin
                        if not ParkingLotManagement.CheckAbsenceModule(ParkingSpaces.MainUserID) then
                            isApprovedByMainUser := false
                        else
                            isApprovedByMainUser := true;
                    end;
                end until next = 0;
            end;
        end;
    end;

    var
        myInt: Integer;
}