codeunit 50104 HandleGuestReservation
{
    trigger OnRun()
    var
        GuestReservation: Record GuestReservation;
        ParkingSpace: Record ParkingSpace;
    begin
        if GuestReservation.findset then begin
            repeat begin
                if (CurrentDateTime >= GuestReservation.FromDateTime) and (CurrentDateTime <= GuestReservation.ToDateTime) then begin
                    if ParkingSpace.Get(GuestReservation.ParkingLotCode, GuestReservation.Row, GuestReservation.Collumn) then begin
                        ParkingSpace.IsReserved := True;
                        ParkingSpace.isGuestReservation := true;
                        ParkingSpace.ParkingLotUserID := GuestReservation.ParkingLotUser;
                        ParkingSpace.ReservedUntil := GuestReservation.ToDateTime;
                        ParkingSpace.Modify();
                    end;
                end;
            end until GuestReservation.Next = 0;
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