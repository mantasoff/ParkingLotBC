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
                    IsReserved := true;
                    ReservedUntil := 0DT;
                    isGuestReservation := false;
                    if PrivateUserID <> '' then begin
                        if not ParkingLotManagement.CheckAbsenceModule(ParkingSpaces.PrivateUserID) then begin
                            isApprovedByPrivateUser := false;
                            ParkingLotUserID := PrivateUserID;
                        end else
                            isApprovedByPrivateUser := true;
                    end;
                end until next = 0;
            end;
        end;
    end;

    var
        myInt: Integer;
}