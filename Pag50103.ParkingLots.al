page 50103 ParkingLots
{
    UsageCategory = Administration;
    PageType = List;
    ApplicationArea = All;
    SourceTable = ParkingLot;
    Editable = false;
    CardPageId = ParkingLotCard;
    Caption = 'Parking Lots';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Adress; Adress)
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