page 50108 ParkingLotSetup
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ParkingLotSetup;
    Caption = 'Parking Lot Setup';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(ReservationStart; ReservationStart)
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