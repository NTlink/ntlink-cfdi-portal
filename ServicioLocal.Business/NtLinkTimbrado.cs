using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using ServicioLocalContract;

namespace ServicioLocal.Business
{
    public class NtLinkTimbrado : NtLinkBusiness
    {

        public bool ExisteTimbreUuid(string uuid)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var timbre = db.TimbreWs.Any(p => p.Uuid == uuid);
                    return timbre;
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                return false;
            }
        }


         public TimbreWs ObtenerTimbre(string uuid)
         {
             try
             {
                 using (var db = new NtLinkLocalServiceEntities())
                 {
                     var timbre = db.TimbreWs.FirstOrDefault(p => p.Uuid == uuid);
                     return timbre;
                 }
             }
             catch (Exception ee)
             {
                 Logger.Error(ee);
                 return null;
             }
         }

         public TimbreWs ObtenerTimbreHash(string hash)
         {
             try
             {
                 using (var db = new NtLinkLocalServiceEntities())
                 {
                     var timbre = db.TimbreWs.FirstOrDefault(p => p.Hash == hash);
                     return timbre;
                 }
             }
             catch (Exception ee)
             {
                 Logger.Error(ee);
                 return null;
             }
         }


         public bool ExisteTimbre(string hash)
         {
             try
             {
                 using (var db = new NtLinkLocalServiceEntities())
                 {
                     return db.TimbreWs.Any(p => p.Hash == hash);
                 }

             }
             catch (Exception ee)
             {
                 Logger.Error(ee);
                 if (ee.InnerException != null)
                     Logger.Error(ee.InnerException);
                 return false;
             }
         }


         public List<TimbreWs> ObtenerTimbres(string rfc, DateTime inicial, DateTime final)
         {
             try
             {
                 if ((final - inicial).TotalDays > 90)
                 {
                     throw new FaultException("El rango de fechas excede los 90 días");
                 }
                 using (var db = new NtLinkLocalServiceEntities())
                 {
                     db.CommandTimeout = 3600;
                     var timbre = db.TimbreWs.Where(p =>p.FechaFactura >= inicial && p.FechaFactura <= final);
                     if (!string.IsNullOrEmpty(rfc))
                     {
                         timbre = timbre.Where(p => p.RfcEmisor == rfc);
                     }
                     return timbre.OrderBy(p=>p.IdTimbre).Take(1000).ToList();
                 }
             }
             catch (Exception ee)
             {
                 Logger.Error(ee);
                 return null;
             }
         }

        public List<TimbreWs> ObtenerTimbres()
         {
             try
             {
                 using (var db = new NtLinkLocalServiceEntities())
                 {
                     db.CommandTimeout = 3600;
                     var timbre = db.TimbreWs.Where(p => p.Status == 0 && 
                                                   (p.Error == 0 || p.Error == null));
                     return timbre.ToList();
                 }
             }
             catch (Exception ee)
             {
                 Logger.Error(ee);
                 return null;
             }
         }

        public bool GuardarTimbre(TimbreWs timbre)
        {
            try
            {
                
                using (var db = new NtLinkLocalServiceEntities())
                {
                    db.CommandTimeout = 90;
                    if (timbre.IdTimbre == 0)
                    {
                        
                        db.TimbreWs.AddObject(timbre);
                    }
                    else
                    {
                        var t = db.TimbreWs.FirstOrDefault(p => p.IdTimbre == timbre.IdTimbre);
                        db.TimbreWs.ApplyCurrentValues(timbre);
                    }
                    db.SaveChanges();
                    return true;
                }

            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                //throw;
                return false;
            }
        }
    }
}
