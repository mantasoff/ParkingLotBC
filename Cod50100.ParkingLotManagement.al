codeunit 50100 ParkingLotManagement
{
    Description = 'Contains functions associated with reservations';
    trigger OnRun()
    begin

    end;

    local procedure IsUserFromGroup(ParkingGroup: Code[20]; User: Code[50]): Boolean
    var
        UserAllowedSpaceTypes: Record UserAllowedSpaceTypes;
    begin
        exit(UserAllowedSpaceTypes.GET(User, ParkingGroup));
    end;

    local procedure IsUserParkingLotUser(User: Code[50]): Boolean
    var
        ParkingLotUser: Record ParkingLotUser;
    begin
        exit(ParkingLotUser.GET(User));
    end;

    procedure ReserveSpace(ParkingSpace: Record ParkingSpace; User: Code[50])
    begin

        IsUserParkingLotUser(User);
        IsUserFromGroup(ParkingSpace.SpaceType, User);
    end;

    local procedure IsUserFromParkingLot(ParkingLotCode: Code[20]; User: Code[50]): Boolean
    var
        ParkingLotUsers: Record ParkingLotUsers;
    begin
        exit(ParkingLotUsers.Get(ParkingLotCode, User));
    end;

    var
        myInt: Integer;
}