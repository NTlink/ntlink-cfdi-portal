<%@ Page Title="" Language="C#" MasterPageFile="~/Login.Master" AutoEventWireup="true" CodeBehind="registroClientes.aspx.cs" Inherits="GafLookPaid.registroClientes" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<script runat="server">

  
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
    <style type="text/css">
        .style126
        {
            width: 10%;
        }
        .style128
        {
            width: 15%;
        }
        .MsoNormal
        {
            text-align: left;
            font-size: small;
        }
        .style132
        {
            width: 125px;
        }
        .style133
        {
            color: #FF0000;
        }
        .style135
        {
            text-align: left;
        }
        .style136
        {
            text-align: right;
        }
        .style137
        {
            text-align: right;
            width: 17%;
        }
        .style138
        {
            width: 17%;
        }
        .style139
        {
            width: 17%;
            text-align: right;
        }
        .style140
        {
            text-align: left;
            width: 245px;
        }
        .style141
        {
            width: 245px;
        }
        .style142
        {
            color: #FFFF00;
        }
        .style143
        {
            color: #FFFF66;
        }
        .style144
        {
            text-align: left;
            font-size: small;
            color: #FFFF00;
        }
        .style145
        {
            color: #C0C0C0;
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" >
 
       
                <table class="table-condensed">
                    <tr>
                      <td></td>
                      <td class="style132"></td>
                 
                       <td colspan="3">
                           
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            &nbsp;
                           
                            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="12pt"  class="style125"
                                
                                Text="Registro / Alta de clientes" 
                                ForeColor="#666666" style="color: #FFFFFF; text-align: right;"></asp:Label>
                            
                        &nbsp;</td>
                    </tr>
             
            </table>
            <table>  
      
     
                                <tr>
                        <td colspan="3">
                            <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="NTLI-F-79.00_Carta Autorización del Contribuyente " 
                                style="color: #CCCCCC; font-size: small;"></asp:Label>
                          
                            <br />
                          
                        </td>
                    </tr>
                    <tr>
                    <td align="left" colspan="3" >
                            <asp:Label ID="Label12" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="9pt"
                                Text="Le solicitamos atentamente descargue el documento(carta autorización) llene los campos en 
                            blanco,firme y cargue nuevamente el presente documento, 
                            " Style="font-weight: 700;" CssClass="style145"></asp:Label> 
                            <span class="style145">a efecto de poder estar autorizados a 
                            brindarle el servicio que Usted se merece y poder cumplir con la entrega de 
                            información certificada al SAT en virtud de la Resolución Miscelánea Fiscal del 
                            año 2014.
                            
                            </span>
                            
                            <br />

                            
                        </tr>

</table>
                <br />
 <br />
      <table>  
                    <tr>
                       
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>  
                        <td><input type="button" value="Carta autorización" onclick="javascript: window.open('http://ntlink2.com.mx/ajax/NTLI-F-79%20%20Carta%20Autorizaci%C3%B3n%20del%20Contribuyente.docx', '', 'width=620,height=400,left=50,top=50,toolbar=yes');" class="btn btn-primary" />
                         
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>   
                                
                                 <td style="text-align: right; font-weight: 500;" width="20%">
                        <span class="style160" style="color: #FFF">*Comprobante/Carta autorización:</span> </td>
                                    <td colspan ="5">
                                        <asp:FileUpload runat="server" ID="archivoPagos" CssClass="form-control2" Width="300px"/>
             
             </td>
             <td align="right" >
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                 
                                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>  
                                  <td></td>
                                      <td></td>
                                      <td></td>
                                    <td>
                                        <asp:RegularExpressionValidator ID="REGEXFileUploadLogo" runat="server"
              ErrorMessage="Archivo no Admitido" ControlToValidate="archivoPagos" 
              ValidationExpression= "(.*).(.jpg|.JPG|.gif|.GIF|.jpeg|.JPEG|.bmp|.BMP|.png|.PNG|.pdf|.PDF|.docx)$" 
                                            style="color: #FF0000" />
                                        <br />
                                    </td>
                                </tr>
            
                                    <td class="style29">
                            &nbsp;</td>
            
               </table> 
                
                   <table>
                     <tr>
                        <td colspan="3">
                            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="NTLI-F-78  Alta-Registro de clientes" 
                                style="color: #C0C0C0; font-size: small;"></asp:Label>
                          
                            <br />
                          
                        </td>
                    </tr>
                    
                    <tr>
                    
                   <td style="text-align: right; font-weight: 700;" class="style138">
                        <span class="style160" style="color: #FF0000">*</span>
                            <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="RFC:" style="color: #CBCACA"></asp:Label>
                            </td>
                          
                        <td align="left" class="style140">
                            <asp:TextBox ID="txtRFC" runat="server" CssClass="form-control2" Width="200px" 
                                MaxLength="40"></asp:TextBox>
                        </td>
                    
                      <td style="text-align: right; font-weight: 700;" width="15%">
                        <span class="style160" style="color: #FF0000">*</span>
                            <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Razón Social:" 
                                style="color: #fff; text-align: right;"></asp:Label>
                            </td>
                        <td align="left" class="style29">
                            <asp:TextBox ID="txtEmpresa" runat="server" CssClass="form-control2" Width="250px" 
                                MaxLength="500"></asp:TextBox>
                        </td>
                                            
                       <td style="text-align: right; font-weight: 700;" width="15%">
                        <span class="style160" style="color: #FF0000">*</span>
                            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Régimen Fiscal:" style="color: #fff; "></asp:Label>
                            </td>
                        <td align="left">
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control2" Width="250px"
                                MaxLength="200"></asp:TextBox>
                        </td>
                     </tr>
                    <tr>
                        <td align="right" class="style137">
                            <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Dirección: "  style="color: #fff"></asp:Label>
                            </td>
                        <td align="left" class="style140">
                           <asp:TextBox ID="txtApellidoP" runat="server" CssClass="form-control2" Width="200px" 
                                MaxLength="200"></asp:TextBox>
                        </td>
                   
                       
                          <td class="style136">
                            <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Delegación o Municipio: " 
                                  style="color: #fff; text-align: right;"></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                        <td align="left" class="style29">
                            <asp:TextBox ID="txtExtension" runat="server" CssClass="form-control2" Width="250px"
                                MaxLength="10"></asp:TextBox>
                        </td>
                       <td style="text-align: right; font-weight: 700;" width="15%">
                        <span class="style160" style="color: #FF0000">*</span>
                            <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Código Postal:" style="color: #fff"></asp:Label>
                            </td>
                             <td align="left" class="style29">
                            <asp:TextBox ID="txtMovil" runat="server" CssClass="form-control2"
                                MaxLength="5"></asp:TextBox>
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" 
                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                    CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" 
                    Mask="99999" MaskType="Number" TargetControlID="txtMovil">
                </cc1:MaskedEditExtender>
                        </td> 
                    </tr>
                    <tr>
                     

                    <td style="text-align: right; font-weight: 700;" width="15%">
                        <span class="style160" style="color: #FF0000">*</span>
                            <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Colonia:" style="color: #fff"></asp:Label>
                            </td>
                        <td align="left" class="style29">
                            <asp:TextBox ID="txtcolonia" runat="server" CssClass="form-control2" Width="200px" 
                                MaxLength="250"></asp:TextBox>
                        </td>

                        <td align="right" class="style128">
                            <asp:Label ID="Label14" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Estado: " style="color: #fff"></asp:Label>
                          
                            </td>
                        <td align="left" class="style29">
                            <asp:TextBox ID="txtestado" runat="server" CssClass="form-control2" 
                                MaxLength="200"></asp:TextBox>
                        </td>

                         <td style="font-weight: 700;" class="style139">
                        <span class="style160" style="color: #FF0000">*</span><asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Teléfono:" style="color: #fff"></asp:Label>
                        
                            </td>
                        <td align="left" class="style140">
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control2" Width="200px"
                                MaxLength="10"></asp:TextBox>
                            <cc1:MaskedEditExtender ID="txtCP_MaskedEditExtender" runat="server" 
                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                    CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                    CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" 
                    Mask="9999999999" MaskType="Number" TargetControlID="txtTelefono">
                </cc1:MaskedEditExtender>
                    </tr>
                     <tr>
                      <td style="text-align: right; font-weight: 700;" width="15%">
                        <span class="style160" style="color: #FF0000">*</span>
                            <asp:Label ID="Label16" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Correo Electrónico:" style="color: #fff"></asp:Label>
                            </td>
                        <td align="left" class="style29">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control2" Width="200px" 
                                MaxLength="250"></asp:TextBox>
                        </td>

                        <td align="right" class="style128">
                            <asp:Label ID="Label17" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Ejecutivo de Ventas: " style="color: #fff"></asp:Label>
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </td>
                        <td align="left" class="style29">
                            <asp:TextBox ID="txtApellidoM" runat="server" CssClass="form-control2" 
                                MaxLength="200"></asp:TextBox>
                        </td>
                      <td align="center" class="style137">
                            <asp:Label ID="Label15" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="8pt" Text="Observaciones"  
                                style="color: #fff; text-align: center;"></asp:Label>
                           
                            </td>
                       <td align="left" class="style135">
                           <asp:TextBox ID="txtAsesorv" runat="server" CssClass="form-control2" Width="200px" Height="40px"
                               TextMode="MultiLine"></asp:TextBox>
                        </td>
          <!---     <td>  <asp:DropDownList runat="server" ID="ddlAsesorv" AutoPostBack="True"  CssClass="form-control2" Enabled="true">
                         <asp:ListItem runat="server" Value="Selecciona" Text="Selecciona" Selected="True"></asp:ListItem>
                         <asp:ListItem runat="server" Text="Daniel López" Value="Daniel López"></asp:ListItem>
                         <asp:ListItem runat="server" Text="Ivonne Ahuatzy" Value="Ivonne Ahuatzy"></asp:ListItem>
                         <asp:ListItem runat="server" Text="Jessica Ambros" Value="Jessica ambros"></asp:ListItem>
                         <asp:ListItem runat="server" Text="Ntlink" Value="Ntlink"></asp:ListItem>
                        </asp:DropDownList></td>-->
<td></td>
</tr>
<tr>

                       <td align="left" class="style141">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="True" 
                                Font-Names="Verdana" Font-Size="10pt" ForeColor="#fff" class="btn btn-primary"
                                onclick="LinkButton1_Click">Enviar Solicitud</asp:LinkButton>
                        </td>
                        <td colspan="3" class="style135">
                            <asp:Label ID="lblMensaje" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                Font-Size="7pt" ForeColor="#fff" style="color: #CCCCCC"></asp:Label>
                                <br />
                            <asp:Label ID="Label25" runat="server" Text="* Campos requeridos" ForeColor="Red" Font-Size="12px" />
                          &nbsp;<br />
                             </td>
                    
                        
                       
                    </tr>
                    
           </TABLE> 
           <br /> 
           <TABLE> 
                  <tr>
                       
                        <td align="left" colspan="3">
                            <asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Names="Verdana" 
                                Font-Size="9pt" 
                                
                                Text="Observaciones Importantes- Una vez notificado y comprobado el depósito se procederá a la activación de la cuenta
 " 
                                style="color: #fff; font-weight: 700;"></asp:Label>
                          
                            <p class="MsoNormal">
                              •	<span class="style142">El correo es único por contribuyente </span>
                            </p>
                            <p class="MsoNormal">
                                <span class="style143">•	Verificar que la fiel y su CSD estén vigentes en la lista de contribuyentes obligados. Liga</span> 
                                <a href="https://portalsat.plataforma.sat.gob.mx/RecuperacionDeCertificados/faces/consultaCertificados.xhtml" 
                                   target="_blank" class="style133">https://portalsat.plataforma.sat.gob.mx/RecuperacionDeCertificados/faces/consultaCertificados.xhtml </a> 
                            </p>
                            <p class="style144">
                                •	Los archivos de certificado y llave privada del CSD no serán enviados a NTLink (El cliente los dará de alta personalmente en el sistema).
                            </p>
                            <p class="MsoNormal">
                                <span class="style142">•	El Logotipo de su empresa no será enviado a NTLink (El cliente los dará de alta personalmente en el sistema) y este será en formato .jpg o .png como máximo de 50 kb y de 4.27 cm de largo x 2.41 cm de ancho
                                </span>
                                <span class="style126" 
                                    style="font-size: 11.5pt; font-family: &quot;Arial&quot;,sans-serif; mso-fareast-font-family: &quot;Times New Roman&quot;; letter-spacing: .15pt; mso-fareast-language: ES">
                                </span>
                                <span style="font-size:10.5pt;
font-family:&quot;Arial&quot;,sans-serif;mso-fareast-font-family:&quot;Times New Roman&quot;;
color:#797979;letter-spacing:.15pt;mso-fareast-language:ES">
                                <o:p>
                                </o:p>
                                </span>
                            </p>
                        </td>
                    </tr>
</table>

   
                  <table> 
                      <tr>
                        <td colspan="3">
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                ControlToValidate="txtRFC" Display="None" ErrorMessage="RFC" 
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                ControlToValidate="txtEmpresa" Display="None" 
                                ErrorMessage="Razon Social" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                  
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="txtNombre" Display="None" ErrorMessage="Régimen Fiscal" 
                                SetFocusOnError="True"></asp:RequiredFieldValidator>

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="txtTelefono" Display="None" ErrorMessage="Teléfono" 
                                SetFocusOnError="True"></asp:RequiredFieldValidator>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="txtEmail" Display="None" ErrorMessage="Correo Electrónico" 
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                ControlToValidate="txtEmail" Display="None" 
                                ErrorMessage="Correo Electrónico Incorrecto" SetFocusOnError="True" 
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            
                            
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="archivoPagos" Display="None" ErrorMessage="Carta autorización" 
                                SetFocusOnError="True"></asp:RequiredFieldValidator>

                           
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="page7"
                                HeaderText="Favor de Verificar los siguientes campos:" ShowMessageBox="True" 
                                ShowSummary="False" />
                        </td>
                    </tr>
                   
                    <tr>
                        <td colspan="2">
                            &nbsp;</td>
                        <td align="left" class="style29">
                            &nbsp;</td>
                    </tr>
             
            
        <tr>
            <td>
                &nbsp;</td>
            <td style="background-image:url('images/InfCentral.gif')">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
           </table>

            
</asp:Content>
