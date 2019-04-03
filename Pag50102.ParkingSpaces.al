
page 50102 ParkingSpaces
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ParkingSpace;
    Editable = false;
    Caption = 'Parking Space List';

    layout
    {
        area(Content)
        {
            repeater(ParkingLotSpaces)
            {
                field(ParkingLotCode;
                ParkingLotCode)
                {
                    ApplicationArea = All;
                }
                field(Row; Row)
                {
                    ApplicationArea = All;
                }
                field(Column; Column)
                {
                    Caption = 'Column';
                    ApplicationArea = All;
                }
                field(SpaceType; SpaceType)
                {
                    ApplicationArea = All;
                }
                field(IsReserved; IsReserved)
                {
                    ApplicationArea = All;
                }
                field(ParkingLotUserID; ParkingLotUserID)
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
            action(Reserve)
            {
                ApplicationArea = All;
                Caption = 'Reserve Space';
                Image = Reserve;
                trigger OnAction()
                begin
                    MESSAGE('Place Holder');
                end;

            }
        }
    }

    var
        myInt: Integer;
}