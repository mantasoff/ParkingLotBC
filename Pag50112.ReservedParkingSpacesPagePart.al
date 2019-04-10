page 50112 ReservedParkingSpacesPagePart
{
    Caption = 'Reserved Parking Spaces';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ParkingSpace;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Reserved Spaces")
            {
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
                field(ReservedUntil; ReservedUntil)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    trigger OnOpenPage()
    begin
        SetRange(ParkingLotUserID, UserId);
    end;

}