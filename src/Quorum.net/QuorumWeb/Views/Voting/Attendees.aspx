<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Root.master" AutoEventWireup="true" CodeBehind="Attendees.aspx.cs" Inherits="QuorumWeb.Views.Voting.Attendees" %>

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

    <h3 class="section-caption contents-caption">Submenu</h3>

    <dx:ASPxHyperLink runat="server" EnableViewState="false" CssClass="button"
        NavigateUrl="~/Views/Admin/Voters.aspx"
        Text="+ Crear Votante" ViewStateMode="Disabled" ValidateRequestMode="Disabled">
    </dx:ASPxHyperLink>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">

    <h2>Registro Asistentes con Derecho a Voto</h2>

    <p>Solo se permite el registro de 1 votante por empresa.</p>

    <dx:ASPxGridView ID="ASPxGridView1" runat="server" Width="940"
        DataSourceID="DataSourceMaster"
        KeyFieldName="ID"
        ClientInstanceName="grid"
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

        <SettingsEditing Mode="PopupEditForm" EditFormColumnCount="1" />

        <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True"
            ShowFooter="True" ShowGroupPanel="True" ShowTitlePanel="True" ShowColumnHeaders="True"
            ShowGroupButtons="True" ShowHeaderFilterButton="False" />

        <SettingsCookies Enabled="True" StoreControlWidth="True" />

        <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="true" ExportMode="All"></SettingsDetail>

        <SettingsContextMenu Enabled="True" EnableFooterMenu="True" EnableGroupPanelMenu="True"
            EnableRowMenu="True" EnableColumnMenu="True">
        </SettingsContextMenu>

        <SettingsSearchPanel Visible="False" CustomEditorID="tbToolbarSearch" ShowClearButton="False" ShowApplyButton="False" Delay="1500" />
        <SettingsExport EnableClientSideExportAPI="true" ExcelExportMode="DataAware" />

        <Columns>

            <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="0" Width="60" ReadOnly="True">
                <EditFormSettings Visible="False"></EditFormSettings>
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataComboBoxColumn FieldName="OrganizationsID" Caption="Empresa" Width="180" VisibleIndex="1">
                <PropertiesComboBox DataSourceID="SqlDataSourceOrganizations"
                    ValueField="ID" ValueType="System.Int32" TextField="Name">

                    <ValidationSettings CausesValidation="True" ValidateOnLeave="false" ErrorDisplayMode="ImageWithText" ErrorTextPosition="Bottom">
                        <RequiredField IsRequired="true" />
                    </ValidationSettings>

                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>


            <dx:GridViewDataComboBoxColumn FieldName="VotersID" Caption="Votante" Width="240" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="SqlDataSourceVoters"
                    ValueField="ID" ValueType="System.Int32" TextField="Name">

                    <Columns>
                        <dx:ListBoxColumn FieldName="Name" Caption="Nombres" Width="120">
                        </dx:ListBoxColumn>
                        <dx:ListBoxColumn FieldName="Identification" Caption="Identificacion" Width="120">
                        </dx:ListBoxColumn>
                    </Columns>

                    <ValidationSettings CausesValidation="True" ValidateOnLeave="false">
                        <RequiredField IsRequired="true" />
                    </ValidationSettings>

                </PropertiesComboBox>

            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="VoterCategoryID" Caption="Categoria Votante" Width="180" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="SqlDataSourceVoterCategory"
                    ValueField="ID" ValueType="System.Int32" TextField="Category">

                    <ValidationSettings CausesValidation="True" ValidateOnLeave="false">
                        <RequiredField IsRequired="true" />

                    </ValidationSettings>

                </PropertiesComboBox>

            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn FieldName="GUIDCHECKSUM" Caption="Contraseña" Visible="true" VisibleIndex="4" Width="100" ReadOnly="True">
                <EditFormSettings Visible="False"></EditFormSettings>
                <PropertiesTextEdit Password="false"></PropertiesTextEdit>
            </dx:GridViewDataTextColumn>

            <dx:GridViewCommandColumn ShowEditButton="true" ButtonRenderMode="Link" Width="60">
            </dx:GridViewCommandColumn>

        </Columns>

        <ClientSideEvents ToolbarItemClick="OnToolbarItemClick" />

        <ClientSideEvents RowDblClick="function(s, e) {
        s.StartEditRow(e.visibleIndex);
    }" />

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
                    <dx:GridViewToolbarItem Command="New" />
                    <dx:GridViewToolbarItem Command="Edit" />
                    <dx:GridViewToolbarItem Command="Delete" />
                    <dx:GridViewToolbarItem Command="Refresh" BeginGroup="true" DisplayMode="Image" />
                    <dx:GridViewToolbarItem Command="FullExpand" DisplayMode="Image" />
                    <dx:GridViewToolbarItem Command="FullCollapse" DisplayMode="Image" />
                    <dx:GridViewToolbarItem Name="ResetGrid" ToolTip="Resetear Diseño" DisplayMode="Image" Image-IconID="grid_autofittocontent_16x16" />

                </Items>
            </dx:GridViewToolbar>

        </Toolbars>

        <GroupSummary>
            <dx:ASPxSummaryItem FieldName="ID" SummaryType="Count" DisplayFormat="n0" />
        </GroupSummary>
        <TotalSummary>
            <dx:ASPxSummaryItem FieldName="ID" SummaryType="Count" DisplayFormat="n0" />
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

            <EditForm>
                <div class="gridEditForm">

                    <dx:ContentControl ID="ContentControl1" runat="server">
                        <dx:ASPxGridViewTemplateReplacement ID="Editors" ReplacementType="EditFormEditors"
                            runat="server"></dx:ASPxGridViewTemplateReplacement>
                    </dx:ContentControl>

                </div>
                <hr />
                <div class="gridEditForm">
                    <dx:ASPxValidationSummary ID="ASPxValidationSummary1" runat="server" RenderMode="OrderedList" ShowErrorsInEditors="True"
                        HeaderText="Errores en el Formulario a Corregir" CssClass="alert alert-danger"
                        HeaderStyle-CssClass="alert-heading alert-danger" ValidationGroup='<%# Container.ValidationGroup %>' />
                    <span>

                        <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                    </span>
                    &nbsp;|&nbsp; 
                            <span>
                                <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                            </span>
                </div>
            </EditForm>


            <DetailRow>

                <p><b>Contraseña:</b> <%# Eval("GUIDCHECKSUM") %></p>

            </DetailRow>

        </Templates>

    </dx:ASPxGridView>

    <asp:SqlDataSource runat="server" ID="DataSourceMaster"
        EnableCaching="true" CacheExpirationPolicy="Absolute" CacheDuration="60"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        OnInit="DBMainDataSources_Init"
        OnSelecting="DBMainDataSources_Selecting"
        DeleteCommand="DELETE FROM [Attendees] WHERE [ID] = @ID"
        InsertCommand="INSERT INTO [Attendees] ([OrganizationsID], [VotersID], [VoterCategoryID]) VALUES (@OrganizationsID, @VotersID, @VoterCategoryID)"
        SelectCommand="SELECT [ID], [OrganizationsID], [VotersID], [VoterCategoryID], [GUID], [GUIDCHECKSUM]  FROM [Attendees]"
        UpdateCommand="UPDATE [Attendees] SET [OrganizationsID] = @OrganizationsID, [VotersID] = @VotersID, [VoterCategoryID] = @VoterCategoryID WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="OrganizationsID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="VotersID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="VoterCategoryID" Type="Int32"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="OrganizationsID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="VotersID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="VoterCategoryID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceOrganizations"
        EnableCaching="true" CacheExpirationPolicy="Sliding" CacheDuration="300"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        OnInit="DBMainDataSources_Init"
        OnSelecting="DBMainDataSources_Selecting" SelectCommand="SELECT [ID], [Name] FROM [Organizations]"></asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSourceVoterCategory"
        EnableCaching="true" CacheExpirationPolicy="Sliding" CacheDuration="300"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        OnInit="DBMainDataSources_Init"
        OnSelecting="DBMainDataSources_Selecting" SelectCommand="SELECT [ID], [Category] FROM [VoterCategory]"></asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSourceVoters"
        EnableCaching="true" CacheDuration="30"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        OnInit="DBMainDataSources_Init"
        OnSelecting="DBMainDataSources_Selecting" SelectCommand="SELECT [ID], [Name], [Identification] FROM [Voters]"></asp:SqlDataSource>



</asp:Content>
