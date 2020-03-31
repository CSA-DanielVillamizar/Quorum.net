<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Basic.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QuorumWeb.Views.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .form {
            padding-bottom: 0;
        }

        .content {
            display: table;
        }

        .formLayout-verticalAlign {
            display: table-cell;
            vertical-align: middle;
        }

        .formLayout-container {
            background-color: white;
            margin-left: auto;
            margin-right: auto;
            max-width: 362px;
            box-shadow: 0px 1px 4px 0 rgba(0, 0, 0, 0.2) !important;
            border-radius: 2px;
        }

        .formLayout-groupBox {
            margin: 0;
            padding: 0 !important;
        }

        .formLayout-generalErrorText {
            color: red;
            padding-top: 1em;
        }

        .eye-button {
            background: none;
        }

            .eye-button > div {
                background: url('Images/eye-button.svg') no-repeat center;
                width: 18px;
                height: 12px;
                vertical-align: baseline;
                pointer-events: none;
                user-select: none;
            }

            .eye-button.show-password > div {
                background: url('Images/eye-button-hide.svg') no-repeat center;
            }

        input[type=password]::-ms-reveal,
        input[type=password]::-ms-clear {
            display: none;
        }

        .footer-wrapper {
            position: static;
            display: table-row;
        }
    </style>

    <script>

        (function () {
            function onPasswordButtonEditButtonClick(s, e) {
                var inputType = s.GetInputElement().type;
                var turnOnPasswordMode = inputType !== "password";

                s.GetInputElement().type = turnOnPasswordMode ? "password" : "text";

                var eyeButton = s.GetMainElement().getElementsByClassName("eye-button")[0];
                if (turnOnPasswordMode)
                    ASPxClientUtils.RemoveClassNameFromElement(eyeButton, "show-password");
                else
                    ASPxClientUtils.AddClassNameToElement(eyeButton, "show-password");
            }

            function isPasswordSimple(password) {
                var passwordMinLength = 8;
                return password.length > 0 && password.length < passwordMinLength;
            }

            function getErrorText(editor) {
                var password = passwordButtonEdit.GetText(),
                    confirmPassword = confirmPasswordButtonEdit.GetText();
                if (editor === passwordButtonEdit && isPasswordSimple(password)) {
                    return "Use 8 characters or more for your password";
                } else if (editor === confirmPasswordButtonEdit && password !== confirmPassword) {
                    return "The password you entered do not match";
                }
                return "";
            }

            function onPasswordValidation(s, e) {
                var errorText = getErrorText(s);
                if (errorText) {
                    e.isValid = false;
                    e.errorText = errorText;
                }
            }

            window.onPasswordButtonEditButtonClick = onPasswordButtonEditButtonClick;
            window.onPasswordValidation = onPasswordValidation;
        })();


    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">

    <div class="formLayout-verticalAlign">
        <div class="formLayout-container">

            <dx:ASPxFormLayout runat="server" ID="FormLayout" ClientInstanceName="formLayout" UseDefaultPaddings="false">
                <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" />
                <SettingsItemCaptions Location="Top" />
                <Styles LayoutGroup-Cell-Paddings-Padding="0" LayoutItem-Paddings-PaddingBottom="8" />
                <Items>
                    <dx:LayoutGroup ShowCaption="False" GroupBoxDecoration="None" Paddings-Padding="16">
                        <Items>
                            <dx:LayoutItem Caption="User name" HelpText="Please, enter your user name">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>

                                        <dx:ASPxTextBox ID="UserNameTextBox" runat="server" Width="100%">
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="User name is required" />
                                            </ValidationSettings>
                                            <ClientSideEvents Init="function(s, e){ s.Focus(); }" />
                                        </dx:ASPxTextBox>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem Caption="Password">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>

                                        <dx:ASPxButtonEdit ID="PasswordButtonEdit" runat="server" Width="100%" Password="true" ClearButton-DisplayMode="Never">
                                            <ButtonStyle Border-BorderWidth="0" Width="6" CssClass="eye-button" HoverStyle-BackColor="Transparent" PressedStyle-BackColor="Transparent">
                                            </ButtonStyle>
                                            <ButtonTemplate>
                                                <div></div>
                                            </ButtonTemplate>
                                            <Buttons>
                                                <dx:EditButton>
                                                </dx:EditButton>
                                            </Buttons>
                                            <ValidationSettings Display="Dynamic" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorDisplayMode="ImageWithText">
                                                <RequiredField IsRequired="true" ErrorText="Password is required" />
                                            </ValidationSettings>
                                            <ClientSideEvents ButtonClick="onPasswordButtonEditButtonClick" />
                                        </dx:ASPxButtonEdit>

                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>

                            <dx:LayoutItem ShowCaption="False" Name="GeneralError">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <div id="GeneralErrorDiv" runat="server" class="formLayout-generalErrorText"></div>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>

                    <dx:LayoutGroup GroupBoxDecoration="HeadingLine" ShowCaption="False">
                        <Paddings PaddingTop="13" PaddingBottom="13" />
                        <GroupBoxStyle CssClass="formLayout-groupBox" />
                        <Items>
                            <dx:LayoutItem ShowCaption="False" HorizontalAlign="Center" Paddings-Padding="0">
                                <LayoutItemNestedControlCollection>
                                    <dx:LayoutItemNestedControlContainer>
                                        <dx:ASPxButton ID="SignInButton" runat="server" Width="200" Text="Log In" OnClick="SignInButton_Click"></dx:ASPxButton>
                                    </dx:LayoutItemNestedControlContainer>
                                </LayoutItemNestedControlCollection>
                            </dx:LayoutItem>
                        </Items>
                    </dx:LayoutGroup>
                </Items>
            </dx:ASPxFormLayout>
        </div>
    </div>

</asp:Content>
