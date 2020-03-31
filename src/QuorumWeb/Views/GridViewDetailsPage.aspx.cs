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
using QuorumWeb.Model;
using System;
using System.Web;

namespace QuorumWeb {
    public partial class GridViewDetailsPageModule : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            long recordId;
            if(long.TryParse(Request.QueryString["id"], out recordId)) {
                var issue = GetCurrentIssue(recordId);
                SubjectText.InnerHtml = HttpUtility.HtmlEncode(issue.Subject);
                IdLabel.Text = recordId.ToString();
            }
            Master.EnableBackButton = true;
        }

        protected Issue GetCurrentIssue(long recordId) {
            var issue = DataProvider.GetIssues().Find(i => i.Id == recordId);
            if(issue == null)
                throw new Exception("The issue was not found");
            return issue;
        }
    }
}