table 50107 ParkingLotChanges
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
        }
        field(21; ParkingLotCode; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Parking Lot Code';
        }
        field(30; Row; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Row';
        }
        field(40; Column; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Column';
        }
        field(50; UserID; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'User ID';
        }
        field(60; Description1; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description 1';
        }
        field(70; Description2; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description 2';
        }
    }

    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        if ParkingLotChanges.FindLast() then;
        EntryNo := ParkingLotChanges.EntryNo + 1;
    end;

    procedure AddEntry(ParkingLotCodeP: Code[50]; RowP: Integer; ColumnP: Integer; UserIDP: Code[50]; Description1P: Text[250]; Description2P: Text[250])
    begin
        ParkingLotCode := ParkingLotCodeP;
        Row := RowP;
        Column := ColumnP;
        UserID := UserIDP;
        Description1 := Description1P;
        Description2 := Description2P;
        Insert(true);
    end;
}