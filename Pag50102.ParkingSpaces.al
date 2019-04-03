
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
                    IF IsReserved then
                        Error(ReservedError);
                    IsReserved := true;
                    ParkingLotUserID := USERID;
                    MODIFY;
                end;

            }
            action(CancelReservation)
            {
                ApplicationArea = All;
                Caption = 'Cancel Reservation';
                Image = CancelLine;
                trigger OnAction()
                begin
                    if not IsReserved then
                        Error(NotReservedError);
                    if not (UserId() = ParkingLotUserID) then
                        Error(NotUserSpace);
                    IsReserved := false;
                    ParkingLotUserID := '';
                    Modify();
                end;
            }
        }
    }

    var
        myInt: Integer;
        ReservedError: TextConst ENU = 'This space is already reserved';
        NotReservedError: TextConst ENU = 'This space is not reserved';
        NotUserSpace: TextConst ENU = 'This space is not reserved for this user';
}