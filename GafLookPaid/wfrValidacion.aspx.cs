using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Text;
using System.Xml;
using AjaxControlToolkit;
using ServicioLocalContract;

namespace GafLookPaid
{
    public partial class wfrValidacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        class UploadedFileNtLink
        {
            public string FileName { get; set; }
            public string FileContent { get; set; }
        }

        protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            //AjaxFileUpload1.SaveAs(e.FileName);
            //var bytes = e.GetContents();
            //var contenido = Encoding.UTF8.GetString(bytes);
            //var clienteServicio = NtLinkClientFactory.Cliente();

            //using (clienteServicio as IDisposable)
            //{
            //    var res = clienteServicio.ValidarCfdi(contenido);
            //    var lblTitle = new Label();
            //    var lblContent = new Label();
            //    if (res.Entrada != null)
            //    {
            //        lblTitle.Text = res.Entrada.RfcEmisor;
            //        lblContent.Text = res.Entrada.CadenaOriginal;
            //        var pn = new AjaxControlToolkit.AccordionPane();
            //        pn.HeaderContainer.Controls.Add(lblTitle);
            //        pn.ContentContainer.Controls.Add(lblContent);
            //        this.Resultados.Panes.Add(pn);
            //        pn.ID = Guid.NewGuid().ToString();
            //    }
            //}
            //lblTexto.Text = e.FileName;
            List<UploadedFileNtLink> lista;
            if (Session["uploaded"] == null)
            {
                lista = new List<UploadedFileNtLink>();
            }
            else lista = Session["uploaded"] as List<UploadedFileNtLink>;
            lista.Add(new UploadedFileNtLink { FileContent = Encoding.UTF8.GetString(e.GetContents()), FileName = e.FileName });
            Session["uploaded"] = lista;
            
        }

        protected void AjaxFileUpload1_UploadCompleteAll(object sender, AjaxControlToolkit.AjaxFileUploadCompleteAllEventArgs e)
        {
            //lblTexto.Text = "Hola ";
            // if (Session["uploaded"] != null)
            // {
            //     var lista = Session["uploaded"] as List<string>;
            //     foreach (string s in lista)
            //     {
            //         var lblTitle = new Label();
            //         var lblContent = new Label();
            //         lblTitle.Text = Guid.NewGuid().ToString();
            //         lblContent.Text = "Hola";
            //         var pn = new AjaxControlToolkit.AccordionPane();
            //         pn.HeaderContainer.Controls.Add(lblTitle);
            //         pn.ContentContainer.Controls.Add(lblContent);
            //         pn.ID = lblTitle.Text;
            //         this.Resultados.Panes.Add(pn);
            //     }
            //// }
            //Update1.Update();
        }



        protected void Update1_Load(object sender, EventArgs e)
        {
           

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            if (Session["uploaded"] != null)
             {
                 var lista = Session["uploaded"] as List<UploadedFileNtLink>;
                 var clienteServicio = NtLinkClientFactory.Cliente();
                using (clienteServicio as IDisposable)
                {
                    foreach (UploadedFileNtLink file in lista)
                    {
                        var lblTitle = new Label();
                        lblTitle.ID = Guid.NewGuid().ToString();
                        lblTitle.Text = file.FileName;
                        
                        var pn = new AccordionPane();
                        
                        pn.HeaderContainer.ID = Guid.NewGuid().ToString();
                        pn.HeaderContainer.Controls.Add(lblTitle);
                        try
                        {
                            var res = clienteServicio.ValidarCfdi(file.FileContent);
                            HtmlGenericControl div = new HtmlGenericControl("div");
                            div.Attributes.Add("ID", Guid.NewGuid().ToString());
                            string datosGenerales = "Versión: " + res.Entrada.Version + "<br />" +
                                                    "Rfc Emisor: " + res.Entrada.RfcEmisor + "<br />" +
                                                    "Cadena Original: " + res.Entrada.CadenaOriginal + "<br />" +
                                                    "No. Certificado: " + res.Entrada.NoCertificado + "<br />" +
                                                    "Fecha Comprobante: " + res.Entrada.Fecha + "<br />";
                            if(res.Entrada.Version == "3.2")
                            {
                                datosGenerales = datosGenerales + "Fecha Timbrado: " + res.Entrada.FechaTimbrado +
                                                 "<br />" +
                                                 "No. Certificado SAT: " + res.Entrada.NoCertificadoSat + "<br />";
                            }
                            else
                            {
                                datosGenerales = datosGenerales + "No Aprobación: " + res.Entrada.NoAprobacion +
                                                    "<br />" +
                                                    "Año de Aprobación: " + res.Entrada.AnoAprobacion + "<br />";
                                
                            }
                            div.InnerHtml = datosGenerales;
                            pn.ContentContainer.Controls.Add(div);
                            var lblValido = new Label() { Text = (res.Valido ? "Archivo Válido" : "Archivo Inválido"), ID = Guid.NewGuid().ToString() };
                            pn.ContentContainer.ID = Guid.NewGuid().ToString();
                            pn.ContentContainer.Controls.Add(lblValido);
                            if (res.Detalles != null)
                            {
                                GridView grid = new GridView();
                                grid.AutoGenerateColumns = false;
                                grid.Columns.Add(new BoundField(){HeaderText = "Validación", DataField = "Descripcion"});
                                grid.Columns.Add(new BoundField(){HeaderText = "Resultado", DataField = "Error"});
                                grid.DataSource = res.Detalles;
                                grid.DataBind();
                                grid.ID = Guid.NewGuid().ToString();
                                pn.ContentContainer.Controls.Add(grid);
                            }
                            pn.ID = Guid.NewGuid().ToString();
                        }
                        catch (Exception ee)
                        {
                            var lblValido = new Label() { Text = ("Error al leer el archivo"), ID = Guid.NewGuid().ToString() };
                            pn.ContentContainer.ID = Guid.NewGuid().ToString();
                            pn.ContentContainer.ID = Guid.NewGuid().ToString();
                            pn.ContentContainer.Controls.Add(lblValido);
                        }
                        
                        
                        this.Resultados.Panes.Add(pn);
                    }
                    lista.Clear();
                }

                 
            }
        }
    }
}