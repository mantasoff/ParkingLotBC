page 50101 ParkingLotQues
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Parking Lot Ques';

    layout
    {
        area(Content)
        {
            cuegroup(ParkingSpaces)
            {
                field(NotReserved; NotReservedParkingSpaces)
                {
                    Caption = 'Not Reserved Spaces';
                }
                field(ReservedParkingSpaces; ReservedParkingSpaces)
                {
                    Caption = 'Reserved Spaces';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        NotReservedParkingSpaces: Integer;
        ReservedParkingSpaces: Boolean;

    trigger OnOpenPage()
    begin
        //Reikia apskaiciavimo formules visam sitam dalykui.
    end;
}