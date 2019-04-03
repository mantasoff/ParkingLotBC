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

        if not IsUserParkingLotUser(User) then
            error(UserNotParkingLotUser);
        if not IsUserFromParkingLot(ParkingSpace.ParkingLotCode, User) then
            Error(UserIsNotAllowedError);
        if not IsUserFromGroup(ParkingSpace.SpaceType, User) then
            Error(UserNotInGroupError);
        IF ParkingSpace.IsReserved then
            Error(ReservedError);

        ParkingSpace.IsReserved := true;
        ParkingSpace.ParkingLotUserID := USERID;

        ParkingSpace.MODIFY;
    end;

    procedure CancelReservation(ParkingSpace: Record ParkingSpace; User: Code[50])
    begin
        if not ParkingSpace.IsReserved then
            Error(NotReservedError);
        if not (User = ParkingSpace.ParkingLotUserID) then
            Error(NotUserSpaceError);

        ParkingSpace.IsReserved := false;
        ParkingSpace.ParkingLotUserID := '';

        ParkingSpace.Modify();
    end;

    local procedure IsUserFromParkingLot(ParkingLotCode: Code[20]; User: Code[50]): Boolean
    var
        ParkingLotUsers: Record ParkingLotUsers;
    begin
        exit(ParkingLotUsers.Get(ParkingLotCode, User));
    end;

    var
        myInt: Integer;
        ReservedError: TextConst ENU = 'This space is already reserved';
        NotReservedError: TextConst ENU = 'This space is not reserved';
        NotUserSpaceError: TextConst ENU = 'This space is not reserved for this user';
        UserNotParkingLotUser: TextConst ENU = 'User is not registered to use parking lot functionality';
        UserNotInGroupError: TextConst ENU = 'User is not from this space group';
        UserIsNotAllowedError: TextConst ENU = 'User is not allowed to park in this specific parking lot';
}