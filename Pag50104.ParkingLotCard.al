page 50104 ParkingLotCard
{
    PageType = Document;
    SourceTable = ParkingLot;
    Caption = 'Parking Lot Card';
    layout
    {
        area(Content)
        {
            group(ParkingLot)
            {
                Caption = 'Main information';
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
            part(ParkingLotsSubform; ParkingLotsSubform)
            {
                Caption = 'Spaces';
                ApplicationArea = All;
                SubPageLink = ParkingLotCode = field (Code);
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
        myInt: Integer;
}