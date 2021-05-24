<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrComisionistas.aspx.cs" Inherits="GafLookPaid.wfrComisionistas1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Promotores</h1>
    <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    <table>
        <tr>
            <td>Nombre:</td>
            <td>
                <asp:TextBox runat="server" ID="txtNombre" />
                <asp:RequiredFieldValidator runat="server" ID="rfvNombre" ErrorMessage="* Requerido" Display="Dynamic"
                 ControlToValidate="txtNombre" />
            </td>
        </tr>
        <tr>
            <td>Email:</td>
            <td>
                <asp:TextBox runat="server" ID="txtEmail" />
                <asp:RequiredFieldValidator runat="server" ID="rfvEmail" ErrorMessage="* Requerido" Display="Dynamic"
                 ControlToValidate="txtEmail" />
                <asp:RegularExpressionValidator runat="server" ID="revEmail" ControlToValidate="txtEmail" Display="Dynamic"
                 ErrorMessage="* Direccion invalida" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
            </td>
        </tr>
        <tr>
            <td>Teléfono:</td>
            <td>
                <asp:TextBox runat="server" ID="txtTelefono" />
                <asp:RequiredFieldValidator runat="server" ID="rfvtelefono" ErrorMessage="* Requerido" Display="Dynamic"
                 ControlToValidate="txtTelefono" />
                <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono"
                 ErrorMessage="* Número invalido" ValidationExpression="\d{1,10}" Display="Dynamic" /> 
            </td>
        </tr>
    </table>
    <div align="right">
        <asp:Button runat="server" ID="btnGuardar" Text="Guardar" class="btn btn-primary" 
            onclick="btnGuardar_Click" />
        <asp:Button runat="server" ID="btnCancelar" Text="Cancelar" PostBackUrl="wfrComisionistasConsulta.aspx" class="btn btn-primary"  CausesValidation="False"/>
    </div>
</asp:Content>
