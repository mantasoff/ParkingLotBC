page 50114 ParkingLotChanges
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ParkingLotChanges;
    Caption = 'Parking Lot Changes';
    layout
    {
        area(Content)
        {
            repeater("Parking Lot Changes")
            {
                field(EntryNo; EntryNo)
                {
                    ApplicationArea = All;
                }
                field(ParkingLotCode; ParkingLotCode)
                {
                    ApplicationArea = All;
                }
                field(Row; Row)
                {
                    ApplicationArea = All;
                }
                field(Column; Column)
                {
                    ApplicationArea = All;
                }
                field(UserID; UserID)
                {
                    ApplicationArea = All;
                }
                field(Description1; Description1)
                {
                    ApplicationArea = All;
                }
                field(Description2; Description2)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

}