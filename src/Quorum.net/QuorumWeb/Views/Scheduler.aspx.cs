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
using QuorumWeb.Model;
using DevExpress.Web.Internal;
using DevExpress.XtraScheduler;

namespace QuorumWeb {
    public partial class SchedulerModule : System.Web.UI.Page {
        protected void Page_Init(object sender, EventArgs e) {
            ResourcesListBox.DataSource = ResourceDataSourceHelper.GetItems();
            ResourcesListBox.DataBind();
            if(!IsPostBack)
                ResourcesListBox.SelectAll();

            // DXCOMMENT: Setting ViewType: a compact view (Day) for mobile devices, a large view (WorkWeek) for desktops
            Scheduler.ActiveViewType = RenderUtils.Browser.Platform.IsMobileUI ? SchedulerViewType.Day : SchedulerViewType.WorkWeek;

            if(!IsPostBack) {
                // DXCOMMENT: Scroll to actual time
                var currentTime = new TimeSpan(DateTime.Now.Hour - 1, 0, 0);

                Scheduler.DayView.TopRowTime = currentTime;
                Scheduler.WorkWeekView.TopRowTime = currentTime;
                Scheduler.FullWeekView.TopRowTime = currentTime;
            }

            // DXCOMMENT: Map labels by their ids
            Scheduler.Storage.Appointments.Labels.Clear();
            foreach(SchedulerLabel label in SchedulerLabelsHelper.GetItems())
                Scheduler.Storage.Appointments.Labels.Add(label.Id, label.Name, label.Name, label.Color);
        }

        protected void Scheduler_FilterResource(object sender, PersistentObjectCancelEventArgs e) {
            if(ResourcesListBox.SelectedValues.Count != ResourcesListBox.Items.Count) {
                if(ResourcesListBox.SelectedValues.Count == 0)
                    e.Cancel = true;
                else {
                    var resourceId = (Int64)(e.Object as Resource).Id;
                    if(!ResourcesListBox.SelectedValues.Contains(resourceId))
                        e.Cancel = true;
                }
            }
        }
    }
}