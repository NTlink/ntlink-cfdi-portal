<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServicioParcialConstrucciones.ascx.cs" Inherits="GafLookPaid.controles.ServicioParcialConstrucciones" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>


<style type="text/css">
    .style1
    {
        width: 114px;
    }
           
    }
    .style5
    {
        text-align: left;
        width: 271px;
    }
    .style7
    {
        width: 183px;
    }
    .style8
    {
        width: 130px;
    }
</style>


<hr width="100%" align="left"> 
<table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

    Servicio Parcial Construccion</td>
</tr>
<tr>
<td class="style1" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Calle:
    </td><td class="style7">
    <asp:TextBox ID="txtCalle" runat="server" 
    ToolTip="Este atributo requerido sirve para precisar la avenida, calle, camino o carretera del inmueble" 
   CssClass="form-control2"></asp:TextBox>
        <br />
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtCalle" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>

      </td>
    
<td style="text-align: right" class="style8" > 
    Colonia:</td><td class="style5">
        <asp:TextBox ID="txtColonia" runat="server"
         
        ToolTip="Este atributo opcional sirve para precisar la colonia en donde se da la ubicación del inmueble cuando se desea ser más específico en casos de ubicaciones urbanas." CssClass="form-control2"
         Width="300px"></asp:TextBox><br />

      
    </td>
   
<td style="text-align: right" > 
    NoExterior:</td>
  <td>
        <asp:TextBox ID="txtNoExterior" runat="server"
         ToolTip="Este atributo opcional sirve para expresar el número particular en donde se da la ubicación del inmueble en una calle dada." CssClass="form-control2"
         Width="100px"></asp:TextBox></td> 
</tr>
<tr>
<td style="text-align: right"> 
    <asp:Label ID="Label13" runat="server" ForeColor="Red" Text="*"></asp:Label>
    NumPerLicoAut:</td>
<td>
        <asp:TextBox ID="txtNumPerLicoAut" runat="server"
         
            ToolTip="Atributo requerido para expresar el número de permiso, licencia o autorización de construcción proporcionado por el prestatario de los servicios parciales de construcción. " CssClass="form-control2"
         Width="100px"></asp:TextBox>
         <br />
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtNumPerLicoAut" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>

         </td>
<td style="text-align: right">Referencia:</td>
<td>
        <asp:TextBox ID="txtReferencia" runat="server"
                 
        ToolTip="Atributo opcional para expresar una referencia adicional de ubicación del inmueble." CssClass="form-control2"
         Width="300px"></asp:TextBox></td>
<td style="text-align: right">NoInterior:</td>
<td>
        <asp:TextBox ID="txtNoInterior" runat="server"
         
        ToolTip="Este atributo opcional sirve para expresar información adicional para especificar la ubicación cuando calle y número exterior (noExterior) no resulten suficientes para determinar la ubicación precisa del inmueble." CssClass="form-control2"
         Width="100px" ontextchanged="txtNoInterior_TextChanged"></asp:TextBox></td>

</tr>
<tr>
<td style="text-align: right">Localidad:</td>
<td>
        <asp:TextBox ID="txtLocalidad" runat="server"
         
        ToolTip="Atributo opcional que sirve para precisar la ciudad o población donde se da la ubicación del inmueble." CssClass="form-control2"
         Width="300px"></asp:TextBox></td>
<td style="text-align: right"> 
    <asp:Label ID="Label11" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Estado:</td>
<td>

        <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control2"
     ToolTip="Entidad Federativa donde se ubica el inmueble conforme al catálogo publicado en el portal del SAT en Internet."
    >
      <asp:ListItem Value="01">01 (AGUASCALIENTES)</asp:ListItem>
    <asp:ListItem Value="02">02 (BAJA CALIFORNIA)</asp:ListItem>
    <asp:ListItem Value="03">03 (BAJA CALIFORNIA SUR)</asp:ListItem>
    <asp:ListItem Value="04">04 (CAMPECHE)</asp:ListItem>
    <asp:ListItem Value="05">05 (COAHUILA)</asp:ListItem>
    <asp:ListItem Value="06">06 (COLIMA)</asp:ListItem>
    <asp:ListItem Value="07">07 (CHIAPAS)</asp:ListItem>
    <asp:ListItem Value="08">08 (CHIHUAHUA)</asp:ListItem>
    <asp:ListItem Value="09">09 (DISTRITO FEDERAL)</asp:ListItem>
    <asp:ListItem Value="10">10 (DURANGO)</asp:ListItem>
    <asp:ListItem Value="11">11 (GUANAJUATO)</asp:ListItem>
    <asp:ListItem Value="12">12 (GUERRERO)</asp:ListItem>
    <asp:ListItem Value="13">13 (HIDALGO)</asp:ListItem>
    <asp:ListItem Value="14">14 (JALISCO)</asp:ListItem>
    <asp:ListItem Value="15">15 (MEXICO)</asp:ListItem>
    <asp:ListItem Value="16">16 (MICHOACAN)</asp:ListItem>
    <asp:ListItem Value="17">17 (MORELOS)</asp:ListItem>
    <asp:ListItem Value="18">18 (NAYARIT)</asp:ListItem>
    <asp:ListItem Value="19">19 (NUEVO LEON)</asp:ListItem>
    <asp:ListItem Value="20">20 (OAXACA)</asp:ListItem>
    <asp:ListItem Value="21">21 (PUEBLA)</asp:ListItem>
    <asp:ListItem Value="22">22 (QUERETARO)</asp:ListItem>
    <asp:ListItem Value="23">23 (QUINTANA ROO)</asp:ListItem>
    <asp:ListItem Value="24">24 (SAN LUIS POTOSI)</asp:ListItem>
    <asp:ListItem Value="25">25 (SINALOA)</asp:ListItem>
    <asp:ListItem Value="26">26 (SONORA)</asp:ListItem>
    <asp:ListItem Value="27">27 (TABASCO)</asp:ListItem>
    <asp:ListItem Value="28">28 (TAMAULIPAS)</asp:ListItem>
    <asp:ListItem Value="29">29 (TLAXCALA)</asp:ListItem>
    <asp:ListItem Value="30">30 (VERACRUZ)</asp:ListItem>
    <asp:ListItem Value="31">31 (YUCATAN)</asp:ListItem>
    <asp:ListItem Value="32">32 (ZACATECAS)</asp:ListItem>
    </asp:DropDownList>

    </td>
<td style="text-align: right"> 
    <asp:Label ID="Label12" runat="server" ForeColor="Red" Text="*"></asp:Label>
    CodigoPostal:</td>
<td>
        <asp:TextBox ID="txtCodigoPostal" runat="server"
         
        ToolTip="Atributo requerido que sirve para asentar el código postal en donde se da la ubicación del inmueble." CssClass="form-control2"
         Width="100px"></asp:TextBox>
         <br />
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtCodigoPostal" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>
         </td>

</tr>
<tr>
<td style="text-align: right"> 
    <asp:Label ID="Label10" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Municipio:</td>
<td>
        <asp:TextBox ID="txtMunicipio" runat="server"
                 
        ToolTip="Atributo requerido que sirve para precisar el municipio o delegación (en el caso del Distrito Federal) en donde se da la ubicación del inmueble." CssClass="form-control2"
         Width="300px"></asp:TextBox>
         
           <br />
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtMunicipio" ValidationGroup="CrearFactura"></asp:RequiredFieldValidator>

         </td>
<td style="text-align: right"> 
    &nbsp;</td>
<td>
    
         </td>
</tr>
<tr>
<td style="text-align: right">&nbsp;</td>
<td>
        &nbsp;</td>
<td style="text-align: right">&nbsp;</td>
<td>
        &nbsp;</td>
</tr>
</table>