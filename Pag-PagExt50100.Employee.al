pageextension 50100 EmployeePageExtension extends "Employee Card"
{
    layout
    {
        addlast(General)
        {
            field(UserID; UserID)
            {
                ApplicationArea = All;
            }
        }
    }

}