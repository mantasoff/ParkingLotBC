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


    procedure ReserveSpace2(ParkingSpace: Record ParkingSpace; User: Code[50])
    var
        ParkingLotSetup: Record ParkingLotSetup;
        ParkingLotChanges: Record ParkingLotChanges;
        ParkingLotUser: Record ParkingLotUser;
        Reservation: Record GuestReservation;
    begin
        if not IsUserParkingLotUser(User) then
            error(UserNotParkingLotUser);
        if not IsUserFromParkingLot(ParkingSpace.ParkingLotCode, User) then
            Error(UserIsNotAllowedError);
        if not IsUserFromGroup(ParkingSpace.SpaceType, User) then
            Error(UserNotInGroupError);
        if ParkingSpace.PrivateUserID <> User then
            if isReservedByMainUser(ParkingSpace) then
                Error(UserIsNotAllowedToReserveMainSpot);
        ParkingLotSetup.Get();
        ParkingLotUser.Get(User);
        if ParkingLotSetup.EnableTwoStepReservation AND (User <> ParkingSpace.PrivateUserID) then begin
            if DT2Time(CurrentDateTime) >= ParkingLotSetup.MainParkingLotReservationLimit then begin
                if DT2Time(CurrentDateTime) <= ParkingLotSetup.FirstStepReservationTime then begin
                    if ParkingLotUser.ParkingReservationPriority = ParkingLotUser.ParkingReservationPriority::Low then
                        error('User has low priority reservation rights. Allowed to reserve space after: ' + Format(ParkingLotSetup.FirstStepReservationTime));
                end;
            end;
        end;

        if ParkingLotSetup.AbsenceModuleActive then begin
            if CheckAbsenceModule(User) then begin
                Error('The User is currently absent!')
            end;
        end;


    end;

    procedure ReserveSpace(ParkingSpace: Record ParkingSpace; User: Code[50])
    var
        ParkingLotSetup: Record ParkingLotSetup;
        ParkingLotChanges: Record ParkingLotChanges;
        ParkingLotUser: Record ParkingLotUser;
        Reservation: Record GuestReservation;
    begin

        if not IsUserParkingLotUser(User) then
            error(UserNotParkingLotUser);
        if not IsUserFromParkingLot(ParkingSpace.ParkingLotCode, User) then
            Error(UserIsNotAllowedError);
        if not IsUserFromGroup(ParkingSpace.SpaceType, User) then
            Error(UserNotInGroupError);
        if ParkingSpace.PrivateUserID <> User then
            if isReservedByMainUser(ParkingSpace) then
                Error(UserIsNotAllowedToReserveMainSpot);
        ParkingLotSetup.Get();
        ParkingLotUser.Get(User);
        if ParkingLotSetup.EnableTwoStepReservation AND (User <> ParkingSpace.PrivateUserID) then begin
            if DT2Time(CurrentDateTime) >= ParkingLotSetup.MainParkingLotReservationLimit then begin
                if DT2Time(CurrentDateTime) <= ParkingLotSetup.FirstStepReservationTime then begin
                    if ParkingLotUser.ParkingReservationPriority = ParkingLotUser.ParkingReservationPriority::Low then
                        error('User has low priority reservation rights. Allowed to reserve space after: ' + Format(ParkingLotSetup.FirstStepReservationTime));
                end;
            end;
        end;

        if ParkingLotSetup.AbsenceModuleActive then begin
            if CheckAbsenceModule(User) then begin
                Error('The User is currently absent!')
            end;
        end;

        if ParkingSpace.PrivateUserID = User then
            ParkingSpace.isApprovedByPrivateUser := true;

        ParkingSpace.IsReserved := true;
        ParkingSpace.ParkingLotUserID := USERID;
        ParkingSpace.ReservedUntil := GetReservationEndDate(ParkingSpace.SpaceType);

        Reservation.SetRange(ParkingLotCode, ParkingSpace.ParkingLotCode);
        Reservation.SetRange(Row, ParkingSpace.Row);
        Reservation.SetRange(Collumn, ParkingSpace.Column);
        if Reservation.FindSet() then begin
            repeat
                if DT2Date(Reservation.FromDateTime) = DT2Date(ParkingSpace.ReservedUntil) then begin
                    if Reservation.FromDateTime < ParkingSpace.ReservedUntil then begin
                        if Confirm(StrSubstNo(GuestReservationTimeChange, ParkingSpace.ReservedUntil, Reservation.FromDateTime)) then begin
                            ParkingSpace.ReservedUntil := Reservation.FromDateTime;
                        end else begin
                            Error('');
                        end;
                    end;
                end;
            until Reservation.Next = 0;
        end;

        Reservation.Reset();
        Clear(Reservation);

        Reservation.ParkingLotCode := ParkingSpace.ParkingLotCode;
        Reservation.Collumn := ParkingSpace.Column;
        Reservation.Row := ParkingSpace.Row;
        Reservation.FromDateTime := CreateDateTime(DT2Date(ParkingSpace.ReservedUntil), ParkingLotSetup.ReservationStart);
        Reservation.ReservationConfirmed := true;
        Reservation.ToDateTime := ParkingSpace.ReservedUntil;
        Reservation.ParkingLotUser := User;
        Reservation.Insert(true);

        ParkingSpace.MODIFY;
        Message('Reservation active until ' + Format(ParkingSpace.ReservedUntil));
        ParkingLotChanges.AddEntry(ParkingSpace.ParkingLotCode, ParkingSpace.Row, ParkingSpace.Column, UserId, 'Space Reserved', '');
    end;

    procedure CancelReservation(ParkingSpace: Record ParkingSpace; User: Code[50])
    var
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        if not ParkingSpace.IsReserved then
            Error(NotReservedError);
        if not (User = ParkingSpace.ParkingLotUserID) then
            Error(NotUserSpaceError);

        ParkingSpace.IsReserved := false;
        ParkingSpace.ParkingLotUserID := '';
        ParkingSpace.ReservedUntil := 0DT;
        ParkingSpace.isGuestReservation := False;
        ParkingSpace.Modify();
        Message('The reservation has been cancelled' + Format(ParkingSpace.ReservedUntil));
        ParkingLotChanges.AddEntry(ParkingSpace.ParkingLotCode, ParkingSpace.Row, ParkingSpace.Column, UserId, 'Reservation Canceled', '');
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
        if Space.PrivateUserID <> User then
            error(NotMainUser);
        ReserveSpace(Space, User);

    end;




    procedure isReservedByMainUser(Space: Record ParkingSpace): Boolean
    begin
        if Space.PrivateUserID = '' then
            exit(false);

        if Space.IsReserved = true then
            exit(true);

        if Space.isApprovedByPrivateUser = false then
            exit(true);
    end;

    procedure guestReservation(ParkingSpace: Record ParkingSpace; User: Code[50])
    var
        ParkingLotSetup: Record ParkingLotSetup;
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        ParkingLotSetup.Get;
        if ParkingSpace.IsReserved then
            if not Confirm(AlreadyReservedByUser) then exit;
        ParkingSpace.IsReserved := true;
        ParkingSpace.ParkingLotUserID := User;
        ParkingSpace.isGuestReservation := true;
        ParkingSpace.isApprovedByPrivateUser := true;
        if DT2Time(CurrentDateTime) < ParkingLotSetup.EndOfWorkTime then begin
            ParkingSpace.ReservedUntil := CreateDateTime(Today, ParkingLotSetup.EndOfWorkTime);
        end else begin
            ParkingSpace.ReservedUntil := CreateDateTime(Today + 1, ParkingLotSetup.EndOfWorkTime);
        end;
        ParkingSpace.Modify();

        Message('Guest Reservation active until ' + Format(ParkingSpace.ReservedUntil));

        ParkingLotChanges.AddEntry(ParkingSpace.ParkingLotCode, ParkingSpace.Row, ParkingSpace.Column, UserId, 'Guest Reservation Enabled', '');
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

    procedure CheckReservationPriority(User: Code[50])
    var
        ParkingLotSetup: Record ParkingLotSetup;
        ParkingLotUser: Record ParkingLotUser;
        PresentTime: Time;
    begin
        ParkingLotSetup.Get;
        ParkingLotUser.Get(User);
        PresentTime := Time;

        if (PresentTime > ParkingLotSetup.EndOfWorkTime) and
        (PresentTime < ParkingLotSetup.FirstStepReservationTime) and
        (ParkingLotUser.ParkingReservationPriority = ParkingLotUser.ParkingReservationPriority::Low) then begin
            Error(NotHighPriorityError);
        end;
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
        NotHighPriorityError: TextConst ENU = 'Your reservation priority is not high. You may need to wait up to an hour to be allowed to reserve a parking space';

        GuestReservationTimeChange: TextConst ENU = 'You are not able to reserve until %1 due to the fact that there is a guest reservation. Is a reservation until %2 enough?';
}