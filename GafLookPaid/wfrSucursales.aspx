<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrSucursales.aspx.cs" Inherits="GafLookPaid.wfrSucursales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style125
        {
            width: 159px;
        }
        .style126
        {
            width: 214px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Sucursal</h1>
    <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    <table class="table-bordered">
        <tr>
            <td>Nombre:</td>
            <td class="style126">
                <asp:HiddenField runat="server" ID="txtIdEmpresa"/>
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control2" />
                <asp:RequiredFieldValidator runat="server" ID="rfvNombre" ErrorMessage="* Requerido" Display="Dynamic"
                 ControlToValidate="txtNombre" />
            </td>
        </tr>
        <tr>
            <td>Lugar de expedición:</td>
            <td class="style126">
                <asp:DropDownList ID="ddlEstado" runat="server" AutoPostBack="True" CssClass="form-control2"
                    onselectedindexchanged="ddlEstado_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlMunicipio" runat="server" AutoPostBack="True" CssClass="form-control2"
                    onselectedindexchanged="ddlMunicipio_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlCP" runat="server" AutoPostBack="True" CssClass="form-control2"
                    onselectedindexchanged="ddlCP_SelectedIndexChanged">
                </asp:DropDownList>

                <%--
                <asp:TextBox runat="server" ID="txtLugarExpedicion"  Width="400px"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="rfvLugarExpedicion" ErrorMessage="* Requerido" Display="Dynamic"
                 ControlToValidate="txtLugarExpedicion" />
                 --%>
            </td>
        </tr>
        <tr>
            <td>Domicilio:</td>
            <td class="style126">
                <asp:TextBox runat="server" ID="txtDomicilio"  CssClass="form-control2" 
                    TextMode="MultiLine" Height="44px" Width="375px"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="* Requerido" Display="Dynamic"
                 ControlToValidate="txtDomicilio" />
            </td>
        </tr>
    </table>
    <div align="right" style="width:40%">
        <asp:Button runat="server" ID="btnGuardar" Text="Guardar" onclick="btnGuardar_Click" class="btn btn-primary"/>&nbsp;&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnCancelar" Text="Cancelar" class="btn btn-primary"
            CausesValidation="False" onclick="btnCancelar_Click" />
    </div>
</asp:Content>
