table 50103 SpaceType
{
    Caption = 'Space Type';

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';

        }
        field(21; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(30; Description; Text[200])
        {
            Caption = 'Description';
        }
        field(40; ReservationPeriod; Integer)
        {
            Caption = 'Reservation Period (Minutes)';

            trigger OnValidate()
            begin
                if ReservationPeriod <= 0 then begin
                    Error('You cannot set a reservation period to a negative number');
                end;
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
}