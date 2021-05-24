<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Planesderetiro.ascx.cs" Inherits="GafLookPaid.controles.Planesderetiro" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>



<hr width="100%" align="left"> 
<table width="100%">
<tr>
<td  style="text-align: left" 
        class="style10" >
<asp:Label ID="Label1" runat="server" Text="Planes de retiro" Font-Bold="True" 
        style="font-size: medium"></asp:Label>
</td>
</tr>
<tr>
<td align="right" class="style10" > 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    SistemaFinanc:</td><td class="style3">
    <asp:DropDownList ID="ddlSistemaFinanc" runat="server" CssClass="form-control2"
     ToolTip="Atributo requerido para expresar si los planes personales de retiro son del sistema financiero"
    >
        <asp:ListItem>SI</asp:ListItem>
        <asp:ListItem>NO</asp:ListItem>
    </asp:DropDownList>
    </td>
   
<td class="style1" style="text-align: right"> 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    HuboRetirosAnioInmAntPer:</td><td class="style5">
     <asp:DropDownList ID="ddlHuboRetirosAnioInmAntPer" runat="server" CssClass="form-control2"
      ToolTip="Atributo requerido para expresar si se realizaron retiros de recursos invertidos y sus rendimientos en el ejercicio inmediato anterior antes de cumplir los requisitos de permanencia" 
      >
        <asp:ListItem>SI</asp:ListItem>
        <asp:ListItem>NO</asp:ListItem>
       
    </asp:DropDownList>
    </td>
 
<td class="style1"> 
    MontTotExentRetiradoAnioInmAnt:</td><td class="style7" style="text-align: left">
    <asp:TextBox ID="txtMontTotExentRetiradoAnioInmAnt" runat="server" 
     ToolTip="Atributo opcional que expresa el  monto total exento del retiro realizado en el ejercicio inmediato anterior" 
      CssClass="form-control2"></asp:TextBox>
       
  
     <asp:FilteredTextBoxExtender ID="txtMontIntRealesDevengAniooInmAnt0_FilteredTextBoxExtender" 
            runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotExentRetiradoAnioInmAnt" />
    <asp:RegularExpressionValidator id="RegularExpressionValidator4" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotExentRetiradoAnioInmAnt" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>
  
    </td>
   
</tr>
<tr>
<td align="right" class="style10" > 
    MontTotAportAnioInmAnterior:</td>
<td class="style8">
    <asp:TextBox ID="txtMontTotAportAnioInmAnterior" runat="server"
      ToolTip="Atributo opcional que expresa el monto total de las aportaciones actualizadas en el año inmediato anterior de los planes personales de retiro" 
      CssClass="form-control2"></asp:TextBox>
     
        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotAportAnioInmAnterior" />
    
    <asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotAportAnioInmAnterior" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>
  
    </td>
<td class="style1" style="text-align: right"> 
    <asp:Label ID="Label7" runat="server" ForeColor="Red" Text="*"></asp:Label>
    MontIntRealesDevengAniooInmAnt:</td>
<td class="style8">
    <asp:TextBox ID="txtMontIntRealesDevengAniooInmAnt" runat="server" 
     ToolTip="Atributo requerido para expresar el  monto de los intereses reales devengados o percibidos durante el año inmediato anterior de los planes personales de retiro" 
      CssClass="form-control2"></asp:TextBox>
     <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtMontIntRealesDevengAniooInmAnt" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
       
  
     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontIntRealesDevengAniooInmAnt" />
    
    <br />
     <asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" Display="Dynamic"
    ControlToValidate="txtMontIntRealesDevengAniooInmAnt" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion" />
       
    </td>
<td class="style1" style="text-align: right"> 
    MontTotRetiradoAnioInmAntPer:</td>
<td class="style8">
    <asp:TextBox ID="txtMontTotRetiradoAnioInmAntPer"  runat="server"
    ToolTip="Atributo opcional que expresa el monto total del retiro realizado antes de cumplir con los requisitos de permanencia" 
    CssClass="form-control2"></asp:TextBox>

             
     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotRetiradoAnioInmAntPer" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotRetiradoAnioInmAntPer" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>


    </td>
</tr>
<tr>
<td style="text-align: right">
    MontTotExedenteAnioInmAnt:</td>
<td>
    <asp:TextBox ID="txtMontTotExedenteAnioInmAnt" runat="server"
      ToolTip="Atributo opcional que expresa  el monto total excedente del monto exento del retiro realizado en el ejercicio inmediato anterior" 
     CssClass="form-control2"></asp:TextBox>
     
        <asp:FilteredTextBoxExtender ID="txtMontTotAportAnioInmAnterior0_FilteredTextBoxExtender" 
        runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotExedenteAnioInmAnt" />
      <asp:RegularExpressionValidator id="RegularExpressionValidator5" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotExedenteAnioInmAnt" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    
    </td><td style="text-align: right"> 
    <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
        HuboRetirosAnioInmAnt:</td>
<td>
    <asp:DropDownList ID="ddlHuboRetirosAnioInmAnt" runat="server" CssClass="form-control2"
     ToolTip="Atributo requerido que expresa si se realizaron retiros en el ejercicio inmediato anterior"
    >
        <asp:ListItem>SI</asp:ListItem>
        <asp:ListItem>NO</asp:ListItem>
    </asp:DropDownList>
    </td><td style="text-align: right">MontTotRetiradoAnioInmAnt:</td>
    <td>
    <asp:TextBox ID="txtMontTotRetiradoAnioInmAnt" runat="server" 
     ToolTip="Atributo opcional que expresa el monto total del retiro realizado en el ejercicio inmediato anterior" 
      CssClass="form-control2"></asp:TextBox>
       
  
     <asp:FilteredTextBoxExtender ID="txtMontIntRealesDevengAniooInmAnt0_FilteredTextBoxExtender0" 
            runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontTotRetiradoAnioInmAnt" />
     <asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" Display="Dynamic"
    ControlToValidate="txtMontTotRetiradoAnioInmAnt" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="GeneraRetencion"/>

    
    </td>
</tr>
<tr>
<td style="text-align: right">NumReferencia:</td><td>
    <asp:TextBox ID="txtNumReferencia" runat="server" CssClass="form-control2" 
        
        
        ToolTip="Atributo opcional que expresa el número de referencia, contrato o cuenta con la que identifica la institución a su cliente."></asp:TextBox>
    </td>
<td></td><td></td>
<td></td><td></td>
</tr>
<tr>
<td></td><td></td>
<td></td><td></td>
<td></td><td></td>
</tr>
<tr>
<td style="text-align: left"> 
 <table width="100%">
   <tr><td>  
       <asp:CheckBox ID="chActivar" runat="server" style="text-align: left" 
        Text="Activar" oncheckedchanged="chActivar_CheckedChanged" 
           AutoPostBack="True" /></td>
        
       <td style="text-align: right">
    <asp:Label ID="Label9" runat="server" ForeColor="Red" Text="*"></asp:Label>
    SistemaFinanc:</td>
        </tr>
   </table>
  </td>
  <td>
    <asp:DropDownList ID="ddlSistemaFinanc1" runat="server" CssClass="form-control2"
     ToolTip="Atributo requerido que identifica el tipo de aportación o depósito que se realiza al plan de retiro." >
        <asp:ListItem>a</asp:ListItem>
        <asp:ListItem>b</asp:ListItem>
        <asp:ListItem>c</asp:ListItem>
    </asp:DropDownList>
    </td>
<td style="text-align: right"> 
    <asp:Label ID="Label10" runat="server" ForeColor="Red" Text="*"></asp:Label>
        MontAportODep:</td><td>
    <asp:TextBox ID="txtMontAportODep" runat="server"
      ToolTip="Atributo requerido que expresa el monto de las aportaciones o depósitos efectuados al plan de retiro." 
      CssClass="form-control2" Enabled="False"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="Requerido" Display="Dynamic" Enabled="false"
              ControlToValidate="txtMontAportODep" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
     

        <asp:FilteredTextBoxExtender ID="txtMontAportODep_FilteredTextBoxExtender0" 
        runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontAportODep" />
    
    </td>
<td style="text-align: right">RFCFiduciaria:</td><td>
    <asp:TextBox ID="txtRFCFiduciaria" runat="server" CssClass="form-control2" 
        
        ToolTip="Atributo opcional que expresa el RFC de la fiduciaria de fungió como administrador del plan de pensiones, cuando se trate de aportaciones realizadas de conformidad con el artículo 258 del Reglamento de la LISR, se vuelve requerido cuando el administrador del plan es una fiduciaria." 
        Enabled="False"></asp:TextBox>
    </td>
</tr>
<tr>
<td style="text-align: left"> 
 <table width="100%">
   <tr><td>  
       <asp:CheckBox ID="chActivar2" runat="server" style="text-align: left" 
        Text="Activar" oncheckedchanged="chActivar2_CheckedChanged" 
           AutoPostBack="True" /></td>
        
       <td style="text-align: right">
    <asp:Label ID="Label2" runat="server" ForeColor="Red" Text="*"></asp:Label>
    SistemaFinanc:</td>
        </tr>
   </table>
  </td>
  <td>
    <asp:DropDownList ID="ddlSistemaFinanc2" runat="server" CssClass="form-control2"
     ToolTip="Atributo requerido que identifica el tipo de aportación o depósito que se realiza al plan de retiro." >
        <asp:ListItem>a</asp:ListItem>
        <asp:ListItem>b</asp:ListItem>
        <asp:ListItem>c</asp:ListItem>
    </asp:DropDownList>
    </td>
<td style="text-align: right"> 
    <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="*"></asp:Label>
        MontAportODep:</td><td>
    <asp:TextBox ID="txtMontAportODep2" runat="server"
      ToolTip="Atributo requerido que expresa el monto de las aportaciones o depósitos efectuados al plan de retiro." 
      CssClass="form-control2" Enabled="False"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ErrorMessage="Requerido" Display="Dynamic" Enabled="false"
              ControlToValidate="txtMontAportODep2" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
     

        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" 
        runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontAportODep2" />
    
    </td>
<td style="text-align: right">RFCFiduciaria:</td><td>
    <asp:TextBox ID="txtRFCFiduciaria2" runat="server" CssClass="form-control2" 
        
        ToolTip="Atributo opcional que expresa el RFC de la fiduciaria de fungió como administrador del plan de pensiones, cuando se trate de aportaciones realizadas de conformidad con el artículo 258 del Reglamento de la LISR, se vuelve requerido cuando el administrador del plan es una fiduciaria." 
        Enabled="False"></asp:TextBox>
    </td>
</tr>
<tr>
<td style="text-align: left"> 
 <table width="100%">
   <tr><td>  
       <asp:CheckBox ID="chActivar3" runat="server" style="text-align: left" 
        Text="Activar" oncheckedchanged="chActivar3_CheckedChanged" 
           AutoPostBack="True" /></td>
        
       <td style="text-align: right">
    <asp:Label ID="Label6" runat="server" ForeColor="Red" Text="*"></asp:Label>
    SistemaFinanc:</td>
        </tr>
   </table>
  </td>
  <td>
    <asp:DropDownList ID="ddlSistemaFinanc3" runat="server" CssClass="form-control2"
     ToolTip="Atributo requerido que identifica el tipo de aportación o depósito que se realiza al plan de retiro." >
        <asp:ListItem>a</asp:ListItem>
        <asp:ListItem>b</asp:ListItem>
        <asp:ListItem>c</asp:ListItem>
    </asp:DropDownList>
    </td>
<td style="text-align: right"> 
    <asp:Label ID="Label11" runat="server" ForeColor="Red" Text="*"></asp:Label>
        MontAportODep:</td><td>
    <asp:TextBox ID="txtMontAportODep3" runat="server"
      ToolTip="Atributo requerido que expresa el monto de las aportaciones o depósitos efectuados al plan de retiro." 
      CssClass="form-control2" Enabled="False"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ErrorMessage="Requerido" Display="Dynamic" Enabled="false"
              ControlToValidate="txtMontAportODep3" ValidationGroup="GeneraRetencion"></asp:RequiredFieldValidator>
     

        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" 
        runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtMontAportODep3" />
    
    </td>
<td style="text-align: right">RFCFiduciaria:</td><td>
    <asp:TextBox ID="txtRFCFiduciaria3" runat="server" CssClass="form-control2" 
        
        ToolTip="Atributo opcional que expresa el RFC de la fiduciaria de fungió como administrador del plan de pensiones, cuando se trate de aportaciones realizadas de conformidad con el artículo 258 del Reglamento de la LISR, se vuelve requerido cuando el administrador del plan es una fiduciaria." 
        Enabled="False"></asp:TextBox>
    </td>
</tr>
</table>



