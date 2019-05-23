page 50115 GuestReservationCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = GuestReservation;
    Caption = 'Guest Reservation Card';
    layout
    {
        area(Content)
        {
            group(SpaceInformation)
            {
                Caption = 'Parking Space Information';
                field(ParkingLotCode; ParkingLotCode)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Row; Row)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Collumn; Collumn)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(ReservationInformation)
            {
                field(ReservationConfirmed; ReservationConfirmed)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ParkingLotUser; ParkingLotUser)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(FromDateTime; FromDateTime)
                {
                    ApplicationArea = All;
                }
                field(ToDateTime; ToDateTime)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ConfirmReservation)
            {
                ApplicationArea = All;
                Caption = 'Confirm Reservation';
                Image = Confirm;
                trigger OnAction()
                var
                    GuestReservation: Record GuestReservation;
                begin
                    if DT2Date(FromDateTime) <> DT2Date(ToDateTime) then
                        Error(DifferentDayError);
                    GuestReservation.SetRange(ParkingLotCode, ParkingLotCode);
                    GuestReservation.SetRange(Collumn, Collumn);
                    GuestReservation.SetRange(Row, Row);

                    GuestReservation.FindSet();
                    repeat
                        if DT2Date(FromDateTime) = DT2Date(GuestReservation.FromDateTime) then begin
                            if GuestReservation.EntryNo <> EntryNo then
                                Error(SameDayTwoReservationError);
                        end;
                    until GuestReservation.Next = 0;


                    if Confirm(ConfirmMessage) then
                        ReservationConfirmed := true;
                end;
            }
        }
    }

    var
        ConfirmMessage: TextConst ENU = 'Do you want to confirm the reservation?';
        DifferentDayError: TextConst ENU = 'You can only reserve a space for the same day';

        SameDayTwoReservationError: TextConst ENU = 'One space can only be guest reserved for one time in one day';

    trigger OnClosePage()
    begin
        if not ReservationConfirmed then Delete;
    end;
}