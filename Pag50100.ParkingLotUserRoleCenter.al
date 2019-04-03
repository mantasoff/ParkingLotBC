page 50100 ParkingLotUserRoleCenter
{
    Caption = 'Parking Lot User Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(RoleCenter)
        {
            part(ParkingLotQues; ParkingLotQues)
            {
                ApplicationArea = All;
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

            }
        }
    }

    var
        myInt: Integer;

}