codeunit 50102 UncheckAndUndoAllReservations
{
    trigger OnRun()
    var
        ParkingSpaces: Record ParkingSpace;
        ParkingLotManagement: Codeunit ParkingLotManagement;
        ParkingLotSetup: Record ParkingLotSetup;
    begin
        ParkingLotSetup.Get;
        if (ParkingLotSetup.MainParkingLotReservationLimit = DT2Time(CurrentDateTime)) then begin
            with ParkingSpaces do begin
                if FindSet() then begin
                    repeat begin
                        IsReserved := false;
                        ReservedUntil := 0DT;
                        isGuestReservation := false;
                        if PrivateUserID <> '' then begin
                            if not ParkingLotManagement.CheckAbsenceModule(ParkingSpaces.PrivateUserID) then begin
                                IsReserved := true;
                                isApprovedByPrivateUser := false;
                                ParkingLotUserID := PrivateUserID;
                            end else begin
                                IsReserved := false;
                                isApprovedByPrivateUser := true;
                            end;

                        end;
                        Modify();
                    end until next = 0;
                end;
            end;
        end;

    end;

    var
        myInt: Integer;
}