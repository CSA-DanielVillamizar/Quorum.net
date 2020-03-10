<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Root.master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" 
    Inherits="QuorumWeb.Views.Admin.Users" %>

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
                ASPxClientUtils.DeleteCookie("Administration_Users_Grid_Layout");<%-- *** WARNING SET THE SAME VALUE OF SettingsCookies-CookiesID OF GRID *** --%>
                targetGrid.Refresh();
                window.location.reload();
            }
        }
        function ResetDetGrid(targetGrid) {
            if (confirm('¿Esta seguro de RESETEAR el diseño de la grilla actual?')) {
                ASPxClientUtils.DeleteCookie("Administration_Users_Detail_Grid_Layout");<%-- *** WARNING SET THE SAME VALUE OF SettingsCookies-CookiesID OF GRID *** --%>
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
        function sPopup(userId, table) {
            var spage = "UsersDataFilter.aspx?time=" + new Date().getTime() + "&userId=" + userId + "&table=" + table;
            showPopupMasterModal('Edicion Filtros', spage, 800, 600);
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
                Width="1600" Settings-ColumnMinWidth="40" Styles-AlternatingRow-Enabled="True"
                Settings-HorizontalScrollBarMode="Hidden"
                Settings-VerticalScrollBarMode="Hidden"
                EnablePagingCallbackAnimation="False" EnableCallbackAnimation="False"
                DataSourceID="masterDataSource"
                KeyFieldName="UserId"
                SettingsCookies-CookiesID="Administration_Users_Grid_Layout"
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

                <StylesEditors>
                </StylesEditors>


                <SettingsSearchPanel Visible="true" HighlightResults="true" ShowApplyButton="true" ShowClearButton="true" AllowTextInputTimer="false"
                    Delay="3000" ColumnNames="UserLogin,UserEmail,UserFirstName,UserLastName,DisplayName" />


                <Columns>
                    <dx:GridViewDataColumn Caption="#" FieldName="UserId" Visible="true" Width="90"
                        VisibleIndex="0" Settings-AllowAutoFilter="False" Settings-AllowAutoFilterTextInputTimer="False" Settings-AllowGroup="False"
                        Settings-AllowDragDrop="False" Settings-AllowHeaderFilter="False" Settings-AllowSort="False" Settings-ShowFilterRowMenu="False"
                        Settings-ShowFilterRowMenuLikeItem="False" Settings-ShowInFilterControl="False">
                        <EditFormSettings Visible="False"></EditFormSettings>
                        <DataItemTemplate>
                            <div class="btn-toolbar">
                                <div class="btn-group btn-group-sm">
                                    <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Update) %>" onclick="grid.StartEditRowByKey(<%# Eval("UserId")  %>);">
                                        <span class="fa fa-edit"></span>
                                    </button>
                                    <%-- 
                                    <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Delete) %>" onclick="gridDeleteRow(grid, <%#Eval("UserId") %>);">
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

                    <dx:GridViewDataTextColumn Caption="Id" FieldName="UserId" Visible="false"
                        EditFormCaptionStyle-CssClass="control-label" PropertiesTextEdit-DisplayFormatString="n0"
                        VisibleIndex="0" ReadOnly="True">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <EditItemTemplate>
                            <fieldset disabled>
                                <dx:ASPxTextBox runat="server" ID="UserId" ReadOnly="true" CssClass="form-control" Text='<%# Bind("UserId")%>' NullText="0" Native="true"></dx:ASPxTextBox>
                            </fieldset>
                        </EditItemTemplate>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Usuario" FieldName="UserLogin"
                        EditFormCaptionStyle-CssClass="control-label"
                        VisibleIndex="0">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <PropertiesTextEdit MaxLength="128" Native="True" Style-CssClass="form-control">
                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ValidationGroup="ValidateForm"
                                ErrorFrameStyle-CssClass="alert-warning" CausesValidation="True">
                                <RequiredField IsRequired="True" ErrorText="Usuario es requerido" />
                                <RegularExpression ErrorText="Email no válido." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Email" FieldName="UserEmail"
                        EditFormCaptionStyle-CssClass="control-label"
                        VisibleIndex="0">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <PropertiesTextEdit MaxLength="128" Native="True" Style-CssClass="form-control">
                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorFrameStyle-CssClass="alert-warning">
                                <RequiredField IsRequired="True" ErrorText="Email es requerido" />
                                <RegularExpression ErrorText="Email no válido." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Nombres" FieldName="UserFirstName"
                        EditFormCaptionStyle-CssClass="control-label"
                        VisibleIndex="0">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <PropertiesTextEdit MaxLength="60" Native="True" Style-CssClass="form-control">
                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorFrameStyle-CssClass="alert-warning">
                                <RequiredField IsRequired="True" ErrorText="Nombres es requerido" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Apellidos" FieldName="UserLastName" Visible="true"
                        EditFormCaptionStyle-CssClass="control-label"
                        VisibleIndex="0">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <PropertiesTextEdit MaxLength="60" Native="True" Style-CssClass="form-control">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataComboBoxColumn Caption="Rol" FieldName="UserRolId"
                        EditFormCaptionStyle-CssClass="control-label"
                        VisibleIndex="0">
                        <PropertiesComboBox IncrementalFilteringMode="StartsWith" EnableSynchronization="False"
                            DataSourceID="SqlDataSourceCbRoles" ValueType="System.Int32" TextField="DisplayName"
                            ValueField="UserRolId">
                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorFrameStyle-CssClass="alert-warning">
                                <RequiredField IsRequired="True" ErrorText="Rol es requerido" />
                            </ValidationSettings>
                        </PropertiesComboBox>
                    </dx:GridViewDataComboBoxColumn>

                    <dx:GridViewDataTextColumn Caption="Nombre Mostrar" FieldName="DisplayName" Visible="true"
                        EditFormCaptionStyle-CssClass="control-label"
                        VisibleIndex="0">
                        <EditFormSettings Visible="True"></EditFormSettings>
                        <PropertiesTextEdit MaxLength="60" Native="True" Style-CssClass="form-control">
                            <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithText" ErrorFrameStyle-CssClass="alert-warning">
                                <RequiredField IsRequired="True" ErrorText="Nombre Mostrar es requerido" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataCheckColumn Caption="Activo" FieldName="UserActive" VisibleIndex="0"></dx:GridViewDataCheckColumn>
                    <dx:GridViewDataCheckColumn Caption="Suspendido" FieldName="UserBanned" VisibleIndex="0"></dx:GridViewDataCheckColumn>


                    <%-- 
                    <dx:GridViewDataColumn Caption="#" VisibleIndex="2" Width="40">
                        <EditFormSettings Visible="False"></EditFormSettings>
                        <DataItemTemplate>
                            <a href="javascript:sPopup(<%# Eval("UserId") %>, 'pdv')">
                                <img src="<%# ResolveClientUrl("~/Content/Icons/icon_filter.gif") %>" alt="Filtro" /></a>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>

                    <dx:GridViewDataMemoColumn FieldName="UserQueriesFilterDataPOS" Width="300"
                        Visible="True" VisibleIndex="2">
                        <EditFormSettings Visible="false" />
                        <HeaderCaptionTemplate>
                            <div>Filtro Consultas</div>
                            <div>Tabla Punto Venta</div>
                        </HeaderCaptionTemplate>
                    </dx:GridViewDataMemoColumn>

                    
                    <dx:GridViewDataColumn Caption="#" VisibleIndex="2" Width="40">
                        <EditFormSettings Visible="False"></EditFormSettings>
                        <DataItemTemplate>
                            <a href="javascript:sPopup(<%# Eval("UserId") %>, 'sales')">
                                <img src="<%# ResolveClientUrl("~/Content/Icons/icon_filter.gif") %>" alt="Filtro" /></a>
                        </DataItemTemplate>
                    </dx:GridViewDataColumn>

                    <dx:GridViewDataMemoColumn FieldName="UserQueriesFilterDataSales" Width="300"
                        Visible="True" VisibleIndex="2">
                        <EditFormSettings Visible="false" />
                        <HeaderCaptionTemplate>
                            <div>Filtro Consultas</div>
                            <div>Tabla Ventas</div>
                        </HeaderCaptionTemplate>
                    </dx:GridViewDataMemoColumn>
                    --%>
                </Columns>
                <GroupSummary>
                    <dx:ASPxSummaryItem FieldName="UserLogin" SummaryType="Count" DisplayFormat="{0:n0}" />
                    <dx:ASPxSummaryItem FieldName="UserRolId" SummaryType="Count" DisplayFormat="{0:n0}" />
                </GroupSummary>
                <TotalSummary>
                    <dx:ASPxSummaryItem FieldName="UserLogin" SummaryType="Count" DisplayFormat="{0:n0}" />
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
                            <label class="control-label">Contraseña</label>
                            <dx:ASPxTextBox ID="UserPass" runat="server" Text='<%# Bind("UserPass") %>' Native="true" CssClass="form-control" NullText="Escriba para asignar nueva contraseña"
                                Password="True" MaxLength="20" ValidationSettings-ValidationGroup="ValidateForm">
                                <ValidationSettings CausesValidation="True" Display="Dynamic" ErrorFrameStyle-CssClass="alert-warning">
                                    <RegularExpression ErrorText="La contraseña debe de contener al menos 8 caracteres con letras y números y combinar mayusculas y minusculas."
                                        ValidationExpression="^(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$" />
                                </ValidationSettings>
                            </dx:ASPxTextBox>
                            <p class="help-block">
                                Deje en blanco para no actualizar.  La contraseña debe de contener al menos 8 caracteres con letras y números y combinar
                                mayúsculas y minúsculas.
                            </p>
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

                        <span class="label label-default pull-left">&nbsp;Permisos Para Usuario <%# Eval("DisplayName")  %>&nbsp;(<%# Eval("UserId")  %>)
                        </span>
                        <div class="btn-toolbar">
                            <div class="btn-group btn-group-sm">
                                <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Insert) %>" onclick="detailGrid<%# Eval("UserId")  %>.AddNewRow();">
                                    <span class="fa fa-file"></span>
                                </button>
                                <button type="button" class="btn btn-default" onclick="ResetGrid(detailGrid<%# Eval("UserId")  %>);">
                                    <span class="fa fa-th-list"></span>
                                </button>
                            </div>
                        </div>

                        <dx:ASPxGridView ID="ASPxGridView1Detail" runat="server"
                            DataSourceID="detailDataSource"
                            KeyFieldName="UserPerId"
                            SettingsCookies-CookiesID="Administration_Users_Detail_Grid_Layout"
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
                                                <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Update) %>" onclick="detailGrid<%# Eval("UserId")  %>.StartEditRowByKey(<%# Eval("UserPerId")  %>);">
                                                    <span class="fa fa-edit"></span>
                                                </button>
                                                <button type="button" class="btn btn-default <%# SecurityGetDisableClass(UserActionsEnum.Delete) %>" onclick="gridDeleteRow(detailGrid<%#Eval("UserId") %>, <%#Eval("UserPerId") %>);">
                                                    <span class="fa fa-times-circle"></span>
                                                </button>
                                            </div>
                                        </div>
                                    </DataItemTemplate>
                                </dx:GridViewDataColumn>

                                <dx:GridViewDataTextColumn Caption="Id" FieldName="UserPerId" Visible="false"
                                    EditFormCaptionStyle-CssClass="control-label" PropertiesTextEdit-DisplayFormatString="n0"
                                    VisibleIndex="0" ReadOnly="True">
                                    <EditFormSettings Visible="True"></EditFormSettings>
                                    <EditItemTemplate>
                                        <fieldset disabled>
                                            <dx:ASPxTextBox runat="server" ID="UserId" ReadOnly="true" CssClass="form-control" Text='<%# Bind("UserPerId")%>' NullText="0" Native="true"></dx:ASPxTextBox>
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

                                <dx:GridViewDataCheckColumn Caption="Permitido" FieldName="UserPermission" VisibleIndex="0"></dx:GridViewDataCheckColumn>
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
UPDATE [dbo].[User] SET	
                 [UserLogin] = @UserLogin --nvarchar(128)
                ,[UserPass] = ISNULL(NULLIF(@UserPass, ''), UserPass) --nvarchar(255)
                ,[UserEmail] =  @UserEmail --nvarchar(128)
                ,[UserFirstName] = @UserFirstName --nvarchar(60)
                ,[UserLastName] = @UserLastName --nvarchar(60)
                ,[UserRolId] = @UserRolId --int
                ,DisplayName = @DisplayName -- nvarchar(60)
                ,UserActive = @UserActive -- bit
                ,UserBanned = @UserBanned -- bit
                ,UserUpdatedIn = GETDATE()
                ,UserUpdatedByUserId = @UserUpdatedByUserId -- bit
                ,UserRolName = R.UserRolName
                ,UserRolDisplayName = R.DisplayName
FROM dbo.[User] U
    INNER JOIN dbo.UserRol R ON R.UserRolId = @UserRolId
WHERE 
    UserId = @UserId
 "
        InsertCommand="
    INSERT INTO [dbo].[User]
           (
            [UserLogin]
           ,[UserPass]
           ,[UserEmail]
           ,[UserFirstName]
           ,[UserLastName]
           ,[UserRolId]
           ,[DisplayName]
           ,[UserActive]
           ,UserBanned
           ,[UserCreatedIn]
           ,[UserCreatedByUserId]
           ,R.UserRolName
           ,R.UserRolDisplayName
        )
SELECT
            @UserLogin --nvarchar(128)
           ,@UserPass --nvarchar(255)
           ,@UserEmail --nvarchar(128)
           ,@UserFirstName --nvarchar(60)
           ,@UserLastName --nvarchar(60)
           ,@UserRolId --int
           ,@DisplayName -- nvarchar(60)
           ,@UserActive -- bit
           ,@UserBanned -- bit
           ,GETDATE()  --@UserCreatedIn --datetime
           ,@UserCreatedByUserId -- int
           ,R.UserRolName
           ,R.DisplayName
FROM dbo.UserRol R 
WHERE
R.UserRolId = @UserRolId
                    
;
                
        "
        DeleteCommand="
-- TODO: delete permissions and references...
--	DELETE FROM [dbo].[User]
--	WHERE
--  UserId = @UserId	
        ">
        <SelectParameters>
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="UserLogin" DbType="AnsiString" Size="128" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserPass" DbType="AnsiString" Size="255" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserEmail" DbType="AnsiString" Size="128" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserFirstName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserLastName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserRolId" DbType="Int32" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DisplayName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserActive" DbType="Boolean" DefaultValue="True" />
            <asp:Parameter Name="UserBanned" DbType="Boolean" DefaultValue="False" />
            <asp:SessionParameter Name="UserCreatedByUserId" SessionField="User.UserId" DbType="Int32" ConvertEmptyStringToNull="true" />


        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserLogin" DbType="AnsiString" Size="128" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserPass" DbType="AnsiString" Size="255" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserEmail" DbType="AnsiString" Size="128" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserFirstName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserLastName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserRolId" DbType="Int32" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserId" DbType="Int32" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="DisplayName" DbType="AnsiString" Size="60" ConvertEmptyStringToNull="true" />
            <asp:Parameter Name="UserActive" DbType="Boolean" />
            <asp:Parameter Name="UserBanned" DbType="Boolean" />
            <asp:SessionParameter Name="UserUpdatedByUserId" SessionField="User.UserId" DbType="Int32" ConvertEmptyStringToNull="true" />

        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserId" DbType="Int32" DefaultValue="-1" />
        </DeleteParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="detailDataSource" runat="server" OnSelecting="DBMainDataSources_Selecting" OnInit="DBMainDataSources_Init"
        EnableCaching="true" CacheDuration="60"
        CacheExpirationPolicy="Sliding"
        SelectCommand="
SELECT P.UserPerId
      ,P.UserId
      ,P.UserPerTypeId
      ,P.UserPermission
      ,T.DisplayName PermissionDisplayName
      ,C.UserPerCatId
      ,C.UserPerCatName
      ,C.DisplayName CategoryDisplayName
  FROM dbo.UserPermission P
INNER JOIN dbo.UserPermissionType T ON P.UserPerTypeId = T.UserPerTypeId
INNER JOIN dbo.UserPermissionCategory C ON T.UserPerCatName = C.UserPerCatName  
WHERE
UserId = @UserId 
;
"
        InsertCommand="
IF( SELECT COUNT(*) FROM UserPermission WHERE UserId = @UserId AND UserPerTypeId = @UserPerTypeId  ) = 0
BEGIN
INSERT INTO [dbo].[UserPermission]
           ([UserId]
           ,[UserPerTypeId]
           ,[UserPermission])
SELECT
            @UserId --, int
           ,@UserPerTypeId --, int
           ,@UserPermission --, bit
;
END;
"
        UpdateCommand="
UPDATE [dbo].[UserPermission]
   SET 
     --[UserPerTypeId] = @UserPerTypeId --int
     [UserPermission] = @UserPermission --bit
 WHERE 
    UserPerId = @UserPerId
;
"
        DeleteCommand="
DELETE FROM [dbo].[UserPermission]
      WHERE
    UserPerId = @UserPerId
                ">
        <SelectParameters>
            <asp:Parameter Name="UserId" DbType="Int32" DefaultValue="-1" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="UserId" DbType="Int32" />
            <asp:Parameter Name="UserPerTypeId" DbType="Int32" />
            <asp:Parameter Name="UserPermission" DbType="Boolean" DefaultValue="False" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserPermission" DbType="Boolean" DefaultValue="True" />
            <asp:Parameter Name="UserPerId" DbType="Int32" DefaultValue="-1" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserPerId" DbType="Int32" DefaultValue="-1" />
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

