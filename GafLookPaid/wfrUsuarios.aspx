<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrUsuarios.aspx.cs" Inherits="GafLookPaid.wfrUsuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style>
tr:nth-child(even){background-color: #EBEBEB}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1><strong>Usuario</strong></h1>
    <asp:Label runat="server" ID="lblErrorMessage" ForeColor="Red" />
    <table class="table">
        <tr>
            <td>Empresa:</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlEmpresas" AppendDataBoundItems="True" DataValueField="idEmpresa" CssClass="form-control0"
                 DataTextField="RazonSocial"/>
            </td>
        </tr>
       
        <tr>
            <td>Email (inicio de sesión)</td>
            <td>
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control0" />
                <asp:RequiredFieldValidator runat="server" ID="rfvEmail" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="* Requerido" />
                <asp:RegularExpressionValidator runat="server" ID="revEmail" ControlToValidate="txtEmail" ErrorMessage="* Direccion invalida"
                         ValidationExpression="^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$" Display="Dynamic" />
            </td>
        </tr>
         <tr>
            <td>Nombre Completo</td>
            <td>
                <asp:TextBox runat="server" ID="txtNombreCompleto" CssClass="form-control0" />
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtNombreCompleto" Display="Dynamic" ErrorMessage="* Requerido" />

            </td>
        </tr>
         <tr>
            <td>Iniciales</td>
            <td>
                <asp:TextBox runat="server" ID="txtIniciales" CssClass="form-control0" />
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtIniciales" Display="Dynamic" ErrorMessage="* Requerido" CssClass="alert-error" />
            </td>
        </tr>
        <tr>
            <td>Password:</td>
            <td>
                <asp:TextBox runat="server" ID="txtConfirmarPassword" TextMode="Password" CssClass="form-control0" />
                <asp:RequiredFieldValidator runat="server" ID="rfvPassword" ControlToValidate="txtPassword"
                    ErrorMessage="* Requerido" Display="Dynamic" />
                <asp:RegularExpressionValidator runat="server" ID="revPassword" ControlToValidate="txtPassword"
                    Display="Dynamic" ErrorMessage="* El password no cumple con las politicas de seguridad"
                    ValidationExpression="((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%+-_]).{8,20})"  />
                <asp:CompareValidator runat="server" ID="cvPassword" ControlToValidate="txtPassword" Display="Dynamic"
                    ControlToCompare="txtConfirmarPassword" ErrorMessage="* La confirmacion y el password no coinciden" Operator="Equal"  />
            </td>
        </tr>
        <tr>
            <td>Confirmar Password:</td>
            <td>
                <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control0" />
                </td>
        </tr>

        <tr>
            <td>Perfil:</td>
            <td><asp:DropDownList runat="server" ID="ddlPerfiles" AppendDataBoundItems="True" 
                   CssClass="form-control0" /></td>
        </tr>
    </table>
    <div align="center">
        <asp:Button runat="server" ID="btnGuardar" Text="Guardar" onclick="btnGuardar_Click" class="btn btn-primary"/>&nbsp;&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnCancelar" Text="Cancelar" PostBackUrl="wfrUsuariosConsulta.aspx" class="btn btn-primary"/>
    </div>
</asp:Content>
