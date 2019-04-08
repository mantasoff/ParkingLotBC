page 50109 UserAllowedSpaceTypes
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = UserAllowedSpaceTypes;
    Caption = 'User Allowed Parking Space Types';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ParkingLotUserID; ParkingLotUserID)
                {
                    ApplicationArea = All;

                }
                field(SpaceType; SpaceType)
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