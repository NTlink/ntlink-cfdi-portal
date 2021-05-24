<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="wfrEmpresas.aspx.cs" Inherits="NtLinkAdministracion.wfrEmpresas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            width: 318px;
        }
        .style2
        {
            width: 120px;
        }
        .style3
        {
            width: 204px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>&nbsp; Empresa</h1>
    <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    <table>
        <tr>
            <td style="text-align: right" class="style3">RFC:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtRFC" Width="150px" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             </td>
              <td class="style2"> 
               <asp:Label ID="Label1" runat="server" Text="Empresa Principal:"></asp:Label></td>
             
               <td><asp:Label ID="LabEmpresaPrincipal" runat="server" Text="Label" 
                    Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="style3">Razón Social:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtRazonSocial" Width="266px" /></td>
            <td style="text-align: right" class="style2">Régimen Fiscal:</td>
            <td><asp:DropDownList runat="server" ID="ddlRegimen" AutoPostBack="True" Width="266px"
                    onselectedindexchanged="ddlRegimen_SelectedIndexChanged" >
                     <asp:ListItem Value="601" Text="General de Ley Personas Morales"	 runat="server" />
 <asp:ListItem Value="603" Text="Personas Morales con Fines no Lucrativos"	 runat="server" />
 <asp:ListItem Value="605" Text="Sueldos y Salarios e Ingresos Asimilados a Salarios"	 runat="server" />
 <asp:ListItem Value="606" Text="Arrendamiento"	 runat="server" />
 <asp:ListItem Value="608" Text="Demás ingresos"	 runat="server" />
 <asp:ListItem Value="609" Text="Consolidación"	 runat="server" />
 <asp:ListItem Value="610" Text="Residentes en el Extranjero sin Establecimiento Permanente en México"	 runat="server"/>
 <asp:ListItem Value="611" Text="Ingresos por Dividendos (socios y accionistas)"	 runat="server" />
 <asp:ListItem Value="612" Text="Personas Físicas con Actividades Empresariales y Profesionales"	 runat="server" />
 <asp:ListItem Value="614" Text="Ingresos por intereses"	 runat="server" />
 <asp:ListItem Value="616" Text="Sin obligaciones fiscales"	 runat="server" />
 <asp:ListItem Value="620" Text="Sociedades Cooperativas de Producción que optan por diferir sus ingresos"	 runat="server" />
 <asp:ListItem Value="621" Text="Incorporación Fiscal"	 runat="server" />
 <asp:ListItem Value="622" Text="Actividades Agrícolas, Ganaderas, Silvícolas y Pesqueras"	 runat="server" />
 <asp:ListItem Value="623" Text="Opcional para Grupos de Sociedades"	 runat="server" />
 <asp:ListItem Value="624" Text="Coordinados"	 runat="server" />
 <asp:ListItem Value="628" Text="Hidrocarburos"	 runat="server" />
 <asp:ListItem Value="607" Text="Régimen de Enajenación o Adquisición de Bienes"	 runat="server" />
 <asp:ListItem Value="629" Text="De los Regímenes Fiscales Preferentes y de las Empresas Multinacionales"	 runat="server" />
 <asp:ListItem Value="630" Text="Enajenación de acciones en bolsa de valores"	 runat="server" />
 <asp:ListItem Value="615" Text="Régimen de los ingresos por obtención de premios"	 runat="server" />
               
                </asp:DropDownList></td>
                <tr>
                    <td style="text-align: right" class="style3">CURP: <span style="font-size: x-small"></span></td>
            <td class="style1"><asp:TextBox runat="server" ID="txtCURP" MaxLength="24" Width="266px" /></td>
                    <td class="style2"></td>
                     <td runat="server" ID="tdRegimen" Visible="False" >
                Escribe el régimen: <asp:TextBox runat="server" ID="txtRegimen"></asp:TextBox>
                <asp:RequiredFieldValidator ID="valRegimen" ErrorMessage="Campo obligatorio" runat="server" Enabled="false" Display="Dynamic" ControlToValidate="txtRegimen"></asp:RequiredFieldValidator>
            </td>

                </tr>
           
        </tr>
        <tr>
            
            <td style="text-align: right" class="style3">Calle:</td>
            <td><asp:TextBox runat="server" ID="txtDireccion" Width="266px" /></td>
             <td style="text-align: right" class="style2">Referencia:</td>
            <td><asp:TextBox runat="server" ID="txtReferencia" Width="266px" /></td>
        </tr>
         <tr>
            <td style="text-align: right" class="style3">No Exterior:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtExt" Width="266px" /></td>

            <td style="text-align: right" class="style2">No Interior:</td>
            <td><asp:TextBox runat="server" ID="txtInt" Width="266px" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="style3">Colonia:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtColonia" Width="266px" /></td>
            <td style="text-align: right" class="style2">Municipio:</td>
            <td><asp:TextBox runat="server" ID="txtMunicipio" Width="266px" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="style3">Localidad:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtLocalidad" Width="266px" /></td>
            <td style="text-align: right" class="style2">Estado:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtEstado" Width="266px" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="style3">C.P.:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtCP" Width="266px" /></td>
            <td style="text-align: right" class="style2">Teléfono:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtTelefono" Width="266px" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="style3">Email:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtEmail" Width="266px" /></td>
            <td style="text-align: right" class="style2">Web:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtWeb" Width="266px" /></td>
        </tr>
         <tr>
            <td style="text-align: right" class="style3">Orientación del Archivo Pdf:</td>
            <td class="style1"><asp:DropDownList runat="server" ID="ddlOrientacion" >
                    <asp:ListItem Value="0" Text="Vertical" ></asp:ListItem> 
                    <asp:ListItem Value="1" Text="Horizontal" ></asp:ListItem> 
            </asp:DropDownList>
            </td>
            <td style="text-align: right" class="style2">Contacto Administrativo:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtContacto" Width="266px" /></td>
        </tr>
        <tr>
            <td style="text-align: right" class="style3">Leyenda Encabezado:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtLeyendaSuperior" Width="266px"></asp:TextBox>
            </td>
            <td style="text-align: right" class="style2">Leyenda pie de Página:</td>
            <td class="style1"><asp:TextBox runat="server" ID="txtLeyendaPie" Width="266px"></asp:TextBox>
            </td>
        </tr>
        <asp:Panel runat="server" ID="pnlSucursal" Visible="False">
            <tr>
                <td>Sucursal:</td>
                <td>
                    <asp:TextBox runat="server" ID="txtSucursal" Width="266px" />
                    <asp:RequiredFieldValidator runat="server" ID="rfvSucursal" ControlToValidate="txtSucursal"
                      Display="Dynamic" ErrorMessage="* Requerido" />
                </td>
            </tr>
            <tr>
                <td>Lugar de Expedición:</td>
                <td>
                    <asp:TextBox runat="server" ID="txtLugarExpedicion" Width="266px" />
                    <asp:RequiredFieldValidator runat="server" ID="rfvLugarExpedicion" ControlToValidate="txtLugarExpedicion"
                      Display="Dynamic" ErrorMessage="* Requerido" />
                </td>
            </tr>
        </asp:Panel>
        <tr>
            <td style="text-align: right" class="style3">Logo Empresa:</td>
            <td class="style1">
                <asp:FileUpload runat="server" ID="fuLogoEmpresa"  />
                </td>
                <td class="style2">(Máximo 50 Kb)</td>
        </tr>
        <tr>
            <td class="style3"></td>
            <td class="style1"></td>
        </tr>
        <tr>
            <td class="style3" />
            <td class="style1">Debes de modificar los 3 siguientes datos en conjunto.</td>
        </tr>
        
        <tr>
            <td style="text-align: right" class="style3">Certificado:</td>
            <td class="style1">
                <asp:FileUpload runat="server" ID="fuCertificado" Width="266px" />

            </td>
            <td class="style2"> <asp:Label runat="server" ID="lblVencimiento"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="style3">Llave Privada:</td>
            <td class="style1">
                <asp:FileUpload runat="server" ID="fuLlave" Width="266px" />

            </td>

        </tr>
        <tr>
            <td style="text-align: right" class="style3">Password Llave:</td>
            <td class="style1">
                <asp:TextBox runat="server" ID="txtPassWordLlave" TextMode="Password" />

            </td>
        </tr>
    </table>
    <asp:Panel runat="server" ID="pnlPantallas" Visible="False">
        <h1>Pantallas</h1>
        <asp:GridView runat="server" ID="gvPantallas" AutoGenerateColumns="False" CssClass="page1"
            Width="216px" OnSelectedIndexChanged="gvPantallas_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="Documento" HeaderText="Documento" />
                <asp:TemplateField HeaderText="Visible">
		            <ItemTemplate>
		                <asp:CheckBox ID="chkSelected" runat="server" Checked='<%# Bind("Visible") %>' />
		            </ItemTemplate>
		        </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>
    <div align="right">
        <asp:Button runat="server" ID="btnGuardar"  class="btn btn-primary" Text="Guardar" onclick="btnGuardar_Click" />&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnCancelar"  class="btn btn-primary" Text="Cancelar" onclick="btnCancelar_Click" CausesValidation="False" />
    </div>
</asp:Content>
