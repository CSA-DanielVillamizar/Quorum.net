using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Softcanon.DAL;
using System.Data.SqlClient;
using System.Data;

namespace QuorumMobile.Views
{
    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnSend_Click(object sender, EventArgs e)
        {

            Page.Validate();
            if (!Page.IsValid) return;


            string tsql = "SELECT [VoteCode] FROM [Attendees] WHERE [VoteCode] = @VoteCode;";

            IDataParameter[] parameters = {
                new SqlParameter{ ParameterName="VoteCode", DbType= DbType.AnsiString, Value = TextBoxCode.Value.ToString().Trim() }

            };
            
            string result = SqlApiSqlClient.GetStringRecordValue(tsql, parameters, Global.Configuration.DB.GetConnectionStringDBMain());

            if (result == null)
            {
                Msg.Visible = true;
                Msg.InnerHtml = "Código Ingresado No Valido.";

            }
            else {

                Session["User.VoteCode"] = result;

                // if you store session in cookies need redirect, not server.transfer:
                Response.Redirect("~/Views/Questions/Questions.aspx", false);

            }


        }



    }
}