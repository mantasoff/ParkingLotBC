page 50113 ParkingLotHeadline
{
    PageType = HeadlinePart;
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {

        area(content)
        {

            field(Headline1; HeadlineConstant)
            {
                ApplicationArea = All;
            }
            field(Headline2; HeadlineConstant)
            {
                ApplicationArea = All;
            }
        }
    }


    var
        HeadlineConstant: TextConst ENU = '<qualifier>Welcome</qualifier><payload>Welcome to the <emphasize>Parking Lot</emphasize> integration for D365BC.</payload>';

}