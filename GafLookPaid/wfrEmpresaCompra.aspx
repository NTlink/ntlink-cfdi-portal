<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrEmpresaCompra.aspx.cs" Inherits="GafLookPaid.wfrEmpresaCompra" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .style1 {
            color: #000000;
            font-weight: normal;
            border: 1px;
        }

        .style128
        {
            width: 207px;
        }
        .style129
        {
            width: 274px;
            text-align: right;
        }
        .style130
        {
            width: 207px;
            text-align: center;
        }
        .style139
        {
            width: 175px;
        }
        .style140
        {
            color: #FF0000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
            <h1 class="style1">Enviar Comprobante de Pago</h1>
            <br />
            <div>
                <table>
                    <tr>
              
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Cuenta Principal: " Visible="true" 
                                style="font-weight: 700" />
                            <asp:Label ID="LblIdEmpresa" runat="server" Visible="true" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:Label ID="Label21" runat="server" Text="RFC: " Visible="true"   style="font-weight: 700" />
                            <asp:Label ID="LblRFC" runat="server"  Visible="true  "></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:Label ID="Label22" runat="server" Text="Correo:" style="font-weight: 700" ></asp:Label>
                            <asp:Label ID="lblcorreo" runat="server" ></asp:Label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>

                    </tr> 
                    <caption>
                     
                       
                        <caption>
                            
                        </caption>
                       
                    </caption>
                </table>
            </div>
           <br /> &nbsp;<asp:Label ID="Label2" runat="server" style="font-weight: 700" Text="Asesor de ventas: " Visible="true" />
            <asp:Label ID="LblIdPromotor" runat="server" Visible="true" />
            <asp:Label ID="LblIdPromotor0" runat="server" Visible="true" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label23" runat="server" style="font-weight: 700" Text="Correo:"></asp:Label>
            <asp:Label ID="lblcorreo0" runat="server"></asp:Label>
            <asp:Label ID="lblcorreo1" runat="server"></asp:Label>
            <br />
            <asp:Panel ID="Pnl1" runat="server" BorderStyle="Double" CssClass="page2" HorizontalAlign="Center" Width="100%">
                <table>
                    <tr>
                                    <td colspan="6">
                                        <h1 class="style1">Datos del Pago</h1>
                                    </td>
                                </tr>
                    <tr>
                        <td valign="top">
                            <table  class="table-hover" runat="server" id="TB1">
                                
                                                       
                               <tr>
                             
                                    <td style="text-align: right; font-weight: 700;" class="style129">&nbsp;</td>
                                    <td>
                                        <asp:RadioButtonList ID="rbStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbStatus_SelectedIndexChanged" RepeatDirection="Horizontal" Height="34px" Width="204px">
                                            <asp:ListItem Text="Folios" Value="Facturación Completa" />
                                            <asp:ListItem Text="Timbrado" Value="Timbrado" />
                                        </asp:RadioButtonList>
                                    </td>
                                  
                                           <td class="style138"> <%--<input type="button" value="Costos" onclick="javascript: window.open('http://ntlink2.com.mx/#work', '', 'width=600,height=400,left=50,top=50,toolbar=yes');" class="btn btn-primary" />--%> 
     </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; font-weight: 700;">

                                        *Paquete:</td>
                                    <td>

                                        <asp:DropDownList ID="ddlPaquete" runat="server" AutoPostBack="True" CssClass="form-control2" Width="210px">
                                        </asp:DropDownList>

                                    </td>
                                    <td>

                                        <asp:RadioButtonList ID="rbcant" runat="server" AutoPostBack="true" 
                                            OnSelectedIndexChanged="rbcant_SelectedIndexChanged" 
                                            RepeatDirection="Horizontal" Visible="False" style="font-weight: 700">
                                            <asp:ListItem Text="Facturación" Value="Facturación" />
                                            <asp:ListItem Text="Nomina" Value="Nómina" />
                                            <asp:ListItem Text="Ambos" Value="Ambos" />
                                        </asp:RadioButtonList>

                                    </td>
                                    <td colspan="2">
                                    
                                        <asp:Label ID="txtfac" runat="server" Text="Facturación :" Visible="False" 
                                            style="font-weight: 700"></asp:Label>
                                        <asp:TextBox ID="cantif" runat="server" Height="16px"  Visible="False" 
                                            Width="26px"></asp:TextBox>
                                        <asp:Label ID="txtnom" runat="server" Text="Nómina :" Visible="False" 
                                            style="font-weight: 700"></asp:Label>
                                        <asp:TextBox ID="cantin" runat="server" Height="16px" Visible="False" 
                                            Width="26px"></asp:TextBox>
                                     
                                    </td>
                                    <td>

                                    </td>

                                </tr>
<tr>

    <td style="text-align: right">

        &nbsp;</td>

    <td>
        
        &nbsp;</td>
    <td colspan ="2">
        &nbsp;</td>
</tr>

<tr>
                                    <td colspan="6">
                                        <h1 class="style1">Datos Bancarios</h1>
                                    </td>
                                </tr>
                                <caption>
                                    <br>
                                   
                                    <tr>
                                        <td class="style139" style="text-align: right; font-weight: 700;">
                                            *Monto $</td>
                                        <td class="style158" style="text-align: left">
                                            <asp:TextBox ID="txtMonto" runat="server" CssClass="form-control2" Height="18px" Width="133px" />
                                        </td>
                                        <td class="style129">
                                            <asp:Label ID="Label3" runat="server" Text="Tipo de Pago: " Visible="true" />
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlTipodePago" runat="server" AutoPostBack="True" 
                                                CssClass="form-control2" 
                                                OnSelectedIndexChanged="ddlTipodePago_SelectedIndexChanged" Width="150px">
                                                <asp:ListItem runat="server" Text="Seleccionar" Value="00" />
                                                <asp:ListItem runat="server" Text="Deposito" Value="Deposito" />
                                                <asp:ListItem runat="server" Text="Cheque" Value="Cheque" />
                                                <asp:ListItem runat="server" Text="Transferencia" Value="Transferencia" />
                                            </asp:DropDownList>
                                        </td>
                                        <td class="style128" style="text-align: right; font-weight: 700;">
                                            *Referencia:
                                        </td>
                                        <td class="style158" style="text-align: left">
                                            <asp:TextBox ID="txtReferencia" runat="server" CssClass="form-control2" Width="133px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="rfvMonto" runat="server" 
                                                ControlToValidate="txtMonto" Display="Dynamic" ErrorMessage="* Requerido" 
                                                Style="color: #FF0000; font-size: medium;" ValidationGroup="Enviar" />
                                            <asp:CompareValidator ID="cvMonto" runat="server" ControlToValidate="txtMonto" 
                                                Display="Dynamic" ErrorMessage="* Monto no valido" Operator="DataTypeCheck" 
                                                Style="color: #FF0000; font-size: medium;" Type="Double" 
                                                ValidationGroup="Enviar" />
                                        </td>
                                        <td>
                                        </td>
                                        <td align="left">
                                            &nbsp;</td>
                                        <td class="style139">
                                            <asp:RequiredFieldValidator ID="rfvReferencia" runat="server" ControlToValidate="txtReferencia" Display="Dynamic" ErrorMessage="* Requerido" Style="font-size: medium; color: #FF0000;" ValidationGroup="Enviar" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style129" style="text-align: right; font-weight: 700;">
                                            *Fecha de Pago
                                        </td>
                                        <td class="style146">
                                            <asp:TextBox ID="txtFechaPago" runat="server" CssClass="form-control2" 
                                                Width="133px" />
                                            <asp:CalendarExtender ID="ceFechaInicial" runat="server" Animated="False" 
                                                Format="dd/MM/yyyy" PopupButtonID="txtFechaPago" 
                                                TargetControlID="txtFechaPago" />
                                        </td>
                                        <td class="style130" style="font-weight: 700;">
                                            *Hora: (hh:mm:ss)
                                        </td>
                                        <td style="text-align: left">
                                            <asp:TextBox ID="txtHora" runat="server" CssClass="form-control2" 
                                                MaxLength="8" Width="133px"/>
                                            <asp:DropDownList ID="ddlHora" runat="server" AutoPostBack="True" 
                                                Visible="false" Width="50px">
                                                <asp:ListItem runat="server" Text="a.m." Value="am" />
                                                <asp:ListItem runat="server" Text="p.m." Value="pm" />
                                            </asp:DropDownList>
                                        </td>
                                        <td class="style139" style="text-align: right; font-weight: 700;">
                                            Comentarios:
                                        </td>
                                        <td class="style158" style="text-align: left">
                                            <asp:TextBox ID="txtDetalles" runat="server" CssClass="form-control2" 
                                                TextMode="MultiLine" Width="134px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style129" />
                                        <td align="left">
                                            <asp:RequiredFieldValidator ID="rfvFecha" runat="server" 
                                                ControlToValidate="txtFechaPago" Display="Dynamic" ErrorMessage="* Requerido" 
                                                Style="font-size: medium; color: #FF0000;" ValidationGroup="Enviar" />
                                            <asp:CompareValidator ID="cvFechaInicial" runat="server" 
                                                ControlToValidate="txtFechaPago" Display="Dynamic" 
                                                ErrorMessage="* Fecha Invalida" ForeColor="#FF0000" Operator="DataTypeCheck" 
                                                Type="Date" />
                                        </td>
                                        <td class="style128" />
                                        <td align="left">
                                            <asp:RequiredFieldValidator ID="rfvHora" runat="server" 
                                                ControlToValidate="txtHora" Display="Dynamic" ErrorMessage="* Requerido" 
                                                Style="font-size: medium; color: #FF0000;" ValidationGroup="Enviar" />
                                        </td>
                                        <td class="style139" />
                                    </tr>
                                    <tr>
                                        <td class="style129" style="text-align: right; font-weight: 700;">
                                            Comprobante:
                                        </td>
                                        <td colspan="5">
                                            <asp:FileUpload ID="archivoPagos" runat="server" CssClass="form-control2" 
                                                Width="300px" />
                                        </td>
                                        <td colspan="5">
                                            <asp:Label ID="lblValidacion" runat="server" ForeColor="#FF0000" 
                                                Visible="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style129" />
                                        <td>
                                            <asp:RegularExpressionValidator ID="REGEXFileUploadLogo" runat="server" 
                                                ControlToValidate="archivoPagos" ErrorMessage="Archivo no Admitido" 
                                                ValidationExpression="(.*).(.jpg|.JPG|.gif|.GIF|.jpeg|.JPEG|.bmp|.BMP|.png|.PNG|.pdf|.PDF)$" />
                                            <asp:RequiredFieldValidator ID="archivosPagos" runat="server" 
                                                ControlToValidate="archivoPagos" CssClass="alert-error" Display="Dynamic" 
                                                ErrorMessage="* Requerido" style="font-size: medium" ValidationGroup="Enviar" />
                                        </td>
                                    </tr>
                                    
                                   
                      </table> 
                        <table class="table-hover">  
                               <tr>
                               <td colspan="6">
                                        <h1 class="style1">Datos para Facturación</h1>
                                    </td>
                                 </tr> 
                                
                                     <tr>
                                         <td colspan="3">
                                             <p>
                                                 <span class="style140">Si desea que se facture a una empresa diferente a la 
                                                 registrada, favor de llenar los sig. datos.</span>
                                             </p>
                                             <br />
                                         </td>
                                     </tr>
                                     <tr>
                                         <td class="style129" style="text-align: right; font-weight: 700;">
                                             <span class="style160" style="color: #FF0000">*</span>
                                             <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                                 Font-Size="8pt" style="color: #000" Text="RFC:"></asp:Label>
                                         </td>
                                         <td align="left" class="style140">
                                             <asp:TextBox ID="txtRFC" runat="server" CssClass="form-control2" MaxLength="40" 
                                                 Width="200px"></asp:TextBox>
                                         </td>
                                         <td class="style129" style="text-align: right; font-weight: 700;">
                                             <span class="style160" style="color: #ff0000; text-align: right;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *</span>
                                             <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                                 Font-Size="8pt" style="color: #000; text-align: right;" Text="Razón Social:"></asp:Label>
                                         </td>
                                         <td align="left" class="style29">
                                             <asp:TextBox ID="txtEmpresa" runat="server" CssClass="form-control2" 
                                                 MaxLength="500" Width="250px"></asp:TextBox>
                                         </td>
                                     </tr>
                                     <tr>
                                         <td class="style129" style="text-align: right; font-weight: 700;">
                                             <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                                 Font-Size="8pt" style="color: #000" Text="Correo: "></asp:Label>
                                         </td>
                                         <td align="left" class="style140">
                                             <asp:TextBox ID="txtcorreo" runat="server" CssClass="form-control2" 
                                                 MaxLength="200" Width="200px"></asp:TextBox>
                                         </td>
                                         <td class="style129" style="font-weight: 700;">
                                             <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                                 Font-Size="8pt" style="color: #000; text-align: right;" Text="Dirección : "></asp:Label>
                                            
                                         </td>
                                         <td align="left" class="style29">
                                             <asp:TextBox ID="txtExtension" runat="server" CssClass="form-control2" 
                                                 MaxLength="300" Width="250px" TextMode="MultiLine"></asp:TextBox>
                                         </td>
                                     </tr>
                                     <tr>
                                         <td style="text-align: right; font-weight: 700;" width="15%">
                                             <span class="style160" style="color: #FF0000">*</span>
                                             <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Names="Verdana" 
                                                 Font-Size="8pt" style="color: #000" Text="Código Postal:"></asp:Label>
                                         </td>
                                         <td align="left" class="style29">
                                             <asp:TextBox ID="txtCP" runat="server" CssClass="form-control2" 
                                                 MaxLength="5"></asp:TextBox>
                                         </td>
                                     </tr>
                                     <tr>
                                         <td align="center">
                                             &nbsp;</td>
                                         <td>
                                             &nbsp;</td>
                                         <td>
                                             <asp:Button ID="btnEnviar" runat="server" class="btn btn-primary" OnClick="btnEnviar_Click" Text="Enviar pago" ValidationGroup="Enviar" Width="146px" />
                                             <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Confirma que deseas enviar el comprobante" TargetControlID="btnEnviar" />
                                         </td>
                                     </tr>
                               </caption>
                             
                            </table>
                        </td>
                        <td style="width: 30%" valign="top">
                            <table>
                                <tr>
                                    <td><img visible="false" alt="NTLink" src="images/D.jpg" style="height: 100%; width: 100%; margin-bottom: 0px" runat="server" id="img"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                </table>


                <asp:ModalPopupExtender runat="server" ID="mpeCFDIG" TargetControlID="btngenerarDummy"
        BackgroundCssClass="mpeBack"  PopupControlID="pnlMSG" />

    <asp:Panel runat="server" ID="pnlMSG" Style="text-align: center;"  CssClass="page7"
        BackColor="#A8CF38" Height="98px" Width="418px">
        <h1 class="style161" style="color: #000000; text-align:center">
            <strong>Comprobante enviado correctamente</strong></h1>
        <br />
        <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
        <asp:Button runat="server" ID="Button1" Text="Aceptar"  class="btn btn-primary" OnClick="Button1_Click" />
    </asp:Panel>
    <asp:Button runat="server" ID="btngenerarDummy" Style="display: none;" />



            </asp:Panel>
        </ContentTemplate>
        <Triggers>
                <asp:PostBackTrigger ControlID="btnEnviar" />
            </Triggers>


 

    </asp:UpdatePanel>

</asp:Content>
