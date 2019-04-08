codeunit 50103 CheckMainReservations
{
    trigger OnRun()
    var
        ParkingSpace: Record ParkingSpace;
    begin
        with ParkingSpace do begin
            repeat begin
                isApprovedByMainUser := true;
                Modify();
            end until next = 0;
        end;
    end;

}