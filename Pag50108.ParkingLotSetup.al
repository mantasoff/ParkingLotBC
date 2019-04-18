page 50108 ParkingLotSetup
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ParkingLotSetup;
    Caption = 'Parking Lot Setup';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group("Setup Information")
            {
                field(ReservationStart; ReservationStart)
                {
                    ApplicationArea = All;

                }
                field(MainParkingLotReservationLimit; MainParkingLotReservationLimit)
                {
                    ApplicationArea = All;
                }
                field(EndOfWorkTime; EndOfWorkTime)
                {
                    ApplicationArea = All;
                }
                field(EnableGuestFunctionality; EnableGuestFunctionality)
                {
                    ApplicationArea = All;
                }
                field(AbsenceModuleActive; AbsenceModuleActive)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        If Not Get then Insert;

    end;
}