<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Masters/Root.master" AutoEventWireup="true" CodeBehind="Questions.aspx.cs" Inherits="QuorumMobile.Views.Questions.Questions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Content" runat="server">


    <dx:BootstrapGridView runat="server" ID="MainGrid" DataSourceID="SqlDataSourceQuestions" KeyFieldName="ID">

        <SettingsDetail ShowDetailRow="true" AllowOnlyOneMasterRowExpanded="True" />
        <SettingsBootstrap Sizing="Large" />
        <SettingsBehavior AllowAutoFilter="False" AllowDragDrop="False" AllowGroup="False" AllowHeaderFilter="False" AllowSort="False" />

        <Columns>
            <dx:BootstrapGridViewDataColumn FieldName="Number" Caption="#" />
            <dx:BootstrapGridViewDataColumn FieldName="Question" Caption="Pregunta" />
        </Columns>
        <Templates>
            <DetailRow>

                <dx:BootstrapGridView runat="server" ID="DetailGrid" DataSourceID="SqlDataSourceUserAnswers"
                    ClientInstanceName="detailGrid"
                    KeyFieldName="IDUserAnswers"
                    OnBeforePerformDataSelect="DetailGrid_OnBeforePerformDataSelect"
                    OnCellEditorInitialize="DetailGrid_CellEditorInitialize"
                    >

                    <SettingsBootstrap Sizing="Large" />
                    <SettingsBehavior AllowAutoFilter="False" AllowDragDrop="False" AllowGroup="False" AllowHeaderFilter="False" AllowSort="False" />
                    <SettingsDataSecurity AllowInsert="true" AllowEdit="true" />

                    <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                    <SettingsCommandButton RenderMode="Button">

                        <UpdateButton CssClass="btn-success" />
                        <CancelButton CssClass="btn btn-light" />

                    </SettingsCommandButton>

                    <Columns>

                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" ShowCancelButton="True" ShowUpdateButton="True" ShowNewButton="False">
                        </dx:BootstrapGridViewCommandColumn>
                        
                        <dx:BootstrapGridViewComboBoxColumn FieldName="AnswersID" Caption="Respuesta">
                            <PropertiesComboBox DataSourceID="SqlDataSourceAnswers" ValueField="AnswersID" ValueType="System.Int32"
                                TextField="Answer" EnableSynchronization="False">
                                <ValidationSettings>
                                    <RequiredField IsRequired="true" />
                                </ValidationSettings>
                            </PropertiesComboBox>
                        </dx:BootstrapGridViewComboBoxColumn>                    

                    </Columns>

                    <Templates>

                        <EmptyDataRow>
                            <a class="btn btn-primary" onclick="detailGrid.AddNewRow();">Responder</a>
                        </EmptyDataRow>

                    </Templates>
                </dx:BootstrapGridView>

            </DetailRow>
        </Templates>
    </dx:BootstrapGridView>


    <asp:SqlDataSource runat="server" ID="SqlDataSourceQuestions"
        EnableCaching="true" CacheDuration="60" CacheExpirationPolicy="Sliding"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        CancelSelectOnNullParameter="false"
        SelectCommand="SELECT [ID], ROW_NUMBER() OVER(ORDER BY ID) Number, [Question] FROM [Questions]"></asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSourceAnswers"
        EnableCaching="true" CacheDuration="60" CacheExpirationPolicy="Sliding"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        CancelSelectOnNullParameter="false"
        SelectCommand="SELECT 
       ID AnswersID
      ,[Answer]
  FROM [QuestionsAnswers]
  WHERE
  [QuestionsID] = @QuestionsID">

        <SelectParameters>
            <asp:Parameter Name="QuestionsID" Type="Int32" />

        </SelectParameters>

    </asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSourceUserAnswers"
        EnableCaching="false" CacheDuration="60" CacheExpirationPolicy="Sliding"
        ConnectionString='<%$ ConnectionStrings:MsSqlServer.Main %>'
        CancelSelectOnNullParameter="false"
        SelectCommand="
SELECT AttendeesAnswers.[ID] IDUserAnswers
      ,[QuestionsID]
      ,[AnswersID]
  FROM [AttendeesAnswers]
INNER JOIN [Attendees] ON [AttendeesAnswers].AttendeesID = [Attendees].ID
AND [Attendees].[VoteCode] = @VoteCode  
WHERE
[QuestionsID] = @QuestionsID
        "
        InsertCommand="
INSERT INTO [AttendeesAnswers]
           ([QuestionsID]
           ,[AnswersID]
           ,[AttendeesID]
            )
SELECT
            @QuestionsID
           ,@AnswersID
           ,[ID] [AttendeesID]
FROM [Attendees]           
WHERE
[VoteCode] = @VoteCode       
        "
        UpdateCommand="
UPDATE [AttendeesAnswers] SET 
       [AnswersID] = @AnswersID
      ,[DateAnswered] = GETDATE()
 WHERE 
 ID = @IDUserAnswers        
        ">


        <SelectParameters>

            <asp:Parameter Name="QuestionsID" Type="Int32" />
            <asp:SessionParameter Name="VoteCode" SessionField="User.VoteCode" Type="Int64" />
        </SelectParameters>

        <InsertParameters>

            <asp:Parameter Name="QuestionsID" Type="Int32" />
            <asp:Parameter Name="AnswersID" Type="Int32" />

            <asp:SessionParameter Name="VoteCode" SessionField="User.VoteCode" Type="Int64" />
        </InsertParameters>

        <UpdateParameters>

            <asp:Parameter Name="IDUserAnswers" Type="Int32" />
            <asp:Parameter Name="QuestionsID" Type="Int32" />
            <asp:Parameter Name="AnswersID" Type="Int32" />

            <asp:SessionParameter Name="VoteCode" SessionField="User.VoteCode" Type="Int64" />
        </UpdateParameters>


    </asp:SqlDataSource>


</asp:Content>
