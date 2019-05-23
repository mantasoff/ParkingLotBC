codeunit 50103 CheckMainReservations
{
    trigger OnRun()
    var
        ParkingSpace: Record ParkingSpace;
        ParkingLotSetup: Record ParkingLotSetup;
    begin
        ParkingLotSetup.Get;
        if ParkingLotSetup.FirstStepReservationTime = DT2Time(CurrentDateTime) then begin

            with ParkingSpace do begin
                repeat begin
                    if PrivateUserID <> '' then begin
                        if isApprovedByPrivateUser = false then begin
                            ReservedUntil := CreateDateTime(Today + 1, ParkingLotSetup.EndOfWorkTime);
                            IsReserved := true;
                            isApprovedByPrivateUser := true;
                            Modify();
                        end;
                    end;
                end until next = 0;
            end;
        end;

    end;
}