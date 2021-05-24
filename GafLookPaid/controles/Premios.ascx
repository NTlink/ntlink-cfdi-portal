<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Premios.ascx.cs" Inherits="GafLookPaid.controles.Premios" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>


<hr width="100%" align="left"> 
<table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label1" runat="server" Text="Premios" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td class="style1" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    EntidadFederativa:</td><td class="style3">
        <asp:DropDownList ID="ddlEntidadFederativa" runat="server" CssClass="form-control2"
     ToolTip="Atributo requerido para expresar la entidad federativa en la que se paga el premio obtenido, conforme al catálogo"
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
        <br />
       
      </td>
    
<td style="text-align: right" > 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontTotPago:</td><td class="style5">
        <asp:TextBox ID="txtMontTotPago" runat="server"
         ToolTip="Atributo requerido para expresar el importe del pago realizado por la obtención de un premio" 
         CssClass="form-control2"></asp:TextBox>
          

    </td>
   
<td style="text-align: right" > 
    <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontTotPagoGrav:</td><td style="text-align: left">
    <asp:TextBox ID="txtMontTotPagoGrav"  runat="server"
    ToolTip="Atributo requerido para expresar el importe  gravado en la obtención de un premio" 
    CssClass="form-control2" ></asp:TextBox>
        

    </td>
   

<td class="style1" style="text-align: right"> 
    
    <asp:Label ID="Label9" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontTotPagoExent:<br /></td>
<td style="text-align: left">
    <asp:TextBox ID="txtMontTotPagoExent" runat="server" 
    ToolTip="Atributo requerido para expresar el monto total exento en la obtención de un premio" 
    CssClass="form-control2"></asp:TextBox>
    </td>
</tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="*Requerido" Display="Dynamic"
              ControlToValidate="txtMontTotPago" ValidationGroup="GeneraRetencion" style="color: #F72020"></asp:RequiredFieldValidator>

               <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotPago" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotPago" ErrorMessage="*Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion" style="color: #F72020"/></td>
        <td></td>
        <td><asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ErrorMessage="*Requerido" Display="Dynamic" style="color: #F72020"
              ControlToValidate="txtMontTotPagoGrav" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotPagoGrav" />
 <asp:RegularExpressionValidator id="RegularExpressionValidator4" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotPagoGrav" style="color: #F72020" ErrorMessage="*Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/></td>
        <td></td>
        <td>
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" style="color: #F72020" ErrorMessage="*Requerido" Display="Dynamic"
              ControlToValidate="txtMontTotPagoExent" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>

        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotPagoExent" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotPagoExent" style="color: #F72020" ErrorMessage="*Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>
        </td>
    </tr>

</table>