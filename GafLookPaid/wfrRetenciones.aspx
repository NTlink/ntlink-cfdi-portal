<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrRetenciones.aspx.cs" Inherits="GafLookPaid.wfrRetenciones" %>
<%@ Register TagPrefix="cc1" Namespace="WebControls.FilteredDropDownList" Assembly="WebControls.FilteredDropDownList" %>
     <%@ Register Assembly="DropDownChosen" Namespace="CustomDropDown" TagPrefix="cc1" %>

<%@ Register TagPrefix="cc1" Namespace="WebControls.FilteredDropDownList" Assembly="WebControls.FilteredDropDownList" %>
<%@ Register Src="~/controles/Intereses.ascx" TagPrefix="uc" TagName="UCIntereses" %>
<%@ Register Src="~/controles/Dividendos.ascx" TagPrefix="uc" TagName="UCDividendos" %>
<%@ Register Src="~/controles/arrendamientoenfideicomiso.ascx" TagPrefix="uc" TagName="UCArrendamientosenfideicomiso" %>
<%@ Register Src="~/controles/EnajenaciondeAcciones.ascx" TagPrefix="uc" TagName="UCEnajenaciondeAcciones" %>
<%@ Register Src="~/controles/FideicomisoNoEmpresarial.ascx" TagPrefix="uc" TagName="UCFideicomisoNoEmpresarial" %>
<%@ Register Src="~/controles/Intereseshipotecarios.ascx" TagPrefix="uc" TagName="UCIntereseshipotecarios" %>
<%@ Register Src="~/controles/Operacionesconderivados.ascx" TagPrefix="uc" TagName="UCOperacionesconderivados" %>
<%@ Register Src="~/controles/Pagoaextranjeros.ascx" TagPrefix="uc" TagName="UCPagoextranjeros" %>
<%@ Register Src="~/controles/Planesderetiro.ascx" TagPrefix="uc" TagName="UCPlanesderetiro" %>
<%@ Register Src="~/controles/Premios.ascx" TagPrefix="uc" TagName="UCPremios" %>
<%@ Register Src="~/controles/SectorFinanciero.ascx" TagPrefix="uc" TagName="UCSectorFinanciero" %>

<%@ MasterType VirtualPath="~/Site.Master" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
  

    <script type="text/javascript">
/*
          $(document).ready(function () {
              alert('hola');
          $('.decimal').keypress(function (tecla) {
                  alert('hola');
                  if ((tecla.charCode < 48 || tecla.charCode > 57) && (tecla.charCode != 46) && (tecla.charCode != 8))
                  { return false; }
                  else {

                      var len = $('.decimal').val().length;
                      var index = $('.decimal').val().indexOf('.');

                      if (index > 0 && tecla.charCode == 46) { return false; }

                      if (index > 0) {
                          var CharAfterdot = (len + 1) - index;
                          if (CharAfterdot > 3) { return false; }

                      }
                  }
                  return true;
                  
              });
          });*/
    </script>

    <script type="text/javascript" language="javascript">

   Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
   function BeginRequestHandler(sender, args) { var oControl = args.get_postBackElement(); oControl.disabled = true; }

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Generar Constancia de Retenciones</h1>
    <div style="text-align: right">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </div>

    <asp:UpdatePanel ID="up1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <table>
            <tr>
             <td class="style160" align="right">
                        <asp:Label ID="lblVencimiento" runat="server" ForeColor="Red" Font-Bold="true" style=" font-size: x-small; text-align: left; font-variant: small-caps;" Width="250px"></asp:Label>
              </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Folio:" style="color: #0000FF"></asp:Label>
                        <asp:Label ID="LabFolio" runat="server" Text="" style="color: #0000FF"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Empresa:&nbsp;
        <asp:DropDownList runat="server" ID="ddlEmpresa" AutoPostBack="True" CssClass="form-control0"
            DataTextField="RazonSocial" DataValueField="idEmpresa" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" />
                    </td>


                    <td>Cliente:&nbsp;
                <cc1:DropDownListChosen ID="ddlClientes" runat="server" AllowSingleDeselect="true" AutoPostBack="True" CausesValidation="false" CssClass="form-control2" DataPlaceHolder="Seleccione..." DataTextField="RazonSocial" DataValueField="idCliente"  NoResultsText="No hay resultados coincidentes." OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" SelectMethod=""  Width="400px" AppendDataBoundItems="True" >
                               
                 
                            </cc1:DropDownListChosen>

                        <%--<cc1:dropdownlistchosen ID="ddlClientes" runat="server"  CausesValidation="false" 
            NoResultsText="No hay resultados coincidentes." SelectMethod="" DataPlaceHolder="Escriba aquí..."
                            AllowSingleDeselect="true" AutoPostBack="True" OnSelectedIndexChanged="ddlClientes_SelectedIndexChanged" 
                            Height="16px" Width="197px" DataTextField="RazonSocial" DataValueField="idCliente" CssClass="page">                
        </cc1:dropdownlistchosen>--%>
                    </td>
                    <td>
                        <asp:TextBox runat="server" CssClass="page" TextMode="MultiLine" ID="txtRazonSocial" Width="341px" Height="35px" Enabled="False" />

                    </td>
                     </tr>
                <table />

                <table>
                    <caption>
                        <tr>
                            <td class="style129">Selecciona clave de retencion</td>
                            <td>
                                <asp:DropDownList ID="ddlClaveRetencion" runat="server" CssClass="form-control0" AppendDataBoundItems="True" />
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="rfvClaveRetencion" runat="server"
                                    ControlToValidate="ddlClaveRetencion" Display="Dynamic"
                                    ErrorMessage="* Requerido" ValidationGroup="GeneraRetencion" Style="color: #F72020" />
                            </td>
                        </tr>

                    </caption>
                </table>


                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Panel ID="Panel2" runat="server" BorderStyle="Double" HorizontalAlign="Center" CssClass="page3">
                            <table>
                                <tr>
                                    <td>
                                        <strong>Tipo&nbsp;de Retencion</strong></td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBoxList ID="ckeckboxlist1" runat="server" Font-Bold="True"
                                            OnSelectedIndexChanged="ckeckboxlist1_SelectedIndexChanged"
                                            RepeatLayout="table" RepeatColumns="11" RepeatDirection="vertical" CssClass="table"
                                            AutoPostBack="True">
                                            <asp:ListItem>Intereses</asp:ListItem>
                                            <asp:ListItem>Dividendos</asp:ListItem>
                                            <asp:ListItem>Arrendamiento en Fideicomiso</asp:ListItem>
                                            <asp:ListItem>Enajenación de Acciones</asp:ListItem>
                                            <asp:ListItem>Fideicomiso NoEmpresarial</asp:ListItem>
                                            <asp:ListItem>Intereses hipotecarios</asp:ListItem>
                                            <asp:ListItem>Operaciones con derivados</asp:ListItem>
                                            <asp:ListItem>Pago extranjeros</asp:ListItem>
                                            <asp:ListItem>Planes de retiro</asp:ListItem>
                                            <asp:ListItem>Premios</asp:ListItem>
                                            <asp:ListItem>Sector Financiero</asp:ListItem>
                                        </asp:CheckBoxList>
                                    </td> 
                                </tr>
                            </table>
                        </asp:Panel>
                        <br />
                        <div id="divretenciones" style="width: 100%" runat="server" class="page1">

                            <uc:UCIntereses ID="Intereses" runat="server"></uc:UCIntereses>
                            <uc:UCDividendos ID="dividendos" runat="server"></uc:UCDividendos>
                            <uc:UCArrendamientosenfideicomiso ID="arrendamientoenfideicomiso" runat="server"></uc:UCArrendamientosenfideicomiso>
                            <uc:UCEnajenaciondeAcciones ID="enajenaciondeAcciones" runat="server"></uc:UCEnajenaciondeAcciones>
                            <uc:UCFideicomisoNoEmpresarial ID="fideicomisoNoEmpresarial" runat="server" CssClass="form-control2" />
                            </UCFideicomisoNoEmpresarial>
         <uc:UCIntereseshipotecarios ID="intereseshipotecarios" runat="server" />
                            </UCIntereseshipotecarios>
        <uc:UCOperacionesconderivados ID="operacionesconderivados" runat="server" />
                            </UCOperacionesconderivados>
         <uc:UCPagoextranjeros ID="pagoextranjeros" runat="server" />
                            </UCPagoextranjeros>
         <uc:UCPlanesderetiro ID="planesderetiro" runat="server"  />
                            </UCPlanesderetiro>
         <uc:UCPremios ID="premios" runat="server" />
                            </UCPremios>
         <uc:UCSectorFinanciero ID="sectorFinanciero" runat="server" CssClass="form-control2"/>
                            </UCSectorFinanciero>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>






                <%--<hr width="100%" align="center"  /> --%>
                <br />
                <asp:Panel ID="Panel1" runat="server" BorderStyle="Double" HorizontalAlign="Center" CssClass="page3">
                    <table width="60%" class="page2">
                        <tr>
                            <td colspan="6" class="style10" style="text-align: center">
                                <h1>Periodo</h1>
                            </td>

                        </tr>
                        <tr>
                            <td class="style10" style="text-align: right">Mes inicial</td>
                            <td class="style11">
                                <asp:DropDownList runat="server" ID="ddlMesInicial" CssClass="form-control0">
                                    <Items>
                                        <asp:ListItem Text="" Value="" Selected="True" />
                                        <asp:ListItem Text="Enero" Value="01" />
                                        <asp:ListItem Text="Febrero" Value="02" />
                                        <asp:ListItem Text="Marzo" Value="03" />
                                        <asp:ListItem Text="Abril" Value="04" />
                                        <asp:ListItem Text="Mayo" Value="05" />
                                        <asp:ListItem Text="Junio" Value="06" />
                                        <asp:ListItem Text="Julio" Value="07" />
                                        <asp:ListItem Text="Agosto" Value="08" />
                                        <asp:ListItem Text="Septiembre" Value="09" />
                                        <asp:ListItem Text="Octubre" Value="10" />
                                        <asp:ListItem Text="Noviembre" Value="11" />
                                        <asp:ListItem Text="Diciembre" Value="12" />
                                    </Items>
                                </asp:DropDownList>
                            </td>


                            <td  style="text-align: right" >Mes final</td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlMesFinal" CssClass="form-control2">
                                    <Items>
                                        <asp:ListItem Text="" Value="" Selected="True" />
                                        <asp:ListItem Text="Enero" Value="01" />
                                        <asp:ListItem Text="Febrero" Value="02" />
                                        <asp:ListItem Text="Marzo" Value="03" />
                                        <asp:ListItem Text="Abril" Value="04" />
                                        <asp:ListItem Text="Mayo" Value="05" />
                                        <asp:ListItem Text="Junio" Value="06" />
                                        <asp:ListItem Text="Julio" Value="07" />
                                        <asp:ListItem Text="Agosto" Value="08" />
                                        <asp:ListItem Text="Septiembre" Value="09" />
                                        <asp:ListItem Text="Octubre" Value="10" />
                                        <asp:ListItem Text="Noviembre" Value="11" />
                                        <asp:ListItem Text="Diciembre" Value="12" />
                                    </Items>
                                </asp:DropDownList>

                            </td>


                            <td style="text-align: right">Ejercicio</td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlEjercicio" CssClass="form-control2">
                                    <Items>
                                        <asp:ListItem Text="" Value="" Selected="True" />
                                        <asp:ListItem Text="2014" Value="2014" />
                                        <asp:ListItem Text="2015" Value="2015" />
                                        <asp:ListItem Text="2016" Value="2016" />
                                        <asp:ListItem Text="2017" Value="2017" />
                                        <asp:ListItem Text="2018" Value="2018" />
                                        <asp:ListItem Text="2019" Value="2019" />
                                        <asp:ListItem Text="2020" Value="2020" />
                                        <asp:ListItem Text="2021" Value="2021" />
                                        <asp:ListItem Text="2022" Value="2022" />
                                        <asp:ListItem Text="2023" Value="2023" />
                                        <asp:ListItem Text="2024" Value="2024" />
                                    </Items>
                                </asp:DropDownList></td>

                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:RequiredFieldValidator runat="server" ID="rfvMesInicial" Display="Dynamic"
                                    ControlToValidate="ddlMesInicial" Style="color: #F72020" ErrorMessage="* Requerido" ValidationGroup="GeneraRetencion" />
                            </td>
                            <td></td>
                            <td>
                                <asp:RequiredFieldValidator runat="server" ID="rfvMesFinal" Display="Dynamic"
                                    ControlToValidate="ddlMesFinal" Style="color: #F72020" ErrorMessage="* Requerido" ValidationGroup="GeneraRetencion" />
                                <asp:CompareValidator runat="server" ID="cvMesFinal" Display="Dynamic" ControlToValidate="ddlMesFinal"
                                    ControlToCompare="ddlMesInicial" Style="color: #F72020" ErrorMessage="* No puede ser menor al mes inicial" Operator="GreaterThanEqual"
                                    ValidationGroup="GeneraRetencion"></asp:CompareValidator>
                            </td>
                            <td></td>
                            <td>
                                <asp:RequiredFieldValidator runat="server" ID="rfvEjercicio" Display="Dynamic"
                                    ControlToValidate="ddlEjercicio" Style="color: #F72020" ErrorMessage="* Requerido" ValidationGroup="GeneraRetencion" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <br />
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Panel ID="Panel3" runat="server" BorderStyle="Double" HorizontalAlign="Center" CssClass="page3">
                            <table class="page2">
                                <tr>
                                    <td colspan="8">
                                        <h1>Agregar Retenciones Totales</h1>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">Base:
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtBaseRetField" CssClass="form-control0"/>

                                    </td>
                                    <td style="text-align: right" >Impuesto:
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlImpuestoField"  CssClass="form-control0"/>
                                    </td>
                                    <td style="text-align: right"  >Monto:
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtMontoRetField"  CssClass="form-control0"/>
                                    </td>
                                    <td style="text-align: right" >Tipo Pago:
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlTipoPagoRetField"  CssClass="form-control0"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:RequiredFieldValidator runat="server" ID="rfvBaseRetField" Style="color: #F72020" ErrorMessage="* Requrido" Display="Dynamic"
                                            ControlToValidate="txtBaseRetField" ValidationGroup="Item"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator runat="server" ID="cvBaseRetField" Display="Dynamic" Style="color: #F72020" ErrorMessage="* Dato invalido"
                                            ControlToValidate="txtBaseRetField" ValidationGroup="Item" Operator="DataTypeCheck" Type="Currency"></asp:CompareValidator></td>
                                    <td></td>
                                    <td>
                                        <asp:RequiredFieldValidator runat="server" ID="rfvImpuestosField" Style="color: #F72020" ErrorMessage="* Requerido" Display="Dynamic"
                                            ControlToValidate="ddlImpuestoField" ValidationGroup="Item"></asp:RequiredFieldValidator></td>
                                    <td></td>
                                    <td>
                                        <asp:RequiredFieldValidator runat="server" ID="rfvMontoRetField" Style="color: #F72020" ErrorMessage="* Requerido" Display="Dynamic"
                                            ControlToValidate="txtMontoRetField" ValidationGroup="Item"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator runat="server" ID="cvMontoRetField" Display="Dynamic" Style="color: #F72020" ErrorMessage="* Dato invalido"
                                            ControlToValidate="txtMontoRetField" ValidationGroup="Item" Operator="DataTypeCheck" Type="Currency"></asp:CompareValidator></td>
                                    <td></td>
                                    <td>
                                        <asp:RequiredFieldValidator runat="server" ID="rfvTipoPagoField" Style="color: #F72020" ErrorMessage="* Requerido" Display="Dynamic"
                                            ControlToValidate="ddlTipoPagoRetField" ValidationGroup="Item"></asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td colspan="7"></td>

                                    <td>
                                        <asp:Button runat="server" ID="btnAgregar" Text="Agregar" OnClick="btnAgregar_Click" ValidationGroup="Item" class="btn btn-primary" />
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <div style="height: 100%; overflow-y: scroll">
                                <asp:GridView runat="server" CssClass="style124" ID="gvRetenciones" DataKeyNames="ID" AutoGenerateColumns="false" OnRowCommand="gvRetenciones_RowCommand"
                                    Width="100%" HorizontalAlign="Center" ShowHeaderWhenEmpty="True">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Base</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblBaseRetField" Text='<%# Eval("baseRetField") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Impuesto</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblImpuestoField" Text='<%# Eval("impuestoField") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Monto</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblMontoRetField" Text='<%# Eval("montoRetField") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <HeaderTemplate>Tipo Pago</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblTipoPagoRetField" Text='<%# Eval("tipoPagoRetField") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="btnEliminar" CommandName="DeleteRetItem"
                                                    CommandArgument='<%# ((GridViewRow) Container).RowIndex %>'>Eliminar
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </div>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <br />
                <table class="page3">
                    <tr>
                        <td class="style125" colspan="4" align="center">
                            <h1>Totales</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="style125">Monto Total Operación</td>
                        <td>
                            <asp:TextBox runat="server" ID="txtMontoTotalOperacion" CssClass="form-control2" /></td>

                        <td style="text-align: right" class="style125">Monto Total Gravado</td>
                        <td>
                            <asp:TextBox runat="server" ID="txtMontoTotalGravado" CssClass="form-control2" /></td>

                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:RequiredFieldValidator runat="server" ID="rfvMontoTotalOperacion" Display="Dynamic"
                                ControlToValidate="txtMontoTotalOperacion" Style="text-align: left; color: #F72020" ErrorMessage="* Requerido" ValidationGroup="GeneraRetencion" />
                            <asp:CompareValidator runat="server" ID="cvMontoTotalOperacion" Display="Dynamic" Style="text-align: left; color: #F72020" ErrorMessage="* Dato invalido"
                                ControlToValidate="txtMontoTotalOperacion" ValidationGroup="GeneraRetencion" Operator="DataTypeCheck" Type="Currency"></asp:CompareValidator>
                        </td>
                        <td></td>
                        <td>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" Display="Dynamic"
                                ControlToValidate="txtMontoTotalGravado" Style="text-align: left; color: #F72020" ErrorMessage="* Requerido"
                                ValidationGroup="GeneraRetencion" />
                            <asp:CompareValidator runat="server" ID="cvMontoTotalGravado" Display="Dynamic" Style="text-align: left; color: #F72020" ErrorMessage="* Dato invalido"
                                ControlToValidate="txtMontoTotalGravado" ValidationGroup="GeneraRetencion"
                                Operator="DataTypeCheck" Type="Currency"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right" class="style125">Monto Total Retenciones</td>
                        <td>
                            <asp:TextBox runat="server" ID="txtMontoTotalRetenciones" CssClass="form-control2" /></td>

                        <td style="text-align: right" class="style125">Monto Total Exento</td>
                        <td>
                            <asp:TextBox runat="server" ID="txtMontoTotalExento" CssClass="form-control2" /></td>

                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" Display="Dynamic"
                                ControlToValidate="txtMontoTotalRetenciones" Style="text-align: left; color: #F72020" ErrorMessage="* Requerido" ValidationGroup="GeneraRetencion" />
                            <asp:CompareValidator runat="server" ID="cvMontoTotalRetenciones" Display="Dynamic" Style="text-align: left; color: #F72020" ErrorMessage="* Dato invalido"
                                ControlToValidate="txtMontoTotalRetenciones" ValidationGroup="GeneraRetencion" Operator="DataTypeCheck" Type="Currency"></asp:CompareValidator>
                        </td>
                        <td></td>
                        <td>
                            <asp:RequiredFieldValidator runat="server" ID="rfvMontoTotalExento" Display="Dynamic"
                                ControlToValidate="txtMontoTotalExento" Style="text-align: left; color: #F72020" ErrorMessage="* Requerido" ValidationGroup="GeneraRetencion" />
                            <asp:CompareValidator runat="server" ID="cvMontoTotalExento" Display="Dynamic" Style="text-align: left; color: #F72020" ErrorMessage="* Dato invalido"
                                ControlToValidate="txtMontoTotalExento" ValidationGroup="GeneraRetencion" Operator="DataTypeCheck" Type="Currency"></asp:CompareValidator>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <asp:UpdateProgress AssociatedUpdatePanelID="up1" ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <div align="center">
                            <asp:Image ID="Image1" ImageUrl="images/ajax-loader.gif" runat="server" />
                            <br />
                            Constancia de Retenciones en proceso ..
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <br />
                <asp:Label runat="server" ID="lblError" ForeColor="Red" />

                <p align="right">
                    <asp:Button runat="server" ID="btnLimpiar" Text="Limpiar"
                        OnClick="btnLimpiar_Click" class="btn btn-primary" Width="70px" />&nbsp;&nbsp;&nbsp;
            <asp:Button runat="server" ID="BtnVistaPrevia" Text="Vista Previa" OnClick="btnGenerarVista_Click" class="btn btn-primary"
                ValidationGroup="GeneraRetencion" />
                    <asp:Button runat="server" ID="btnGenerarRetencion" Text="Generar Retenciones" OnClick="btnGenerarFactura_Click" class="btn btn-primary"
                        ValidationGroup="GeneraRetencion"  UseSubmitBehavior="false"
      OnClientClick="this.disabled='true';" />
                    <asp:ConfirmButtonExtender ID="cfeGenerarRetencion" runat="server" TargetControlID="btnGenerarRetencion"
                        ConfirmText="Confirma que deseas generar el comprobante" />
                </p>


                <asp:ModalPopupExtender runat="server" ID="mpeSellos" TargetControlID="btnSelloDummy"
        BackgroundCssClass="mpeBack"  PopupControlID="pnlSello" />
    <asp:Panel runat="server" ID="pnlSello" Style="text-align: center;"  CssClass="page7"
        BackColor="#A8CF38" Height="165px" Width="418px">
        <br />
        <asp:Label runat="server" ID="Label5" Text="¡Importante!" Visible="True" class="style161" style="color: #000000"/>
        <br />
        <asp:Label runat="server" ID="LblDiasSello" Text="Su sello caduca en x dias" Visible="True" class="style161" style="color: #000000" Height="50px"/>
        <br />
        <asp:Label runat="server" ID="lblpop" Text="Seleccione otra empresa" Visible="false" class="style161" style="color: #000000"/>
        <br />
        <asp:DropDownList runat="server" ID="ddlEmpresaE" AutoPostBack="false" CssClass="form-control2"
            DataTextField="RazonSocial" DataValueField="idEmpresa" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged" Visible="false"/>
        <br />
        <br />
        <asp:Button runat="server" ID="btclose" Text="Aceptar"  class="btn btn-primary" OnClick="btclose_Click"/>
    </asp:Panel>
    <asp:Button runat="server" ID="btnSelloDummy" Style="display: none;" />



                <asp:ModalPopupExtender runat="server" ID="mpeCFDIG" TargetControlID="btngenerarDummy"
                    BackgroundCssClass="mpeBack" PopupControlID="pnlMSG" />
                <asp:Panel runat="server" ID="pnlMSG" Style="text-align: center;" CssClass="page7"
                    BackColor="#A8CF38" Height="98px" Width="418px">
                    <h1 class="style161" style="color: #000000">
                        <strong>Comprobante generado correctamente y enviado por correo electrónico</strong>
                          <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="#FF3300" 
                onclick="LinkButton1_Click">Descargar PDF</asp:LinkButton>
                        </h1>
                    <br />
                    <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
                    <asp:Button runat="server" ID="btnCerrar" Text="Aceptar" class="btn btn-primary" OnClick="btnCerrar_Click" />
                </asp:Panel>
                <asp:Button runat="server" ID="btngenerarDummy" Style="display: none;" />

                 <!-- error -->

            <asp:ModalPopupExtender runat="server" ID="Error" TargetControlID="btngenerarDummy2"
        BackgroundCssClass="mpeBack"  PopupControlID="pnerror" />

            <asp:Panel runat="server" ID="pnerror" Style="text-align: center;"  CssClass="page7"
        BackColor="#A8CF38" Height="98px" Width="418px">
        <h1 class="style161" style="color: #000000">
            <strong>Por favor seleccione un cliente.
            </strong></h1>
        <br />
        <%--<asp:Button runat="server" ID="btnSeleccionarConcepto" Text="Seleccionar" onclick="btnSeleccionarConcepto_Click" />&nbsp;&nbsp;--%>
        <asp:Button runat="server" ID="Button2" Text="Aceptar"  class="btn btn-primary"/>
    </asp:Panel>
<asp:Button runat="server"  ID="btngenerarDummy2" Style="display: none;" />
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnLimpiar" />
            <asp:PostBackTrigger ControlID="BtnVistaPrevia" />
            <%-- <asp:PostBackTrigger ControlID="btnGenerarRetencion" />--%>
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
