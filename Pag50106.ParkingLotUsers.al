page 50106 ParkingLotUsers
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ParkingLotUsers;
    Caption = 'Parking Lot Users';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ParkingLotCode; ParkingLotCode)
                {
                    ApplicationArea = All;

                }
                field(ParkingLotUserID; ParkingLotUserID)
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}