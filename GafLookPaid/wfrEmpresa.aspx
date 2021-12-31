<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrEmpresa.aspx.cs" Inherits="GafLookPaid.wfrEmpresa" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1
        {
            border-style: none;
          border-color: inherit;
          border-width: 1px;
color: #333333;
            font-weight: normal;
            }
      
        .style125
        {
            border-style: none;
            border-color: inherit;
            border-width: 1px;
            color: #0000FF;
            font-weight: normal;
        }
        .style126
        {
            border-style: none;
            border-color: inherit;
            border-width: 1px;
            color: #333333;
            font-weight: normal;
        }
      
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1><strong class="style126">Empresa</strong></h1>
    <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    <td class="style138"> <input type="button" value="Actualiza tus datos" onclick="javascript: window.open('http://ntlink2.com.mx/actualizacion%20de%20datos/actualizaciondatos.html', '', 'width=600,height=400,left=50,top=50,toolbar=yes');" class="btn btn-primary" />
     </td>
     <br />
     <br />
    <table class="page7">
      <tr>
            <td>RFC:</td>
   <td><asp:TextBox runat="server" ID="txtRFC"  CssClass="form-control2"/></td>
<td> Razón Social:</td>
            <td><asp:TextBox runat="server" ID="txtRazonSocial" 
                    CssClass="form-control2" Width="251px"  /></td>
             
        </tr>  
        <tr>
        
            <td>Régimen Fiscal:</td>
            <td><asp:DropDownList runat="server" ID="ddlRegimen" AutoPostBack="True" 
                    onselectedindexchanged="ddlRegimen_SelectedIndexChanged" CssClass="form-control2" Width="251px" >
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
 <asp:ListItem Value="625" Text="Régimen de las Actividades Empresariales con ingresos a través de Plataformas Tecnológicas"	 runat="server" />
 <asp:ListItem Value="628" Text="Hidrocarburos"	 runat="server" />
 <asp:ListItem Value="607" Text="Régimen de Enajenación o Adquisición de Bienes"	 runat="server" />
 <asp:ListItem Value="629" Text="De los Regímenes Fiscales Preferentes y de las Empresas Multinacionales"	 runat="server" />
 <asp:ListItem Value="630" Text="Enajenación de acciones en bolsa de valores"	 runat="server" />
 <asp:ListItem Value="615" Text="Régimen de los ingresos por obtención de premios"	 runat="server" />
          
                </asp:DropDownList></td>
                  
        <td>CURP:</td>
            <td>
                <asp:TextBox runat="server" ID="txtCURP" MaxLength="24" 
CssClass="form-control2" Width="151px"  /></td>
<td></td>
           </tr>
   
        <tr>
            <td>Calle:</td>
            <td>
                <asp:TextBox runat="server" ID="txtDireccion" CssClass="form-control2"
                  /></td>
        
            <td> No Exterior:</td>
            <td>
                <asp:TextBox runat="server" ID="txtExt" CssClass="form-control2"
                    /></td>
        
            <td> No Interior:</td>
            <td>
                <asp:TextBox runat="server" ID="txtInt" CssClass="form-control2" /></td>
                    <td></td>
        </tr>
        <tr>
            <td>Colonia:</td>
            <td><asp:TextBox runat="server" ID="txtColonia" CssClass="form-control2" /></td>
        
            <td>Municipio:</td>
            <td>
                <asp:TextBox runat="server" ID="txtMunicipio" CssClass="form-control2" /></td>
        
            <td>Localidad:</td>
            <td><asp:TextBox runat="server" ID="txtLocalidad" CssClass="form-control2" /></td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
        </tr>
        <tr>
            
            <td>Estado:</td>
            <td>
                <asp:TextBox runat="server" ID="txtEstado" CssClass="form-control2" /></td>
             <td> C.P.:</td>
            <td>
                <asp:TextBox runat="server" ID="txtCP" CssClass="form-control2" /></td> 
                    <td>Referencia:</td>
            <td>
                <asp:TextBox runat="server" ID="txtReferencia" CssClass="form-control2" /></td> 
<td></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td>
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control2" /></td>
<td> Teléfono:</td>
            <td>
                <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control2" /></td>
                     <td> Contacto Administrativo: </td>
            <td>
                <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control2" /></td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
        </tr>
        <tr>
          <!--  <td class="style139">Web:</td>
            <td class="style129"><asp:TextBox runat="server" ID="txtWeb" Width="292px" 
                    Height="20px" /></td>
            <td class="style139">Orientación del Archivo Pdf:</td>
            <td class="style129">
                <asp:DropDownList runat="server" ID="ddlOrientacion" 
                    Height="16px" Width="99px" >
                    <asp:ListItem Value="0" Text="Vertical" ></asp:ListItem> 
                    <asp:ListItem Value="1" Text="Horizontal" ></asp:ListItem> 
            </asp:DropDownList>-->
           
            
           
        </tr>
        <tr>
          
            <td> Leyenda Encabezado:</td>
            <td class="style125">
                <asp:TextBox runat="server" ID="txtLeyendaSuperior" 
                    CssClass="form-control0"></asp:TextBox>
            </td>
            <td>Leyenda pie de Página:</td>
            <td>
                <asp:TextBox runat="server" ID="txtLeyendaPie" 
                    TextMode="MultiLine" CssClass="form-control2"></asp:TextBox>
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>  
        </tr>
           <tr>
           <td> Logo Empresa:</td>
            <td class="style125">
                <asp:FileUpload runat="server" ID="fuLogoEmpresa" CssClass="form-control0" />
                   <td><asp:Button runat="server" ID="btnGuardar" Text="Guardar" onclick="btnGuardar_Click"  class="btn btn-primary" />
             <td> <asp:Button runat="server" ID="btnCancelar" Text="Cancelar" onclick="btnCancelar_Click" CausesValidation="False"  class="btn btn-primary" /></td>
    </td>
    </tr>
         <tr>
       
         <td></td>   
                <td>(Peso máximo de logo 50 Kb)</td>   
            
        </tr>
        <asp:Panel runat="server" ID="pnlSucursal" Visible="False">
            <tr>
                <td>Sucursal:</td>
                <td>
                    <asp:TextBox runat="server" ID="txtSucursal"  CssClass="form-control2"/>
                    <asp:RequiredFieldValidator runat="server" ID="rfvSucursal" ControlToValidate="txtSucursal" 
                      Display="Dynamic" ErrorMessage="* Requerido" />
                </td>
            </tr>
            <tr>
                <td> Lugar de Expedición:</td>
                <td>
                    <asp:TextBox runat="server" ID="txtLugarExpedicion" CssClass="form-control2" />
                    <asp:RequiredFieldValidator runat="server" ID="rfvLugarExpedicion" ControlToValidate="txtLugarExpedicion" 
                      Display="Dynamic" ErrorMessage="* Requerido" />
                </td>
                <td> Contacto Administrativo: </td>
            <td><asp:TextBox runat="server" ID="txtContacto" CssClass="form-control2"
                   /></td>
            </tr>
        </asp:Panel>
       
 </table>
       <h1><strong class="style1">Carga de Certificados</strong></h1>
       <table class="page7"> <tr>
         <!--td class="style159">Si la validación es:“El CSD es correcto”,vuelva a cargar el Cer, Key, Password y de click en Guardar</td-->
         

        </tr></table>
        <table class="page7">
           
          
           <tr>
            <td> Certificado:</td>
            <td>
                <asp:FileUpload runat="server" ID="fuCertificado" CssClass="form-control2" />

            </td>
            <td> 
                <asp:Label runat="server" ID="lblVencimiento" 
                   CssClass="alert-info"></asp:Label></td>
       </tr>
        <tr>
            <td > Llave Privada:</td>
            <td class="style129">
                <asp:FileUpload runat="server" ID="fuLlave" CssClass="form-control2" 
                    style="text-align: left" />

            </td>
            <td> <asp:Label runat="server" ID="lblAdvertencia" ForeColor="Red"  CssClass="alert-error"></asp:Label></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td> Contraseña de la Llave:</td>
            <td class="style135">
                <asp:TextBox runat="server" ID="txtPassWordLlave" TextMode="Password" 
                    CssClass="form-control2"  />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnValidar" runat="server" Text="Validar y Guardar" 
                    onclick="btnValidar_Click"  class="btn btn-primary" />
               
               
            </td>
            
        </tr>
        <!--  <tr>
        <td class="style139"></td>
      <td><asp:Label ID="Label1" runat="server" 
                    Text="  Validar y Cargar de nuevo y dar  Click en Guardar" 
                    style="color: #000099; text-align: right"></asp:Label></td> 
        </tr>-->
    </table>
    <%--<asp:Panel runat="server" ID="pnlPantallas" Visible="False">
        <h1>Pantallas</h1>
        <asp:GridView runat="server" ID="gvPantallas" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Documento" HeaderText="Documento" />
                <asp:TemplateField HeaderText="Visible">
		            <ItemTemplate>
		                <asp:CheckBox ID="chkSelected" runat="server" Checked='<%# Bind("Visible") %>' />
		            </ItemTemplate>
		        </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </asp:Panel>--%>
   
    <asp:ModalPopupExtender runat="server" ID="mpeSELLOS" TargetControlID="btngenerarDummy"
        BackgroundCssClass="mpeBack"  PopupControlID="pnlMSG" />
    <asp:Panel runat="server" ID="pnlMSG" Style="text-align: center;"  CssClass="page7"
        BackColor="#A8CF38" Height="130px" Width="418px">
        <br />
        <asp:Label runat="server" ID="LblMensaje" Text="Mensaje:" 
                            Visible="True" class="style161" style="color: #F72020"/>
        <!--h1 class="style161" style="color: #000000"><strong>Comprobante generado correctamente y enviado por correo electrónico</strong></h1-->
        <br />
        <br />
        <asp:Label runat="server" ID="LblSolucion" Text="Solucion:" 
                            Visible="True" Height="40px" class="style161" style="color: #000000"/>
        <br />
        
        <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
        <asp:Button runat="server" ID="btnCerrar" Text="Aceptar"  class="btn btn-primary" OnClick="btnCerrar_Click" />
    </asp:Panel>
    <asp:Button runat="server" ID="btngenerarDummy" Style="display: none;" />

</asp:Content>