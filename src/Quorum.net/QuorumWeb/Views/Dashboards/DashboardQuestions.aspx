<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Basic.Master" AutoEventWireup="true" CodeBehind="DashboardQuestions.aspx.cs" Inherits="QuorumWeb.Views.Dashboards.DashboardQuestions" %>

<%@ Register Assembly="DevExpress.XtraCharts.v19.2.Web, Version=19.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.XtraCharts" Assembly="DevExpress.XtraCharts.v19.2, Version=19.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var timeout;
        function scheduleGridUpdate(grid) {
            window.clearTimeout(timeout);
            timeout = window.setTimeout(
                function () {
                    gridAnswers.Refresh();
                    chart.PerformCallback();
                },
                10000
            );
        }
        function grid_Init(s, e) {
            scheduleGridUpdate(s);
        }
        function grid_BeginCallback(s, e) {
            window.clearTimeout(timeout);
        }
        function grid_EndCallback(s, e) {
            scheduleGridUpdate(s);

            var today = new Date();
            var date = today.getFullYear() + '-' + pad(today.getMonth() + 1) + '-' + pad(today.getDate());
            var time = pad(today.getHours()) + ":" + pad(today.getMinutes()) + ":" + pad(today.getSeconds());
            var dateTime = date + ' ' + time;
            document.getElementById("lastUpdate").innerHTML = "Ultima Actualización: " + dateTime;
        }
        function pad(n) { return n < 10 ? '0' + n : n; }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <table class="dashboarTable">

        <tr>
            <td colspan="2">

                <dx:ASPxComboBox runat="server" ID="ASPxComboBoxQuestion" Caption="¿Pregunta?"
                    DataSourceID="SqlDataSourceQuestions" ValueField="ID" ValueType="System.Int32" TextField="Question"
                    Font-Bold="True" Font-Size="Large">
                    <ClientSideEvents ValueChanged="function (s, e){gridAnswers.Refresh();}" />
                </dx:ASPxComboBox>

            </td>

        </tr>

        <tr>
            <td>

                <dx:WebChartControl ID="WebChartControl1" DataSourceID="SqlDataSourceChart" ClientInstanceName="chart"
                    runat="server" Width="600px" Height="600px" CrosshairEnabled="False">
                    <BorderOptions Visibility="True"></BorderOptions>
                    <DiagramSerializable>
                        <dx:SimpleDiagram3D RotationMatrixSerializable="0.912329138300601;-0.306710104574815;0.271264548290762;0;0.407921851979479;0.738155773422579;-0.537332128985925;0;-0.0354302989730128;0.6008784951341;0.798554774577215;0;0;0;0;1"></dx:SimpleDiagram3D>
                    </DiagramSerializable>

                    <Legend Name="Default Legend" AlignmentHorizontal="Center">
                        <Border Visibility="True"></Border>
                    </Legend>
                    <SeriesSerializable>
                        <dx:Series Name="Series 1" ArgumentDataMember="Answer" LabelsVisibility="True" ValueDataMembersSerializable="Cnt" ColorDataMember="Color" LegendTextPattern="{A}: {VP:p2}">
                            <ViewSerializable>
                                <dx:Pie3DSeriesView></dx:Pie3DSeriesView>
                            </ViewSerializable>
                            <LabelSerializable>
                                <dx:Pie3DSeriesLabel Position="Inside" Font="Tahoma, 20pt" ResolveOverlappingMode="Default"></dx:Pie3DSeriesLabel>
                            </LabelSerializable>
                        </dx:Series>
                    </SeriesSerializable>
                    <Titles>
                        <dx:ChartTitle Visibility="True" Text="Quorum"></dx:ChartTitle>
                    </Titles>
                </dx:WebChartControl>

            </td>


            <td>

                <dx:ASPxGridView ID="ASPxGridViewAnswers" ClientInstanceName="gridAnswers" runat="server"
                    DataSourceID="SqlDataSourceAnswers"
                    Width="240"
                    AutoGenerateColumns="False" EnableRowsCache="true"
                    CssClass="dashboardGrid"
                    SettingsText-Title="Respuestas"
                    KeyFieldName="ID"     
                    Font-Size="XX-Small"
                    >


                    <SettingsBehavior EnableRowHotTrack="False"
                        AllowDragDrop="False" AllowFocusedRow="False" AllowGroup="False" AllowSort="False" AllowSelectByRowClick="False"
                        EnableCustomizationWindow="False" AllowEllipsisInText="True" />

                    <Styles>
                        <Header HorizontalAlign="Center" />
                    </Styles>

                    <Settings GridLines="Both" ShowStatusBar="Visible" ShowGroupButtons="False" ShowTitlePanel="True" ShowFooter="True" />

                    <SettingsPager Mode="ShowAllRecords" />

                    <SettingsLoadingPanel Mode="ShowOnStatusBar" />

                    <ClientSideEvents Init="grid_Init" BeginCallback="grid_BeginCallback" EndCallback="grid_EndCallback" />
                    <Columns>

                        <dx:GridViewDataTextColumn FieldName="Number" Caption="#" Width="40" ReadOnly="True">
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn FieldName="Answer" Caption="Respuestas" Width="200" ReadOnly="True">
                        </dx:GridViewDataTextColumn>

                    </Columns>

                    <FormatConditions>
                        <dx:GridViewFormatConditionHighlight FieldName="OrganizationsID" Expression="[OrganizationsID] < 0" Format="LightRedFill" ApplyToRow="True" />
                        <dx:GridViewFormatConditionHighlight FieldName="OrganizationsID" Expression="[OrganizationsID] > 0" Format="LightGreenFill" ApplyToRow="True" />

                    </FormatConditions>

                    <TotalSummary>
                        <dx:ASPxSummaryItem FieldName="Quorum" SummaryType="Sum" DisplayFormat="n0" />
                    </TotalSummary>

                </dx:ASPxGridView>

            </td>
        </tr>

        <tr>
            <td colspan="2">

                <h3 id="lastUpdate">Ultima Actualización:</h3>
            </td>
        </tr>


    </table>


    <asp:SqlDataSource runat="server" ID="DataSourceMaster"
        EnableCaching="false" CacheExpirationPolicy="Absolute" CacheDuration="60"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        CancelSelectOnNullParameter="false"
        SelectCommand="SELECT 
       [OrganizationsID]
      ,[Name]
      ,SUM([Shareholding]) Quorum
  FROM [Attendees]
  INNER JOIN [Organizations] ON [Attendees].[OrganizationsID] = [Organizations].ID
  GROUP BY [OrganizationsID], [Organizations].[Name]
">

        <SelectParameters>
            <asp:ControlParameter ControlID="ctl00$Content$ASPxComboBoxQuestion" Type="Int32" />

        </SelectParameters>


    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceChart"
        EnableCaching="false" CacheExpirationPolicy="Absolute" CacheDuration="60"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        SelectCommand="
SELECT 
       Answer
      ,COUNT(*) Cnt
      ,'#008000' Color
  FROM [AttendeesAnswers]
INNER JOIN [QuestionsAnswers] ON [AttendeesAnswers].AnswersID = [QuestionsAnswers].ID
WHERE
[AttendeesAnswers].[QuestionsID] = @QuestionsID
GROUP BY Answer

UNION

SELECT 
      'ABSTENCIONES' Answer
      ,COUNT(*) Cnt
      ,'#FF0000' Color
  FROM [Attendees]
LEFT JOIN [AttendeesAnswers] ON [Attendees].ID = [AttendeesAnswers].AttendeesID
WHERE
[Attendees].[ID] NOT IN (SELECT [AttendeesID] FROM [AttendeesAnswers] WHERE [AttendeesAnswers].[QuestionsID] = @QuestionsID GROUP BY [AttendeesID])">


        <SelectParameters>

            <asp:ControlParameter Name="QuestionsID" ControlID="ctl00$Content$ASPxComboBoxQuestion" Type="Int32" />

        </SelectParameters>

    </asp:SqlDataSource>



    <asp:SqlDataSource runat="server" ID="SqlDataSourceQuestions"
        EnableCaching="true" CacheDuration="60" CacheExpirationPolicy="Sliding"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        SelectCommand="SELECT [ID], [Question] FROM [Questions]"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceAnswers"
        EnableCaching="true" CacheDuration="60" CacheExpirationPolicy="Sliding"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        SelectCommand="SELECT 
       ID
      ,ROW_NUMBER() OVER(ORDER BY ID) Number 
      ,[Answer]
  FROM [QuestionsAnswers]
  WHERE
  [QuestionsID] = @QuestionsID">

        <SelectParameters>

            <asp:ControlParameter Name="QuestionsID" ControlID="ctl00$Content$ASPxComboBoxQuestion" Type="Int32" />

        </SelectParameters>

    </asp:SqlDataSource>

</asp:Content>
