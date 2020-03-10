<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Root.master" AutoEventWireup="true" CodeBehind="Administration.aspx.cs" Inherits="QuorumWeb.Views.Admin.Administration" %>

<%@ Register Src="~/Views/Controls/ControlAdminLeftSubmenu.ascx" TagPrefix="uc1" TagName="ControlAdminLeftSubmenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftPanelContent" runat="server">

    <h3 class="section-caption contents-caption">Submenu</h3>

    <uc1:ControlAdminLeftSubmenu runat="server" id="ControlAdminLeftSubmenu" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="RightPanelContent" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="PageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageContent" runat="server">


        <h3>Seleccione una opción del submenu laterial izquierdo...</h3>

</asp:Content>
