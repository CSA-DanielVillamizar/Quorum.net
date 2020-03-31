<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Root.master" AutoEventWireup="true" CodeBehind="Queries.aspx.cs" Inherits="QuorumWeb.Views.Queries.Queries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">
    
    <h2 class="section-caption contents-caption">Consultas</h2>

    <table class="dashboardsList">

        <tr>
            <td><i class="fas fa-file-alt"></i>
                <dx:ASPxHyperLink runat="server" EnableViewState="false" CssClass="button"
                    NavigateUrl="~/Views/Queries/GridAttendees.aspx" 
                    Text="Quorum" ViewStateMode="Disabled" ValidateRequestMode="Disabled">
                </dx:ASPxHyperLink>
            </td>
        </tr>

    </table>
    
</asp:Content>
