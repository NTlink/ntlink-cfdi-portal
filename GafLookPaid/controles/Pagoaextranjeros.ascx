<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Pagoaextranjeros.ascx.cs" Inherits="GafLookPaid.controles.Pagoaextranjeros" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.7.607, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>
<%@ Register Src="~/controles/NoBeneficiario.ascx" TagPrefix="uc" TagName="UCNoBeneficiario" %>
<%@ Register Src="~/controles/Beneficiario.ascx" TagPrefix="uc" TagName="UCBeneficiario" %>


<style type="text/css">
    .style1 {
        width: 187px;
    }

    .style2 {
        width: 187px;
        height: 26px;
    }

    .style3 {
        height: 26px;
    }
</style>



<hr width="100%" align="left">

<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <table>
            <tr>
                <td colspan="2" style="text-align: center; font-weight: 700;">
                    <asp:Label ID="Label1" runat="server" Text="Pagoaextranjeros Nobeneficiario" Font-Bold="True" Style="font-size: medium"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"/>
                    <asp:Label runat="server" Text="EsBenefEfectDelCobro:"/>
                    </td>
                <td style="text-align: left">
                    <asp:DropDownList ID="ddlEsBenefEfectDelCobro" runat="server" AutoPostBack="True" CssClass="form-control2"
                        OnSelectedIndexChanged="ddlEsBenefEfectDelCobro_SelectedIndexChanged">
                        <asp:ListItem>SI</asp:ListItem>
                        <asp:ListItem>NO</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <Table />
            <Table>
            <caption>
                <div id="PagosExtranjeros" runat="server" style="width: 100%">
                    <uc:UCBeneficiario ID="beneficiario" runat="server" />
                    <uc:UCNoBeneficiario ID="noBeneficiario" runat="server" />
                </div>
            </caption>

            <caption>
                <br />
                </td>
                </tr>
            </caption>

        </table>
    </ContentTemplate>
</asp:UpdatePanel>
