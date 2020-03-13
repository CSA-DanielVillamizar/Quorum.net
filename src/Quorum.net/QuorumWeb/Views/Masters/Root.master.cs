// GNU Version 3 License Copyright (c) 2020 Javier Cañon | https://www.javiercanon.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using QuorumWeb.Model;
using DevExpress.Web;

namespace QuorumWeb {
    public partial class Root : MasterPage {
        public bool EnableBackButton { get; set; }
        protected void Page_Load(object sender, EventArgs e) {

            if(!string.IsNullOrEmpty(Page.Header.Title))
                Page.Header.Title += " - ";
            Page.Header.Title = Page.Header.Title + " Quorum.net";

            Page.Header.DataBind();
            UpdateUserMenuItemsVisible();
            HideUnusedContent();
            UpdateUserInfo();
        }

        protected void HideUnusedContent() {
            LeftAreaMenu.Items[1].Visible = EnableBackButton;

            bool hasLeftPanelContent = HasContent(LeftPanelContent);
            LeftAreaMenu.Items.FindByName("ToggleLeftPanel").Visible = hasLeftPanelContent;
            LeftPanel.Visible = hasLeftPanelContent;

            bool hasRightPanelContent = HasContent(RightPanelContent);
            RightAreaMenu.Items.FindByName("ToggleRightPanel").Visible = hasRightPanelContent;
            RightPanel.Visible = hasRightPanelContent;

            bool hasPageToolbar = HasContent(PageToolbar);
            PageToolbarPanel.Visible = hasPageToolbar;
        }

        protected bool HasContent(Control contentPlaceHolder) {
            if(contentPlaceHolder == null) return false;

            ControlCollection childControls = contentPlaceHolder.Controls;
            if(childControls.Count == 0) return false;

            return true;
        }

        // SignIn/Register

        protected void UpdateUserMenuItemsVisible() {
            var isAuthenticated = AuthHelper.IsAuthenticated();
            RightAreaMenu.Items.FindByName("SignInItem").Visible = !isAuthenticated;
            RightAreaMenu.Items.FindByName("RegisterItem").Visible = !isAuthenticated;
            RightAreaMenu.Items.FindByName("MyAccountItem").Visible = isAuthenticated;
            RightAreaMenu.Items.FindByName("SignOutItem").Visible = isAuthenticated;
        }

        protected void UpdateUserInfo() {
            if(AuthHelper.IsAuthenticated()) {
                var user = AuthHelper.GetLoggedInUserInfo();
                var myAccountItem = RightAreaMenu.Items.FindByName("MyAccountItem");
                var userName = (ASPxLabel)myAccountItem.FindControl("UserNameLabel");
                var email = (ASPxLabel)myAccountItem.FindControl("EmailLabel");
                var accountImage = (HtmlGenericControl)RightAreaMenu.Items[0].FindControl("AccountImage");
                userName.Text = string.Format("{0} ({1} {2})", user.UserName, user.FirstName, user.LastName);
                email.Text = user.Email;
                accountImage.Attributes["class"] = "account-image";

                if(string.IsNullOrEmpty(user.AvatarUrl)) {
                    accountImage.InnerHtml = string.Format("{0}{1}", user.FirstName[0], user.LastName[0]).ToUpper();
                } else {
                    var avatarUrl = (HtmlImage)myAccountItem.FindControl("AvatarUrl");
                    avatarUrl.Attributes["src"] = ResolveUrl(user.AvatarUrl);
                    accountImage.Style["background-image"] = ResolveUrl(user.AvatarUrl);                    
                }
            }
        }

        protected void RightAreaMenu_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e) {
            if(e.Item.Name == "SignOutItem") {
                AuthHelper.SignOut(); // DXCOMMENT: Your Signing out logic
                Response.Redirect("~/");
            }
        }

        protected void ApplicationMenu_ItemDataBound(object source, MenuItemEventArgs e) {
            e.Item.Image.Url = string.Format("Content/Images/{0}.svg", e.Item.Text);
            e.Item.Image.UrlSelected = string.Format("Content/Images/{0}-white.svg", e.Item.Text);
        }
    }
}