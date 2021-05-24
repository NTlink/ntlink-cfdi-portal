<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="wfrValidacion.aspx.cs" Inherits="GafLookPaid.wfrValidacion" Culture="es-MX" UICulture="es-MX" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

<link href="Styles/StyleBoton.css" rel="stylesheet" type="text/css" />
    <style type="text/css">  
        .accordion {  
            width: 400px;  
        }  
          
        .accordionHeader {  
            border: 1px solid #2F4F4F;  
            color: white;  
            background-color: #2E4d7B;  
            font-family: Arial, Sans-Serif;  
            font-size: 12px;  
            font-weight: bold;  
            padding: 5px;  
            margin-top: 5px;  
            cursor: pointer;  
        }  
          
        .accordionHeaderSelected {  
            border: 1px solid #2F4F4F;  
            color: white;  
            background-color: #5078B3;  
            font-family: Arial, Sans-Serif;  
            font-size: 12px;  
            font-weight: bold;  
            padding: 5px;  
            margin-top: 5px;  
            cursor: pointer;  
        }  
          
        .accordionContent {  
            background-color: #D3DEEF;  
            border: 1px dashed #2F4F4F;  
            border-top: none;  
            padding: 5px;  
            padding-top: 10px;  
        }  
    </style>  

<script type ="text/javascript" >
    function UploadComplete(sender, args) {


        __doPostBack('UP_Btn', '');
    }


   </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server"><%--
<asp:Button ID="UP_Btn" runat="server" Text="Updatepanel_Trigger" onclick="UP_Btn_Click" style="display:none" />--%>
    <asp:UpdatePanel ID="Update1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
     <br />
		
		   
        <asp:AjaxFileUpload ID="AjaxFileUpload1"
        ThrobberID="myThrobber"
        AllowedFileTypes="xml"
        MaximumNumberOfFiles="100" 
        runat="server" onuploadcomplete="AjaxFileUpload1_UploadComplete" 
            /> 
        <asp:Image
                ID="myThrobber"
                ImageUrl="/images/ajax-loader.gif"
                Style="display:None"
                runat="server" />
                <br/>
                <asp:Button runat="server" Text="Validar Todos" ID="BtnValidar"
            onclick="Unnamed1_Click" class="btn btn-primary"/>
            <asp:UpdateProgress AssociatedUpdatePanelID="Update1" ID="UpdateProgress1" runat="server">
			<ProgressTemplate>
			<div align="center" >
			  <asp:Image ID="Image1" ImageUrl="images/ajax-loader.gif" runat="server"/> 
			  <br />
			    <br />
                Validando...</div>
			</ProgressTemplate>
			</asp:UpdateProgress>
            <br/>
        <asp:Accordion Width="100%" runat="server" ID="Resultados" 
        HeaderCssClass="accordionHeader"  
        HeaderSelectedCssClass="accordionHeaderSelected"  
        ContentCssClass="accordionContent" >
        <Panes>

          </Panes> 
          </asp:Accordion>
 </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger runat="server" ControlID="BtnValidar"/>
    </Triggers>
       
   
</asp:UpdatePanel>
</asp:Content>
