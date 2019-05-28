table 50108 GuestReservation
{
    DataClassification = ToBeClassified;
    Caption = 'Reservation';
    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';

        }
        field(20; ParkingLotCode; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = ParkingLot;
            Caption = 'Parking Lot Code';
        }
        field(30; Row; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Row';
        }
        field(40; Collumn; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Collumn';
        }
        field(50; FromDateTime; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'From Date Time';
        }
        field(60; ToDateTime; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'To Date Time';
            trigger OnValidate()
            begin
                if ToDateTime < FromDateTime then
                    Error(ToDateTimeError);
            end;
        }
        field(70; ReservationConfirmed; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reservation confirmed';
            trigger OnValidate()
            begin
                if ToDateTime < FromDateTime then
                    Error(ToDateTimeError);
            end;
        }
        field(80; ParkingLotUser; Code[20])
        {
            TableRelation = ParkingLotUser;
            Caption = 'Parking Lot User';
        }
        field(90; GuestReservation; Boolean)
        {
            TableRelation = ParkingLotUser;
            Caption = 'Guest Reservation';
        }
    }

    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }

    var
        ToDateTimeError: TextConst ENU = 'To Date Time Cannot be less than from date time';

    trigger onInsert()
    var
        Reservation: Record GuestReservation;
    begin
        if Reservation.findlast then;
        EntryNo := Reservation.EntryNo + 1;
    end;
}