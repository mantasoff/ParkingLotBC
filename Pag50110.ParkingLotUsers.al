page 50110 ParkingLotAppUsers
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ParkingLotUser;
    Caption = 'Parking Lot Application Users';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(UserID; UserID)
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Surname; Surname)
                {
                    ApplicationArea = All;
                }
                field(CarRegistrationNumber; CarRegistrationNumber)
                {
                    ApplicationArea = All;
                }
                field(UserContactInfo; UserContactInfo)
                {
                    ApplicationArea = All;
                }
                field(EmployeeNo; EmployeeNo)
                {
                    ApplicationArea = All;
                }
                field(ParkingReservationPriority; ParkingReservationPriority)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}