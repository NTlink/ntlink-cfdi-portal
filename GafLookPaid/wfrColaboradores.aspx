<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrColaboradores.aspx.cs" Inherits="GafLookPaid.wfrColaboradores" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <h1>Editar Empleado</h1>
    <p>
        <asp:Label runat="server" ID="lblError" ForeColor="Red" />
    </p>
    <asp:TabContainer runat="server" ID="cfdTabContainer" Width="100%" 
        ActiveTabIndex="0" >
            <asp:TabPanel ID="tabGral" runat="server" HeaderText="Datos del Empleado">
                <ContentTemplate>
                    <table>
                        <tr>
                            <td>Empresa Emisora de Recibos de Nómina:</td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlEmpresa" AppendDataBoundItems="true" DataTextField="RazonSocial" 
                                    DataValueField="IdEmpresa" />
                            </td>
                        </tr>
                        <tr><td /></tr>
                        <tr>
                            <td>RFC:</td>
                            <td><asp:TextBox runat="server" ID="txtRFC" Width="150px" /></td>
                        </tr>
                        <tr>
                            <td>CURP:</td>
                            <td><asp:TextBox runat="server" ID="txtCURP" MaxLength="24" /></td>
                        </tr>
                        <tr>
                            <td>Razón Social:</td>
                            <td><asp:TextBox runat="server" ID="txtRazonSocial" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>Calle y Número:</td>
                            <td><asp:TextBox runat="server" ID="txtDireccion" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>Colonia:</td>
                            <td><asp:TextBox runat="server" ID="txtColonia" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>Municipio:</td>
                            <td><asp:TextBox runat="server" ID="txtMunicipio" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>Estado:</td>
                            <td><asp:TextBox runat="server" ID="txtEstado" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>País:</td>
                            <td><asp:TextBox runat="server" ID="txtPais" Width="400px" >México</asp:TextBox> </td>
                        </tr>
                        <tr>
                            <td>CP:</td>
                            <td><asp:TextBox runat="server" ID="txtCP" Width="75px" /></td>
                        </tr>
                        <tr>
                            <td>Teléfono</td>
                            <td><asp:TextBox runat="server" ID="txtTelefono" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td><asp:TextBox runat="server" ID="txtEmail" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>Bcc:</td>
                            <td><asp:TextBox runat="server" ID="txtBcc" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>Web:</td>
                            <td><asp:TextBox runat="server" ID="txtWeb" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>Contacto:</td>
                            <td><asp:TextBox runat="server" ID="txtContacto" Width="400px" /></td>
                        </tr>
                        <tr>
                            <td>Días Revisión:</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtDiasRevision" Width="400px" />
                                <asp:CompareValidator runat="server" ID="cvDiasRevision" ControlToValidate="txtDiasRevision" Display="Dynamic"
                                 ErrorMessage="* Dato Invalido" Type="Integer" Operator="DataTypeCheck" />
                            </td>
                        </tr>
                        <tr>
                            <td>Cta. Contable:</td>
                            <td><asp:TextBox runat="server" ID="txtCuentaContable" Width="400px" /></td>
                        </tr>
        
                        <tr>
                            <td>Cta. Depósito</td>
                            <td><asp:TextBox runat="server" ID="txtCuentaDeposito" Width="400px" /></td>
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
                        <td><asp:Label ID="Label10" runat="server" Text="* Número de Empleado:"></asp:Label></td>
                        <td><asp:TextBox runat="server" ID="txtNumEmpleado"></asp:TextBox>
                            <br/><asp:Label runat="server" ID="lblNumEmpleado" ForeColor="Red"></asp:Label></td>
                   
                        
                        <td><asp:Label ID="Label12" runat="server" text="* Tipo de Régimen:"></asp:Label></td>
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
                        <asp:CalendarExtender runat="server" TargetControlID="txtFechaInicialLaboral" Format="yyyy-MM-dd" ID="calExt" />
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
            
            
    </asp:TabContainer>
    
    
    <div align="right">
        <asp:Button runat="server" ID="btnSave" Text="Guardar" onclick="btnSave_Click" class="btn btn-primary" />&nbsp;&nbsp;
        <asp:Button runat="server" ID="btnCancel" Text="Cancelar" class="btn btn-primary" 
            onclick="btnCancel_Click" />
    </div>
</asp:Content>