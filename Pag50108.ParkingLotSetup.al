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
                    Width = 8;
                }
                field(MainParkingLotReservationLimit; MainParkingLotReservationLimit)
                {
                    ApplicationArea = All;
                    Caption = 'Private Spot Res. Time';
                }
                field(EndOfWorkTime; EndOfWorkTime)
                {
                    ApplicationArea = All;
                }
                field(FirstStepReservationTime; FirstStepReservationTime)
                {
                    ApplicationArea = All;
                    Caption = 'First Step Res. Time';
                }
                field(EnableGuestFunctionality; EnableGuestFunctionality)
                {
                    ApplicationArea = All;
                }
                field(AbsenceModuleActive; AbsenceModuleActive)
                {
                    ApplicationArea = All;
                }
                field(EnableTwoStepReservation; EnableTwoStepReservation)
                {
                    ApplicationArea = All;

                }

            }
        }
    }

    var
        FirstStepReservationTimeVisible: Boolean;

    trigger OnOpenPage()
    begin
        If Not Get then Insert;
    end;
}