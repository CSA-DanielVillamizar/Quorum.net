<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Root.master" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" 
    Inherits="QuorumWeb.Views.Admin.Roles" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Import Namespace="BINumber_Web.SL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentHead" runat="Server">
    <script type="text/javascript">
        function gridDeleteRow(targetGrid, id) {
            if (confirm('¿Esta seguro de ELIMINAR el registro actual? (' + id + ')')) {
                targetGrid.DeleteRowByKey(id);
            }
        }
        function ResetGrid(targetGrid) {
            if (confirm('¿Esta seguro de RESETEAR el diseño de la grilla actual?')) {
                ASPxClientUtils.DeleteCookie("Administration_Roles_Grid_Layout");<%-- *** WARNING SET THE SAME VALUE OF SettingsCookies-CookiesID OF GRID *** --%>
                targetGrid.Refresh();
                window.location.reload();
            }
        }
        function ResetDetGrid(targetGrid) {
            if (confirm('¿Esta seguro de RESETEAR el diseño de la grilla actual?')) {
                ASPxClientUtils.DeleteCookie("Administration_Roles_Detail_Grid_Layout");<%-- *** WARNING SET THE SAME VALUE OF SettingsCookies-CookiesID OF GRID *** --%>
                targetGrid.Refresh();
                window.location.reload();
            }
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
    </script>
    <style type="text/css">
        .tab-pane {
            padding: 5px !important;
        }

        .wrapper1, .wrapper2 {
            width: 100% !important;
            border: none 0 RED !important;
            overflow-x: scroll !important;
            overflow-y: hidden !important;
        }

        .wrapper1 {
            height: 20px !important;
        }

        .wrapper2 {
        }

        .div1 {
            width: 20000px !important;
            height: 20px !important;
        }

        .div2 {
            width: 20000px !important;
            overflow: auto !important;
        }

        .tab-content {
            width: 100% !important;
        }

        .form-group {
            border-bottom: 1px dotted #F2F4F6 !important;
            margin-bottom: 5px !important;
            padding-bottom: 5px !important;
            padding-left: 25px !important;
            width: 90% !important;
        }

            .form-group table {
                /*width: 90% !important;*/
            }

            .form-group .form-control {
                width: 90% !important;
                min-width: 200px !important;
            }

            .form-group .dxeErrorFrame_Web4CRM {
                width: 100% !important;
            }

            .form-group .dxeControlsCell_Web4CRM {
                width: 90% !important;
                min-width: 100px !important;
            }

            .form-group .dxeErrorCell_Web4CRM {
                width: 90% !important;
            }

        .radio, .checkbox, .radio label, .checkbox label {
            width: 200px !important;
            font-weight: bold !important;
            text-indent: 5px !important;
            vertical-align: middle !important;
        }

        .label.label-success a, .label.label-default a {
            color: #FFF !important;
            font-weight: bold !important;
            font-size: 14px !important;
            text-decoration: none !important;
        }

        .label.label-success, .label.label-default {
            padding: 10px !important;
        }

            .label.label-success:hover, .label.label-default:hover {
                background-color: #EF643C !important;
            }

        .dropdown-header {
            font-style: italic !important;
            color: #428BCA !important;
        }

        .dxgvDetailCell_Web4CRM,
        .dxgvPreviewRow_Web4CRM td.dxgv,
        .dxgvEmptyDataRow_Web4CRM td.dxgv {
            padding: 0 !important;
        }

        .dxgvDetailCell_Web4CRM {
            padding: 0 !important;
        }

        .dxgvDetailRow_Web4CRM td.dxgvIndentCell {
            padding-right: 0 !important;
        }

        .dxgvIndentCell .dxgv {
            padding: 0 !important;
        }

        .editForm {
            width: 600px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHeader" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentMain" runat="Server">
    <div>
        <div>
            <dx:ASPxGridView ID="ASPxGridView1" ClientInstanceName="grid" runat="server" EnableViewState="true" EnableRowsCache="true"
                Width="1000" Settings-ColumnMinWidth="40" Styles-AlternatingRow-Enabled="True"
                Settings-HorizontalScrollBarMode="Hidden"
                Settings-VerticalScrollBarMode="Hidden"
                EnablePagingCallbackAnimation="False" EnableCallbackAnimation="False"
                DataSourceID="masterDataSource"
                KeyFieldName="UserRolId"
                SettingsCookies-CookiesID="Administration_Roles_Grid_Layout"
                OnHtmlRowPrepared="grid_HtmlRowPrepared"
                OnRowValidating="grid_RowValidating"
                OnStartRowEditing="grid_StartRowEditing"
                OnRowUpdating="ASPxGridView1_RowUpdating"
                OnParseValue="grid_ParseValue"
                OnRowDeleted="ASPxGridView1_RowDeleted"
                OnRowInserted="ASPxGridView1_RowInserted"
                OnRowUpdated="ASPxGridView1_RowUpdated"
                OnDataBinding="ASPxGridView1_DataBinding"
                OnRowInserting="ASPxGridView1_RowInserting"
                OnDetailRowExpandedChanged="ASPxGridView1_DetailRowExpandedChanged"
                OnCustomCallback="ASPxGridView1_CustomCallback"
                OnCellEditorInitialize="ASPxGridView1_CellEditorInitialize">
                <SettingsText Title="Usuarios" />
                <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True"
                    ShowFooter="True" ShowGroupPanel="True" ShowTitlePanel="False" ShowColumnHeaders="True" ShowGroupButtons="True" />
                <SettingsBehavior ConfirmDelete="True" EnableRowHotTrack="True" ColumnResizeMode="Control"
                    AllowDragDrop="True" AllowFocusedRow="True" AllowGroup="True" AllowSort="True" />
                <SettingsLoadingPanel ImagePosition="Left" />
                <SettingsPager PageSize="5" Position="Bottom"></SettingsPager>
                <SettingsEditing Mode="EditForm" EditFormColumnCount="1" />
                <%-- <SettingsPopup EditForm-Height="90%" EditForm-Width="90%" EditForm-AllowResize="true" EditForm-ShowHeader="True" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter"></SettingsPopup> --%>
                <SettingsCookies Enabled="True" StoreControlWidth="True" />
                <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="False"></SettingsDetail>
                <%-- <ClientSideEvents DetailRowExpanding="function(s, e) {
        gridFocusedIndex = e.visibleIndex;
}" /> --%>
                <Styles>
                    <AlternatingRow Enabled="True" CssClass="gridDataRowAlt"></AlternatingRow>
                    <RowHotTrack CssClass="gridDataHover"></RowHotTrack>
                    <EditForm CssClass="editForm"></EditForm>
                    <EditFormTable CssClass="editForm"></EditFormTable>
                </Styles>


                <SettingsSearchPanel Visible="true" HighlightResults="true" ShowApplyButton="true" ShowClearButton="true" AllowTextInputTimer="false"
                    Delay="3000" ColumnNames="UserRolName,DisplayName" />


                <Columns>
                    <dx:GridViewDataColumn Caption="#" FieldName="UserRolId" Visible="true" Width="90"
                        VisibleIndex="0" Settings-AllowAutoFilter="False" Settings-AllowAutoFilterTextInputTimer="False" Settings-AllowGroup="False"
                        Settings-AllowDragDrop="False" Settings-AllowHeaderFilter="False" Settings-AllowSort="False" Settings-ShowFilterRowMenu="False"
                        Settings-ShowFilterRowMenuLikeItem="False" Settings-ShowInFilterControl="False">
                        <EditFormSettings Visible="False"></EditFormSettings>
                        <DataItemTemplate>
                            <div class="btn-toolbar">
                                <div class="btn-group btn-group-sm">
                                    <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Update) %>" onclick="grid.StartEditRowByKey(<%# Eval("UserRolId")  %>);">
                                        <span class="fa fa-edit"></span>
                                    </button>
                                    <%-- 
                                    <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Delete) %>" onclick="gridDeleteRow(grid, <%#Eval("UserRolId") %>);">
                                        <span class="fa fa-times-circle"></span>
                                    </button>--%>
                                </div>
                            </div>
                        </DataItemTemplate>
                        <HeaderTemplate>
                            <div class="btn-toolbar">
                                <div class="btn-group btn-group-sm">
                                    <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Insert) %>" onclick="grid.AddNewRow();">
                                        <span class="fa fa-file"></span>
                                    </button>
                                    <button type="button" class="btn btn-default" onclick="ResetGrid(grid);">
                                        <span class="fa fa-th-list"></span>
                                    </button>
                                </div>
                            </div>
                        </HeaderTemplate>
                    </dx:GridViewDataColumn>

                    <dx:GridViewDataTextColumn Caption="Id" FieldName="UserRolId" Visible="false"
                        EditFormCaptionStyle-CssClass="control-label" PropertiesTextEdit-DisplayFormatString="n0"
                        VisibleIndex="0" ReadOnly="True">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <EditItemTemplate>
                            <fieldset disabled>
                                <dx:ASPxTextBox runat="server" ID="UserRolId" ReadOnly="true" CssClass="form-control" Text='<%# Bind("UserRolId")%>' NullText="0" Native="true"></dx:ASPxTextBox>
                            </fieldset>
                        </EditItemTemplate>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Nombre" FieldName="UserRolName"
                        EditFormCaptionStyle-CssClass="control-label"
                        VisibleIndex="0">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <PropertiesTextEdit MaxLength="60" Native="True" Style-CssClass="form-control">
                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorFrameStyle-CssClass="alert-warning">
                                <RequiredField IsRequired="True" ErrorText="Nombre es requerido" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Nombre Mostrar" FieldName="DisplayName"
                        EditFormCaptionStyle-CssClass="control-label"
                        VisibleIndex="0">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <PropertiesTextEdit MaxLength="60" Native="True" Style-CssClass="form-control">
                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorFrameStyle-CssClass="alert-warning">
                                <RequiredField IsRequired="True" ErrorText="Nombre Mostrar es requerido" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Orden Mostrar" FieldName="DisplayOrder"
                        EditFormCaptionStyle-CssClass="control-label"
                        VisibleIndex="0">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <PropertiesTextEdit MaxLength="60" Native="True" Style-CssClass="form-control">
                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorFrameStyle-CssClass="alert-warning">
                                <RequiredField IsRequired="True" ErrorText="Orden Mostrares requerido" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataCheckColumn Caption="Mostrar" FieldName="DisplayActive" VisibleIndex="0"></dx:GridViewDataCheckColumn>

                </Columns>
                <GroupSummary>
                    <dx:ASPxSummaryItem FieldName="UserRolId" SummaryType="Count" DisplayFormat="{0:n0}" />
                </GroupSummary>
                <TotalSummary>
                    <dx:ASPxSummaryItem FieldName="UserRolId" SummaryType="Count" DisplayFormat="{0:n0}" />
                </TotalSummary>
                <Templates>
                    <EmptyDataRow>
                        <div class="alert alert-warning" role="alert">No existen registros.</div>
                    </EmptyDataRow>
                    <EditForm>
                        <div class="form-group">
                            <dx:ContentControl ID="ContentControl1" runat="server">
                                <dx:ASPxGridViewTemplateReplacement ID="Editors" ReplacementType="EditFormEditors"
                                    runat="server"></dx:ASPxGridViewTemplateReplacement>
                            </dx:ContentControl>
                        </div>
                        <hr />
                        <div class="form-group">
                            <dx:ASPxValidationSummary ID="ASPxValidationSummary1" runat="server" RenderMode="OrderedList" ShowErrorsInEditors="True"
                                HeaderText="Errores en el Formulario a Corregir" CssClass="panel panel-danger" HeaderStyle-CssClass="panel-heading panel-danger"
                                ValidationGroup='<%# Container.ValidationGroup %>' />
                            <span class="label label-success">
                                <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                            </span>
                            &nbsp;|&nbsp; 
                                        <span class="label label-default">
                                            <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                        </span>
                        </div>
                    </EditForm>
                    <DetailRow>
                        <span class="label label-default pull-left">&nbsp;Permisos Para Usuario <%# Eval("DisplayName")  %>&nbsp;(<%# Eval("UserRolId")  %>)
                        </span>
                        <div class="btn-toolbar">
                            <div class="btn-group btn-group-sm">
                                <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Insert) %>" onclick="detailGrid<%# Eval("UserRolId")  %>.AddNewRow();">
                                    <span class="fa fa-file"></span>
                                </button>
                                <button type="button" class="btn btn-default" onclick="ResetGrid(detailGrid<%# Eval("UserRolId")  %>);">
                                    <span class="fa fa-th-list"></span>
                                </button>
                            </div>
                        </div>

                        <dx:ASPxGridView ID="ASPxGridView1Detail" runat="server"
                            DataSourceID="detailDataSource"
                            KeyFieldName="UserRolPerId"
                            SettingsCookies-CookiesID="Administration_Roles_Detail_Grid_Layout"
                            Width="600"
                            OnInit="ASPxGridView1Detail_Init"
                            OnLoad="ASPxGridView1Detail_Load"
                            OnBeforePerformDataSelect="ASPxGridView1Detail_BeforePerformDataSelect"
                            OnRowInserting="ASPxGridView1Detail_RowInserting"
                            OnRowInserted="ASPxGridView1Detail_RowInserted"
                            OnRowUpdating="ASPxGridView1Detail_RowUpdating"
                            OnRowUpdated="ASPxGridView1Detail_RowUpdated"
                            OnParseValue="ASPxGridView1Detail_ParseValue">
                            <SettingsText Title="Permisos" />
                            <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True"
                                ShowFooter="True" ShowGroupPanel="True" ShowTitlePanel="False" ShowColumnHeaders="True" ShowGroupButtons="True" />
                            <SettingsBehavior ConfirmDelete="True" EnableRowHotTrack="True" ColumnResizeMode="Control"
                                AllowDragDrop="True" AllowFocusedRow="True" AllowGroup="True" AllowSort="True" />
                            <SettingsLoadingPanel ImagePosition="Left" />
                            <SettingsPager PageSize="5" Position="Bottom"></SettingsPager>
                            <SettingsEditing Mode="EditForm" EditFormColumnCount="1" />
                            <%-- <SettingsPopup EditForm-Height="90%" EditForm-Width="90%" EditForm-AllowResize="true" EditForm-ShowHeader="True" EditForm-VerticalAlign="WindowCenter" EditForm-HorizontalAlign="WindowCenter"></SettingsPopup> --%>
                            <SettingsCookies Enabled="True" StoreControlWidth="True" />
                            <%-- <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="False"></SettingsDetail> --%>
                            <ClientSideEvents EndCallback="detailGridOnEndCallback" BeginCallback="detailGridOnBeginCallback" />

                            <Styles>
                                <AlternatingRow Enabled="True" CssClass="gridDataRowAlt"></AlternatingRow>
                                <RowHotTrack CssClass="gridDataHover"></RowHotTrack>
                                <EditForm CssClass="editForm"></EditForm>
                                <EditFormTable CssClass="editForm"></EditFormTable>
                            </Styles>

                            <Columns>
                                <dx:GridViewDataColumn Caption="#" FieldName="UserPerId" Visible="true" Width="90"
                                    VisibleIndex="0" Settings-AllowAutoFilter="False" Settings-AllowAutoFilterTextInputTimer="False" Settings-AllowGroup="False"
                                    Settings-AllowDragDrop="False" Settings-AllowHeaderFilter="False" Settings-AllowSort="False" Settings-ShowFilterRowMenu="False"
                                    Settings-ShowFilterRowMenuLikeItem="False" Settings-ShowInFilterControl="False">
                                    <EditFormSettings Visible="False"></EditFormSettings>
                                    <DataItemTemplate>
                                        <div class="btn-toolbar">
                                            <div class="btn-group btn-group-sm">
                                                <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Update) %>" onclick="detailGrid<%# Eval("UserRolId")  %>.StartEditRowByKey(<%# Eval("UserRolPerId")  %>);">
                                                    <span class="fa fa-edit"></span>
                                                </button>
                                                <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Delete) %>" onclick="gridDeleteRow(detailGrid<%#Eval("UserRolId") %>, <%#Eval("UserRolPerId") %>);">
                                                    <span class="fa fa-times-circle"></span>
                                                </button>
                                            </div>
                                        </div>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>

                                <dx:GridViewDataTextColumn Caption="Id" FieldName="UserRolPerId" Visible="false"
                                    EditFormCaptionStyle-CssClass="control-label" PropertiesTextEdit-DisplayFormatString="n0"
                                    VisibleIndex="0" ReadOnly="True">
                                    <EditFormSettings Visible="True"></EditFormSettings>
                                    <EditItemTemplate>
                                        <fieldset disabled>
                                            <dx:ASPxTextBox runat="server" ID="UserRolPerId" ReadOnly="true" CssClass="form-control" Text='<%# Bind("UserRolPerId")%>' NullText="0" Native="true"></dx:ASPxTextBox>
                                        </fieldset>
                                    </EditItemTemplate>
                                </dx:GridViewDataTextColumn>

                                <dx:GridViewDataComboBoxColumn Caption="Categoria" FieldName="UserPerCatId"
                                    EditFormCaptionStyle-CssClass="control-label"
                                    VisibleIndex="0">
                                    <PropertiesComboBox IncrementalFilteringMode="StartsWith" EnableSynchronization="False"
                                        DataSourceID="SqlDataSourceCbPermissionCategory" ValueType="System.Int32" TextField="DisplayName"
                                        ValueField="UserPerCatId">
                                    </PropertiesComboBox>
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataComboBoxColumn>

                                <dx:GridViewDataTextColumn Caption="Permiso" FieldName="PermissionDisplayName" VisibleIndex="0">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>

                                <dx:GridViewDataCheckColumn Caption="Permitido" FieldName="UserRolPermission" VisibleIndex="0"></dx:GridViewDataCheckColumn>
                            </Columns>
                            <GroupSummary>
                                <dx:ASPxSummaryItem FieldName="PermissionDisplayName" SummaryType="Count" DisplayFormat="{0:n0}" />
                            </GroupSummary>
                            <TotalSummary>
                                <dx:ASPxSummaryItem FieldName="PermissionDisplayName" SummaryType="Count" DisplayFormat="{0:n0}" />
                            </TotalSummary>
                            <Templates>
                                <EmptyDataRow>
                                    <div class="alert alert-warning" role="alert">No existen registros.</div>
                                </EmptyDataRow>
                                <EditForm>
                                    <div class="form-group">
                                        <dx:ContentControl ID="ContentControl1" runat="server">
                                            <dx:ASPxGridViewTemplateReplacement ID="Editors" ReplacementType="EditFormEditors"
                                                runat="server"></dx:ASPxGridViewTemplateReplacement>
                                        </dx:ContentControl>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">Buscar Permiso</label>
                                        <dx:ASPxComboBox ID="CBUserPermissionType" runat="server" EnableCallbackMode="True" CallbackPageSize="20"
                                            DataSourceID="SqlDataSourceUserPermissionType"
                                            IncrementalFilteringMode="Contains" ValueType="System.Int32" ValueField="UserPerTypeId"
                                            TextFormatString="{0} | {1}" ValidationSettings-ValidationGroup="<%# Container.ValidationGroup %>"
                                            Width="700px" DropDownStyle="DropDown" IncrementalFilteringDelay="500" FilterMinLength="4"
                                            OnItemRequestedByValue="CBUserPermissionType_ItemRequestedByValue"
                                            OnItemsRequestedByFilterCondition="CBUserPermissionType_ItemsRequestedByFilterCondition"
                                            Value='<%# Bind("UserPerTypeId")%>'>
                                            <Columns>
                                                <dx:ListBoxColumn Caption="Categoría" FieldName="CatDisplayName" Width="40%" />
                                                <dx:ListBoxColumn Caption="Permiso" FieldName="DisplayName" Width="60%" />
                                            </Columns>
                                            <ValidationSettings>
                                                <RequiredField IsRequired="true" ErrorText="Permiso es requerido" />
                                            </ValidationSettings>
                                        </dx:ASPxComboBox>
                                        <span class="help-block">Busqueda por Categoría y Nombre Permiso, puede utilizar * para finalizar una palabra.</span>
                                    </div>
                                    <hr />
                                    <div class="form-group">
                                        <dx:ASPxValidationSummary ID="ASPxValidationSummary1" runat="server" RenderMode="OrderedList" ShowErrorsInEditors="True"
                                            HeaderText="Errores en el Formulario a Corregir" CssClass="panel panel-danger" HeaderStyle-CssClass="panel-heading panel-danger"
                                            ValidationGroup='<%# Container.ValidationGroup %>' />
                                        <span class="label label-success">
                                            <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server" />
                                        </span>
                                        &nbsp;|&nbsp; 
                                        <span class="label label-default">
                                            <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server" />
                                        </span>
                                    </div>
                                </EditForm>
                            </Templates>
                        </dx:ASPxGridView>
                    </DetailRow>
                </Templates>
            </dx:ASPxGridView>
        </div>
    </div>

    <asp:SqlDataSource ID="masterDataSource" runat="server" OnSelecting="DBMainDataSources_Selecting" OnInit="DBMainDataSources_Init"
        EnableCaching="True" CacheDuration="60"
        CacheExpirationPolicy="Sliding"
        SelectCommand="
-- SET IN CODEBEHIND
"
        UpdateCommand="
IF(SELECT COUNT(*) FROM dbo.UserRol WHERE  UserRolId != @UserRolId 
AND (UserRolName = @UserRolName OR DisplayName = @DisplayName)  
) = 0
BEGIN
UPDATE dbo.UserRol
   SET 
       UserRolName = @UserRolName
      ,DisplayName = @DisplayName
      ,DisplayOrder = @DisplayOrder
      ,DisplayActive = @DisplayActive
 WHERE 
 UserRolId = @UserRolId
 ;
 END
 ;
 "
        InsertCommand="
IF(SELECT COUNT(*) FROM dbo.UserRol WHERE  (UserRolName = @UserRolName OR DisplayName = @DisplayName)  
) = 0
BEGIN
INSERT INTO [dbo].[UserRol]
           (
            [UserRolId]
           ,[UserRolName]
           ,[DisplayName]
           ,[DisplayOrder]
           ,[DisplayActive]
           ,[SystemRol]
           )
SELECT
            newrolid = (SELECT MAX([UserRolId]) + 1 FROM [dbo].[UserRol] ) -- int
           ,@UserRolName -- nvarchar(60)
           ,@DisplayName -- nvarchar(60)
           ,@DisplayOrder -- int
           ,@DisplayActive -- bit
           ,0 -- bit
;                	
END				
        "
        DeleteCommand="
DELETE FROM [dbo].[UserRolPermission]
WHERE
UserRolId = @UserRolId
;

DELETE FROM [dbo].[UserRol]
WHERE 
UserRolId = @UserRolId
AND
SystemRol = 0 -- no del sysadmin role
AND
UserRolId &gt; 3 -- prevent del default roles
;
        ">
        <SelectParameters>
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="UserRolName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DisplayName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DisplayOrder" DbType="Int32" />
            <asp:Parameter Name="DisplayActive" DbType="Boolean" />

        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserRolId" DbType="Int32" />

            <asp:Parameter Name="UserRolName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DisplayName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DisplayOrder" DbType="Int32" />
            <asp:Parameter Name="DisplayActive" DbType="Boolean" />

        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserRolId" DbType="Int32" />
        </DeleteParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="detailDataSource" runat="server" OnSelecting="DBMainDataSources_Selecting" OnInit="DBMainDataSources_Init"
        EnableCaching="true" CacheDuration="60"
        CacheExpirationPolicy="Sliding"
        SelectCommand="
SELECT P.UserRolPerId
      ,P.UserRolId
      ,P.UserPerTypeId
      ,P.UserRolPermission
      ,T.DisplayName PermissionDisplayName
      ,C.UserPerCatId
      ,C.UserPerCatName
      ,C.DisplayName CategoryDisplayName
  FROM dbo.UserRolPermission P
INNER JOIN dbo.UserPermissionType T ON P.UserPerTypeId = T.UserPerTypeId
INNER JOIN dbo.UserPermissionCategory C ON T.UserPerCatName = C.UserPerCatName 
WHERE
UserRolId = @UserRolId 
;
"
        InsertCommand="
IF( SELECT COUNT(*) FROM UserRolPermission WHERE UserRolId = @UserRolId AND UserPerTypeId = @UserPerTypeId  ) = 0
BEGIN
INSERT INTO [dbo].[UserRolPermission]
           ([UserRolId]
           ,[UserPerTypeId]
           ,[UserRolPermission])
SELECT
            @UserRolId --, int
           ,@UserPerTypeId --, int
           ,@UserRolPermission --, bit
;
END;
"
        UpdateCommand="
UPDATE [dbo].[UserRolPermission]
   SET 
     --[UserPerTypeId] = @UserPerTypeId --int
     [UserRolPermission] = @UserRolPermission --bit
 WHERE 
    UserRolPerId = @UserRolPerId
;
"
        DeleteCommand="
DELETE FROM [dbo].[UserPermission]
      WHERE
    UserRolPerId = @UserRolPerId
                ">
        <SelectParameters>
            <asp:Parameter Name="UserRolId" DbType="Int32" DefaultValue="-1" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="UserRolId" DbType="Int32" />
            <asp:Parameter Name="UserPerTypeId" DbType="Int32" />
            <asp:Parameter Name="UserRolPermission" DbType="Boolean" DefaultValue="False" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserRolPermission" DbType="Boolean" DefaultValue="True" />
            <asp:Parameter Name="UserRolPerId" DbType="Int32" DefaultValue="-1" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserRolPerId" DbType="Int32" DefaultValue="-1" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCbRoles" runat="server" EnableCaching="true" CacheDuration="60" CacheExpirationPolicy="Sliding"
        SelectCommand="
SELECT [UserRolId]
      --,[UserRolName]
      ,[DisplayName]
      --,[DisplayOrder]
      --,[DisplayActive]
  FROM [dbo].[UserRol]
WHERE
DisplayActive = 1
ORDER BY DisplayOrder, DisplayName         
"
        OnInit="DBMainDataSources_Init"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceCbPermissionCategory" runat="server" EnableCaching="true" CacheDuration="60" CacheExpirationPolicy="Sliding"
        SelectCommand="
SELECT [UserPerCatId]
      --,[UserPerCatName]
      ,[DisplayName]
      --,[UserPerCatDescription]
      --,[DisplayOrder]
      --,[DisplayActive]
  FROM [dbo].[UserPermissionCategory]
WHERE
DisplayActive = 1
ORDER BY DisplayOrder, DisplayName         
"
        OnInit="DBMainDataSources_Init"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUserPermissionType" runat="server" EnableCaching="true" CacheDuration="60" CacheExpirationPolicy="Sliding"
        SelectCommand="
SELECT U.[UserPerTypeId]
      --,U.[UserPerTypeName]
      --,U.[UserPerCatName]
      ,U.[DisplayName]
      --,U.[UserPerTypeDescription]
      --,U.[EnumName]
      --,U.[DisplayOrder]
      --,U.[DisplayActive]
        ,C.DisplayName as CatDisplayName
  FROM [dbo].[UserPermissionType] U
  INNER JOIN  [dbo].[UserPermissionCategory] C
  ON U.UserPerCatName = C.UserPerCatName
  WHERE
  U.[DisplayActive] = 1
  AND
( 
U.[DisplayName] LIKE @search
OR 
C.DisplayName LIKE @search
)
ORDER BY U.[DisplayOrder], U.[DisplayName]          
"
        OnInit="DBMainDataSources_Init">
        <SelectParameters>
            <asp:Parameter Name="search" DbType="AnsiString" Size="60" DefaultValue="%" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentFooter" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentBottom" runat="Server">
</asp:Content>

