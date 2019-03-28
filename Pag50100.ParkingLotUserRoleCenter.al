page 50100 ParkingLotUserRoleCenter
{
    Caption = 'Parking Lot User Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
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

            }
        }
    }

    var
        myInt: Integer;

}