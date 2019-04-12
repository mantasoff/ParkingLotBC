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
            MinValue = 0;
        }
        field(3; Column; Integer)
        {
            Caption = 'Column';
            MinValue = 0;
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
        field(60; MainUserID; Code[50])
        {
            Caption = 'Main UserID';
            TableRelation = "User Setup";
        }
        field(70; isApprovedByMainUser; Boolean)
        {
            Caption = 'Is Approved By Main User';
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

}