table 50102 ParkingLotUser
{
    Caption = 'Parking Lot User';

    fields
    {
        field(1; UserID; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
        }
        field(21; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(30; Surname; Text[50])
        {
            Caption = 'Surname';
        }
        field(40; UserContactInfo; Text[200])
        {
            Caption = 'User Contact Info';
        }
        field(50; CarRegistrationNumber; Code[20])
        {
            Caption = 'Car Registration Number';
        }
    }

    keys
    {
        key(PK; UserID)
        {
            Clustered = true;
        }
    }

}