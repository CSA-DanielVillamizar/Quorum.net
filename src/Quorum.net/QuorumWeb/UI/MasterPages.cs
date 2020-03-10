using System;
using System.Collections.Generic;


namespace QuorumWeb.UI
{

	/// <summary>
	/// Summary description for MasterPages
	/// </summary>
	public class MasterPages : System.Web.UI.MasterPage
	{
		protected void Page_Init(object sender, EventArgs e)
		{
			Page.Header.DataBind();
		}
	}
}
