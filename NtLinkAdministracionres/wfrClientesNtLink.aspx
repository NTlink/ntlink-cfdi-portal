<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrClientesNtLink.aspx.cs" Inherits="NtLinkAdministracion.wfrClientesNtLink" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Editar Cliente</h1>
    <p>
        <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    </p>
    <table>
        <tr>
            <td>Empresa Emisora:</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlEmpresa" AppendDataBoundItems="true" DataTextField="RazonSocial" 
                    DataValueField="IdEmpresa" />
            </td>
        </tr>
        <tr><td />
        <tr>
            <td>RFC:</td>
            <td><asp:TextBox runat="server" ID="txtRFC" Width="266px" /></td>
            <td>Razón Social:</td>
            <td><asp:TextBox runat="server" ID="txtRazonSocial" Width="266px" /></td>
        </tr>
        <tr>
            <td>Calle:</td>
            <td><asp:TextBox runat="server" ID="txtDireccion" Width="266px" /></td>
            <td>Colonia:</td>
            <td><asp:TextBox runat="server" ID="txtColonia" Width="266px" /></td>
        </tr>
        <tr>
            <td>No Exterior:</td>
            <td><asp:TextBox runat="server" ID="txtExt" Width="266px" /></td>
            <td>No Interior:</td>
            <td><asp:TextBox runat="server" ID="txtInt" Width="266px" /></td>
        </tr>
        <tr>
            <td>Municipio:</td>
            <td><asp:TextBox runat="server" ID="txtMunicipio" Width="266px" /></td>
            <td>Localidad:</td>
            <td><asp:TextBox runat="server" ID="txtLocalidad" Width="266px" /></td>
        </tr>
        <tr>
            <td>Referencia:</td>
            <td><asp:TextBox runat="server" ID="txtReferencia" Width="266px" /></td>

            <td>Estado:</td>
            <td><asp:TextBox runat="server" ID="txtEstado" Width="266px" /></td>
        </tr>
        <tr>
            <td>País:</td>
            <td><asp:TextBox runat="server" ID="txtPais" Width="266px" >México</asp:TextBox> </td>
            <td>CP:</td>
            <td><asp:TextBox runat="server" ID="txtCP" Width="266px" /></td>
        </tr>
        <tr>
            <td>Teléfono</td>
            <td><asp:TextBox runat="server" ID="txtTelefono" Width="266px" /></td>
            <td>Contacto:</td>
            <td><asp:TextBox runat="server" ID="txtContacto" Width="266px" /></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td><asp:TextBox runat="server" ID="txtEmail" Width="266px" /></td>
            <td>Bcc:</td>
            <td><asp:TextBox runat="server" ID="txtBcc" Width="266px" /></td>
        </tr>
        <tr>
            <td>Web:</td>
            <td><asp:TextBox runat="server" ID="txtWeb" Width="266px" /></td>
            <td>Cta. Depósito</td>
            <td><asp:TextBox runat="server" ID="txtCuentaDeposito" Width="266px" /></td>
        </tr>
        <tr>
            <td>Días Revisión:</td>
            <td>
                <asp:TextBox runat="server" ID="txtDiasRevision" Width="266px" />
                <asp:CompareValidator runat="server" ID="cvDiasRevision" ControlToValidate="txtDiasRevision" Display="Dynamic"
                 ErrorMessage="* Dato Invalido" Type="Integer" Operator="DataTypeCheck" />
            </td>

            <td>Cta. Contable:</td>
            <td><asp:TextBox runat="server" ID="txtCuentaContable" Width="266px" /></td>
        </tr>
        
        </table>
    <div align="right" style="width: 90%">
        <asp:Button runat="server" ID="btnSave" class="btn btn-primary"  Text="Guardar" onclick="btnSave_Click" />&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnCancel" class="btn btn-primary" Text="Cancelar" 
            onclick="btnCancel_Click" />
    </div>
</asp:Content>

