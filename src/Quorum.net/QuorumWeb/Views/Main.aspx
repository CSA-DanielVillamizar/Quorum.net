<%-- 
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
--%>
<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Views/Masters/Root.master" CodeBehind="Main.aspx.cs" Inherits="QuorumWeb.Views.Main" Title="Inicio" %>

<asp:Content ContentPlaceHolderID="LeftPanelContent" runat="server">
    <h3 class="section-caption contents-caption">Inicio</h3>
    
    <dx:ASPxTreeView runat="server" ID="TableOfContentsTreeView" ClientInstanceName="tableOfContentsTreeView"
        EnableNodeTextWrapping="true" AllowSelectNode="true" Width="100%">
        <Styles>
            <Elbow CssClass="tree-view-elbow" />
            <Node CssClass="tree-view-node" HoverStyle-CssClass="hovered" />
        </Styles>
        <Nodes>
            <dx:TreeViewNode Text="Dashboards">
                <Nodes>
                    <dx:TreeViewNode NavigateUrl="xxx" Text="Quorum" Target="_blank"></dx:TreeViewNode>
                </Nodes>
            </dx:TreeViewNode>
            <dx:TreeViewNode Text="Consultas">
                <Nodes>
                    <dx:TreeViewNode NavigateUrl="xxx" Text="Asistencia" Target="_blank"></dx:TreeViewNode>
                </Nodes>
            </dx:TreeViewNode>
        </Nodes>
        <ClientSideEvents NodeClick="function (s, e) { HideLeftPanelIfRequired(); }" />

    </dx:ASPxTreeView>
        

</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="PageContent" runat="server">
    <h3>Seleccione una opción del menú.</h3>
</asp:Content>

