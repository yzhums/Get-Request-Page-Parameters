page 50103 "ZY Get Request Page Parameters"
{
    PageType = Card;
    Caption = 'Get Request Page Parameters';
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(ReportId; ReportId)
            {
                ApplicationArea = All;
                Caption = 'Report Id';
                TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));

                trigger OnValidate()
                var
                    AllObjWithCaption: Record AllObjWithCaption;
                begin
                    if AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Report, ReportId) then begin
                        ReportName := AllObjWithCaption."Object Name";
                        XMLString := '';
                    end;
                end;
            }
            field(ReportName; ReportName)
            {
                ApplicationArea = All;
                Caption = 'Report Name';
                Editable = false;
            }
            field(XMLString; XMLString)
            {
                ApplicationArea = All;
                Caption = 'XML String';
                Editable = false;
                MultiLine = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetReportReuqestPageParameters)
            {
                Caption = 'Get Report Reuqest Page Parameters';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ComfirmReport: Report "Standard Sales - Order Conf.";
                begin
                    XMLString := Report.RunRequestPage(ReportId);
                end;
            }
            action(RunReport)
            {
                Caption = 'Run Report';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Report.Print(ReportId, XMLString);
                end;
            }
        }
    }

    var
        ReportId: Integer;
        ReportName: Text;
        XMLString: Text;
}
