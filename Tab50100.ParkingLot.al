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
            trigger OnValidate()
            var
                ParkingLotChanges: Record ParkingLotChanges;
            begin
                ParkingLotChanges.AddEntry(Code, 0, 0, UserId, 'Address field changed from ' + xRec.Adress + ' to ' + Adress, '');
            end;
        }
        field(30; Description; Text[200])
        {
            Caption = 'Description';

            trigger OnValidate()
            var
                ParkingLotChanges: Record ParkingLotChanges;
            begin
                ParkingLotChanges.AddEntry(Code, 0, 0, UserId, 'Description field changed from ' + xRec.Description + ' to ' + Description, '');
            end;
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
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        ParkingLotUsers.SetRange(ParkingLotCode, Code);
        ParkingLotUsers.DeleteAll();

        ParkingSpace.SetRange(ParkingLotCode, Code);
        ParkingSpace.DeleteAll();

        ParkingLotChanges.AddEntry(Code, 0, 0, UserId, 'Parking lot ' + Code + ' has been deleted', '');
    end;

    trigger OnInsert()
    var
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        ParkingLotChanges.AddEntry(Code, 0, 0, UserId, 'Parking lot ' + Code + ' created', '');
    end;

    trigger OnRename()
    var
        ParkingLotChanges: Record ParkingLotChanges;
    begin
        ParkingLotChanges.AddEntry(Code, 0, 0, UserId, 'Parking lot has been renamed from ' + xRec.Code + ' has been deleted to ' + Code, '');
    end;
}