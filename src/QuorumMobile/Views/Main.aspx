<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Root.master" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="QuorumMobile.Views.Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <dx:BootstrapFormLayout runat="server">
        <Items>
            <dx:BootstrapLayoutGroup Caption="Codigo de Autorización">
                <Items>

                    <dx:BootstrapLayoutItem Caption="Codigo" ColSpanMd="4">
                        <ContentCollection>
                            <dx:ContentControl>
                                
                                <div runat="server" id="Msg" class="alert alert-danger" visible="false"></div>

                                <dx:BootstrapTextBox runat="server" ID="TextBoxCode">

                                    <ValidationSettings CausesValidation="true" ErrorDisplayMode="ImageWithText">
                                        <RequiredField IsRequired="true" ErrorText="Valor Requerido" />
                                    </ValidationSettings>

                                </dx:BootstrapTextBox>

                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:BootstrapLayoutItem>

                </Items>
            </dx:BootstrapLayoutGroup>

            <dx:BootstrapLayoutItem HorizontalAlign="Right" ShowCaption="False" ColSpanMd="12">
                <ContentCollection>
                    <dx:ContentControl>

                        <dx:BootstrapButton runat="server" ID="BtnSend" Text="Enviar" SettingsBootstrap-RenderOption="Primary" 
                            AutoPostBack="true" OnClick="BtnSend_Click"
                            />

                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
        </Items>
    </dx:BootstrapFormLayout>


</asp:Content>
