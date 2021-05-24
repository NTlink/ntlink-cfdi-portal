<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ImpuestosLocales.ascx.cs" Inherits="GafLookPaid.controles.ImpuestosLocales" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>


<style type="text/css">
    .style1
    {
        width: 114px;
    }
    .style124
    {
        border-style:solid;
        border-left:  #A8CF38;
    border-right:  #A8CF38;
    border-top:  #A8CF38;
    border-bottom:  #b3b3b3;
        border-radius: 15px ;
        border-width: 1px;
         padding: 2px 4px;
        height:40%rem;
        width:50%;
        color: #000101;
        background-color:transparent;
        
     background-color: #DCD9D9;
        text-align: center;}
       
    }
    .style5
    {
        text-align: left;
    }
</style>


<hr width="100%" align="left"> 
<table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label1" runat="server" Text="Impuestos Locales" Font-Bold="True"  style="font-size: medium"></asp:Label>
   </td>
</tr>
<tr>
<td class="style1" style="text-align: right"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Impuesto Local:
    </td><td class="style3">
        <asp:DropDownList ID="ddlImpuestoLocal" runat="server" CssClass="form-control2"
     ToolTip="Nodo opcional para la expresión de los impuestos locales"
    >
            
    <asp:ListItem Value="RetencionesLocales">RetencionesLocales</asp:ListItem>
    <asp:ListItem Value="TrasladosLocales">TrasladosLocales</asp:ListItem>
     
       
    </asp:DropDownList>
        <br />
       
      </td>
    
<td style="text-align: right" > 
    <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Nombre Impuesto:</td><td class="style5">
        <asp:TextBox ID="txtImpLoc" runat="server"
         ToolTip="Nombre del impuesto local" CssClass="form-control2"
         Width="300px"></asp:TextBox><br />
          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtImpLoc" ValidationGroup="AgregarImpuestoLocal"></asp:RequiredFieldValidator>

      
    </td>
   
<td style="text-align: right" > 
  </td>
   
</tr>
<tr>
<td class="style1" style="text-align: right"> 
    
    <asp:Label ID="Label9" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Importe:<br /></td>
<td >
    <asp:TextBox ID="txtImporte" runat="server" 
    ToolTip="Monto del impuesto local" 
   CssClass="form-control2"></asp:TextBox><br />
        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtImporte" ValidationGroup="AgregarImpuestoLocal"></asp:RequiredFieldValidator>

        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtImporte" />

    <asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" Display="Dynamic"
    ControlToValidate="txtImporte" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarImpuestoLocal"/>

    </td>
<td  style="text-align: right"> 
      <asp:Label ID="Label8" runat="server" ForeColor="Red" Text="*"></asp:Label>
    Tasa:<br /></td>
<td style="text-align: left">
    <asp:TextBox ID="txtTasa"  runat="server"
    ToolTip="Porcentaje del impuesto local" CssClass="form-control2"
    class="prueba" Width="56px" ></asp:TextBox>
    
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ErrorMessage="Requerido" Display="Dynamic"
              ControlToValidate="txtTasa" ValidationGroup="AgregarImpuestoLocal"></asp:RequiredFieldValidator>

     <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" FilterType="Numbers, Custom"
    ValidChars="." TargetControlID="txtTasa" />
 <asp:RegularExpressionValidator id="RegularExpressionValidator4" runat="server" Display="Dynamic"
    ControlToValidate="txtTasa" ErrorMessage="Dato invalido" ValidationExpression="\d+\.?\d?\d?\d?\d?\d?\d?" ValidationGroup="AgregarImpuestoLocal"/>

    <br />
    
</td>


<td style="text-align: left">
    <br />
     
    </td>
</tr>
<tr>
<td colspan="4" style="text-align: right">
<asp:Button runat="server" ID="btnAgregarImp" Text="Agregar Impuesto" ValidationGroup="AgregarImpuestoLocal"  class="btn btn-primary" onclick="btnAgregarImp_Click"/>
</td>
</tr>
<tr>
<td colspan="5">
<asp:GridView runat="server" ID="gvImpuestosLocales" AutoGenerateColumns="False" CssClass="style124"
			Width="100%" ShowHeaderWhenEmpty="True" onrowcommand="gvImpuestosLocales_RowCommand">
			<Columns>
				<asp:BoundField HeaderText="ImpuestoLocal" DataField="ImpuestosLocales" ItemStyle-HorizontalAlign="Center"  ItemStyle-Width="10%" />
				<asp:BoundField HeaderText="Nombre Impuesto" DataField="ImpLoc" ItemStyle-HorizontalAlign="Center" />
				<asp:BoundField HeaderText="Tasa" DataField="Tasa"  ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Importe" DataField="Importe" DataFormatString="{0:C}" ItemStyle-HorizontalAlign="Center" />
               			
				<asp:ButtonField Text="Eliminar" CommandName="EliminarConcepto" Visible="False" ItemStyle-HorizontalAlign="Center" />
			</Columns>
		</asp:GridView>
</td>
</tr>
</table>