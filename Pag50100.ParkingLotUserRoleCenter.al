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
            part(ParkingLotHeadline; ParkingLotHeadline)
            {
                ApplicationArea = All;
            }
            part(ParkingLotQues; ParkingLotQues)
            {
                ApplicationArea = All;
            }
            part(ReservedParkingSpaces; ReservedParkingSpacesPagePart)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ParkingLotSetup)
            {
                Caption = 'Parking Lot Setup';
                ApplicationArea = All;
                RunPageMode = Edit;
                RunObject = Page ParkingLotSetup;
            }
            action(ParkingLotUsers)
            {
                ApplicationArea = All;
                Caption = 'Parking Lot Users';
                RunPageMode = View;
                RunObject = Page ParkingLotUsers;
            }
            action(ParkingLotApplicationUsers)
            {
                ApplicationArea = All;
                Caption = 'Parking Lot Application Users';
                RunPageMode = View;
                RunObject = Page ParkingLotAppUsers;
            }
            action(ParkingLots)
            {
                ApplicationArea = All;
                Caption = 'Parking Lots';
                RunPageMode = View;
                RunObject = Page ParkingLots;
            }
            action(SpaceTypes)
            {
                ApplicationArea = All;
                Caption = 'Space Types';
                RunPageMode = View;
                RunObject = Page SpaceTypes;
            }
            action(UserAllowedSpaceTypes)
            {
                ApplicationArea = All;
                Caption = 'User Allowed Space Types';
                RunPageMode = View;
                RunObject = Page UserAllowedSpaceTypes;
            }
        }
    }

    var
        myInt: Integer;

}