table 50100 ParkingLot
{
    DataClassification = ToBeClassified;
    Caption = 'Parking Lot';
    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
        }
        field(21; Adress; Text[200])
        {
            Caption = 'Description';
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

}