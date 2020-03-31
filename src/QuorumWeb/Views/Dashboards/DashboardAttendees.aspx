<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Basic.Master" AutoEventWireup="true" CodeBehind="DashboardAttendees.aspx.cs" Inherits="QuorumWeb.Views.Dashboards.DashboardAttendees1" %>

<%@ Register Assembly="DevExpress.XtraCharts.v19.2.Web, Version=19.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.XtraCharts" Assembly="DevExpress.XtraCharts.v19.2, Version=19.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var timeout;
        function scheduleGridUpdate(grid) {
            window.clearTimeout(timeout);
            timeout = window.setTimeout(
                function () {
                    grid.Refresh();
                },
                60000
            );
        }
        function grid_Init(s, e) {
            scheduleGridUpdate(s);
        }
        function grid_BeginCallback(s, e) {
            window.clearTimeout(timeout);
        }
        function grid_EndCallback(s, e) {
            chart.PerformCallback();
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
            <td>

                <dx:WebChartControl ID="WebChartControl1" DataSourceID="SqlDataSourceChart" ClientInstanceName="chart"
                    runat="server" Width="600px" Height="600px" CrosshairEnabled="False">
                    <BorderOptions Visibility="True"></BorderOptions>
                    <DiagramSerializable>
                        <dx:SimpleDiagram3D RotationMatrixSerializable="0.912329138300601;-0.306710104574815;0.271264548290762;0;0.407921851979479;0.738155773422579;-0.537332128985925;0;-0.0354302989730128;0.6008784951341;0.798554774577215;0;0;0;0;1"></dx:SimpleDiagram3D>
                    </DiagramSerializable>

                    <Legend Name="Default Legend" AlignmentHorizontal="Center" EnableAntialiasing="True" Font="Tahoma, 12pt, style=Bold" Visibility="True">
                        <BackImage Stretch="True"></BackImage>

                        <Border Visibility="True"></Border>
                    </Legend>
                    <SeriesSerializable>
                        <dx:Series Name="Series 1" ArgumentDataMember="Name" LabelsVisibility="True" ValueDataMembersSerializable="Quorum" ColorDataMember="Color" LegendTextPattern="{A}: {VP:p2}">
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

                <dx:ASPxGridView ID="ASPxGridView1" ClientInstanceName="grid" runat="server"
                    DataSourceID="DataSourceMaster"
                    Width="400"
                    AutoGenerateColumns="False" EnableRowsCache="false"
                    CssClass="dashboardGrid"
                    SettingsText-Title="Asistencia"
                    KeyFieldName="OrganizationsID"
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

                        <dx:GridViewDataTextColumn FieldName="Name" Caption="Empresa" Width="300" ReadOnly="True">
                        </dx:GridViewDataTextColumn>

                        <dx:GridViewDataTextColumn FieldName="Quorum" Width="100" ReadOnly="True"
                            PropertiesTextEdit-DisplayFormatString="n3">
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
        SelectCommand="SELECT 
       [OrganizationsID]
      ,[Name]
      ,SUM([Shareholding]) Quorum
  FROM [Attendees]
  INNER JOIN [Organizations] ON [Attendees].[OrganizationsID] = [Organizations].ID
  GROUP BY [OrganizationsID], [Organizations].[Name]
"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceChart"
        EnableCaching="false" CacheExpirationPolicy="Absolute" CacheDuration="60"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        SelectCommand="SELECT 
      'CONFIRMADO' [Name]
      ,SUM([Shareholding]) Quorum
      ,'#008000' Color
  FROM [Attendees]
  INNER JOIN [Organizations] ON [Attendees].[OrganizationsID] = [Organizations].ID

UNION

SELECT 
       'SIN CONFIRMAR'
      ,SUM([Shareholding]) Quorum
      ,'#FF0000' Color
  FROM [Attendees]
  RIGHT JOIN [Organizations] ON [Attendees].[OrganizationsID] = [Organizations].ID
  WHERE
   [Attendees].[OrganizationsID] IS NULL"></asp:SqlDataSource>



</asp:Content>
