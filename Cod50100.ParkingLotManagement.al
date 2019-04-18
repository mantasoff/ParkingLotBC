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
        if ParkingSpace.MainUserID <> User then
            if isReservedByMainUser(ParkingSpace) then
                Error(UserIsNotAllowedToReserveMainSpot);

        if ParkingSpace.MainUserID = User then
            ParkingSpace.isApprovedByMainUser := true;

        ParkingSpace.IsReserved := true;
        ParkingSpace.ParkingLotUserID := USERID;
        ParkingSpace.ReservedUntil := GetReservationEndDate(ParkingSpace.SpaceType);
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
        ParkingSpace.ReservedUntil := 0DT;
        ParkingSpace.Modify();
    end;

    local procedure IsUserFromParkingLot(ParkingLotCode: Code[20]; User: Code[50]): Boolean
    var
        ParkingLotUsers: Record ParkingLotUsers;
    begin
        exit(ParkingLotUsers.Get(ParkingLotCode, User));
    end;

    local procedure GetReservationEndDate(SpaceTypeCode: Code[20]): DateTime
    var
        SpaceType: Record SpaceType;
        ParkingLotSetup: Record ParkingLotSetup;
        ReservationTime: Time;
        ReservationDateTime: DateTime;
        Duration: Duration;
    begin
        ParkingLotSetup.Get();
        SpaceType.Get(SpaceTypeCode);
        ReservationTime := ParkingLotSetup.ReservationStart + SpaceType.ReservationPeriod * 60000; //Minutes to Miliseconds
        ReservationDateTime := CreateDateTime(Today, ReservationTime);
        if ReservationDateTime < CurrentDateTime() then begin
            ReservationDateTime := CreateDateTime(Today + 1, ReservationTime);
        end;
        exit(ReservationDateTime);
    end;

    procedure MainUserReservation(Space: Record ParkingSpace; User: Code[50])
    begin
        if Space.MainUserID <> User then
            error(NotMainUser);
        ReserveSpace(Space, User);

    end;




    procedure isReservedByMainUser(Space: Record ParkingSpace): Boolean
    begin
        if Space.MainUserID = '' then
            exit(false);

        if Space.IsReserved = true then
            exit(true);

        if Space.isApprovedByMainUser = false then
            exit(true);
    end;

    procedure guestReservation(ParkingSpace: Record ParkingSpace; User: Code[50])
    var
        ParkingLotSetup: Record ParkingLotSetup;
    begin
        ParkingLotSetup.Get;
        if ParkingSpace.IsReserved then
            if not Confirm(AlreadyReservedByUser) then exit;
        ParkingSpace.IsReserved := true;
        ParkingSpace.ParkingLotUserID := User;
        ParkingSpace.isGuestReservation := true;
        ParkingSpace.isApprovedByMainUser := true;
        if DT2Time(CurrentDateTime) > ParkingLotSetup.EndOfWorkTime then begin
            ParkingSpace.ReservedUntil := CreateDateTime(Today, ParkingLotSetup.EndOfWorkTime);
        end else begin
            ParkingSpace.ReservedUntil := CreateDateTime(Today + 1, ParkingLotSetup.EndOfWorkTime);
        end;
        ParkingSpace.Modify();
    end;

    procedure CheckAbsenceModule(User: Code[50]): Boolean
    var
        ParkingLotSetup: Record ParkingLotSetup;
        EmployeeAbsence: Record "Employee Absence";
        Employee: Record Employee;
    begin
        ParkingLotSetup.Get();
        if ParkingLotSetup.AbsenceModuleActive then begin
            Employee.SetRange(UserID, User);
            if Employee.FindSet() then begin
                EmployeeAbsence.SetRange("Employee No.", Employee."No.");
                if EmployeeAbsence.FindSet() then begin
                    repeat
                        if (((today + 1) > EmployeeAbsence."From Date") and ((today + 1) < EmployeeAbsence."To Date")) then
                            exit(true);
                    until EmployeeAbsence.Next() = 0;
                end;
            end;
        end;
        exit(false);
    end;

    var
        myInt: Integer;
        ReservedError: TextConst ENU = 'This space is already reserved';
        NotReservedError: TextConst ENU = 'This space is not reserved';
        NotUserSpaceError: TextConst ENU = 'This space is not reserved for this user';
        UserNotParkingLotUser: TextConst ENU = 'User is not registered to use parking lot functionality';
        UserNotInGroupError: TextConst ENU = 'User is not from this space group';
        UserIsNotAllowedError: TextConst ENU = 'User is not allowed to park in this specific parking lot';

        UserIsNotAllowedToReserveMainSpot: TextConst ENU = 'Main user has not yet cleared the spot for parking';
        NotMainUser: TextConst ENU = 'You are not the Main user of this specific parking spot';
        AlreadyReservedByUser: TextConst ENU = 'This space is already reserved. Do you want to overwrite this reservation for the guest?';
}