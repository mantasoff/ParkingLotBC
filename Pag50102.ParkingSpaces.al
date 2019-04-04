
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
                field(ReservedUntil; ReservedUntil)
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
                    ParkingLotManagement.ReserveSpace(Rec, UserId());
                end;

            }
            action(CancelReservation)
            {
                ApplicationArea = All;
                Caption = 'Cancel Reservation';
                Image = CancelLine;
                trigger OnAction()
                begin
                    ParkingLotManagement.CancelReservation(Rec, UserId());
                end;
            }
        }
    }

    var
        myInt: Integer;
        ParkingLotManagement: Codeunit ParkingLotManagement;
}