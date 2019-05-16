page 50111 MainParkingUserSpots
{
    Caption = 'Private Parking User Spots';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ParkingSpace;

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
                field(PrivateUserID; PrivateUserID)
                {
                    ApplicationArea = All;
                }
                field(isApprovedByPrivateUser; isApprovedByPrivateUser)
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
    trigger OnOpenPage()
    begin
        SetRange(PrivateUserID, UserId);
        //if Count = 0 then
        //    error(NoParkingSpaceRegisteredError);
    end;

    var
        NoParkingSpaceRegisteredError: TextConst ENU = 'No Parking Space Available for user';
        ParkingLotManagement: Codeunit ParkingLotManagement;
}