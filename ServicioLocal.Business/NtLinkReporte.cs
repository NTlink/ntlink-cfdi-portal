using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ServicioLocalContract;
using System.Data.Objects;

namespace ServicioLocal.Business
{
    public class NtLinkReporte : NtLinkBusiness
    {

       


        public static List<ElementoReporte> ObtenerReporte(int mes, int anio)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (mes == 0)
                    {
                        var timbres = db.vTimbradoAnualSistema.Where(p => p.Anio == anio).ToList();
                        return timbres.Select(
                            p =>
                            new ElementoReporte()
                            {
                                Cancelados = 0,
                                Cliente = p.RazonSocial,
                                Emitidos = p.Timbres.Value,
                                Rfc = p.RFC
                            }).
                            ToList();
                    }
                    else
                    {
                        var timbres =
                            db.vTimbresSistema.Where(p => p.Mes == mes && p.Anio == anio).
                                ToList();
                        
                        return timbres.Select(
                            p =>
                            new ElementoReporte()
                                {Cancelados = 0, 
                                    Cliente = p.RazonSocial, Emitidos = p.Timbres.Value, Rfc = p.Rfc}).
                            ToList();
                    }
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }
        }

        public static List<ElementoReporteMensual> ObtenerReporteMensual()
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    /*

                    var list = db.Sistemas.Join(db.TotalesContratos,
                               s => s.IdSistema,
                               o => o.IdSistema,
                               (s, o) => new ElementoReporteMensual()
                                            {
                                                IdSIstema = s.IdSistema,
                                                consumoEmision = s.ConsumoEmision,
                                                consumoTimbrado = s.ConsumoTimbrado


                                            }).DefaultIfEmpty().ToList();
                    return list;
                    */

                   var list= (from e in db.Sistemas 
                               join d in db.TotalesContratos on e.IdSistema equals d.IdSistema into ej
                               from d in ej.DefaultIfEmpty()
                              select new ElementoReporteMensual() { IdSIstema=e.IdSistema, 
                                                                    Rfc =e.Rfc,
                                                                    Contacto=e.Contacto,
                                                                    Telefono=e.Telefono,
                                                                    Email=e.Email,

                                                                    RazonSocial = e.RazonSocial, 
                                                                    consumoEmision=e.ConsumoEmision,
                                                                    consumoTimbrado= e.ConsumoTimbrado,
                                                                    Timbrado = (d.Timbres)
                              }).ToList();


                    foreach(ElementoReporteMensual e in list)
                    {
                        if (e.consumoEmision == null)
                            e.consumoEmision = 0;
                        if (e.consumoTimbrado == null)
                            e.consumoTimbrado = 0;
                        if (e.Timbrado == null)
                           e.Timbrado = 0;

                        e.Totales = e.consumoEmision + e.consumoTimbrado;
                        if (e.Timbrado == null || e.Timbrado == 0)
                            e.porcentaje = 0;
                        else
                        e.porcentaje = (e.Totales * 100) / e.Timbrado;

                        e.Saldo = e.Timbrado - e.Totales;
                    }

                   return list;
                }
              }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }
        }

        public static List<ElementoReporte> ObtenerReportePorCliente(int mes, int anio, int idSistema)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var cliente = db.Sistemas.FirstOrDefault(p => p.IdSistema == idSistema);
                    if (mes == 0)
                    {
                        var timbres = db.TimbradoSistemaMensual.Where(p => p.Anio == anio && p.IdSistema == idSistema).ToList();
                        return timbres.Select(
                            p =>
                            new ElementoReporte()
                            {
                                Cancelados = 0,
                                Cliente = cliente.RazonSocial,
                                Emitidos = p.Timbres,
                                Rfc = cliente.Rfc,
                                Mes=p.Mes.ToString()
                            }).ToList();
                    }
                    else
                    {
                        var timbres =
                            db.TimbradoSistemaMensual.Where(p => p.Mes == mes && p.Anio == anio && p.IdSistema == idSistema).
                                ToList();
                        var rfc = db.Sistemas.Where(p => p.IdSistema == idSistema).FirstOrDefault();
                       return timbres.Select(
                            p =>
                            new ElementoReporte()
                            {
                                Cancelados =0,
                                Cliente =rfc.RazonSocial,
                                Emitidos = p.Timbres,
                                Rfc = rfc.Rfc,
                                Mes=p.Mes.ToString()

                            }).ToList();
                    }
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }

        }

        public static List<ElementoReporte> ObtenerReportePorEmisor(int mes, int anio, int idEmpresa)
        {
            try
            {

                var listaReporte = new List<ElementoReporte>();
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var emisor = db.empresa.First(e => e.IdEmpresa == idEmpresa);
                    //var emitidos = db.TimbresEmpresa.FirstOrDefault(p => p.IdEmpresa == idEmpresa && p.Anio == anio && p.Mes == mes);
                    var emitidos = db.TimbradoEmpresaMensual.FirstOrDefault(p => p.IdEmpresa == idEmpresa && p.Anio == anio && p.Mes == mes);

                    var elementoReporte = new ElementoReporte
                                              {
                                                  Cancelados = 0,
                                                  Cliente = emisor.RazonSocial,
                                                  Rfc = emisor.RFC,
                                                  Emitidos = emitidos.Timbres
                                                 
                                                //  Emitidos = emitidos.Timbres ?? 0
                                                 // Mes = emitidos.Mes.ToString() ?? "",
                                              };
                    listaReporte.Add(elementoReporte);
                }
                return listaReporte;
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }
        }

        public static List<ElementoReporte> ObtenerReporteFullEmisor(int mes, int anio, int idSistema)
        {
            List<ElementoReporte> lista = new List<ElementoReporte>();
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    //--------------------------------------------------------
                    if (anio == 0 && mes ==0)
                    {

                        var emisor = db.vTimbradoAnualSistema.Where(e => e.idSistema == idSistema).ToList();
                        var mensual = emisor.Select(
                            t => new ElementoReporte()
                            {
                                Cancelados = 0,
                                Cliente = t.RazonSocial,
                                Emitidos = t.Timbres.Value,
                                Rfc = t.RFC
                                

                            }).ToList();

                     
                        var mensual2 = from e in mensual
                                        group e by new {e.Rfc, e.Cliente} into g
                                        select new ElementoReporte() { Cliente = g.Key.Cliente, Rfc = g.Key.Rfc, Emitidos = g.Sum(x => x.Emitidos) }; 

                        //var a = mensual.GroupBy(i => i.Rfc).Select(g => new ElementoReporte() { ,Emitidos = g.Sum(i => i.Emitidos) });

                        return mensual2.ToList();
                          
                    }
                    if (anio == 0 && mes != 0)
                    {

                        var emisor = db.vTimbradoMensualSistema.Where(e => e.idSistema == idSistema && e.Mes == mes).ToList();
                        var mensual = emisor.Select(
                            t => new ElementoReporte()
                            {
                                Cancelados = 0,
                                Cliente = t.RazonSocial,
                                Emitidos = t.Timbres,
                                Rfc = t.RFC
                                
                            }).ToList();

                        var mensual2 = from e in mensual
                                       group e by new { e.Rfc, e.Cliente } into g
                                       select new ElementoReporte() { Cliente = g.Key.Cliente, Rfc = g.Key.Rfc, Emitidos = g.Sum(x => x.Emitidos) }; 

                        return mensual2.ToList();

                    }
                    //--------------------------------------------------------

                    if (mes == 0 && anio!=0)
                    {
                        var emisor = db.vTimbradoAnualSistema.Where(e => e.Anio == anio && e.idSistema == idSistema).ToList();
                        var mensual = emisor.Select(
                            t => new ElementoReporte()
                                {
                                    Cancelados = 0,
                                    Cliente = t.RazonSocial,
                                    Emitidos = t.Timbres.Value,
                                    Rfc = t.RFC
                                   
                                    
                                }).ToList();
                        return mensual;
                    }
                   // else
                    if(mes!=0 && anio!=0)
                    {
                        var emisor = db.vTimbradoMensualSistema.Where(e => e.idSistema == idSistema && e.Anio == anio && e.Mes == mes).ToList();
                        var mensual = emisor.Select(
                            t => new ElementoReporte()
                            {
                                Cancelados = 0,
                                Cliente = t.RazonSocial,
                                Emitidos = t.Timbres,
                                Rfc = t.RFC
                                //Mes= t.Mes.ToString()
                            }).ToList();
                        return mensual;
                    }

                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }
            return lista;
        }
     
        
    }
}
