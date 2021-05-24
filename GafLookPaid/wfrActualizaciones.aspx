<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrActualizaciones.aspx.cs" Inherits="GafLookPaid.wfrActualizaciones" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <h1 class="style1">Historico de Cambios y Actualizaciones</h1>
            <br />
            <div>
                
            </div>
            <br />
            <asp:Panel ID="Pnl1" runat="server" BorderStyle="Double" CssClass="page2" HorizontalAlign="Center" Width="100%">
                
            </asp:Panel>

        </ContentTemplate>
        <Triggers>
            <%--<asp:PostBackTrigger ControlID="btnEnviar" />--%>
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
