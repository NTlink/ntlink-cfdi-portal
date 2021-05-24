<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WfrNomina.aspx.cs" Inherits="GafLookPaid.WfrNomina" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ MasterType VirtualPath="~/Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

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
            width: 19%;
        }
		.style4
        {
            width: 413px;
        }
        .style6
        {
            width: 291px;
        }
        .style7
        {
            width: 239px;
        }
        .style8
        {
            width: 410px;
        }
		</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h1>Generar Recibo de Nómina</h1>
	<p>
		Empresa:&nbsp;<asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True"
		 DataTextField="RazonSocial" DataValueField="idEmpresa" onselectedindexchanged="ddlEmpresa_SelectedIndexChanged" />
	</p>
    <p>
		Empleado:&nbsp;<asp:DropDownList runat="server" ID="ddlClientes" AutoPostBack="True"
		 DataTextField="RazonSocial" DataValueField="idCliente" onselectedindexchanged="ddlClientes_SelectedIndexChanged" />
		<br/>
		<asp:TextBox runat="server" TextMode="MultiLine" ID="txtRazonSocial" Width="500px" Height="75px" Enabled="False" />
	</p>
    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
		    <table width="100%" >
		<tr>
			<td class="style4">
			Status Factura    
			</td>
			<td>
				<asp:DropDownList runat="server" ID="ddlStatusFactura" AutoPostBack="True" >
					<asp:ListItem Value="1" Text="Pagada" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td class="style6">
				<asp:Label runat="server" ID="lblFechaPago" Text="Fecha de Pago" Visible="False" />

			</td>
			<td>
				<asp:TextBox runat="server" ID="txtFechaPago" Width="75px" Visible="False" />
				<asp:CompareValidator runat="server" ID="cvFechaInicial" ControlToValidate="txtFechaPago" Display="Dynamic" 
				 ErrorMessage="* Fecha Invalida" Operator="DataTypeCheck" Type="Date" />
				<asp:CalendarExtender runat="server" ID="ceFechaInicial" Animated="False" PopupButtonID="txtFechaPago" TargetControlID="txtFechaPago" Format="dd/MM/yyyy" />

			</td>
            <td class="style8">
                Tipo de Documento
            </td>
            <td>
            <asp:DropDownList runat="server" ID="ddlTipoDocumento" AutoPostBack="True" >
                <asp:ListItem runat="server" Text="Recibo de Nómina" Value="Egreso" Selected="True" />
            </asp:DropDownList>
            </td>
			
		</tr>
		<tr>
			<td class="style4">Serie:</td>
			<td>
				<asp:TextBox runat="server" ID="txtSerie" Width="75px" />
			</td>
			<td class="style6">Folio:</td>
			<td><asp:TextBox runat="server" ID="txtFolio" Width="75px" /></td>
			<td class="style8">Moneda:</td>
			<td>
				<asp:DropDownList runat="server" ID="ddlMoneda" >
					<asp:ListItem Value="1" Text="MXN" Selected="True" />
                    <asp:ListItem Value="2" Text="USD" />
					 <asp:ListItem Value="3" Text="EUR" />
                            <asp:ListItem Value="4" Text="JPY" />
				</asp:DropDownList>
			</td>
			
			
		</tr>
        <tr> 
        <td class="style4"></td>
        <td>&nbsp;</td>
        <td class="style6"></td>
        <td></td>
        
         </tr>
       <tr >
			<td style="text-align: center; vertical-align:top;" class="style4">
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
                  oncheckedchanged="CheckNA_CheckedChanged"  />&nbsp;<asp:Label ID="Label8" runat="server"
                      Text="Label">(Solo aplica para este caso:“Regla RMF 2.7.1.32.”) </asp:Label><br />
        
              <asp:CheckBox ID="Check99" runat="server" Text="99-Otros" AutoPostBack="True"
                  oncheckedchanged="Check99_CheckedChanged"  />

             
       
			</td>
			
			<td colspan="2" style=" vertical-align:top;" >
				 <asp:TextBox ID="txtMetodoPagoMul" runat="server" Enabled="False"  CssClass="page2"
                    TextMode="MultiLine" Width="100%" Height="72px" /> <br />
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
	<td style="text-align: right;" class="style4">
		        Sucursal
	        </td>
	        <td >
		        <asp:DropDownList runat="server" ID="ddlSucursales" AppendDataBoundItems="True" DataValueField="LugarExpedicion"
		         DataTextField="Nombre" />			
	        </td>
	        <td colspan="2">
		        Observaciones
	        </td>
	        <td colspan="2" >
		        <asp:TextBox runat="server" ID="txtProyecto" />
	        </td>
        </tr>
        <tr>
            <td style="text-align: right;" class="style4">
		        Forma de Pago
	        </td>
	        <td width="25%">
		        <asp:DropDownList runat="server" ID="ddlCondicionesPago" AutoPostBack="True" 
                    onselectedindexchanged="ddlCondicionesPago_SelectedIndexChanged">
		            <asp:ListItem runat="server" Text="Pago en una sola exhibición" Value="Pago en una sola exhibición"></asp:ListItem>
                    <asp:ListItem runat="server" Text="En parcialidades" Value="En parcialidades"></asp:ListItem>
		        </asp:DropDownList>
	        </td>
        </tr>
	</table>
    

    <asp:TabContainer runat="server" ID="cfdTabContainer" Width="100%" 
        ActiveTabIndex="2" >
            <asp:TabPanel ID="TabPanel4" runat="server" HeaderText="Datos Nómina Empleado">
            <ContentTemplate>
                <table>
                    <tr>
                        <td><h3><asp:Label ID="Label4" runat="server" Text="Datos de Nómina"></asp:Label></h3></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="Label5" runat="server" Text="* Número de Empleado:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ID="txtNumEmpleado"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblNumEmpleado" ForeColor="Red"></asp:Label></td>
                   
                        
                        <td><asp:Label ID="Label6" runat="server" text="* Tipo de Régimen:"></asp:Label></td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlRegimen" Width="400">
                                    <asp:ListItem  Value="2" Text="Sueldos y salarios" />
                                    <asp:ListItem  Value="3" Text="Jubilados" />
                                    <asp:ListItem  Value="4" Text="Pensionados" />
                                    <asp:ListItem  Value="5" Text="Asimilados a salarios, Miembros de las Sociedades Cooperativas de Producción." />
                                    <asp:ListItem  Value="6" Text="Asimilados a salarios, Integrantes de Sociedades y Asociaciones Civiles" />
                                    <asp:ListItem  Value="7" Text="Asimilados a salarios, Miembros de consejos directivos, de vigilancia, consultivos, honorarios a administradores, comisarios y gerentes generales." />
                                    <asp:ListItem  Value="8" Text="Asimilados a salarios, Actividad empresarial (comisionistas)" />
                                    <asp:ListItem  Value="9" Text="Asimilados a salarios, Honorarios asimilados a salarios" />
                                    <asp:ListItem  Value="10" Text="Asimilados a salarios, Ingresos acciones o títulos valor" />
                            </asp:DropDownList>

                            <br/><asp:Label runat="server" ID="lblRegimen" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="Label13" runat="server" Text="Número Seguridad Social:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ID="txtNumSeguridadSocial"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblNumSeguridadSocial" ForeColor="Red"></asp:Label></td>
                        <td><asp:Label ID="Label14" runat="server" Text="Departamento"></asp:Label></td>
                        <td><asp:TextBox runat="server" ID="txtDepartamento"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblDepartamento" ForeColor="Red"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="Label15" runat="server" Text="CLABE:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ID="txtClabe"></asp:TextBox>
                            <br /><asp:Label ID="lblClabe" runat="server" ForeColor="Red"></asp:Label></td>
                        <td><asp:Label ID="Label16" runat="server" Text="Banco:"></asp:Label></td>
                        <td><asp:DropDownList runat="server" ID="ddlBanco">
                                <asp:ListItem  Value="002" Text="BANAMEX " />
                                <asp:ListItem  Value="006" Text="BANCOMEXT " />
                                <asp:ListItem  Value="009" Text="BANOBRAS " />
                                <asp:ListItem  Value="012" Text="BBVA BANCOMER " />
                                <asp:ListItem  Value="014" Text="SANTANDER " />
                                <asp:ListItem  Value="019" Text="BANJERCITO " />
                                <asp:ListItem  Value="021" Text="HSBC " />
                                <asp:ListItem  Value="030" Text="BAJIO " />
                                <asp:ListItem  Value="032" Text="IXE " />
                                <asp:ListItem  Value="036" Text="INBURSA " />
                                <asp:ListItem  Value="037" Text="INTERACCIONES " />
                                <asp:ListItem  Value="042" Text="MIFEL " />
                                <asp:ListItem  Value="044" Text="SCOTIABANK " />
                                <asp:ListItem  Value="058" Text="BANREGIO " />
                                <asp:ListItem  Value="059" Text="INVEX " />
                                <asp:ListItem  Value="060" Text="BANSI " />
                                <asp:ListItem  Value="062" Text="AFIRME " />
                                <asp:ListItem  Value="072" Text="BANORTE " />
                                <asp:ListItem  Value="102" Text="THE ROYAL BANK " />
                                <asp:ListItem  Value="103" Text="AMERICAN EXPRESS " />
                                <asp:ListItem  Value="106" Text="BAMSA " />
                                <asp:ListItem  Value="108" Text="TOKYO " />
                                <asp:ListItem  Value="110" Text="JP MORGAN " />
                                <asp:ListItem  Value="112" Text="BMONEX " />
                                <asp:ListItem  Value="113" Text="VE POR MAS " />
                                <asp:ListItem  Value="116" Text="ING " />
                                <asp:ListItem  Value="124" Text="DEUTSCHE " />
                                <asp:ListItem  Value="126" Text="CREDIT SUISSE " />
                                <asp:ListItem  Value="127" Text="AZTECA " />
                                <asp:ListItem  Value="128" Text="AUTOFIN " />
                                <asp:ListItem  Value="129" Text="BARCLAYS " />
                                <asp:ListItem  Value="130" Text="COMPARTAMOS " />
                                <asp:ListItem  Value="131" Text="BANCO FAMSA " />
                                <asp:ListItem  Value="132" Text="BMULTIVA " />
                                <asp:ListItem  Value="133" Text="ACTINVER " />
                                <asp:ListItem  Value="134" Text="WAL-MART " />
                                <asp:ListItem  Value="135" Text="NAF136 " />
                                <asp:ListItem  Value="137" Text="BANCOPPEL " />
                                <asp:ListItem  Value="138" Text="ABC CAPITAL " />
                                <asp:ListItem  Value="139" Text="UBS BANK " />
                                <asp:ListItem  Value="140" Text="CONSUBANCO " />
                                <asp:ListItem  Value="141" Text="VOLKSWAGEN " />
                                <asp:ListItem  Value="143" Text="CIBANCO " />
                                <asp:ListItem  Value="145" Text="BBASE " />
                                <asp:ListItem  Value="166" Text="BANSEFI " />
                                <asp:ListItem  Value="168" Text="HIPOTECARIA FEDERAL " />
                                <asp:ListItem  Value="600" Text="MONEXCB " />
                                <asp:ListItem  Value="601" Text="GBM " />
                                <asp:ListItem  Value="602" Text="MASARI " />
                                <asp:ListItem  Value="605" Text="VALUE " />
                                <asp:ListItem  Value="606" Text="ESTRUCTURADORES " />
                                <asp:ListItem  Value="607" Text="TIBER " />
                                <asp:ListItem  Value="608" Text="VECTOR " />
                                <asp:ListItem  Value="610" Text="B&B " />
                                <asp:ListItem  Value="614" Text="ACCIVAL " />
                                <asp:ListItem  Value="615" Text="MERRILL LYNCH " />
                                <asp:ListItem  Value="616" Text="FINAMEX " />
                                <asp:ListItem  Value="637" Text="ORDER " />
                                <asp:ListItem  Value="638" Text="AKALA " />
                                <asp:ListItem  Value="640" Text="CB JPMORGAN " />
                                <asp:ListItem  Value="642" Text="REFORMA " />
                                <asp:ListItem  Value="646" Text="STP " />
                                <asp:ListItem  Value="647" Text="TELECOMM " />
                                <asp:ListItem  Value="648" Text="EVERCORE " />
                                <asp:ListItem  Value="649" Text="SKANDIA " />
                                <asp:ListItem  Value="651" Text="SEGMTY " />
                                <asp:ListItem  Value="652" Text="ASEA " />
                                <asp:ListItem  Value="653" Text="KUSPIT " />
                                <asp:ListItem  Value="655" Text="SOFIEXPRESS " />
                                <asp:ListItem  Value="656" Text="UNAGRA " />
                                <asp:ListItem  Value="659" Text="OPCIONES EMPRESARIALES DEL NOROESTE " />
                                <asp:ListItem  Value="901" Text="CLS " />
                                <asp:ListItem  Value="902" Text="INDEVAL " />
                                <asp:ListItem  Value="670" Text="LIBERTAD " />
                        </asp:DropDownList>
                            <br/><asp:Label runat="server" ID="lblBanco" ForeColor="Red"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="Label17" runat="server" Text="Fecha inicio laboral:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ID="txtFechaInicialLaboral"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblFechaInicialLaboral" ForeColor="Red"></asp:Label></td>
                        <asp:CalendarExtender runat="server" TargetControlID="txtFechaInicialLaboral" Format="yyyy-MM-dd" ID="CalendarExtender3" />
                        <td>
                            CURP
                            
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtCURP" Width="200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="Label19" runat="server" Text="Puesto:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ID="txtPuesto"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblPuesto" ForeColor="Red"></asp:Label></td>
                        <td><asp:Label ID="Label20" runat="server" text="Tipo de Contrato:"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtTipoContrato" runat="server" 
                                ToolTip="Base, Evential, Confianza, Sindicalizado, a prueba, etc." />
                            <br/><asp:Label runat="server" ID="lblTipoContrato" ForeColor="Red"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="Label21" runat="server" Text="Tipo de jornada:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ToolTip="Diurna, nocturna, mixta, por hora, reducida, continua, partida, por turnos, etc." ID="txtTipoJornada"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblTipoJornada" ForeColor="Red"></asp:Label></td>
                        <td><asp:Label ID="Label22" runat="server" Text="* Periodicidad de pago:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ToolTip="diario, semanal, quincenal, catorcenal mensual, bimestral, unidad de obra, comisión, precio alzado, etc." ID="txtPeriodicidadPago"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblPeriodicidadPago" ForeColor="Red"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="Label23" runat="server" Text="Salario base CotApor:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ID="txtSalarioBaseCotApor"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblSalarioBaseCotApor" ForeColor="Red"></asp:Label></td>
                        <td><asp:Label ID="Label24" runat="server" Text="Riesgo del puesto:"></asp:Label></td>
                        <td><asp:DropDownList runat="server" ID="ddlRiesgoPuesto">
                                <asp:ListItem Text="Clase I" Value="1" />
                                <asp:ListItem Text="Clase II" Value="2" />
                                <asp:ListItem Text="Clase III" Value="3" />
                                <asp:ListItem Text="Clase VI" Value="4"/>
                                <asp:ListItem Text="Clase C" Value="5" />
                            </asp:DropDownList>
                            <br/><asp:Label runat="server" ID="lblRiesgoPuesto" ForeColor="Red"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="Label25" runat="server" Text="Salario Diario Integro:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ID="txtSalarioDiarioIntegro"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblSalarioDiarioIntegro" ForeColor="Red"></asp:Label></td>
                        <td></td><td></td>
                    </tr>
                </table>
            </ContentTemplate>
            </asp:TabPanel>
    
            <asp:TabPanel ID="TabPanel1" runat="server" HeaderText="Datos Nómina">
                <ContentTemplate>
                <table>
                    <tr>
                        <td><h3><asp:Label ID="Label58" runat="server" Text="Datos de Nómina"></asp:Label></h3></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="Label10" runat="server" Text="* Registro Patronal:"></asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="txtRegistroPatronal"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ValidationGroup="CrearFactura" ControlToValidate="txtRegistroPatronal" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="Label12" runat="server" text="* Fecha de Pago:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtFechaPagoNomina"></asp:TextBox>
                            <br/>
                        <asp:CalendarExtender runat="server" TargetControlID="txtFechaPagoNomina" Format="yyyy-MM-dd" ID="calExt" />
                        </td>

                    </tr>
                    <tr>
                        <td><asp:Label ID="Label1" runat="server" Text="* Fecha de Inicio del Pago:"></asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="txtFechaInicio"></asp:TextBox>
                            <asp:CalendarExtender runat="server" TargetControlID="txtFechaInicio" Format="yyyy-MM-dd" ID="CalendarExtender2" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="CrearFactura" ControlToValidate="txtFechaInicio" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" text="* Fecha Final del Pago::"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtFechaFin"></asp:TextBox>
                        <asp:CalendarExtender runat="server" TargetControlID="txtFechaFin" Format="yyyy-MM-dd" ID="CalendarExtender1" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="CrearFactura" ControlToValidate="txtFechaFin" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
                        </td>

                    </tr>
                    <tr>
                        <td><asp:Label ID="Label3" runat="server" Text="* Días Pagados:"></asp:Label></td>
                        <td>
                            <asp:TextBox runat="server" ID="txtDiasPagados"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDiasPagados" ErrorMessage="Campo Obligatorio" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>

                        </td>

                    </tr>
                </table>
                </ContentTemplate>
            </asp:TabPanel>
            <asp:TabPanel ID="TabPanel5" HeaderText="Concepto de pago" runat="server">
                <ContentTemplate>
                    <table>
                        <tr>
                        <td><asp:Label ID="Label7" runat="server" Text="Concepto:"></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="ddlConcepto" runat="server">
                                <asp:ListItem Value="Pago de nómina" Text="Pago de nómina" Selected="True" />
                                <asp:ListItem Value="Aguinaldo," Text="Aguinaldo," />
                                <asp:ListItem Value="Prima vacacional" Text="Prima vacacional" />
                                <asp:ListItem Value="Fondo de Ahorro" Text="Fondo de Ahorro" />
                                <asp:ListItem Value="Liquidación" Text="Liquidación" />
                                <asp:ListItem Value="Finiquito" Text="Finiquito" />


                            </asp:DropDownList>
                            

                        </td>

                    </tr>
                    </table>
                </ContentTemplate>
            </asp:TabPanel>
            
            
    </asp:TabContainer>
    <br/>
    <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="3" Width="100%">

        <asp:TabPanel ID="PanelPercepciones" runat="server" HeaderText="Percepciones">
            <ContentTemplate>
            <asp:Button runat="server" Text="Agregar Percepcion" ID="btnAgregarPercepcion" 
                    onclick="btnAgregarPercepcion_Click" class="btn btn-primary"/>
            <asp:GridView runat="server" ID="gvPercepciones" AutoGenerateColumns="False" 
			Width="100%" ShowHeaderWhenEmpty="True" >
			<Columns>
				
				<asp:BoundField HeaderText="Clave" DataField="Clave" >
				<ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
				<asp:BoundField HeaderText="Concepto" DataField="Concepto" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Importe Gravado" DataField="ImporteGravado" DataFormatString="{0:C}"  />
				<asp:BoundField HeaderText="Importe Exento" DataField="ImporteExento" DataFormatString="{0:C}" />
				
			</Columns>
		</asp:GridView>
        </ContentTemplate>
        </asp:TabPanel>
        <asp:TabPanel ID="PanelDeducciones" runat="server" HeaderText="Deducciones">
            <ContentTemplate>
            <asp:Button runat="server" Text="Agregar Deducción" ID="Button1" 
                    OnClick="Button1_Click" class="btn btn-primary"/>
            <asp:GridView runat="server" ID="GvDeducciones" AutoGenerateColumns="False" 
			Width="100%" ShowHeaderWhenEmpty="True" >
			<Columns>
				
				<asp:BoundField HeaderText="Clave" DataField="Clave" >
				<ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
				<asp:BoundField HeaderText="Concepto" DataField="Concepto" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Importe Gravado" DataField="ImporteGravado" DataFormatString="{0:C}"  />
				<asp:BoundField HeaderText="Importe Exento" DataField="ImporteExento" DataFormatString="{0:C}" />
				
			</Columns>
		</asp:GridView>
        </ContentTemplate>
        </asp:TabPanel>
        <asp:TabPanel ID="TabPanel2" runat="server" Visible="False" HeaderText="Incapacidades">
            <ContentTemplate>
            <asp:Button runat="server" Text="Agregar Incapacidad" ID="btnAgregarIncapacidad" class="btn btn-primary"/>
            <asp:GridView runat="server" ID="GridIncapacidad" AutoGenerateColumns="False" 
			Width="100%" ShowHeaderWhenEmpty="True" >
			<Columns>
				<asp:BoundField HeaderText="Dias Incapacidad" DataField="DiasIncapacidad" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Tipo Incapacidad" DataField="TipoIncapacidad" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Descuento" DataField="Descuento" DataFormatString="{0:C}" />
				
			</Columns>
		</asp:GridView>
        </ContentTemplate>
        </asp:TabPanel>
        <asp:TabPanel Visible="False" ID="TabPanel3" runat="server" HeaderText="Horas Extra">
            <ContentTemplate>
            <asp:Button runat="server" Text="Agregar Horas Extra" ID="Button2" class="btn btn-primary"/>
            <asp:GridView runat="server" ID="GridView2" AutoGenerateColumns="False" 
			Width="100%" ShowHeaderWhenEmpty="True" >
			<Columns>
				<asp:BoundField HeaderText="Dias Horas Extra" DataField="Dias" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Tipo Horas" DataField="TipoHoras" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Horas Extra" DataField="HorasExtra"  />
                <asp:BoundField HeaderText="Importe Pagado" DataField="ImportePagado" DataFormatString="{0:C}" />
				
			</Columns>
		</asp:GridView>
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
			
			<tr>
				<td>Percepciones</td>
				<td><asp:Label runat="server" ID="lblTotalPercepciones" /></td>
			</tr>
			<tr>
				<td>Deducciones</td>
				<td><asp:Label runat="server" ID="lblTotalDeducciones" /></td>
			</tr>
            <tr>
				<td>Total</td>
				<td><asp:Label runat="server" ID="lblTotal" /></td>
			</tr>
		</table>
		</div>
	<div style="clear: both"></div>
	<p align="right">
		<asp:Button runat="server" ID="btnLimpiar" Text="Limpiar" class="btn btn-primary"
			onclick="btnLimpiar_Click" Width="80px"/>&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" onclick="btnGenerarPreview_Click" class="btn btn-primary"
		 ValidationGroup="CrearFactura" />&nbsp;&nbsp;&nbsp;
		<asp:Button runat="server" ID="btnGenerarFactura" Text="Generar Factura" onclick="btnGenerarFactura_Click" class="btn btn-primary"
		 ValidationGroup="CrearFactura" />
         <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnGenerarFactura" ConfirmText="Confirma que deseas generar el comprobante"/>
	</p>
    <asp:ModalPopupExtender runat="server" ID="mpeBuscarConcepto" TargetControlID="btnConceptoDummy" BackgroundCssClass="mpeBack"
	 CancelControlID="btnCerrarConcepto" PopupControlID="pnlBuscarConcepto" />
	<asp:Panel runat="server" ID="pnlBuscarConcepto" style="text-align: center;" Width="800px" BackColor="White">
		
        <h1><asp:Label Text="Agregar" ID="lblAgregar" runat="server"></asp:Label></h1>
		<p>
			<table width="100%">
			    <tr runat="server" ID="tdDeduccion">
			        <td style="width: 30%;text-align: right">Tipo Deducción *</td>
			        <td style="width: 40%;text-align: left">
			            <asp:DropDownList runat="server" ID="ddlDeduccion">
			                <asp:ListItem Value="001" Text="Seguridad social" />
                            <asp:ListItem Value="002" Text="ISR" />
                            <asp:ListItem Value="003" Text="Aportaciones a retiro, cesantía en edad avanzada y vejez. " />
                            <asp:ListItem Value="004" Text="Otros " />
                            <asp:ListItem Value="005" Text="Aportaciones a Fondo de vivienda " />
			                <asp:ListItem Value="006" Text="Descuento por incapacidad" />
                            <asp:ListItem Value="007" Text="Pensión alimenticia" />
                            <asp:ListItem Value="008" Text="Renta" />
                            <asp:ListItem Value="009" Text="Préstamos provenientes del Fondo Nacional de la Vivienda para los Trabajadores" />
                            <asp:ListItem Value="010" Text="Pago por crédito de vivienda" />
                            <asp:ListItem Value="011" Text="Pago de abonos INFONACOT" />
			                <asp:ListItem Value="012" Text="Anticipo de salarios"/>
                            <asp:ListItem Value="013" Text="Pagos hechos con exceso al trabajador" />
                            <asp:ListItem Value="014" Text="Errores" />
                            <asp:ListItem Value="015" Text="Pérdidas" />
                            <asp:ListItem Value="016" Text="Averías" />
                            <asp:ListItem Value="017" Text="Adquisición de artículos producidos por la empresa o establecimiento " />
                            <asp:ListItem Value="018" Text="Cuotas para la constitución y fomento de sociedades cooperativas y de cajas de ahorro" />
                            <asp:ListItem Value="019" Text="Cuotas sindicales" />
                            <asp:ListItem Value="020" Text="Ausencia (Ausentismo)" />
                            <asp:ListItem Value="021" Text="Cuotas obrero patronales" />
                        </asp:DropDownList>
                    </td >
                    <td style="width: 30%;text-align: left">
                        
                    </td>
			    </tr>
                <tr runat="server" ID="trPercepcion">
			        <td style="width: 30%;text-align: right">Tipo Percepción</td>
			        <td style="width: 40%;text-align: left">
			            <asp:DropDownList runat="server" ID="ddlPercepcion">
			                <asp:ListItem  Value="001" Text="Sueldos, Salarios  Rayas y Jornales " />
                            <asp:ListItem  Value="002" Text="Gratificación Anual (Aguinaldo) " />
                            <asp:ListItem  Value="003" Text="Participación de los Trabajadores en las Utilidades PTU " />
                            <asp:ListItem  Value="004" Text="Reembolso de Gastos Médicos Dentales y Hospitalarios " />
                            <asp:ListItem  Value="005" Text="Fondo de Ahorro " />
                            <asp:ListItem  Value="006" Text="Caja de ahorro " />
                            <asp:ListItem  Value="009" Text="Contribuciones a Cargo del Trabajador Pagadas por el Patrón " />
                            <asp:ListItem  Value="010" Text="Premios por puntualidad " />
                            <asp:ListItem  Value="011" Text="Prima de Seguro de vida " />
                            <asp:ListItem  Value="012" Text="Seguro de Gastos Médicos Mayores " />
                            <asp:ListItem  Value="013" Text="Cuotas Sindicales Pagadas por el Patrón " />
                            <asp:ListItem  Value="014" Text="Subsidios por incapacidad " />
                            <asp:ListItem  Value="015" Text="Becas para trabajadores y/o hijos " />
                            <asp:ListItem  Value="016" Text="Otros " />
                            <asp:ListItem  Value="017" Text="Subsidio para el empleo " />
                            <asp:ListItem  Value="019" Text="Horas extra " />
                            <asp:ListItem  Value="020" Text="Prima dominical " />
                            <asp:ListItem  Value="021" Text="Prima vacacional " />
                            <asp:ListItem  Value="022" Text="Prima por antigüedad " />
                            <asp:ListItem  Value="023" Text="Pagos por separación " />
                            <asp:ListItem  Value="024" Text="Seguro de retiro " />
                            <asp:ListItem  Value="025" Text="Indemnizaciones " />
                            <asp:ListItem  Value="026" Text="Reembolso por funeral " />
                            <asp:ListItem  Value="027" Text="Cuotas de seguridad social pagadas por el patrón " />
                            <asp:ListItem  Value="028" Text="Comisiones " />
                            <asp:ListItem  Value="029" Text="Vales de despensa " />
                            <asp:ListItem  Value="030" Text="Vales de restaurante " />
                            <asp:ListItem  Value="031" Text="Vales de gasolina " />
                            <asp:ListItem  Value="032" Text="Vales de ropa " />
                            <asp:ListItem  Value="033" Text="Ayuda para renta " />
                            <asp:ListItem  Value="034" Text="Ayuda para artículos escolares " />
                            <asp:ListItem  Value="035" Text="Ayuda para anteojos " />
                            <asp:ListItem  Value="036" Text="Ayuda para transporte " />
                            <asp:ListItem  Value="037" Text="Ayuda para gastos de funeral " />
                            <asp:ListItem  Value="038" Text="Otros ingresos por salarios " />
                            <asp:ListItem  Value="039" Text="Jubilaciones, pensiones o haberes de retiro " />
                        </asp:DropDownList>
                    </td >
                    <td style="width: 30%;text-align: left">
                        
                    </td>
			    </tr>
                
                <tr>
			        <td style="width: 30%;text-align: right">Importe Gravado</td>
			        <td style="width: 40%;text-align: left"><asp:TextBox ID="txtImporteGravado" Display="Dynamic" ValidationGroup="agregar" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="agregar" ControlToValidate="txtImporteGravado" ErrorMessage="Campo Obligatorio" runat="server" ></asp:RequiredFieldValidator></td>
			    </tr>
                <tr>
			        <td style="width: 30%;text-align: right">Importe Excento</td>
			        <td style="width: 40%;text-align: left"><asp:TextBox ID="txtImporteExcento" Display="Dynamic" ValidationGroup="agregar" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="agregar" ControlToValidate="txtImporteExcento" ErrorMessage="Campo Obligatorio" runat="server" ></asp:RequiredFieldValidator>
                    </td>
			    </tr>
			</table>
            <div>
                <asp:Label runat="server" ID="lblErrorPercepcion"></asp:Label>
            </div>
        <br/>
		<%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
        <div align="right">
            <asp:Button runat="server" ID="btnCerrarConcepto" Text="Cancelar" class="btn btn-primary"/>
        <asp:Button runat="server" ID="btnAceptar" Text="Aceptar" ValidationGroup="agregar" class="btn btn-primary"
                onclick="btnAceptar_Click" />
        </div>
		
	</asp:Panel>
	<asp:Button runat="server" ID="btnConceptoDummy" style="display: none;"/>

	</ContentTemplate>
	<Triggers>
		<asp:PostBackTrigger ControlID="btnLimpiar" />
		
		<asp:PostBackTrigger ControlID="BtnVistaPrevia"/>
       
        
	</Triggers>
    </asp:UpdatePanel>
    
    

</asp:Content>
