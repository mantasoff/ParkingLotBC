table 50104 UserAllowedSpaceTypes
{
    Caption = 'User Allowed Space Types';

    fields
    {
        field(1; ParkingLotUserID; Code[50])
        {
            Caption = 'Parking Lot User ID';
            TableRelation = ParkingLotUser;
        }
        field(2; SpaceType; Code[20])
        {
            Caption = 'Space Type';
            TableRelation = SpaceType;
        }
    }

    keys
    {
        key(PK; ParkingLotUserID, SpaceType)
        {
            Clustered = true;
        }
    }


}