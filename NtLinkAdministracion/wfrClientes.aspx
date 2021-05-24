<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrClientes.aspx.cs" Inherits="NtLinkAdministracion.wfrClientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server"> 
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" >
    <link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1><asp:Label ID="lblTitulo" runat="server"  ></asp:Label></h1>
    <h1>Cliente</h1>
    <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    <table>
        
    </table>
    <div runat="server" ID="divUsuarios">
    <table >
        <tr>
            <td></td>
            <td class="style1">
                <asp:CheckBox runat="server" ID="cbBloqueado"  Text="Bloqueado Administrativo"/>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">Tipo de Cliente:</td>
            <td><asp:DropDownList runat="server" ID="ddlTipoCliente" AutoPostBack="True" Width="269px">
                   <asp:ListItem runat="server" Text="Facturación" Value="0" ></asp:ListItem>
                   <asp:ListItem runat="server" Text="Timbrado Pre-Pago" Value="1"></asp:ListItem>
                   <%--<asp:ListItem runat="server" Text="Distribuidor" Value="2"></asp:ListItem>--%>
                   <asp:ListItem runat="server" Text="Timbrado Post-Pago" Value="3"></asp:ListItem> 
                </asp:DropDownList></td>
                <td style="text-align: right">Ejecutivo de ventas:</td>
            <td>
                <asp:DropDownList runat="server" ID="ddlEjecutivos" DataTextField="Nombre" DataValueField="IdPromotor" Width="269px"/>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">RFC:</td>
             <td><asp:TextBox runat="server" ID="txtRFC" Width="266px" /></td>
            <td style="text-align: right">Razon Social:</td>
            <td><asp:TextBox runat="server" ID="txtRazonSocial" Width="266px" /></td>
        </tr>
         <tr>
            <td style="text-align: right">Régimen Fiscal:</td>
            <td><asp:DropDownList runat="server" ID="ddlRegimen" Width="269px" >
                    <asp:ListItem Value="Régimen General de Ley Personas Morales" Text="Régimen General de Ley Personas Morales" runat="server" />
                    <asp:ListItem Value="Personas Morales con Fines no Lucrativos" Text="Personas Morales con Fines no Lucrativos" runat="server" />
                    <asp:ListItem Value="Régimen de las Personas Físicas con Actividades Empresariales y Profesionales" Text="Régimen de las Personas Físicas con Actividades Empresariales y Profesionales" runat="server" />
                    <asp:ListItem Value="Régimen Intermedio de las Personas Físicas con Actividades Empresariales" Text="Régimen Intermedio de las Personas Físicas con Actividades Empresariales" runat="server" />
                    <asp:ListItem Value="Régimen de Arrendamiento" Text="Régimen de Arrendamiento" runat="server" />

                </asp:DropDownList></td>
                <td>Ultimo acceso Al portal:</td>
                <td><asp:TextBox runat="server" ID="txtFechaAcceso" Width="266px" Enabled="False" /></td>
        </tr>

        <tr>
            <td style="text-align: right">Dirección:</td>
            <td><asp:TextBox runat="server" ID="txtDireccion" Width="266px" /></td>
            <td style="text-align: right">Colonia:</td>
            <td><asp:TextBox runat="server" ID="txtColonia" Width="269px" /></td>
        </tr>
        <tr>
            <td style="text-align: right">Municipio:</td>
            <td><asp:TextBox runat="server" ID="txtMunicipio" Width="269px" /></td>
             <td style="text-align: right">Estado:</td>
            <td><asp:TextBox runat="server" ID="txtEstado" Width="269px" /></td>
        </tr>
        <tr>
            <td style="text-align: right">C.P.:</td>
            <td><asp:TextBox runat="server" ID="txtCP" Width="269px"/></td>
            <td style="text-align: right">Telefono:</td>
            <td><asp:TextBox runat="server" ID="txtTelefono" Width="269px" /></td>
        </tr>
        <tr>
            <td style="text-align: right">Email:</td>
            <td><asp:TextBox runat="server" ID="txtEmail" Width="269px" /></td>
            <td style="text-align: right">Contacto:</td>
            <td><asp:TextBox runat="server" ID="txtContacto" Width="269px" /></td>
        </tr>
        
        <tr>
            <td style="text-align: right">Nombre del Administrador:</td>
            <td><asp:TextBox runat="server" ID="txtNombreAdmin" Width="269px" Enabled="False" /></td>
            <td style="text-align: right">Iniciales del Administrador:</td>
            <td><asp:TextBox runat="server" ID="txtInicialesAdmin" Width="269px" Enabled="False" /></td>
        </tr>
        
        <tr>
            <td style="text-align: right">Saldo Emision</td>
            <td>
                <asp:TextBox runat="server" ID="txtSaldoEmision" Width="269px" Enabled="true"></asp:TextBox>
                <asp:CompareValidator runat="server" ControlToValidate="txtSaldoEmision" ErrorMessage="Campo Inválido"
                                      Display="Dynamic" Operator="DataTypeCheck" Type="Integer"/>
            </td>
            <td style="text-align: right">Saldo Timbrado</td>
            <td>
                <asp:TextBox runat="server" ID="txtSaldoTimbrado" Width="269px" Enabled="true" ></asp:TextBox>
                <asp:CompareValidator runat="server" ControlToValidate="txtSaldoTimbrado" ErrorMessage="Campo Inválido"
                                      Display="Dynamic" Operator="DataTypeCheck" Type="Integer"/>
            </td>
        </tr>

        <tr>
            <td style="text-align: right">Folios Contratados:</td>
            <td><asp:TextBox runat="server" ID="txtFolios" Width="269px" Enabled="False" />
                <asp:CompareValidator runat="server" ControlToValidate="txtFolios" ErrorMessage="Campo Inválido" Display="Dynamic" Operator="DataTypeCheck" Type="Integer" ></asp:CompareValidator>
            </td>
             <td style="text-align: right">Ultima Renovación:</td>
             <td><asp:TextBox runat="server" ID="txtRenovacion" Width="269px" Enabled="False" />
            </td>
        </tr>
        
      <%--  <tr>
            <td>Folios Consumidos:</td>
            <td><asp:TextBox runat="server" ID="txtConsumidos" Width="400px" Enabled="False" />
            </td>
        </tr>--%>
        <tr>
            <td style="text-align: right">Consumo Emisión:</td>
            <td><asp:TextBox runat="server" ID="txtConsumoEmision" Width="269px" Enabled="False" />
            </td>
            <td style="text-align: right">Consumo Timbrado:</td>
             <td><asp:TextBox runat="server" ID="txtConsumoTimbrado" Width="269px" Enabled="False" />
            </td>
        </tr>
        
         <tr>
            <td style="text-align: right">Empresa Multiple:</td>
             <td>&nbsp;<asp:CheckBox runat="server" ID="cbMultiple" Text="Activar Multiple" /></td>
        </tr>
        <tr >
            <td colspan="2">
                <asp:Label ID="LblMensaje" runat="server" />    
            </td>
        </tr>
        </table>
        </div>
        
        
        <div align="right" runat="server"   ID="divUsers">
        <asp:Button runat="server" ID="btnGuardar"  class="btn btn-primary" Text="Guardar" OnClick="btnGuardar_Click" />&nbsp;&nbsp;
    </div>
   
</asp:Content>
