using DevExpress.Web.Bootstrap;
using QuorumMobile.UI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuorumMobile.Views.Questions
{
    public partial class Questions : PageBaseGrid
    {
        protected new void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DetailGrid_OnBeforePerformDataSelect(object sender, EventArgs e)
        {

            var grid = (sender as BootstrapGridView);
            //var datasrc = FindControlRecursive(grid.DataSourceID) as SqlDataSource;
            SqlDataSourceAnswers.SelectParameters["QuestionsID"].DefaultValue = grid.GetMasterRowKeyValue().ToString();
            SqlDataSourceUserAnswers.SelectParameters["QuestionsID"].DefaultValue = grid.GetMasterRowKeyValue().ToString();
            SqlDataSourceUserAnswers.InsertParameters["QuestionsID"].DefaultValue = grid.GetMasterRowKeyValue().ToString();
            SqlDataSourceUserAnswers.UpdateParameters["QuestionsID"].DefaultValue = grid.GetMasterRowKeyValue().ToString();
        }

        protected void DetailGrid_CellEditorInitialize(object sender, BootstrapGridViewEditorEventArgs e)
        {
            e.Editor.Enabled = true;
        }
    }
}