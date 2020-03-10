using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;
using BINumber_Web.SL;
using BINumber_Web.Enums;
using System.Data;
using System.Data.SqlClient;
using Softcanon.DAL;

namespace QuorumWeb.Views.Admin
{
    public partial class Users : BINumber_Web.UI.PageBaseGrid
    {
        private const string cachePageName = "Users";
        static string TsqlQueryWithOutSearch, TsqlQueryWithSearch;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            base.Page_PreInit(sender, e);
            PageTitle = "Administración Usuarios";


            TsqlQueryWithOutSearch =
           @"
    SELECT 
                 UserId
                ,UserLogin
                ,LEFT(UserPass,0) as UserPass
                ,UserEmail
                ,UserFirstName
                ,UserLastName
                ,UserRolId
                ,DisplayName
                ,UserActive
                ,UserBanned
                ,UserRolDisplayName
                --,UserQueriesFilterDataPOS
                --,UserQueriesFilterDataSales
FROM [User] S
;
";



            TsqlQueryWithSearch =
              @"
EXEC User_Search @Search; 
";


        }


        protected void Page_InitComplete(object sender, EventArgs e)
        {
            if (!Permissions.GetPermission(UserPermissionTypeEnum.BINUMBER_ACCESO_USUARIOS, Session, Global.DAL.GetConnectionStringDBData()))
            {
                Response.Redirect("~/ErrorPermission.html", true);
            }
            SecurityCanInsert = Permissions.GetPermission(UserPermissionTypeEnum.BINUMBER_ACCESO_USUARIOS, Session, Global.DAL.GetConnectionStringDBData());
            SecurityCanUpdate = Permissions.GetPermission(UserPermissionTypeEnum.BINUMBER_ACCESO_USUARIOS, Session, Global.DAL.GetConnectionStringDBData());
            SecurityCanDelete = Permissions.GetPermission(UserPermissionTypeEnum.BINUMBER_ACCESO_USUARIOS, Session, Global.DAL.GetConnectionStringDBData());

            if (!SecurityCanInsert)
            {
                masterDataSource.InsertCommand = string.Empty;
            }
            if (!SecurityCanDelete)
            {
                masterDataSource.DeleteCommand = string.Empty;
            }
            if (!SecurityCanUpdate)
            {
                masterDataSource.UpdateCommand = string.Empty;
            }
            if (!SecurityCanInsert)
            {
                detailDataSource.InsertCommand = string.Empty;
            }
            if (!SecurityCanDelete)
            {
                detailDataSource.DeleteCommand = string.Empty;
            }
            if (!SecurityCanUpdate)
            {
                detailDataSource.UpdateCommand = string.Empty;
            }


            masterDataSource.CacheKeyDependency = cachePageName + ".masterDataSource";
            detailDataSource.CacheKeyDependency = cachePageName + ".detailDataSource";


        }

        protected static bool SecurityCanInsert;
        protected static bool SecurityCanUpdate;
        protected static bool SecurityCanDelete;

        protected string SecurityGetDisableClass(UserActionsEnum action)
        {
            if (action == UserActionsEnum.Insert)
            {
                if (SecurityCanInsert)
                {
                    return string.Empty;
                }
                else
                {
                    return "disabled";
                }
            }

            if (action == UserActionsEnum.Update)
            {
                if (SecurityCanUpdate)
                {
                    return string.Empty;
                }
                else
                {
                    return "disabled";
                }
            }

            if (action == UserActionsEnum.Delete)
            {
                if (SecurityCanDelete)
                {
                    return string.Empty;
                }
                else
                {
                    return "disabled";
                }
            }

            return string.Empty;
        }


        protected void Page_OnLoad(EventArgs e)
        {
        }

        protected new void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !IsCallback)
            {
                DatasourcesCachesInit(cachePageName + ".masterDataSource");
                DatasourcesCachesInit(cachePageName + ".detailDataSource");
                ASPxGridView_Init_FixRowsCache_Datasources(); // fix initial binding for empty tables or queries
                

            }
            else
            {
                ASPxGridView_Load_FixRowsCache_Datasources();
            }

            if (IsCallback || IsPostBack)
            {
            }
        }

        private void DatasourcesCachesInit(string skey)
        {
            if (Cache[skey] == null)
            {
                Cache[skey] = DateTime.Now;
            }
        }

        private void DatasourcesCachesInvalidate(string skey)
        {
            if (Cache[skey] != null)
            {
                Cache[skey] = DateTime.Now;
            }
        }

        protected void DBMainDataSources_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 60 * 10;
        }

        protected void DBMainDataSources_Init(object sender, EventArgs e)
        {
            (sender as SqlDataSource).ConnectionString = Global.DAL.GetConnectionStringDBData();   
            
                        
        }

        /// <summary>
        ///  fix initial binding for empty tables or queries
        /// </summary>
        private void ASPxGridView_Init_FixRowsCache_Datasources()
        {

            string masterSelect = TsqlQueryWithOutSearch;

            //masterDataSource.SelectParameters[0].DefaultValue = DateTime.Now.Ticks.ToString();
            masterDataSource.SelectCommand = masterSelect;
            masterDataSource.DataBind();
            ASPxGridView1.DataBind();

        }

        private void ASPxGridView_Load_FixRowsCache_Datasources()
        {
            /*
            string masterSelect = "";

            if (ASPxTextBoxSearch.Value == null)
            {
                masterSelect = TsqlQueryWithOutSearch;
            }
            else
            {
                masterSelect = TsqlQueryWithSearch;

            }
            */


            masterDataSource.SelectCommand = TsqlQueryWithOutSearch; // masterSelect;

        }

        protected void ASPxGridView1_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
        {
            if (e.Parameters == "databind")
            {
                DatasourcesCachesInvalidate(cachePageName + ".masterDataSource");
                DatasourcesCachesInvalidate(cachePageName + ".detailDataSource");
                (sender as ASPxGridView).DataBind();
            }
        }

        protected void ASPxGridView1_DetailRowExpandedChanged(object sender, ASPxGridViewDetailRowEventArgs e)
        {
        }


        protected void ASPxGridView1_DataBinding(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// Control the insertion on the DB.
        /// We have 2 options:
        /// 1. update a field value of the grid with: e.NewValues["prodDescripcionHtml"] = htmlEditor.Html; (Prefer method)
        /// 2. update the default or parameter value of the datasource: SqlDataSource1.SelectParameters[0].DefaultValue = novedadid;
        ///
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ASPxGridView1_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            var UserPass = ASPxGridView1.FindEditFormTemplateControl("UserPass") as ASPxTextBox;
            if (UserPass.Value != null)
            {
                var userId = Session["User.UserId"].ToString();
                e.NewValues["UserPass"] = UserLogin.GetNewUserPassword(userId, UserPass.Value.ToString(), UserLogin.EncryptionHashAlgorithm.SHA512, Global.DAL.GetConnectionStringDBData());
            }
            else
            {
                e.NewValues["UserPass"] = string.Empty;
            }
        }

        /// <summary>
        /// Check values before insert and after Parse_Value()
        /// http://www.devexpress.com/Support/Center/Question/Details/Q308089
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ASPxGridView1_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            /*
            if (e.NewValues["UserId"] == null) {
                e.NewValues["UserId"] = 0;
            }
            */

            var UserPass = ASPxGridView1.FindEditFormTemplateControl("UserPass") as ASPxTextBox;
            if (UserPass.Value != null)
            {
                var userId = Session["User.UserId"].ToString();
                e.NewValues["UserPass"] = UserLogin.GetNewUserPassword(userId, UserPass.Value.ToString(), UserLogin.EncryptionHashAlgorithm.SHA512, Global.DAL.GetConnectionStringDBData()  );
            }
            else
            {
                e.NewValues["UserPass"] = System.Guid.NewGuid().ToString();
            }
        }


        protected void ASPxGridView1_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
        {
            DatasourcesCachesInvalidate(cachePageName + ".masterDataSource");
            DatasourcesCachesInvalidate(cachePageName + ".detailDataSource");
        }
        protected void ASPxGridView1_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        {
            DatasourcesCachesInvalidate(cachePageName + ".masterDataSource");
            DatasourcesCachesInvalidate(cachePageName + ".detailDataSource");
        }

        protected void ASPxGridView1_RowDeleted(object sender, DevExpress.Web.Data.ASPxDataDeletedEventArgs e)
        {
            DatasourcesCachesInvalidate(cachePageName + ".masterDataSource");
            DatasourcesCachesInvalidate(cachePageName + ".detailDataSource");
        }


        /// <summary>
        /// http://demos.devexpress.com/ASPxGridViewDemos/GridEditing/Validation.aspx
        /// if (e.NewValues["FirstName"] != null && e.NewValues["FirstName"].ToString().Length
        /// AddError(e.Errors, grid.Columns["Categoria"], grid.Columns["Categoria"].Caption + ": El valor ya existe con otro registro...");
        /// TIP: si el campo esta invisible, e.NewValues devuelve NULL
        /// <2></2></summary>
        protected void grid_RowValidating(object sender, DevExpress.Web.Data.ASPxDataValidationEventArgs e)
        {

            /*
            if (ASPxGridView1.IsNewRowEditing && e.NewValues["UserPass"] == null)
            {
                AddError(e.Errors, ASPxGridView1.Columns["UserPass"], ASPxGridView1.Columns["UserPass"].Caption + ": Escriba una contraseña.");
            }
            */

            string tsql = "";

            // validar valores contra DB
            // TIP: si el campo esta invisible, e.NewValues devuelve NULL
            // http://devexpress.com/Support/Center/p/Q109251.aspx
            if (e.NewValues["UserLogin"] != null)
            {
                int Id = 0;
                int currentIndex = 0;

                if (e.Keys.Count > 0)
                    currentIndex = ASPxGridView1.FindVisibleIndexByKeyValue(e.Keys[0]);

                object IdvalGrid = ASPxGridView1.GetRowValues(currentIndex, "UserId");

                if (IdvalGrid != null)
                    Id = Convert.ToInt32(IdvalGrid);

                SqlParameter[] paramsToSP = {

                         new SqlParameter("@UserLogin", e.NewValues["UserLogin"].ToString())
                        ,new SqlParameter("@UserId", Id )
                         };


                if (e.IsNewRow) // insert
                    tsql = "SELECT UserId FROM [User] WHERE UserLogin = @UserLogin";
                else // update
                    tsql = "SELECT UserId FROM [User] WHERE UserLogin = @UserLogin AND UserId != @UserId";


                int? codigo = SqlApiSqlClient.GetIntRecordValue(tsql, paramsToSP, Global.DAL.GetConnectionStringDBData()  );
                if (codigo != null)
                {
                    AddError(e.Errors, ASPxGridView1.Columns["UserLogin"], ASPxGridView1.Columns["UserLogin"].Caption + ": El valor ya existe con otro registro...");
                }
            }


            if (string.IsNullOrEmpty(e.RowError) && e.Errors.Count > 0)
            {
                e.RowError = "Por favor corrija los errores.";
            }

        }
        private void AddError(Dictionary<GridViewColumn, string> errors, GridViewColumn column, string errorText)
        {
            if (errors.ContainsKey(column))
            {
                return;
            }
            errors[column] = errorText;
        }
        /// <summary>
        /// Para mostrar una fila de algun color especifico.
        ///
        /// bool hasError = e.GetValue("FirstName").ToString().Length 
        /// </<></summary>
        protected void grid_HtmlRowPrepared(object sender, ASPxGridViewTableRowEventArgs e)
        {
        }

        protected void grid_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            if (!ASPxGridView1.IsNewRowEditing)
            {
                ASPxGridView1.DoRowValidation();
            }
        }
        /// <summary>
        /// Validar tipo datos de los valores introducidos
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grid_ParseValue(object sender, DevExpress.Web.Data.ASPxParseValueEventArgs e)
        {
            if (ASPxGridView1.IsNewRowEditing)
            {
                if (e.FieldName == "UserId") e.Value = 0;

                if (e.FieldName == "UserPass")
                {
                    if (string.IsNullOrEmpty(e.Value.ToString())) e.Value = System.Guid.NewGuid().ToString();
                }

            }

        }

        protected void ASPxGridView1_CellEditorInitialize(object sender, ASPxGridViewEditorEventArgs e)
        {
            if (e.Column.GetType() == typeof(GridViewDataTextColumn))
            {
                (e.Column as GridViewDataTextColumn).PropertiesTextEdit.ValidationSettings.ValidationGroup = "ValidateForm";
                   // (e.Editor.NamingContainer as GridViewEditFormTemplateContainer).ValidationGroup;
            }

            if (e.Column.GetType() == typeof(GridViewDataComboBoxColumn))
            {
                (e.Column as GridViewDataComboBoxColumn).PropertiesComboBox.ValidationSettings.ValidationGroup = "ValidateForm";
                   // (e.Editor.NamingContainer as GridViewEditFormTemplateContainer).ValidationGroup;
            }
        }

        protected void ASPxGridView1Detail_BeforePerformDataSelect(object sender, EventArgs e)
        {
            var id = (sender as ASPxGridView).GetMasterRowKeyValue();
            detailDataSource.SelectParameters[0].DefaultValue = id.ToString();
        }

        protected void ASPxGridView1Detail_RowInserted(object sender, DevExpress.Web.Data.ASPxDataInsertedEventArgs e)
        {
            DatasourcesCachesInvalidate(cachePageName + ".detailDataSource");
        }

        /// <summary>
        /// Control the insertion on the DB.
        /// We have 2 options:
        /// 1. update a field value of the grid with: e.NewValues["prodDescripcionHtml"] = htmlEditor.Html;
        /// 2. update the default or parameter value of the datasource: SqlDataSource1.SelectParameters[0].DefaultValue = novedadid;
        ///
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ASPxGridView1Detail_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            var lgrid = (sender as ASPxGridView);

            var cbPermission = lgrid.FindEditFormTemplateControl("CBUserPermissionType") as ASPxComboBox;
            e.NewValues["UserPerTypeId"] = cbPermission.Value.ToString();

            e.NewValues["UserId"] = lgrid.GetMasterRowKeyValue().ToString();

        }

        protected void ASPxGridView1Detail_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            var lgrid = (sender as ASPxGridView);

            var cbPermission = lgrid.FindEditFormTemplateControl("CBUserPermissionType") as ASPxComboBox;
            e.NewValues["UserPerTypeId"] = cbPermission.Value.ToString();

            e.NewValues["UserId"] = lgrid.GetMasterRowKeyValue().ToString();

        }

        protected void ASPxGridView1Detail_RowUpdated(object sender, DevExpress.Web.Data.ASPxDataUpdatedEventArgs e)
        {
            // DatasourcesCachesInvalidate(cachePageName + ".masterDataSource");
            DatasourcesCachesInvalidate(cachePageName + ".detailDataSource");
        }

        protected void ASPxGridView1Detail_ParseValue(object sender, DevExpress.Web.Data.ASPxParseValueEventArgs e)
        {
            if ((sender as ASPxGridView).IsNewRowEditing)
            {
                if (e.FieldName == "UserPerId") e.Value = 0;

            }
        }

        protected string GetLink(object link)
        {
            var stext = link as string;

            if (!String.IsNullOrEmpty(stext))
            {
                Uri myUri;
                if (Uri.TryCreate(stext, UriKind.RelativeOrAbsolute, out myUri))
                {
                    return "<a href=\"" + stext + "\" target=\"_blank\"> Más Info...</a>";
                }
            }

            return string.Empty;
        }


        protected string GetDetailRowValue(string id)
        {
            var index = ASPxGridView1.FindVisibleIndexByKeyValue(id);
            var detail = ASPxGridView1.FindDetailRowTemplateControl(index, "ASPxGridViewDetail") as ASPxGridView;
            if (detail != null)
            {
                return detail.FindVisibleIndexByKeyValue(id).ToString();
            }

            return string.Empty;
        }

        protected string GetDetailRenderedControlID(string keyvalue, string controlId)
        {
            if (string.IsNullOrEmpty(controlId))
            {
                return string.Empty;
            }
            var index = ASPxGridView1.FindVisibleIndexByKeyValue(keyvalue);
            var detail = ASPxGridView1.FindDetailRowTemplateControl(index, "ASPxGridViewDetail") as ASPxGridView;

            var control = detail.FindEditFormTemplateControl(controlId);
            return control.ClientID;
        }



        protected void ASPxGridView1Detail_Init(object sender, EventArgs e)
        {
            (sender as ASPxGridView).ClientInstanceName = "detailGrid" + (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void ASPxGridView1Detail_Load(object sender, EventArgs e)
        {
        }

        #region search
        protected void ASPxButtonSearch_Click(object sender, EventArgs e)
        {
            Page.Validate();

            if (Page.IsValid)
            {

                // dont need this because the parameter is now a control:
                // masterDataSource.SelectParameters["Search"].DefaultValue = ASPxTextBoxSearch.Value.ToString();
                masterDataSource.DataBind();
                ASPxGridView1.DataBind();
            }
        }
        #endregion search

        protected void CBUserPermissionType_ItemRequestedByValue(object source, ListEditItemRequestedByValueEventArgs e)
        {

            if (e.Value != null)
            {

                SqlDataSourceUserPermissionType.SelectParameters.Clear(); // force query to server
                SqlDataSourceUserPermissionType.SelectParameters.Add(
                    new Parameter { Name = "search", DbType = DbType.AnsiString, Size = 60, DefaultValue = e.Value.ToString().Replace("*", "%") }
                    );
                (source as ASPxComboBox).DataBindItems();
            }

        }

        protected void CBUserPermissionType_ItemsRequestedByFilterCondition(object source, ListEditItemsRequestedByFilterConditionEventArgs e)
        {
            if (!string.IsNullOrEmpty(e.Filter))
            {
                SqlDataSourceUserPermissionType.SelectParameters.Clear(); // force query to server
                SqlDataSourceUserPermissionType.SelectParameters.Add(
                    new Parameter { Name = "search", DbType = DbType.AnsiString, Size = 60, DefaultValue = e.Filter.ToString().Replace("*", "%") }
                    );
                (source as ASPxComboBox).DataBindItems();
            }
        }









    }
}