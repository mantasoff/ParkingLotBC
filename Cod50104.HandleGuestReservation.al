codeunit 50104 HandleGuestReservation
{
    trigger OnRun()
    var
        Reservation: Record GuestReservation;
        ParkingSpace: Record ParkingSpace;
    begin
        if Reservation.findset then begin
            repeat begin
                if (CurrentDateTime >= Reservation.FromDateTime) and (CurrentDateTime <= Reservation.ToDateTime) then begin
                    if ParkingSpace.Get(Reservation.ParkingLotCode, Reservation.Row, Reservation.Collumn) then begin
                        ParkingSpace.IsReserved := True;
                        ParkingSpace.isGuestReservation := true;
                        ParkingSpace.ParkingLotUserID := Reservation.ParkingLotUser;
                        ParkingSpace.ReservedUntil := Reservation.ToDateTime;
                        ParkingSpace.Modify();
                    end;
                end;
            end until Reservation.Next = 0;
        end;

        ParkingSpace.Reset();
        Clear(ParkingSpace);

        ParkingSpace.SetRange(isGuestReservation, true);
        if ParkingSpace.findset then begin
            repeat
                if CurrentDateTime > ParkingSpace.ReservedUntil then begin
                    ParkingSpace.ReservedUntil := 0DT;
                    ParkingSpace.ParkingLotUserID := '';
                    ParkingSpace.IsReserved := false;
                    ParkingSpace.isGuestReservation := false;
                    ParkingSpace.Modify();
                end;
            until ParkingSpace.Next = 0;
        end;
    end;

    var
        myInt: Integer;
}