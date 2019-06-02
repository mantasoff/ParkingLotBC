table 50105 ParkingSpace
{
    Caption = 'Parking Space';


    fields
    {
        field(1; ParkingLotCode; Code[20])
        {
            Caption = 'Parking Lot Code';
            TableRelation = ParkingLot;
        }
        field(2; Row; Integer)
        {
            Caption = 'Row';
            MinValue = 1;
        }
        field(3; Column; Integer)
        {
            Caption = 'Column';
            MinValue = 1;
        }
        field(21; SpaceType; Code[20])
        {
            Caption = 'Space Type';
            TableRelation = SpaceType;
        }

        field(30; ParkingLotUserID; Code[50])
        {
            Caption = 'Parking Lot User ID';
            TableRelation = ParkingLotUser;
        }
        field(40; IsReserved; Boolean)
        {
            Caption = 'Is Reserved';

            trigger OnValidate();
            var
                tempTime: Time;
            begin
                if IsReserved = false then
                    ReservedUntil := CreateDateTime(0D, tempTime);
            end;
        }

        field(45; ReservationType; Option)
        {
            Caption = 'Reservation Types';
            OptionMembers = "Individual","Monthly","Both";
        }
        field(50; ReservedUntil; DateTime)
        {
            Caption = 'Reserved Until';

            trigger OnValidate();
            begin
                if DT2Date(ReservedUntil) < Today() then
                    Error(BeforeTodayError);

            end;
        }
        field(60; PrivateUserID; Code[50])
        {
            Caption = 'Private UserID';
            TableRelation = "User Setup";
            trigger OnValidate()
            var
                ParkingLotSetup: Record ParkingLotSetup;
            begin
                if PrivateUserID <> '' then
                    IsReserved := true;
                ParkingLotUserID := PrivateUserID;
                ParkingLotSetup.Get;
                ReservedUntil := CreateDateTime(DT2Date(CurrentDateTime), ParkingLotSetup.EndOfWorkTime);
                if ReservedUntil < CurrentDateTime then begin
                    ReservedUntil := CreateDateTime(DT2Date(ReservedUntil), DT2Time(ReservedUntil));
                end;
            end;
        }
        field(70; isApprovedByPrivateUser; Boolean)
        {
            Caption = 'Is Approved By Private User';
        }
        field(80; isGuestReservation; Boolean)
        {
            Caption = 'Is Guest Reservation';
        }
    }

    keys
    {
        key(PK; ParkingLotCode, Row, Column)
        {
            Clustered = true;
        }
    }
    var
        BeforeTodayError: TextConst ENU = 'Selected date is before today';


    trigger OnInsert()
    var
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        ParkingLotChanges.AddEntry(ParkingLotCode, Row, Column, UserId, 'Record Inserted', '');
    end;

    trigger OnDelete()
    var
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        ParkingLotChanges.AddEntry(ParkingLotCode, Row, Column, UserId, 'Record Deleted', '');
    end;

    trigger OnModify()
    var
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        ParkingLotChanges.AddEntry(ParkingLotCode, Row, Column, UserId, 'Record Modified', '');
    end;
}