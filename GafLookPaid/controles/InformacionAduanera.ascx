<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InformacionAduanera.ascx.cs" Inherits="GafLookPaid.controles.InformacionAduanera" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>


<table width="100%">
        <tr>
        
        <td class="style4" style="text-align: right">
        <asp:Label ID="LabNumero" runat="server" Text="Numero"></asp:Label></td>
        <td class="style7">
				<asp:TextBox runat="server" ID="txtNumeroIA" />
                
                	<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtNumeroIA" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
                 </td>
        <td style="text-align: right">
        <asp:Label ID="LabFecha" runat="server" Text="Fecha"></asp:Label></td>
         <td class="style8"><asp:TextBox ID="txtFechaIA" runat="server"  Width="71%" /><br />
		<asp:CalendarExtender runat="server" ID="CalendarExtender1" PopupButtonID="txtFechaIA" TargetControlID="txtFechaIA" Format="dd/MM/yyyy"  />
		<asp:CompareValidator runat="server" ID="CompareValidator6" ErrorMessage="* Fecha Invalida" Display="Dynamic"
		 ControlToValidate="txtFechaIA" Operator="DataTypeCheck" Type="Date" ValidationGroup="AgregarConcepto" />
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txtFechaIA" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" />
         </td>
         <td style="text-align: right">
         <asp:Label ID="LabAduana" runat="server" Text="Aduana"></asp:Label></td>
         <td><asp:TextBox runat="server" ID="txtAduanaIA" Width="191px" />
         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtAduanaIA" Display="Dynamic"
				 ErrorMessage="* Requerido" ValidationGroup="AgregarConcepto" /></td>
        </tr>
        </table>