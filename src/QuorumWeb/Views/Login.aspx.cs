using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuorumWeb.Views
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void SignInButton_Click(object sender, EventArgs e)
        {
            FormLayout.FindItemOrGroupByName("GeneralError").Visible = false;
            if (ASPxEdit.ValidateEditorsInContainer(this))
            {
                // Your Authentication logic

                string user = UserNameTextBox.Value.ToString().Trim();
                string pass = PasswordButtonEdit.Value.ToString().Trim();

                string val1 = ConfigurationManager.AppSettings["Debug:User.Login"].ToString();
                string val2 = ConfigurationManager.AppSettings["Debug:User.Login"].ToString();

                if (user.Equals(val1) && pass.Equals(val2))
                {
                    //TODO: rol system
                    Global.Sessions.SetDeveloperUserSessionVariables();
                    Response.Redirect("~/Views/Main.aspx");
                }
                else
                {
                    GeneralErrorDiv.InnerText = "Invalid login attempt.";
                    FormLayout.FindItemOrGroupByName("GeneralError").Visible = true;

                }
            }

        }
    }
}