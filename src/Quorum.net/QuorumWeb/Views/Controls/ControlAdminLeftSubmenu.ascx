<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ControlAdminLeftSubmenu.ascx.cs" Inherits="QuorumWeb.Views.Controls.ControlAdminLeftSubmenu" %>
<dx:ASPxTreeView runat="server" ID="TableOfContentsTreeView" ClientInstanceName="tableOfContentsTreeView"
    EnableNodeTextWrapping="true" AllowSelectNode="true" Width="100%">
    <Styles>
        <Elbow CssClass="tree-view-elbow" />
        <Node CssClass="tree-view-node" HoverStyle-CssClass="hovered" />
    </Styles>
    <Nodes>

        <dx:TreeViewNode Text="Tablas">
            <Nodes>
                <dx:TreeViewNode NavigateUrl="~/Views/Admin/Organizations.aspx" Text="Empresas" Target="_self"></dx:TreeViewNode>
                <dx:TreeViewNode NavigateUrl="~/Views/Admin/Voters.aspx" Text="Votantes" Target="_self"></dx:TreeViewNode>
                <dx:TreeViewNode NavigateUrl="~/Views/Admin/Questions.aspx" Text="Preguntas" Target="_self"></dx:TreeViewNode>
                <dx:TreeViewNode NavigateUrl="~/Views/Admin/QuestionsAnswers.aspx" Text="Respuestas" Target="_self"></dx:TreeViewNode>

                <dx:TreeViewNode NavigateUrl="~/Views/Admin/VoterCategory.aspx" Text="Categorias Votantes" Target="_self"></dx:TreeViewNode>
            </Nodes>
        </dx:TreeViewNode>

    </Nodes>
    <ClientSideEvents NodeClick="function (s, e) { HideLeftPanelIfRequired(); }" />

</dx:ASPxTreeView>
