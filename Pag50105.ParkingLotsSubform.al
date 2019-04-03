page 50105 ParkingLotsSubform
{
    PageType = ListPart;
    SourceTable = ParkingSpace;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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