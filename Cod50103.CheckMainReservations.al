codeunit 50103 CheckMainReservations
{
    trigger OnRun()
    var
        ParkingSpace: Record ParkingSpace;
        ParkingLotSetup: Record ParkingLotSetup;
    begin
        ParkingLotSetup.Get;
        with ParkingSpace do begin
            repeat begin
                if MainUserID <> '' then begin
                    if isApprovedByMainUser = false then begin
                        ReservedUntil := CreateDateTime(Today + 1, ParkingLotSetup.EndOfWorkTime);
                        IsReserved := true;
                        isApprovedByMainUser := true;
                        Modify();
                    end;
                end;
            end until next = 0;
        end;
    end;
}