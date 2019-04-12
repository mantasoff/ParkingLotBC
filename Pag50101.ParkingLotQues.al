page 50101 ParkingLotQues
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Parking Lot Reservation Information';

    layout
    {
        area(Content)
        {

            cuegroup(ParkingSpaces)
            {
                Caption = 'Reservations';

                field(NotReserved; NotReservedParkingSpaces)
                {
                    ApplicationArea = All;
                    Caption = 'Not Reserved Spaces';
                    trigger OnDrillDown()
                    var
                        ParkingSpace: Record ParkingSpace;
                    begin
                        ParkingSpace.SetRange(IsReserved, False);
                        Page.RunModal(Page::ParkingSpaces, ParkingSpace);
                    end;
                }
                field(ReservedParkingSpaces; ReservedParkingSpaces)
                {
                    ApplicationArea = All;
                    Caption = 'Reserved Spaces';
                    trigger OnDrillDown()
                    var
                        ParkingSpace: Record ParkingSpace;
                    begin
                        ParkingSpace.SetRange(IsReserved, true);
                        Page.RunModal(Page::ParkingSpaces, ParkingSpace);
                    end;
                }
                field(ChangeLogEntries; ChangeLogEntries)
                {
                    ApplicationArea = All;
                    Caption = 'Changes Today';
                    trigger OnDrillDown()
                    begin
                        Page.RunModal(Page::ParkingLotChanges);
                    end;
                }


            }

        }
    }

    var
        NotReservedParkingSpaces: Integer;
        ReservedParkingSpaces: Integer;
        ChangeLogEntries: Integer;

    trigger OnOpenPage()
    var
        ParkingSpace: Record ParkingSpace;
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        ParkingSpace.SetRange(IsReserved, false);
        NotReservedParkingSpaces := ParkingSpace.Count;
        ParkingSpace.Reset();
        ParkingSpace.SetRange(IsReserved, true);
        ReservedParkingSpaces := ParkingSpace.Count;



    end;


}