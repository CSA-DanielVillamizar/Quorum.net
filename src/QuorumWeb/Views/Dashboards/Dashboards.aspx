<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Root.master" AutoEventWireup="true" CodeBehind="Dashboards.aspx.cs" Inherits="QuorumWeb.Views.Dashboards.Dashboards" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">


    <h2 class="section-caption contents-caption">Dashboards</h2>

    <table class="dashboardsList">

        <tr>
            <td><i class="fas fa-archive"></i>
                <dx:ASPxHyperLink runat="server" EnableViewState="false" CssClass="button"
                    NavigateUrl="~/Views/Dashboards/DashboardAttendees.aspx" Target="_blank"
                    Text="Quorum" ViewStateMode="Disabled" ValidateRequestMode="Disabled">
                </dx:ASPxHyperLink>
            </td>
        </tr>

        <tr>
            <td><i class="fas fa-question-circle"></i>
                <dx:ASPxHyperLink runat="server" EnableViewState="false" CssClass="button"
                    NavigateUrl="~/Views/Dashboards/DashboardQuestions.aspx" Target="_blank"
                    Text="Preguntas" ViewStateMode="Disabled" ValidateRequestMode="Disabled">
                </dx:ASPxHyperLink>
            </td>
        </tr>

    </table>

</asp:Content>
