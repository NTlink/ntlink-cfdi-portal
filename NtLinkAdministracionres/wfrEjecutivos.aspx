<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrEjecutivos.aspx.cs" Inherits="NtLinkAdministracion.wfrEjecutivos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Ejecutivos de ventas</h1>
    <hr/>
    <asp:HiddenField runat="server" ID="hidIdEjecutivo"/>
    <table>
        <tr>
            <td>
                Nombre:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtNombre"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" ErrorMessage="Campo obligatorio" Display="Dynamic"/>
            </td>
        </tr>
         <tr>
            <td>
                Email:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtEmail"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ErrorMessage="Email mal formado" ControlToValidate="txtEmail"/>
            </td>
        </tr>
         <tr>
            <td>
                Teléfono:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtTelefono"/>
            </td>
        </tr>
        <tr>
            <td>
               <asp:Label runat="server" ID="lblMensaje"></asp:Label>
            </td>
        
        </tr>
    </table>
    <asp:Button runat="server" Text="Guardar Datos" ID="btnGuardar"  class="btn btn-primary" OnClick="btnGuardar_OnClick" />
</asp:Content>
