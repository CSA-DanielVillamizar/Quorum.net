<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Root.master" AutoEventWireup="true" CodeBehind="GridAttendees.aspx.cs" Inherits="QuorumWeb.Views.Queries.GridAttendees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">

    <script type="text/javascript">
        function OnToolbarItemClick(s, e) {
            if (IsCustomExportToolbarCommand(e.item.name)) {
                e.processOnServer = true;
                e.usePostBack = true;
                return;
            } else if (e.item.name == "ResetGrid") { ResetGrid(grid); return; }
        }
        function IsCustomExportToolbarCommand(command) {
            if (command == "CustomExportToXLS" || command == "CustomExportToXLSX")
                return true;
            else
                return false;
        }
        function gridDeleteRow(targetGrid, id) {
            if (confirm('¿Esta seguro de ELIMINAR el registro actual? (' + id + ')')) {
                targetGrid.DeleteRowByKey(id);
            }
        }
        function ResetGrid(targetGrid) {
            if (confirm('¿Esta seguro de RESETEAR el diseño de la grilla actual?')) {
                ASPxClientUtils.DeleteCookie("<%= QuorumWeb.UI.PageBaseGrid.MasterGridCookieName  %>");<%-- *** WARNING SET THE SAME VALUE OF SettingsCookies-CookiesID OF GRID *** --%>
                targetGrid.Refresh();
                window.location.reload();
            }
        }
        function ResetDetGrid(targetGrid) {
            if (confirm('¿Esta seguro de RESETEAR el diseño de la grilla actual?')) {
                ASPxClientUtils.DeleteCookie("<%= QuorumWeb.UI.PageBaseGrid.DetailGridCookieName  %>");<%-- *** WARNING SET THE SAME VALUE OF SettingsCookies-CookiesID OF GRID *** --%>
                targetGrid.Refresh();
                window.location.reload();
            }
        }
        function Grid_Update_Click(grid) {
            var isValid = ASPxClientEdit.ValidateEditorsInContainer(grid.GetMainElement());
            if (isValid)
                grid.UpdateEdit();
        }
        var detgridcommand = "";
        function detailGridOnBeginCallback(s, e) {
            detgridcommand = e.command;
        }
        function detailGridOnEndCallback(s, e) {
            /*  if (detgridcommand == "ADDNEWROW" || detgridcommand == "UPDATEEDIT" || detgridcommand == "DELETEROW") {
                  s.Refresh();
              }*/
        }
        function sPopup(userId, table) {
            /*
            var spage = "UsersDataFilter.aspx?time=" + new Date().getTime() + "&userId=" + userId + "&table=" + table;
            showPopupMasterModal('Edicion Filtros', spage);*/
        }

        function OnCountryChanged(cmbCountry, cmbRegion) {
            if (cmbRegion.InCallback())
                return;
            else
                cmbRegion.PerformCallback(cmbCountry.GetValue().toString());
        }
        function OnEndCallbackRegion(s, e) {
        }
        function OnRegionChanged(cmbCountry, cmbRegion, cmbCity) {
            if (cmbCity.InCallback()) return;
            else
                cmbCity.PerformCallback(cmbCountry.GetValue().toString() + '|' + cmbRegion.GetValue().toString());
        }
        function OnEndCallbackCity(s, e) {
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">

    <h2>Consulta Asistencia</h2>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server"
        DataSourceID="DataSourceMaster"
        KeyFieldName="OrganizationsID"
        ClientInstanceName="grid"
        Width="1450"
        OnHtmlRowPrepared="ASPxGridView1_HtmlRowPrepared"
        OnRowValidating="ASPxGridView1_RowValidating"
        OnStartRowEditing="ASPxGridView1_StartRowEditing"
        OnRowUpdating="ASPxGridView1_RowUpdating"
        OnParseValue="ASPxGridView1_ParseValue"
        OnRowDeleted="ASPxGridView1_RowDeleted"
        OnRowInserted="ASPxGridView1_RowInserted"
        OnRowUpdated="ASPxGridView1_RowUpdated"
        OnDataBinding="ASPxGridView1_DataBinding"
        OnRowInserting="ASPxGridView1_RowInserting"
        OnDetailRowExpandedChanged="ASPxGridView1_DetailRowExpandedChanged"
        OnCustomCallback="ASPxGridView1_CustomCallback"
        OnCellEditorInitialize="ASPxGridView1_CellEditorInitialize"
        OnToolbarItemClick="Grid_ToolbarItemClick"
        AutoGenerateColumns="False">

        <SettingsText />

        <Settings ColumnMinWidth="40" HorizontalScrollBarMode="Hidden" VerticalScrollBarMode="Hidden"
            ShowFilterRow="True" ShowTitlePanel="True" ShowFilterBar="Hidden" />

        <SettingsCommandButton
            DeleteButton-ButtonType="Image"
            EditButton-ButtonType="Image"
            NewButton-ButtonType="Image"
            RenderMode="Button">
            <NewButton Image-IconID="actions_additem_16x16office2013" />
            <EditButton Image-IconID="edit_edit_16x16office2013" />
            <DeleteButton Image-IconID="spreadsheet_deletesheetrows_16x16" />
            <UpdateButton Image-IconID="actions_apply_16x16office2013" />
            <CancelButton Image-IconID="actions_cancel_16x16office2013" />
            <SearchPanelApplyButton>
            </SearchPanelApplyButton>
            <SearchPanelClearButton>
            </SearchPanelClearButton>
            <ApplyFilterButton></ApplyFilterButton>
            <ClearFilterButton></ClearFilterButton>
        </SettingsCommandButton>

        <SettingsDataSecurity />
        <SettingsResizing ColumnResizeMode="NextColumn" Visualization="Postponed" />

        <SettingsBehavior ConfirmDelete="True" EnableRowHotTrack="True"
            AllowDragDrop="True" AllowFocusedRow="True" AllowGroup="True" AllowSort="True" AllowSelectByRowClick="True"
            EnableCustomizationWindow="True" AllowEllipsisInText="False" />

        <SettingsPager PageSize="10" Position="Bottom" AllButton-Visible="False" PageSizeItemSettings-Visible="false"
            PageSizeItemSettings-ShowAllItem="False" NumericButtonCount="10">
        </SettingsPager>

        <SettingsEditing Mode="EditFormAndDisplayRow" EditFormColumnCount="1" />

        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True"
            ShowFooter="True" ShowGroupPanel="True" ShowTitlePanel="True" ShowColumnHeaders="True"
            ShowGroupButtons="True" ShowHeaderFilterButton="False" />

        <SettingsCookies Enabled="True" StoreControlWidth="True" />

        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>

        <SettingsDetail ShowDetailRow="False" AllowOnlyOneMasterRowExpanded="False" ExportMode="All"></SettingsDetail>

        <SettingsContextMenu Enabled="True" EnableFooterMenu="True" EnableGroupPanelMenu="True"
            EnableRowMenu="True" EnableColumnMenu="True">
        </SettingsContextMenu>

        <SettingsSearchPanel Visible="False" CustomEditorID="tbToolbarSearch" ShowClearButton="False" ShowApplyButton="False" Delay="1500" />
        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" />

        <Columns>

            <dx:GridViewDataTextColumn FieldName="OrganizationsID" Caption="ID" VisibleIndex="0" Width="50" ReadOnly="True">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Organization" Caption="Empresa" Width="200" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            
            <dx:GridViewDataTextColumn FieldName="Identification1" Caption="Ident.Empre." Width="100" VisibleIndex="2">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Shareholding" Caption="%Part." Width="100" PropertiesTextEdit-HelpText="Valor en Porcentaje" VisibleIndex="3">
                <PropertiesTextEdit DisplayFormatString="n6">
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>
            
            <dx:GridViewDataTextColumn FieldName="VoterName" Caption="Representante" Width="200" VisibleIndex="4">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Identification2" Caption="Ident.Repre." Width="200" VisibleIndex="5">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Category" Caption="Categoria" Width="200" VisibleIndex="6">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="VoteCode" Caption="Contraseña" Width="200" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            
            <dx:GridViewDataTextColumn FieldName="DateIn" Caption="FechaRegistro" Width="200" VisibleIndex="8">
            </dx:GridViewDataTextColumn>

        </Columns>

        <ClientSideEvents ToolbarItemClick="OnToolbarItemClick" />

        <Toolbars>

            <dx:GridViewToolbar ItemAlign="Left">
                <Items>
                    <dx:GridViewToolbarItem BeginGroup="true">
                        <Template>
                            <dx:ASPxButtonEdit ID="tbToolbarSearch" runat="server" NullText="Buscar..." Height="100%">
                                <Buttons>
                                    <dx:SpinButtonExtended Image-IconID="find_find_16x16gray" />
                                </Buttons>
                            </dx:ASPxButtonEdit>
                        </Template>
                    </dx:GridViewToolbarItem>

                    <dx:GridViewToolbarItem Text="Exportar" BeginGroup="true" Image-IconID="actions_download_16x16office2013">
                        <Items>
                            <dx:GridViewToolbarItem Command="ExportToPdf" />
                            <dx:GridViewToolbarItem Command="ExportToDocx" />
                            <dx:GridViewToolbarItem Command="ExportToRtf" />
                            <dx:GridViewToolbarItem Command="ExportToCsv" />
                            <dx:GridViewToolbarItem Command="ExportToXls" Text="XLS(DataAware)" />
                            <dx:GridViewToolbarItem Visible="false" Name="CustomExportToXLS" Text="XLS(WYSIWYG)" Image-IconID="export_exporttoxls_16x16office2013" />
                            <dx:GridViewToolbarItem Command="ExportToXlsx" Text="XLSX(DataAware)" />
                            <dx:GridViewToolbarItem Visible="false" Name="CustomExportToXLSX" Text="XLSX(WYSIWYG)" Image-IconID="export_exporttoxlsx_16x16office2013" />
                        </Items>
                    </dx:GridViewToolbarItem>

                </Items>
            </dx:GridViewToolbar>

            <dx:GridViewToolbar ItemAlign="Left">
                <Items>
                    <dx:GridViewToolbarItem Command="Refresh" BeginGroup="true" DisplayMode="Image" />
                    <dx:GridViewToolbarItem Command="FullExpand" DisplayMode="Image" />
                    <dx:GridViewToolbarItem Command="FullCollapse" DisplayMode="Image" />
                    <dx:GridViewToolbarItem Name="ResetGrid" ToolTip="Resetear Diseño" DisplayMode="Image" Image-IconID="grid_autofittocontent_16x16" />

                </Items>
            </dx:GridViewToolbar>

        </Toolbars>

        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="ID" SummaryType="Count" DisplayFormat="n0" />
            <dx:ASPxSummaryItem FieldName="Shareholding" SummaryType="Sum" DisplayFormat="n0" />

        </GroupSummary>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="ID" SummaryType="Count" DisplayFormat="n0" />
            <dx:ASPxSummaryItem FieldName="Shareholding" SummaryType="Sum" DisplayFormat="n0" />
        </TotalSummary>

        <Styles>

            <AlternatingRow Enabled="True" CssClass="gridDataRowAlt"></AlternatingRow>
            <RowHotTrack CssClass="gridDataHover"></RowHotTrack>
            <SelectedRow CssClass="gridDataSelectedRow"></SelectedRow>

            <SearchPanel>
            </SearchPanel>

            <Cell Wrap="True"></Cell>
            <EditForm CssClass="gridEditForm"></EditForm>

        </Styles>

        <Templates>

            <EmptyDataRow>
                <div class="alert alert-warning" role="alert">No existen registros.</div>
            </EmptyDataRow>

            <DetailRow>
            </DetailRow>

        </Templates>

    </dx:ASPxGridView>

    <asp:SqlDataSource runat="server" ID="DataSourceMaster"
        EnableCaching="true" CacheExpirationPolicy="Sliding" CacheDuration="300"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        OnInit="DBMainDataSources_Init"
        OnSelecting="DBMainDataSources_Selecting"
        SelectCommand="SELECT
       [OrganizationsID]
      ,Organizations.Name Organization
      ,Organizations.Identification Identification1
      ,[Shareholding]
      ,[VotersID]
      ,Voters.Name VoterName
      ,Voters.Identification Identification2
      ,[VoterCategoryID]
      ,VoterCategory.Category
      ,[VoteCode]
      ,[DateIn] 
  FROM [Attendees]
INNER JOIN [Organizations] ON [Attendees].OrganizationsID = Organizations.ID
INNER JOIN [Voters] ON [Attendees].VotersID = Voters.ID
INNER JOIN [VoterCategory] ON [Attendees].VoterCategoryID = [VoterCategory].ID

UNION

SELECT
       [Organizations].ID 
      ,Organizations.Name 
      ,Organizations.Identification 
      ,[Shareholding]
      ,NULL 
      ,NULL 
      ,NULL 
      ,NULL 
      ,NULL 
      ,NULL 
      ,NULL 
  FROM [Organizations]
  WHERE 
  [Organizations].ID NOT IN (SELECT [OrganizationsID] FROM [Attendees])
        "></asp:SqlDataSource>

</asp:Content>
