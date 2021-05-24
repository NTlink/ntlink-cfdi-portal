<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrUsuariosConsulta.aspx.cs" Inherits="GafLookPaid.wfrUsuariosConsulta" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
tr:nth-child(even){background-color: #EBEBEB}

.style124
    {
        border-left:  1px none #A8CF38;
    border-right:  1px none #A8CF38;
    border-top:  1px none #A8CF38;
    border-bottom:  1px none #A8CF38;
        border-radius: 15px;
        padding: 2px 4px;
        height:40%rem;
        width:90%;
        color: #000101;
        background-color:transparent;
        
     background-color: #DCD9D9;
        text-align: left;
        }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    
    <h1>Usuarios</h1>
  <div align="left">  <p>
        <asp:Label runat="server" ID="lblMensaje" />
    </p>
    Empresa:
    <asp:DropDownList runat="server" ID="ddlEmpresas" AutoPostBack="True" AppendDataBoundItems="True"
     DataValueField="idEmpresa" DataTextField="RazonSocial" 
          onselectedindexchanged="ddlEmpresas_SelectedIndexChanged" CssClass="form-control0" />
     
        <asp:Button runat="server" ID="btnNuevoUsuario" Text="Nuevo Usuario" 
            onclick="btnNuevoUsuario_Click" class="btn btn-primary"/>
    </div>
    <br />
    <asp:GridView runat="server" ID="gvUsuarios" CssClass="style124" AutoGenerateColumns="False" onrowcommand="gvUsuarios_RowCommand"
      AllowPaging="True" onpageindexchanging="gvUsuarios_PageIndexChanging">
        <Columns>
            <asp:BoundField HeaderText="Id" DataField="UserId" />
            <asp:BoundField HeaderText="Nombre" DataField="UserName" />
            <asp:BoundField HeaderText="Perfil" DataField="Perfil" />
            <asp:BoundField HeaderText="Email" DataField="Email" />
            <asp:BoundField HeaderText="Status" DataField="IsLockedOut" />
            <asp:ButtonField Text="Editar" CommandName="EditarUsuario" />
            <asp:ButtonField Text="Cambiar Password" CommandName="CambiarPassword" />
            
            <%--<asp:ButtonField Text="Editar" ButtonType="Link" CommandName="EditarUsuario" />--%>
        </Columns>
    </asp:GridView>
    
    <asp:ModalPopupExtender runat="server" ID="mpeCambiarPassword" TargetControlID="btnPasswordDummy" BackgroundCssClass="mpeBack"
     CancelControlID="btnCerrarPassword" PopupControlID="pnlCambiarPassword" /> 
    <asp:Panel runat="server" CssClass="page3" ID="pnlCambiarPassword"   >
        <h1>Cambiar Password</h1>
        <asp:Label runat="server" ID="lblUserIdCambiarPassword" Visible="False" />
        <table align="center">
            <tr>
                <td>Password:</td>
                <td>
                    <asp:TextBox runat="server" ID="txtConfirmarPassword" CssClass="form-control0" TextMode="Password" />
                   
                </td>
            </tr>
            <tr>
                <td />
                <td>
                    <asp:RequiredFieldValidator runat="server" ID="rfvPassword" ControlToValidate="txtPassword" 
                     ErrorMessage="* Requerido" ValidationGroup="CambiarPassword" Display="Dynamic" />
                    <asp:RegularExpressionValidator runat="server" ID="revPassword" ControlToValidate="txtPassword"
                     Display="Dynamic" ErrorMessage="* El password no cumple con las politicas de seguridad"
                     ValidationExpression="((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%+_.-]).{8,20})" ValidationGroup="CambiarPassword" />
                    <asp:CompareValidator runat="server" ID="cvPassword" ControlToValidate="txtPassword" Display="Dynamic"
                     ControlToCompare="txtConfirmarPassword" ErrorMessage="* La confirmacion y el password no coinciden"
                      Operator="Equal" ValidationGroup="CambiarPassword" />
                </td>
            </tr>
            <tr>
                <td>Confirmar:</td>
                <td> <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control0" TextMode="Password"  /></td>
            </tr>
        </table>
        <br />
        <asp:Button runat="server" ID="btnAceptarPassword" Text="Cambiar" onclick="btnAceptarPassword_Click"
         ValidationGroup="CambiarPassword" class="btn btn-primary"/>&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnCerrarPassword" Text="Cancelar" class="btn btn-primary"/>
    </asp:Panel>
    <asp:Button runat="server" ID="btnPasswordDummy" style="display: none;" class="btn btn-primary"/>
    <asp:ModalPopupExtender runat="server" ID="mpeEditarUsuario" TargetControlID="btnDummy2" BackgroundCssClass="mpeBack"
     CancelControlID="btnCerrarEdicion" PopupControlID="panelEditar" />
    <asp:Panel runat="server" ID="panelEditar" CssClass="page3" style="text-align: center;"   >
        <h1>Editar Usuario</h1>
        <asp:Label runat="server" ID="Label1" Visible="False" />
        <table align="center">
            <tr>
                <td>Nombre:</td>
                <td>
                <asp:HiddenField runat="server" ID="txtIdUsuario" />
                    <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control0" />
                   
                </td>
                <td>
                 <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtNombre" 
                     ErrorMessage="* Requerido" ValidationGroup="EditarUsuario" Display="Dynamic" /></td>
            </tr>
            <tr>
                <td>Iniciales:</td>
                <td><asp:TextBox runat="server" ID="txtIniciales" CssClass="form-control0" /></td>
                 <td>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtIniciales" 
                     ErrorMessage="* Requerido" ValidationGroup="EditarUsuario" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td>Perfil:</td>
                
                 <td style="text-align: left;">
                    <asp:DropDownList runat="server" ID="ddlPerfil" CssClass="form-control0">
                        <asp:ListItem runat="server" Text="Administrador" Value="Administrador"></asp:ListItem>
                        <asp:ListItem runat="server" Text="Operador" Value="Operador"></asp:ListItem>
                         <asp:ListItem runat="server" Text="Vendedor" Value="Vendedor"></asp:ListItem>
                       
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <br />
        <asp:Button runat="server" ID="btnGuardarEdicion" class="btn btn-primary"
            ValidationGroup="EditarUsuario" Text="Guardar" onclick="btnGuardarEdicion_Click"
         />&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnCerrarEdicion" Text="Cancelar" class="btn btn-primary"/>
    </asp:Panel>
    <asp:Button runat="server" ID="btnDummy2" style="display: none;" class="btn btn-primary"/>


</asp:Content>