table 50101 ParkingLotUsers
{
    DataClassification = ToBeClassified;
    Caption = 'Parking Lot Users';
    fields
    {
        field(1; ParkingLotCode; Integer)
        {
            Caption = 'Parking Lot Code';
            TableRelation = ParkingLot;
        }
        field(2; ParkingLotUserID; Code[50])
        {
            Caption = 'Parking Lot User ID';
            TableRelation = ParkingLotUser;
        }
    }

    keys
    {
        key(PK; ParkingLotCode, ParkingLotUserID)
        {
            Clustered = true;
        }
    }

}