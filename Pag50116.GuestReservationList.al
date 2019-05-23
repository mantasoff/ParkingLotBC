page 50116 GuestReservationList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GuestReservation;
    Caption = 'Guest Reservation List';
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
}