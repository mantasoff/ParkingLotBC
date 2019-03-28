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
        }
        field(3; Column; Integer)
        {
            Caption = 'Row';
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
        }
        field(50; ReservedUntil; DateTime)
        {
            Caption = 'Reserved Until';
        }
    }

    keys
    {
        key(PK; ParkingLotCode, Row, Column)
        {
            Clustered = true;
        }
    }
}