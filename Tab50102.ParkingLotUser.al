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
        field(60; EmployeeNo; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                if Employee.Get(EmployeeNo) then begin
                    Employee.UserID := UserID;
                    Employee.Modify();
                end;
            end;
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