using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ServicioLocalContract;
using System.Configuration;
using System.IO;


namespace ServicioLocal.Business
{
    public class NtLinkVentas : NtLinkBusiness
    {
        public List<vventas> GetListCuentas(DateTime fechaInicial, DateTime fechaFinal, int idEmpresa, string status, int idCliente = 0, string linea = null)
        {
            try
            {
                List<vventas> lista;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (idEmpresa == 0)
                    {
                        if (linea == null)
                        {
                            lista = db.vventas.Where(p => p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal).ToList();
                        }
                        else
                        {
                            if(idCliente==0)
                            {
                                lista = db.vventas.Where(p => p.Fecha >= fechaInicial &&
                                                              p.Fecha <= fechaFinal && p.Linea == linea).ToList();    
                            }
                            else
                            {
                                lista = db.vventas.Where(p => p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal && p.Linea == linea &&
                                                          p.idcliente == idCliente).ToList();
                            }
                            
                        }


                    }
                    else if (idCliente == 0)
                    {
                        if (linea == null)
                        {
                            lista = db.vventas.Where(p => p.IdEmpresa == idEmpresa && p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal).ToList();
                        }
                        else
                        {
                            lista = db.vventas.Where(p => p.IdEmpresa == idEmpresa && p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal && p.Linea == linea).ToList();
                        }
                    }
                    else
                    {
                        if (linea == null)
                        {
                            lista =
                           db.vventas.Where(
                               p => p.IdEmpresa == idEmpresa && p.idcliente == idCliente && p.Fecha >= fechaInicial &&
                                    p.Fecha <= fechaFinal).ToList();
                        }
                        else
                        {
                            lista =
                              db.vventas.Where(
                                  p => p.IdEmpresa == idEmpresa && p.idcliente == idCliente && p.Fecha >= fechaInicial &&
                                       p.Fecha <= fechaFinal && p.Linea == linea).ToList();
                        }


                    }
                    if (status == "Todos")
                    {
                        return lista;
                    }
                    return lista.Where(p => p.StatusFactura == status || p.StatusFactura == "Pagado").ToList();
                }
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return new List<vventas>();
            }

        }
        public List<vventas> GetList(DateTime fechaInicial, DateTime fechaFinal, int idEmpresa, string status, int idCliente = 0, string linea = null, string iniciales = null)
        {
            try
            {
                List<vventas> lista;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (idEmpresa == 0)
                    {
                        if (!string.IsNullOrEmpty(iniciales))
                        {
                            lista = db.vventas.Where(p => p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal && p.Usuario == iniciales).OrderBy(p => p.Folio).ToList();
                        }
                        else if (linea == null)
                        {
                            lista = db.vventas.Where(p => p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal).OrderBy(p => p.Folio).ToList();
                        }
                        else
                        {
                            if (idCliente == 0)
                            {
                                lista = db.vventas.Where(p => p.Fecha >= fechaInicial &&
                                                              p.Fecha <= fechaFinal && p.Linea == linea).OrderBy(p => p.Folio).ToList();
                            }
                            else
                            {
                                // order by folio
                                lista = db.vventas.Where(p => p.Fecha >= fechaInicial && p.Fecha <= fechaFinal && p.Linea == linea &&
                                                          p.idcliente == idCliente).OrderBy(p => p.Folio).ToList();
                            }

                        }

                        //Lista de REportes
                    }
                    else if (idCliente == 0)
                    {
                        if (!string.IsNullOrEmpty(iniciales))
                        {
                            lista = db.vventas.Where(p => p.IdEmpresa == idEmpresa && p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal && p.Usuario == iniciales).OrderByDescending(p => p.Folio).ToList();
                        }
                        else if (linea == null)
                        {
                            lista = db.vventas.Where(p => p.IdEmpresa == idEmpresa && p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal).OrderByDescending(p => p.Folio).ToList();
                        }
                        else
                        {
                            lista = db.vventas.Where(p => p.IdEmpresa == idEmpresa && p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal && p.Linea == linea).OrderByDescending(p => p.Folio).ToList();
                        }
                    }
                    else
                    {
                        if (linea == null)
                        {
                            lista =
                           db.vventas.Where(
                               p => p.IdEmpresa == idEmpresa && p.idcliente == idCliente && p.Fecha >= fechaInicial &&
                                    p.Fecha <= fechaFinal).OrderByDescending(p => p.Folio).ToList();
                        }
                        else
                        {
                            lista =
                              db.vventas.Where(
                                  p => p.IdEmpresa == idEmpresa && p.idcliente == idCliente && p.Fecha >= fechaInicial &&
                                       p.Fecha <= fechaFinal && p.Linea == linea).OrderByDescending(p => p.Folio).ToList();
                        }


                    }
                    if (status == "Todos")
                    {
                        return lista;
                    }
                    return lista.Where(p => p.StatusFactura == status).ToList();
                }
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return new List<vventas>();
            }
           
        }
        //--------------------------------------
        public List<vventaRetenciones> GetListRetenciones(DateTime fechaInicial, DateTime fechaFinal, int idEmpresa, string status, int idCliente = 0, string linea = null )
        {
            try
            {
                string iniciales = null;
                List<vventaRetenciones> lista;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (idEmpresa == 0)
                    {
                        if (linea == null)
                        {
                            lista = db.vventaRetenciones.Where(p => p.FechaFactura >= fechaInicial &&
                                                          p.FechaFactura <= fechaFinal).OrderByDescending(p => p.Id).ToList();
                        }
                        else
                        {
                            if (idCliente == 0)
                            {
                                lista = db.vventaRetenciones.Where(p => p.FechaFactura >= fechaInicial &&
                                                              p.FechaFactura <= fechaFinal && p.Linea == linea).OrderByDescending(p => p.Id).ToList();
                            }
                            else
                            {
                                // order by folio
                                lista = db.vventaRetenciones.Where(p => p.FechaFactura >= fechaInicial && p.FechaFactura <= fechaFinal && p.Linea == linea &&
                                                          p.idCliente == idCliente).OrderByDescending(p => p.Id).ToList();
                            }

                        }

                        //Lista de REportes
                    }
                    else if (idCliente == 0)
                    {
                         if (linea == null)
                        {
                            lista = db.vventaRetenciones.Where(p => p.IdEmpresa == idEmpresa && p.FechaFactura >= fechaInicial &&
                                                          p.FechaFactura <= fechaFinal).OrderByDescending(p => p.Id).ToList();
                        }
                        else
                        {
                            lista = db.vventaRetenciones.Where(p => p.IdEmpresa == idEmpresa && p.FechaFactura >= fechaInicial &&
                                                          p.FechaFactura <= fechaFinal && p.Linea == linea).OrderByDescending(p => p.Id).ToList();
                        }
                    }
                    else
                    {
                        if (linea == null)
                        {
                            lista =
                           db.vventaRetenciones.Where(
                               p => p.IdEmpresa == idEmpresa && p.idCliente == idCliente && p.FechaFactura >= fechaInicial &&
                                    p.FechaFactura <= fechaFinal).OrderByDescending(p => p.Id).ToList();
                        }
                        else
                        {
                            lista =
                              db.vventaRetenciones.Where(
                                  p => p.IdEmpresa == idEmpresa && p.idCliente == idCliente && p.FechaFactura >= fechaInicial &&
                                       p.FechaFactura <= fechaFinal && p.Linea == linea).OrderByDescending(p => p.Id).ToList();
                        }


                    }
                    if (status == "Todos")//manda todos
                    {
                        return lista;
                    } 
                    return lista.Where(p => p.Status == status).ToList(); //si no busca por el estatus
                }
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return new List<vventaRetenciones>();
            }

        }
        //----------------------------------------------------------
       public string Confirmacion(string Confirmar, Int64 IdTimbre)
        {
            try
            {
           
            using (var db = new NtLinkLocalServiceEntities())
            {
                {
                    ConfirmacionTimbreWs33 C=db.ConfirmacionTimbreWs33.FirstOrDefault(p => p.IdTimbre == IdTimbre);
                    C.Confirmacion = Confirmar;
                    C.procesado = false;
                    db.ConfirmacionTimbreWs33.ApplyCurrentValues(C);
                }
                db.SaveChanges();
                return "OK";
            }
           }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return ("Error al Confirmar ");
            }

        }
        //--------------------------------------
        public List<ConfirmacionTimbreWs33> GetListConfirmacion( string idEmpresa, string idCliente)
        {
            try
            {
                int idC = 0;
                int idE = 0;

                if (!string.IsNullOrEmpty(idCliente))
                    idC = int.Parse(idCliente);
                if (!string.IsNullOrEmpty(idEmpresa))
                    idE = int.Parse(idEmpresa);

                List<ConfirmacionTimbreWs33> lista;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (string.IsNullOrEmpty( idEmpresa))
                    {
                            lista = db.ConfirmacionTimbreWs33.OrderByDescending(p => p.IdTimbre).ToList();
                        //Lista de REportes
                    }
                    else if (string.IsNullOrEmpty(idCliente) || idCliente=="0")
                    {
                          empresa empr = db.empresa.Where(x=>x.IdEmpresa==idE).FirstOrDefault();
                          if (empr != null)
                              idEmpresa = empr.RFC;
                          
                        lista = db.ConfirmacionTimbreWs33.Where(p => p.RfcEmisor == idEmpresa ).OrderByDescending(p => p.IdTimbre).ToList();
                    }
                    else
                    {
                        empresa empr = db.empresa.Where(x => x.IdEmpresa == idE).FirstOrDefault();
                        if (empr != null)
                            idEmpresa = empr.RFC;
                        clientes clien = db.clientes.Where(x => x.idCliente == idC).FirstOrDefault();
                        if (clien != null)
                            idCliente = clien.RFC;
                     
                            lista =
                           db.ConfirmacionTimbreWs33.Where(
                               p => p.RfcEmisor == idEmpresa && p.RfcReceptor == idCliente ).OrderByDescending(p => p.IdTimbre).ToList();
                  
                    }
                  //  if (status == "Todos")//manda todos
                   // {
                        return lista;
                  //  }
                   // return lista.Where(p => p.Status == status).ToList(); //si no busca por el estatus
                }
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return new List<ConfirmacionTimbreWs33>();
            }

        }

      
        //-----------------------------------------------------
        public List<vventas> GetListNomina(DateTime fechaInicial, DateTime fechaFinal, int idEmpresa, string status, int idCliente = 0, string linea = null, string iniciales = null)
        {
            try
            {
                List<vventas> lista;
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (idEmpresa == 0)
                    {
                        if (!string.IsNullOrEmpty(iniciales))
                        {
                            lista = db.vventas.Where(p => p.Tipo == 1 &&  p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal && p.Usuario == iniciales).OrderBy(p => p.Folio).ToList();
                        }
                        else if (linea == null)
                        {
                            lista = db.vventas.Where(p => p.Tipo == 1 && p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal).OrderBy(p => p.Folio).ToList();
                        }
                        else
                        {
                            if (idCliente == 0)
                            {
                                lista = db.vventas.Where(p => p.Tipo == 1 && p.Fecha >= fechaInicial &&
                                                              p.Fecha <= fechaFinal && p.Linea == linea).OrderBy(p => p.Folio).ToList();
                            }
                            else
                            {
                                // order by folio
                                lista = db.vventas.Where(p => p.Tipo == 1 && p.Fecha >= fechaInicial && p.Fecha <= fechaFinal && p.Linea == linea &&
                                                          p.idcliente == idCliente).OrderBy(p => p.Folio).ToList();
                            }

                        }

                        //Lista de REportes
                    }
                    else if (idCliente == 0)
                    {
                        if (!string.IsNullOrEmpty(iniciales))
                        {
                            lista = db.vventas.Where(p => p.Tipo == 1 && p.IdEmpresa == idEmpresa && p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal && p.Usuario == iniciales).OrderByDescending(p => p.Folio).ToList();
                        }
                        else if (linea == null)
                        {
                            lista = db.vventas.Where(p => p.Tipo == 1 && p.IdEmpresa == idEmpresa && p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal).OrderByDescending(p => p.Folio).ToList();
                        }
                        else
                        {
                            lista = db.vventas.Where(p => p.Tipo == 1 && p.IdEmpresa == idEmpresa && p.Fecha >= fechaInicial &&
                                                          p.Fecha <= fechaFinal && p.Linea == linea).OrderByDescending(p => p.Folio).ToList();
                        }
                    }
                    else
                    {
                        if (linea == null)
                        {
                            lista =
                           db.vventas.Where(
                               p => p.Tipo == 1 && p.IdEmpresa == idEmpresa && p.idcliente == idCliente && p.Fecha >= fechaInicial &&
                                    p.Fecha <= fechaFinal).ToList();
                        }
                        else
                        {
                            lista =
                              db.vventas.Where(
                                  p => p.Tipo == 1 && p.IdEmpresa == idEmpresa && p.idcliente == idCliente && p.Fecha >= fechaInicial &&
                                       p.Fecha <= fechaFinal && p.Linea == linea).ToList();
                        }


                    }
                    if (status == "Todos")
                    {
                        return lista;
                    }
                    return lista.Where(p => p.StatusFactura == status).ToList();
                }
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return new List<vventas>();
            }

        }
        //----nuevo
        public vventaRetenciones GetRetencionById(Int64 ID)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var x = db.vventaRetenciones.FirstOrDefault(p => p.Id == ID);
                    return x;
                }
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return null;
            }
        }


        public byte[] GetFacturaAcuse(string uuid, string RFC, string fecha)
        
        {
            try
            {
                DateTime dt = Convert.ToDateTime(fecha);
                string mes = dt.Month.ToString();
                if (mes.Length < 2)
                    mes = "0" + mes;
                string dia=dt.Day.ToString();
                if(dia.Length<2)
                    dia="0"+dia;
                fecha = dt.Year.ToString() + mes + dia;

                string ruta = Path.Combine(ConfigurationManager.AppSettings["RutaTimbrado"], RFC,fecha);
                if (File.Exists(Path.Combine(ruta, "Cancelacion_"+uuid + ".xml")))
               {
                   var bytes = File.ReadAllBytes(Path.Combine(ruta, "Cancelacion_" + uuid + "." + "xml"));
                   return bytes;
               }
               else
                   return null;
                        
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return null;
            }
        }


        public vventas GetById(int idVenta)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var x = db.vventas.FirstOrDefault(p => p.idVenta == idVenta);
                    return x;
                }
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return null;
            }
        }

        public bool SaveList (List<vventas> lista)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    foreach (vventas ventas in lista)
                    {
                        vventas ventas1 = ventas;
                        facturas f = db.facturas.Where(p => p.idVenta == ventas1.idVenta).First();
                        f.Cancelado = ventas.Cancelado;
                        f.FechaPago = ventas.FechaPago;
                        f.ReferenciaPago = ventas.ReferenciaPago;
                        f.Vencimiento = ventas.Vencimiento;
                        f.Proyecto = ventas.Proyecto;
                        //_entities.facturas.ApplyCurrentValues(f);
                    }
                    db.SaveChanges();
                }
                return true;
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return false;
            }
            
        }

        


    }
}
