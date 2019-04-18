table 50106 ParkingLotSetup
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
        }
        field(21; ReservationStart; Time)
        {
            Caption = 'Reservation Start Time';
        }
        field(30; MainParkingLotReservationLimit; Time)
        {
            Caption = 'Main Parking Lot Reservation Time limit';
        }
        field(40; EndOfWorkTime; Time)
        {
            Caption = 'End Of Work Time';
        }
        field(50; EnableGuestFunctionality; Boolean)
        {
            Caption = 'Enable Guest Functionality';
        }
        field(60; AbsenceModuleActive; Boolean)
        {
            Caption = 'Absence Module Active';
        }
        field(70; EnableTwoStepReservation; Boolean)
        {
            Caption = 'Two Step Reservation Active';

            trigger OnValidate()
            begin
                if not EnableTwoStepReservation then
                    FirstStepReservationTime := 0T;
            end;
        }
        field(80; FirstStepReservationTime; Time)
        {
            Caption = 'First Step Reservation Time';
        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}