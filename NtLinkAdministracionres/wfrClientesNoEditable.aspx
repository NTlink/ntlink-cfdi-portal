<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrClientesNoEditable.aspx.cs" Inherits="NtLinkAdministracion.wfrClientesNoEditable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"> 
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<style type= "text/css">
     .disabledStyle
     {
         border : 1px solid gray ;
         color :  Red;
     }
     .enabledStyle
     {
         border : 1px solid Blue;
     }
</style> 


    <h1><asp:Label ID="lblTitulo" runat="server"></asp:Label></h1>
    <h1>Cliente</h1>
    <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    <table>
        
    </table>
    <div runat="server" ID="divUsuarios">
    <table>
        <tr>
            <td></td>
            <td>
                <asp:CheckBox runat="server" ID="cbBloqueado" Text="Bloqueado Administrativo" 
                    Enabled="False"/>
            </td>
        </tr>
        <tr>
            <td>Tipo de Cliente:</td>
            <td><asp:DropDownList runat="server" ID="ddlTipoCliente" AutoPostBack="True" 
                    Enabled="False">
                   <asp:ListItem runat="server" Text="Facturación" Value="0" ></asp:ListItem>
                   <asp:ListItem runat="server" Text="Timbrado Pre-Pago" Value="1"></asp:ListItem>
                   <%--<asp:ListItem runat="server" Text="Distribuidor" Value="2"></asp:ListItem>--%>
                   <asp:ListItem runat="server" Text="Timbrado Post-Pago" Value="3"></asp:ListItem> 
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td>RFC:</td>
            <td><asp:TextBox runat="server" ID="txtRFC" Width="150px" Enabled="False" /></td>
        </tr>
        <tr>
            <td>Razon Social:</td>
            <td><asp:TextBox runat="server" ID="txtRazonSocial" Width="400px" Enabled="False" 
                    ForeColor="Red" /></td>
        </tr>
         <tr>
            <td>Régimen Fiscal:</td>
            <td>
            <asp:TextBox runat="server" ID="ddlRegimen" Width="400px" Enabled="False" 
                    ForeColor="Red" />

          </td>
        </tr>
        <tr>
            <td>Ejecutivo de ventas:</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlEjecutivos" DataTextField="Nombre" 
                    DataValueField="IdPromotor" Enabled="False"/>
            </td>
        </tr>

        <tr>
            <td>Dirección:</td>
            <td><asp:TextBox runat="server" ID="txtDireccion" Width="400px" Enabled="False" 
                    ForeColor="Red" /></td>
        </tr>
        <tr>
            <td>Colonia:</td>
            <td><asp:TextBox runat="server" ID="txtColonia" Width="400px" Enabled="False" 
                    ForeColor="Red" /></td>
        </tr>
        <tr>
            <td>Municipio:</td>
            <td><asp:TextBox runat="server" ID="txtMunicipio" Width="400px" Enabled="False" 
                    ForeColor="Red" /></td>
        </tr>
        <tr>
            <td>Estado:</td>
            <td><asp:TextBox runat="server" ID="txtEstado" Width="400px" Enabled="False" 
                    ForeColor="Red" /></td>
        </tr>
        <tr>
            <td>C.P.:</td>
            <td><asp:TextBox runat="server" ID="txtCP" Width="75px" Enabled="False" 
                    ForeColor="Red" /></td>
        </tr>
        <tr>
            <td>Telefono:</td>
            <td><asp:TextBox runat="server" ID="txtTelefono" Width="400px" Enabled="False" 
                    ForeColor="Red" /></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td><asp:TextBox runat="server" ID="txtEmail" Width="400px" Enabled="False" 
                    ForeColor="Red" /></td>
        </tr>
        <tr>
            <td>Contacto:</td>
            <td><asp:TextBox runat="server" ID="txtContacto" Width="400px" Enabled="False" 
                    ForeColor="Red" /></td>
        </tr>
        
        <tr>
            <td>Nombre del Administrador:</td>
            <td><asp:TextBox runat="server" ID="txtNombreAdmin" Width="400px" Enabled="False" /></td>
        </tr>
         
        <tr>
            <td>Iniciales del Administrador:</td>
            <td><asp:TextBox runat="server" ID="txtInicialesAdmin" Width="400px" 
                    Enabled="False" /></td>
        </tr>
        
        <tr>
            <td>Saldo Emision</td>
            <td>
                <asp:TextBox runat="server" ID="txtSaldoEmision" Width="400px" Enabled="False"></asp:TextBox>
                <asp:CompareValidator runat="server" ControlToValidate="txtSaldoEmision" ErrorMessage="Campo Inválido"
                                      Display="Dynamic" Operator="DataTypeCheck" Type="Integer"/>
            </td>
        </tr>
        
        <tr>
            <td>Saldo Timbrado</td>
            <td>
                <asp:TextBox runat="server" ID="txtSaldoTimbrado" Width="400px" 
                    Enabled="False" ></asp:TextBox>
                <asp:CompareValidator runat="server" ControlToValidate="txtSaldoTimbrado" ErrorMessage="Campo Inválido"
                                      Display="Dynamic" Operator="DataTypeCheck" Type="Integer"/>
            </td>
        </tr>

        <tr>
            <td>Folios Contratados:</td>
            <td><asp:TextBox runat="server" ID="txtFolios" Width="400px" Enabled="False" />
                <asp:CompareValidator runat="server" ControlToValidate="txtFolios" ErrorMessage="Campo Inválido" Display="Dynamic" Operator="DataTypeCheck" Type="Integer" ></asp:CompareValidator>
            </td>
        </tr>
        
      <%--  <tr>
            <td>Folios Consumidos:</td>
            <td><asp:TextBox runat="server" ID="txtConsumidos" Width="400px" Enabled="False" />
            </td>
        </tr>--%>
        <tr>
            <td>Consumo Emisión:</td>
            <td><asp:TextBox runat="server" ID="txtConsumoEmision" Width="400px" Enabled="False" />
            </td>
        </tr>
        <tr>
            <td>Consumo Timbrado:</td>
            <td><asp:TextBox runat="server" ID="txtConsumoTimbrado" Width="400px" Enabled="False" />
            </td>
        </tr>
         <tr>
            <td>Ultima Renovación:</td>
            <td><asp:TextBox runat="server" ID="txtRenovacion" Width="400px" Enabled="False" />
            </td>
        </tr>
       
        <tr >
            <td colspan="2">
                <asp:Label ID="LblMensaje" runat="server" />    
            </td>
        </tr>
        </table>
        </div>
        
        
        <div align="right" runat="server" ID="divUsers">
        <asp:Button runat="server" ID="btnGuardar" Text="Guardar" class="btn btn-primary"
                OnClick="btnGuardar_Click" Enabled="False" Visible="False" />&nbsp;&nbsp;
    </div>
   
</asp:Content>
