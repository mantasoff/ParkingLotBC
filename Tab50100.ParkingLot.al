table 50100 ParkingLot
{
    Caption = 'Parking Lot';

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(21; Adress; Text[200])
        {
            Caption = 'Adress';
        }
        field(30; Description; Text[200])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        ParkingLotUsers: Record ParkingLotUsers;
        ParkingSpace: Record ParkingSpace;
    begin
        ParkingLotUsers.SetRange(ParkingLotCode, Code);
        ParkingLotUsers.DeleteAll();

        ParkingSpace.SetRange(ParkingLotCode, Code);
        ParkingSpace.DeleteAll();

    end;

}