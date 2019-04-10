page 50113 ParkingLotHeadline
{
    PageType = HeadlinePart;
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            field(Field1; HeadlineConstant)
            {
                ShowCaption = false;
                Visible = true;
                ApplicationArea = All;
            }
        }
    }


    var
        HeadlineConstant: TextConst ENU = 'Welcome to the BC  integration!';
}