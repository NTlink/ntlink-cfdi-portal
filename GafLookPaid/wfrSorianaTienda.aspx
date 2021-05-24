<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrSorianaTienda.aspx.cs" Inherits="GafLookPaid.wfrSorianaTienda" %>
<%@ MasterType VirtualPath="~/Site.Master" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	.mpeBack
	{
		background-color: Gray;
		filter: alpha(opacity=70);
		opacity: 0.7;
	}
	.style1
	{
		width: 38%;
	}
        .style2
        {
            height: 24px;
        }
        .style3
        {
            width: 100%;
        }
        .style4
        {
            width: 2px;
        }
        .style18
        {
            width: 15px;
        }
        .style19
        {
            height: 29px;
        }
        .style20
        {
            width: 2px;
            height: 29px;
        }
        .style21
        {
            width: 15px;
            height: 29px;
        }
        .style22
        {
            width: 278px;
        }
        .style23
        {
            color: #000099;
        }
        .style24
        {
            width: 19%;
        }
        .style25
        {
            width: 274px;
        }
        .style26
        {
            width: 256px;
        }
        .style27
        {
            width: 156px;
        }
    </style>
	
	<h1>Generar CFDI&nbsp; soriana tienda </h1>
	<asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
	<p>
		Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True"
		 DataTextField="RazonSocial" DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresa_SelectedIndexChanged" />
	</p>
	<table width="90%" >
		<tr>
			<td style="text-align: left">
				Status Factura    
			</td>
			<td>
				<asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="True" 
					onselectedindexchanged="ddlStatusFactura_SelectedIndexChanged" >
					<asp:ListItem Value="0" Text="Pendiente"></asp:ListItem>
					<asp:ListItem Value="1" Text="Pagada"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td style="text-align: left">
				<asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago" Visible="False" />

			</td>
			<td>
				<asp:TextBox runat="server" ID="txtFechaPago" Width="75px" Visible="False" />
				<asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago" Display="Dynamic" 
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago" TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />

			</td>
			 <td style="text-align: left">
                        Tipo de Documento
                    </td>
                    <td>
                        <asp:DropDownList runat="server" ID="ddlTipoDocumento">
                            <asp:ListItem runat="server" Text="Factura" Value="Ingreso" Selected="True" />
                            <asp:ListItem runat="server" Text="Nota de Crédito" Value="Egreso" />
                            
                        </asp:DropDownList>
                    </td>
		</tr>
		<tr>
			<td style="text-align: left">Serie:</td>
			<td>
				<asp:TextBox runat="server" ID="txtSerie" Width="75px" />
			</td>
			<td style="text-align:left">Folio:</td>
			<td><asp:TextBox runat="server" ID="txtFolio" Width="50px" Enabled="False" /></td>
			<td style="text-align: left">Moneda:</td>
			<td>
				<asp:DropDownList runat="server" ID="ddlMoneda" onselectedindexchanged="ddlMoneda_SelectedIndexChanged">
					<asp:ListItem Value="1" Text="MXN" />
					<asp:ListItem Value="2" Text="USD" />
                     <asp:ListItem Value="3" Text="EUR" />
                            <asp:ListItem Value="4" Text="JPY" />
				</asp:DropDownList>
			</td>
			<td style="text-align:left"><asp:Label runat="server" ID="lblTipoCambio" Text="Tipo Cambio USD:" Visible="False" /></td>
			<td><asp:TextBox runat="server" ID="txtTipoCambio" Visible="False" Width="50px" /></td>
			<td><%--Días Revisión--%></td>
			<td>
				<asp:TextBox runat="server" ID="txtDiasRevision" Width="50px" Visible="false" />
				<asp:CompareValidator runat="server" ID="cvTxtDiasRevision" ControlToValidate="txtDiasRevision" Display="Dynamic"
				 ErrorMessage="* Dato Inválido" Type="Integer" Operator="DataTypeCheck"  />
			</td>
			<td>
				
			</td>
		</tr>
	</table>
	<p>
                Cliente:&nbsp;<asp:DropDownList runat="server" ID="ddlClientes" AutoPostBack="True"
                    DataTextField="RazonSocial" DataValueField="idCliente" 
                    OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" Height="17px" 
                    Width="137px" />
               &nbsp;&nbsp;
                <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="page1" 
                    Enabled="False" Height="26px" TextMode="MultiLine" Width="291px" />
                  </p>
	
    <tr> 
        <td class="style13"></td>
        <td class="style16"><span class="style23">(NA solo aplica para este caso:“Regla RMF 
            2.7.1.32.”)</span> </td>
        <td class="style26"></td>
        <td></td>
        
         </tr>
	<table width="95%">
		<tr>
			<td colspan="4" style="text-align: center;">
				<h1> Datos de la Factura</h1>
			</td>
		</tr>
		<tr >
			<td style="text-align: center; vertical-align:top;" class="style25">
				Método de Pago
			</td>
			
                 <td colspan="2">
       
              <asp:CheckBox ID="Check01" runat="server" Text="01-Efectivo"
                  AutoPostBack="True" oncheckedchanged="Check01_CheckedChanged" 
                    /><br />
        
              <asp:CheckBox ID="Check02" runat="server" Text="02-Cheque nominativo" 
                  AutoPostBack="True" oncheckedchanged="Check02_CheckedChanged" 
                   /> <br />
        
              <asp:CheckBox ID="Check03" runat="server"  AutoPostBack="True"
                  Text="03-Transferencia electrónica de fondos" 
                  oncheckedchanged="Check03_CheckedChanged1"  
                  /><br />
        
              <asp:CheckBox ID="Check04" runat="server" Text="04-Tarjeta de Crédito"  AutoPostBack="True"
                  oncheckedchanged="Check04_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="Check05" runat="server" Text="05-Monedero Electrónico"  AutoPostBack="True"
                  oncheckedchanged="Check05_CheckedChanged" /><br />
        
              <asp:CheckBox ID="Check06" runat="server" Text="06-Dinero Electrónico"  AutoPostBack="True"
                  oncheckedchanged="Check06_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="Check08" runat="server" Text="08-Vales de despensa" AutoPostBack="True"
                  oncheckedchanged="Check08_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="Check28" runat="server" Text="28-Tarjeta de Débito" AutoPostBack="True"
                  oncheckedchanged="Check28_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="Check29" runat="server" Text="29-Tarjeta de Servicio" AutoPostBack="True"
                  oncheckedchanged="Check29_CheckedChanged"  /><br />
        
              <asp:CheckBox ID="CheckNA" runat="server" Text="NA" AutoPostBack="True"
                  oncheckedchanged="CheckNA_CheckedChanged"  />&nbsp;<asp:Label ID="Label1" runat="server"
                      Text="Label">(Solo aplica para este caso:“Regla RMF 2.7.1.32.”) </asp:Label><br />
        
              <asp:CheckBox ID="Check99" runat="server" Text="99-Otros" AutoPostBack="True"
                  oncheckedchanged="Check99_CheckedChanged"  />

             
       
			</td>
			
			<td colspan="2" style=" vertical-align:top;" >
				 <asp:TextBox ID="txtMetodoPagoMul" runat="server" Enabled="False" CssClass="page2"
                    TextMode="MultiLine" Width="100%" Height="72px" /><br />
                 <br />
                Numero de Cuenta (Últimos 4 dígitos) 
                <asp:TextBox runat="server" ID="txtCuenta"  Width="60%" />
                <br />
			   (En caso de ser multiple separar por comas)
			</td>
			</td>
		</tr>
         
        <tr>
          
         <td colspan="2" style=" vertical-align:top">
             <asp:TextBox ID="txtMetodoPagoMulID" runat="server" Width="329px" 
                 Visible="False"></asp:TextBox>
             </td>
         
        
         </tr>
		<tr >
			<td style="text-align: left;" class="style24">
				Sucursal
			</td>
			<td >
				<asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
					DataTextField="Nombre" />			
			</td>
			<td style="text-align:left" class="style27">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Observaciones
			</td>
			<td >
				<asp:TextBox runat="server" ID="txtProyecto" Width="100%" />
			</td>
		</tr>
		<tr>
    <td style="text-align: left;" class="style24">
		Forma de Pago
	</td>
	<td width="25%">
		<asp:DropDownList runat="server" ID="ddlCondicionesPago" AutoPostBack="True" 
            onselectedindexchanged="ddlCondicionesPago_SelectedIndexChanged">
		    <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="Pago en una sola exhibición"></asp:ListItem>
            <asp:ListItem runat="server" Text="En parcialidades" Value="En parcialidades"></asp:ListItem>
		</asp:DropDownList>
	</td>
    <td style="text-align: left" class="style27">
				&nbsp;</td>
			<td >
				&nbsp;</td>
</tr>
 
		
	</table>
    <div runat="server" ID="divParcialidades" Visible="False">
        <h1 style="text-align: center">Parcialidades</h1>
        <table table width="95%">
        <tr >
	<td style="text-align: left">
		Folio Fiscal Original
	</td>
	<td >
		<asp:TextBox runat="server" ID="txtFolioOriginal"  />			
	</td>
	<td style="text-align:left" class="style3">
		Fecha del Folio Fiscal Original:
	</td>
	<td >
		<asp:TextBox ID="txtFechaOriginal" runat="server"  Width="100%" />
		<asp:CalendarExtender runat="server" ID="ceFechaOriginal" PopupButtonID="txtFechaOriginal" TargetControlID="txtFechaOriginal" />
		<asp:CompareValidator runat="server" ID="dvFechaOriginal" ErrorMessage="* Fecha Invalida" Display="Dynamic"
		 ControlToValidate="txtFechaOriginal" Operator="DataTypeCheck" Type="Date" ValidationGroup="CrearFactura" />
	</td>
</tr>
		<tr >
	<td style="text-align: left;">
		Monto del Folio Fiscal Original
	</td>
	<td >
		 <asp:TextBox runat="server" ID="txtMontoOriginal"  Width="100%" />
		 <asp:CompareValidator runat="server" ID="cvMontoOriginal" ControlToValidate="txtMontoOriginal" Display="Dynamic"
		 ErrorMessage="* Monto invalido" Operator="DataTypeCheck" Type="Currency" ValidationGroup="CrearFactura" />			
	</td>
	
</tr>
		</table>

    </div>
	<asp:TabContainer ID="tabContainerAduana" CssClass="page1" runat="server" Width="100%" 
		ActiveTabIndex="0">
	    <asp:TabPanel HeaderText="Addenda" runat="server" ID="datosAddenda">
			
			<ContentTemplate>
				
				<div align="center">
		            
		<table width="95%" style="width: 94%">
			
			<tr>
				
				<td colspan="2" style="text-align: center;" class="style2">
				    
				<h1>Addenda</h1>
				    
				</td>
				
				<td class="style2" style="text-align: center;">
                </td>
                <td class="style2" style="text-align: center;">
                </td>
				
				<td colspan="2" style="text-align: center;" class="style2">
					
					<h1></h1>
				    
				</td>
			    
			</tr>
			
			<tr>
				
				<td style="text-align: right">
					
					Proveedor:
				</td>
				
				<td style="text-align: left;">
					
					<asp:TextBox ID="txtProAdenda" runat="server"></asp:TextBox>
                    	<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="txtProAdenda" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
				    
				</td>
				
				<td style="text-align: right">
				    
				    Cantidad Bultos:
				</td>
				
				<td style="text-align: left">
                    <asp:TextBox ID="txtCBultos" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="txtCBultos" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
                </td>
                <td class="style4" style="text-align: right">
                </td>
				
				<td style="text-align: left" class="style18">
					
					&nbsp;</td>
			    
			</tr>
			
			
			
			<tr>
				
				<td style="text-align: right">
					
					Remisión:
				</td>
				
				<td style="text-align: left">
					
					<asp:TextBox ID="txtRemision1" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="txtRemision1" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
				    
				</td>
				
				<td style="text-align: right">
				    
				    Descuentos:
				</td>
				
				<td style="text-align: left">
					
					<asp:TextBox ID="txtDesct" runat="server"></asp:TextBox>
				    
				    <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" 
                        ControlToValidate="txtDesct" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto"></asp:RequiredFieldValidator>
				    
				</td>
			    <td class="style4" style="text-align: right">
                   </td>
                <td class="style18" style="text-align: left">
                </td>
			    
			</tr>
			
			<tr>
				
				<td style="text-align: right">
					
					Consecutivo:
				</td>
				
				<td style="text-align: left">
					
					<asp:TextBox ID="txtConsecutivo" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ControlToValidate="txtConsecutivo" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
				    
				</td>
				
				<td style="text-align: right">
				    
				    Otros Impuestos:</td>
				
				<td style="text-align: left">
					
					<asp:TextBox ID="txtOtroImp" runat="server"></asp:TextBox>
				    
				    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" 
                        ControlToValidate="txtOtroImp" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto"></asp:RequiredFieldValidator>
				    
				</td>
			    <td class="style4" style="text-align: right">
                </td>
                <td class="style18" style="text-align: left">
                </td>
			    
			</tr>
			
			<tr>
				
				<td style="text-align: right">
					
					Fecha Remision:
				</td>
				
				<td style="text-align: left">
					
					<asp:TextBox ID="txtFechaRemision" runat="server"></asp:TextBox>
                    <asp:CalendarExtender ID="txtFechaVencimiento0_CalendarExtender" runat="server" 
                        Enabled="True" Format="dd/MM/yyyy" PopupButtonID="txtFechaRemision" 
                        TargetControlID="txtFechaRemision">
                        
                    </asp:CalendarExtender>
                    
                   <asp:CompareValidator ID="cvVencimiento0" runat="server" 
                        ControlToValidate="txtFechaRemision" Display="Dynamic" 
                        ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" 
                        ValidationGroup="CrearFactura"></asp:CompareValidator>
				    
				</td>
				
				<td style="text-align: right">
				    
				    Cantidad Pedidos:</td>
				
				<td style="text-align: left">
					
					<asp:TextBox ID="txtCpedido" runat="server"></asp:TextBox>
				    
				    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" 
                        ControlToValidate="txtCpedido" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto"></asp:RequiredFieldValidator>
				    
				</td>
			    <td class="style4" style="text-align: right">
                </td>
                    <td class="style18" style="text-align: left">
            </td>
			    
			</tr>
			 
			<tr>
				
				<td style="text-align: right">
					
					Tienda:</td>
				
				<td style="text-align: left">
					
					<asp:TextBox ID="txtTiendaAdden" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="txtTiendaAdden" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />

				    

				</td>
				
				<td style="text-align: right">
                    Fecha Entrega Mercancia
				</td>
				
				<td style="text-align: left">
					
					<asp:TextBox ID="txtFechaVencimiento" runat="server"></asp:TextBox>
                    
                    <asp:CalendarExtender ID="ceVencimiento" runat="server" Enabled="True" 
                        Format="dd/MM/yyyy" PopupButtonID="txtFechaVencimiento" 
                        TargetControlID="txtFechaVencimiento">
                        
                    </asp:CalendarExtender>
                    
                    <asp:CompareValidator ID="cvVencimiento" runat="server" 
                        ControlToValidate="txtFechaVencimiento" Display="Dynamic" 
                        ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" 
                        ValidationGroup="CrearFactura"></asp:CompareValidator>
				    
				</td>
			     <td class="style4" style="text-align: right">
                </td>
                 <td class="style18" style="text-align: left">
                </td>
			    
			</tr>
			
			<tr>
				
				<td style="text-align: right" class="style19">
				    
				    Tipo Moneda:
				</td>
				
				<td style="text-align: left" class="style19">
					
					<asp:TextBox ID="txtTipoMoneda" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="txtTipoMoneda" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
				    
				</td>
				
				<td style="text-align: right" class="style19">
                    Folio Nota Entrada:</td>
                <td style="text-align: left" class="style19">
                    <asp:TextBox ID="txtFNentra" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" 
                        ControlToValidate="txtFNentra" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto"></asp:RequiredFieldValidator>
                </td>
				
				<td style="text-align: right" class="style20">
				    
				    </td>
				
				<td style="text-align: left" class="style21">
					
					</td>
			    
			</tr>
			
			<tr>
				
				<td style="text-align: right">
				    
				    Tipo Bulto: </td>
				
				<td style="text-align: left">
					
					<asp:TextBox ID="txtTipoBultos" runat="server" Height="22px"></asp:TextBox>
				    
				    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
                        ControlToValidate="txtTipoBultos" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto"></asp:RequiredFieldValidator>
				    
				</td>
				
			    <td style="text-align: right">
                    
                    PEDIDOS</td>
                
                <td style="text-align: left">
                    
                   </td>
				
			    
				
			</tr>
			
			<tr>
                
                <td style="text-align: right">
                    
                    Entrega Mercancia:
                </td>
                
                <td style="text-align: left">
                    
                    <asp:TextBox ID="txtEmercancia" runat="server"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="txtEmercancia" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
                    
                </td>

                <td style="text-align: right">
                    
                    Cantidad Artículos:</td>
                
                <td style="text-align: left">
                    
                    <asp:TextBox ID="txtCantidadArticulos" runat="server"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" 
                        ControlToValidate="txtCantidadArticulos" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto"></asp:RequiredFieldValidator>
                    
                </td>
            </tr>
            <tr>
                
                <td style="text-align: right">
      </td>
                
                <td style="text-align: left">
                    
</td>
                
                <td style="text-align: right">
        </td>
                <td style="text-align: left">
                    
                    &nbsp;</td>
          
            </tr>
            
            <tr>
                
                <td style="text-align: right">
                    
</td>

                <td style="text-align: left">
                    
</td>

                <td style="text-align: right">
                    
<td style="text-align: left">
</td>

            </tr>
			
			<tr>
				
				<td style="text-align: right">
				    
			</td>
				
				<td style="text-align: left">
					
					</td>
				
		</td>
                <td style="text-align: left">
  </td>
				
				<td style="text-align: right" >
				    
				&nbsp;&nbsp;&nbsp;
				    &nbsp;</td>
				
				<td style="text-align: left" >
					
					</td>
			    
			</tr>
			
			<tr>
				
				<td style="text-align: right">
				</td>
				
				<td style="text-align: left">
					
					&nbsp;</td>
				
				<td style="text-align: left">
                    
</td>
                
                <td style="text-align: left">
                    
</td>
				
				<td style="text-align: right">
				   </td>
				
				<td style="text-align: left" >
					
					</td>
			    
			</tr>


			
		    


			
		</table>
	   
	                
	&nbsp;&nbsp; 
		   
	</div>

			    

			</ContentTemplate>
		    
		</asp:TabPanel>
		<asp:TabPanel ID="tabGeneral" HeaderText="Datos Generales"  CssClass="page1" runat="server">
			
			<HeaderTemplate>
				
				Conceptos
			</HeaderTemplate>
			
			<ContentTemplate>
				
				<div align="center"><h1>Conceptos</h1></div>
	
	            
	
	<table width="95%" >
		
		<tr>
			
			<td style="text-align: right;" width="15%">Cantidad</td>
			
			<td class="style1" >
				
				<asp:TextBox runat="server"  ID="txtCantidad" />
				
				<asp:CompareValidator runat="server" ID="cvCantidad" ControlToValidate="txtCantidad" Display="Dynamic" Type="Double"
				 ErrorMessage="* Cantidad Invalida" ValidationGroup="AgregarConcepto" Operator="DataTypeCheck" />
				
				<asp:RequiredFieldValidator runat="server" ID="rfvCantidad" ControlToValidate="txtCantidad" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
			    
			</td>
			
			<td style="text-align: right;" width="15%">
				
				Unidad
			</td>
			
			<td >
				
				<asp:TextBox runat="server" ID="txtUnidad"  />&nbsp;
		<asp:RequiredFieldValidator runat="server" ID="rfvUnidad" ControlToValidate="txtUnidad" Display="Dynamic"
		 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
			    
			</td>
		    
		</tr>
	   
		 
	    <caption>
            &nbsp;&nbsp; &nbsp;<tr>
                <td style="text-align: right;" width="15%">
                    Código
                </td>
                <td class="style1">
                    <asp:TextBox ID="txtCodigo" runat="server"></asp:TextBox>
                </td>
                <td style="text-align: right;" width="15%">
                    Precio Unitario: $
                </td>
                <td>
                    <asp:TextBox ID="txtPrecio" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPrecio" runat="server" 
                        ControlToValidate="txtPrecio" Display="Dynamic" ErrorMessage="* Requerido" 
                        ValidationGroup="AgregarConcepto"></asp:RequiredFieldValidator>
                    &nbsp;
                    <asp:CompareValidator ID="cvPrecio" runat="server" 
                        ControlToValidate="txtPrecio" Display="Dynamic" 
                        ErrorMessage="* Precio Inválido" Operator="DataTypeCheck" Type="Currency" 
                        ValidationGroup="AgregarConcepto"></asp:CompareValidator>
                </td>
            </tr>
            <caption>
                &nbsp;<tr>
                    <td style="text-align: right;">
                        <asp:CheckBox ID="cbIva" runat="server" AutoPostBack="True" Checked="True" 
                            Text="I.V.A." />
                        &nbsp;
                    </td>
                    <td style="text-align: left;">
                        <asp:TextBox ID="txtIvaConcepto" runat="server" Text="0"></asp:TextBox>
                        &nbsp;%
                        <asp:CompareValidator ID="CompareValidator1" runat="server" 
                            ControlToValidate="txtIvaConcepto" Display="Dynamic" 
                            ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Integer" 
                            ValidationGroup="AgregarConcepto"></asp:CompareValidator>
                        &nbsp;
                    </td>
                    <td style="text-align: right">
                        <asp:CheckBox ID="cbRetencion" runat="server" Text="Retención" />
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtRetencion" runat="server" Text="4"></asp:TextBox>
                        &nbsp;%
                        <asp:CompareValidator ID="CompareRetencion" runat="server" 
                            ControlToValidate="txtRetencion" Display="Dynamic" 
                            ErrorMessage="* Dato Inválido" Operator="DataTypeCheck" Type="Integer" 
                            ValidationGroup="AgregarConcepto"></asp:CompareValidator>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right;" width="15%">
                        Descripción
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" 
                            Width="80%"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" 
                            ControlToValidate="txtDescripcion" Display="Dynamic" ErrorMessage="* Requerido" 
                            ValidationGroup="AgregarConcepto"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <caption>
                    &nbsp;<tr>
                        <td style="text-align: right;" width="15%">
                            &nbsp;&nbsp;&nbsp; &nbsp;</td>
                        <td class="style1">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
                        <td>
                            <asp:Button ID="btnAgregar" runat="server" class="btn btn-primary" 
                                OnClick="btnAgregar_Click" Text="Agregar Concepto" 
                                ValidationGroup="AgregarConcepto" />
                        </td>
                        <td>
                            <asp:Button ID="btnBuscar" runat="server" class="btn btn-primary" 
                                OnClick="btnBuscar_Click" Text="Buscar" Width="80px" />
                            <asp:HiddenField ID="txtIdProducto" runat="server" />
                        </td>
                    </tr>
                </caption>
            </caption>
        </caption>

		
	    

		
	</table>
	            
	<div style="width: 900px">
		
		
		
		<asp:GridView runat="server" ID="gvDetalles" AutoGenerateColumns="False" 
			Width="100%" ShowHeaderWhenEmpty="True" onrowcommand="gvDetalles_RowCommand">
			
			<Columns>
				
				<asp:BoundField HeaderText="Cantidad" DataField="Cantidad" >
				
				<ItemStyle HorizontalAlign="Center" />
                
                </asp:BoundField>
				
				<asp:BoundField HeaderText="Unidad" DataField="Unidad" >
				
				<ItemStyle HorizontalAlign="Center" />
                
                </asp:BoundField>
				
				<asp:BoundField HeaderText="Código" DataField="Codigo" >
				
				<ItemStyle HorizontalAlign="Center" />
                
                </asp:BoundField>
				
				<asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
				
				<asp:BoundField HeaderText="Precio Unitario" DataField="Precio" 
                    DataFormatString="{0:C}" >
				
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				
				<asp:BoundField HeaderText="%I.V.A." DataField="PorcentajeIva" >
				
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				
				<asp:BoundField HeaderText="I.V.A" DataField="ImporteIva" 
                    DataFormatString="{0:C}" >
				
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				
				<asp:BoundField HeaderText="%Retención" DataField="PorcentajeRetencionIva" >
				
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				
				<asp:BoundField HeaderText="Retención" DataField="RetencionIva" 
                    DataFormatString="{0:C}" >
				
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				
				<asp:BoundField HeaderText="Total" DataField="TotalPartida" 
                    DataFormatString="{0:C}" >
				
				<ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
				
				<asp:ButtonField Text="Editar" CommandName="Editar" Visible="False">
				
				<ItemStyle HorizontalAlign="Center" />
                </asp:ButtonField>
				
				<asp:ButtonField Text="Eliminar" CommandName="EliminarConcepto" 
                    Visible="False" >
			    <ItemStyle HorizontalAlign="Center" />
                 </asp:ButtonField>
			    
			</Columns>
		    
		</asp:GridView>
		
		</div>
	
			    
	
			</ContentTemplate>
		    
		</asp:TabPanel>
	</asp:TabContainer>
	<br />
	<asp:UpdateProgress AssociatedUpdatePanelID="up1" ID="UpdateProgress1" runat="server">
	<ProgressTemplate>
	<div align="center" >
		<asp:Image ID="Image1" ImageUrl="images/ajax-loader.gif" runat="server"/> 
		<br />
		CFDI en proceso ..
		</div>
	</ProgressTemplate>
	</asp:UpdateProgress>
	<asp:Label runat="server" ID="lblError" ForeColor="Red" />
	<div style="float: right">
	<table style="text-align:right;" >
		<tr style="width: 150px">
			<td>Subtotal:</td>
			<td><asp:Label runat="server" ID="lblSubtotal" /></td>
		</tr>
		<tr>
			<td>I.V.A.</td>
			<td><asp:Label runat="server" ID="lblIva" /></td>
		</tr>
		<tr>
			<td>Retención I.V.A.</td>
			<td><asp:Label runat="server" ID="lblRetencionIva" /></td>
		</tr>
			
		<tr>
			<td>Total</td>
			<td><asp:Label runat="server" ID="lblTotal" /></td>
		</tr>
		<tr>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
			
			<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	</div>
	<div style="clear: both"></div><div>
		<asp:Label runat="server" ID="lblLeyenda" Text="... "></asp:Label>
	</div>
	<p align="right">
		<asp:Button runat="server" ID="btnLimpiar" Text="Limpiar" class="btn btn-primary"
			onclick="btnLimpiar_Click" Width="70px"/>&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" onclick="btnGenerarPreview_Click" class="btn btn-primary"
		 ValidationGroup="CrearFactura" />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnGenerarFactura" Text="Generar Factura" onclick="btnGenerarFactura_Click" class="btn btn-primary"
		 ValidationGroup="CrearFactura" />
         <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnGenerarFactura" ConfirmText="Confirma que deseas generar el comprobante"/>
	</p>
   
	</ContentTemplate>
	<Triggers>
		<asp:PostBackTrigger ControlID="btnLimpiar" />
		<asp:PostBackTrigger ControlID="tabContainerAduana" />
		<asp:PostBackTrigger ControlID="BtnVistaPrevia"/>
	</Triggers>
	</asp:UpdatePanel>
	<asp:ModalPopupExtender runat="server" ID="mpeBuscarConcepto" TargetControlID="btnConceptoDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCerrarConcepto" PopupControlID="pnlBuscarConcepto" />
	<asp:Panel runat="server" ID="pnlBuscarConcepto" style="text-align: center;" Width="800px" BackColor="White">
		<h1>Buscar Conceptos</h1>
		<p>
			<asp:TextBox runat="server" ID="txtConceptoBusqueda" Width="250px" />&nbsp;&nbsp;&nbsp;
			<asp:Button runat="server" ID="btnBuscarConcepto" Text="Buscar" onclick="btnBuscarConcepto_Click" class="btn btn-primary" />
		</p>
        <div style="height: 400px; overflow-y: scroll"  >
		<asp:Label runat="server" ID="lblMensaje" ForeColor="Red" />
		<asp:GridView runat="server" ID="gvBuscarConceptos" Width="100%" AutoGenerateColumns="False"
		 DataKeyNames="IdProducto" ShowHeaderWhenEmpty="True" 
			onrowcommand="gvBuscarConceptos_RowCommand">
			<Columns>
				<asp:BoundField HeaderText="Código" DataField="Codigo" />
				<asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
				<asp:BoundField HeaderText="Observaciones" DataField="Observaciones" />
				<asp:BoundField HeaderText="Precio" DataField="PrecioP" DataFormatString="{0:C}" />
				<asp:ButtonField  Text="Seleccionar" CommandName="Seleccionar"/>
			</Columns>
		</asp:GridView>
        </div>
		<br />
		<%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
		<asp:Button runat="server" ID="btnCerrarConcepto" Text="Cancelar" class="btn btn-primary"/>
	</asp:Panel>
	<asp:Button runat="server" ID="btnConceptoDummy" style="display: none;" class="btn btn-primary"/>

	<asp:ModalPopupExtender runat="server" ID="mpeEdita" TargetControlID="btnEditarDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCancelar" PopupControlID="panelEditaConcepto" />
	<asp:Panel runat="server" ID="panelEditaConcepto" style="text-align: center;" Width="800px" BackColor="White">
		<h1><asp:Label runat="server" ID="lblConcepto" >Editar Concepto</asp:Label></h1>
		 <table width="600px">
		 <tr>
			<td>Cantidad:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtCantidadEdita" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtCantidadEdita" ValidationGroup="Concepto" />
				 <asp:CompareValidator runat="server" ID="CompareValidator2" ControlToValidate="txtCantidadEdita" Display="Dynamic" Type="Double"
		 ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto" Operator="DataTypeCheck" />
				  <asp:HiddenField runat="server" ID="hidDetalle"/>
				  <asp:HiddenField runat="server" ID="hidNumero"/>
			</td>
		</tr>
		<tr>
			<td>Unidad de Medida:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtUnidadEdita" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtUnidadEdita" ValidationGroup="Concepto" />
			</td>
		</tr>
		<tr>
			<td>N° de identificación:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtCodigoEdita"  Width="400px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td>Descripción:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtDescripcionEdita"  Width="400px"></asp:TextBox>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtDescripcionEdita" ValidationGroup="Concepto" />
			</td>
		</tr>
		<tr>
			<td>Observaciones:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtObservacionesEdita"  Width="400px" ></asp:TextBox>
				
			</td>
		</tr>
		 <tr>
			<td>Precio Unitario:</td>
			<td align="left">
				<asp:TextBox runat="server" ID="txtPrecioUnitarioEdita"  ></asp:TextBox>
				<asp:CompareValidator runat="server" ID="CompareValidator3" ControlToValidate="txtPrecioUnitarioEdita" Display="Dynamic" Type="Double"
		 ErrorMessage="* Cantidad Invalida" ValidationGroup="Concepto" Operator="DataTypeCheck" />
				<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ErrorMessage="* Requerido" Display="Dynamic"
				 ControlToValidate="txtPrecioUnitarioEdita" ValidationGroup="Concepto" />
			</td>
		</tr>

	</table>
	<div align="right">
		<asp:Button runat="server" ID="btnGuardar" Text="Guardar"  class="btn btn-primary"
			ValidationGroup="Concepto" onclick="btnGuardar_Click" style="width: 68px"
			 />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnCancelar" Text="Cancelar" class="btn btn-primary"
			CausesValidation="False" />
	</div>
	<br />
	</asp:Panel>
	<asp:Button runat="server" ID="btnEditarDummy" style="display: none;" class="btn btn-primary"/>
</asp:Content>

