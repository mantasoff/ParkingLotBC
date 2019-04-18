tableextension 50100 EmployeeExtension extends Employee
{
    fields
    {
        field(50100; UserID; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                Employee.SetRange(UserID, UserID);
                if Employee.FindSet() then begin
                    if Employee.Count > 1 then begin
                        Error(EmployeeWithUserIDExists);
                    end;
                end;
            end;
        }
    }

    var
        EmployeeWithUserIDExists: TextConst ENU = 'Employee with this User ID already exists';
}