using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.ServiceModel;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using ServicioLocalContract;
using System.Data.Sql;
using I_RFC_SAT;

namespace ServicioLocal.Business
{
    public class NtLinkSistema : NtLinkBusiness
    {

        public List<Contratos> ListaContratos(int idSistema)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var con = db.Contratos.Where(p => p.IdSistema == idSistema).ToList();
                    return con;
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
        
        public void GuardarContrato(Contratos contrato)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (contrato.IdContrato == 0)
                    {
                        db.Contratos.AddObject(contrato);
                       // if (contrato.TipoContrato != "Post-Pago")//debe de agrgar los saldos aun cuando es post pago
                        {
                            var cliente = db.Sistemas.FirstOrDefault(p => p.IdSistema == contrato.IdSistema);
                            if (contrato.TipoContrato == "Emision")
                                cliente.SaldoEmision = cliente.SaldoEmision + contrato.Timbres;
                            else
                                cliente.SaldoTimbrado = cliente.SaldoTimbrado + contrato.Timbres;
                            cliente.UltimaRenovacion = DateTime.Now;
                        }
                    }
                    else
                    {
                        db.Contratos.FirstOrDefault(p => p.IdContrato == contrato.IdContrato);
                        db.Contratos.ApplyCurrentValues(contrato);
                    }
                    db.SaveChanges();
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);

            }
        }

        public void GuardarDisContrato(DistContratos contrato)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (contrato.IdContrato == 0)
                    {
                        
                        
                        db.DistContratos.AddObject(contrato);
                        //if (contrato.TipoContrato != "Post-Pago")//debe de agregar y guardar los saldos aun cuando es post pago
                        {
                            var cliente = db.Sistemas.FirstOrDefault(p => p.IdSistema == contrato.IdSistema);
                            if (contrato.TipoContrato == "Emision")
                                cliente.SaldoEmision = cliente.SaldoEmision + contrato.Timbres;
                            else
                                cliente.SaldoTimbrado = cliente.SaldoTimbrado + contrato.Timbres;
                        }

                    }
                    else
                    {
                        db.DistContratos.FirstOrDefault(p => p.IdContrato == contrato.IdContrato);
                        db.DistContratos.ApplyCurrentValues(contrato);
                    }
                    db.SaveChanges();
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);

            }
        }

        public List<Paquetes> ListaPaquetes()
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var paquetes = db.Paquetes.ToList();
                    return paquetes;
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

        public bool SavePaquete(Paquetes paquete)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    if (db.Paquetes.Any(p => p.Descripcion == paquete.Descripcion))
                    {
                        throw new FaultException("Descripción duplicada");
                    }
                    if (paquete.IdPaquete == 0)
                    {
                        db.AddToPaquetes(paquete);
                        db.SaveChanges();
                    }
                    else
                    {
                        var pa = db.Paquetes.Where(p => p.IdPaquete == paquete.IdPaquete).FirstOrDefault();
                        db.Paquetes.ApplyCurrentValues(paquete);
                        db.SaveChanges();
                    }
                    return true;
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return false;
            }
        }

        public int ObtenerNumeroTimbres(int idSistema)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var res = db.TotalesTimbrado.Where(p => p.idSistema == idSistema).FirstOrDefault();
                    if (res != null) return (int)res.Timbres;
                    return 0;
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return 0;
            }


        }


        public Sistemas GetSistema(int idSistema, bool datos = false)
        {

            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var sistema = db.Sistemas.FirstOrDefault(c => c.IdSistema == idSistema);
                    if (datos)
                    {
                        var totales = db.TotalesTimbrado.FirstOrDefault(p => p.idSistema == idSistema);
                        var totalesCon = db.TotalesContratos.FirstOrDefault(p => p.IdSistema == idSistema);
                        if (totales != null)
                            sistema.TimbresConsumidos = (int) totales.Timbres;
                        if (totalesCon != null)
                            sistema.TimbresContratados = totalesCon.Timbres;
                    }
                    
                    return sistema;
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;

            }

        }

        public Sistemas GetSistema(string rfc)
        {

            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var sistema = db.Sistemas.Where(c => c.Rfc == rfc);
                    return sistema.FirstOrDefault();
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }

        }


        private bool Existe(Sistemas e)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    return db.Sistemas.Any(p => p.Rfc == e.Rfc);
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


        private bool Validar(Sistemas e)
        {
            //TODO: Validar los campos requeridos y generar excepcion
            {
                if (string.IsNullOrEmpty(e.RazonSocial))
                {
                    throw new FaultException("La Razón Social no puede ir vacía");
                }
                if (string.IsNullOrEmpty(e.Rfc))
                {
                    throw new FaultException("El campo RFC es Obligatorio");
                }
                if (string.IsNullOrEmpty(e.Email))
                {
                    throw new FaultException("El campo Email es Obligatorio");
                }
                if (string.IsNullOrEmpty(e.Direccion))
                {
                    throw new FaultException("El campo Calle es Obligatorio");
                }
                if (string.IsNullOrEmpty(e.Ciudad))
                {
                    throw new FaultException("El campo Municipio es Obligatorio");
                }
                if (string.IsNullOrEmpty(e.Estado))
                {
                    throw new FaultException("El campo Estado es Obligatorio");
                }
                if (string.IsNullOrEmpty(e.Cp))
                {
                    throw new FaultException("El campo Código Postal es Obligatorio");
                }
                if (string.IsNullOrEmpty(e.RegimenFiscal))
                {
                    throw new FaultException("El campo Régimen es Obligatorio");
                }

                Regex reg = new Regex("^[A-Z,Ñ,&amp;]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z,0-9]{2}[0-9,A]$");
                if (!reg.IsMatch(e.Rfc))
                {
                    throw new FaultException<ApplicationException>(new ApplicationException("El RFC es inválido"), "El RFC es inválido");
                }
                //Regex regex = new Regex(@"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*([,;]\s*\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*)*");
                Regex regex = new Regex(@"^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$");
                if (!regex.IsMatch(e.Email))
                {
                    throw new FaultException("El campo Email esta mal formado");
                }
                if (e.Multiple == false)//para multiples empresas con el mismo RFC
                {
                    if (e.IdSistema == 0 && Existe(e)) 
                    {
                        throw new FaultException("El RFC ya fue capturado");
                    }
                }
                Operaciones_IRFC lco = new Operaciones_IRFC();
                var rfcLco = lco.SearchLCOByRFC(e.Rfc);
           
                if (rfcLco == null)
                {
                    throw new FaultException("El Rfc no se encuentra en la lista de contribuyentes con obligaciones");
                }
            }
            return true;
        }


        private void EnviarCorreo(string email,string razonSocial, string usuario, string password)
        {
            try
            {
                var archivo = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Resources", "TextoEmail.html");

                var content = File.ReadAllText(archivo,Encoding.UTF8);
                content = content.Replace("[RazonSocial]", razonSocial).Replace("[UserName]", usuario).Replace(
                    "[Password]", password);
                Mailer mailer = new Mailer();
                var recipients = new List<string>();
                recipients.Add(email);
                mailer.Send(recipients, new List<string>(), content, "Notificacion: Registro de Solicitud de Usuario - Facturación Electrónica", "facturacion@ntlink.com.mx", "Servicio de Facturación Electrónica Nt Link");
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                throw new FaultException("Ocurrió un error al enviar el correo electronico, revise el archivo de log para ver los detalles");
            }
        }


        public bool SaveSistema(Sistemas sistema, ref string resultado, string nombreCompleto, string iniciales,int usu)
        {

            try
            {
                if (Validar(sistema))
                {
                    using (var db = new NtLinkLocalServiceEntities())
                    {
                        if (sistema.IdSistema == 0)
                        {
                            // Crear random password
                            if (db.aspnet_Membership.Any(p => p.LoweredEmail == sistema.Email.ToLower()))
                            {
                                throw new FaultException("El Email ya fue registrado");
                            }
                            //--------------------------historico
                            string cadena=AltaEnSistemas(sistema);
                            BitacoraSistemasTotales Bita = new BitacoraSistemasTotales();
                            Bita.Usuario = usu;
                            Bita.Cambio = cadena;

                            db.BitacoraSistemasTotales.AddObject(Bita);
                            //----------------------------------------------------
                            db.Sistemas.AddObject(sistema);
                            db.SaveChanges();
                            var password = Membership.GeneratePassword(8, 2);
                            var userName = sistema.Email;
                            empresa em = new empresa()
                            {
                                PrimeraVez = true,
                                RazonSocial = sistema.RazonSocial,
                                RFC = sistema.Rfc,
                                Ciudad = sistema.Ciudad,
                                Colonia = sistema.Colonia,
                                CP = sistema.Cp,
                                Direccion = sistema.Direccion,
                                Email = sistema.Email,
                                Estado = sistema.Estado,
                                idSistema = sistema.IdSistema,
                                RegimenFiscal = sistema.RegimenFiscal,
                                Linea = "A"
                            };
                            NtLinkEmpresa emp = new NtLinkEmpresa();
                            if(sistema.Multiple==true)
                            emp.Save_RFC_Multiple(em, null,true);//permite repetir el RFC
                            else
                            emp.Save_RFC_Multiple(em, null, true);//no permite repetir RFc
                         

                            var e2 = emp.GetByRfc(em.RFC);
                            //se quito e2 por emp en IdEmpresa en la siguiente linea
                            var usuario = NtLinkUsuarios.CreateUser(userName, password, sistema.Email, em.IdEmpresa, "Administrador", nombreCompleto, iniciales);
                            if (!usuario)
                            {
                                throw new FaultException("Error al crear el nuevo usuario");
                            }
                            Logger.Info( "se creó el usuario: "+ userName + " con el password: " + password);
                            try
                            {
                                EnviarCorreo(sistema.Email, sistema.RazonSocial, userName, password);
                            }
                            catch (Exception ex)
                            {
                                Logger.Error(ex);
                            }
                            resultado = "se creó el usuario: "+ userName + " con el password: " + password;
                            
                        }
                        else
                        {
                            var y = db.Sistemas.Where(p => p.IdSistema == sistema.IdSistema).FirstOrDefault();
                            //---------------------------------------------------------------------------------------------
                            string cadena = CambiosEnSistemas(sistema, y);//verifica que cambios ocurrieron 
                            BitacoraSistemasTotales Bita=new BitacoraSistemasTotales();
                            Bita.Usuario=usu;
                            Bita.Cambio=cadena;
                           
                            db.BitacoraSistemasTotales.AddObject(Bita);

                            //---------------------------------------------------------------------------------------------
                            db.Sistemas.ApplyCurrentValues(sistema);
                            db.SaveChanges();
                            resultado = "Registro actualizado correctamente";
                        }
                       

                        return true;
                    }
                }
                return false;
            }
            catch (FaultException fe)
            {
                throw;
            }
            catch (Exception ee)
            {
                resultado = "Error al guardar el registro";
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return false;
            }
        }



        public List<Sistemas> GetSistemasLista(string filtro, int ejecutivo = 0)
        {

            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var sist = db.Sistemas.AsQueryable();
                    if (ejecutivo != 0)
                        sist = db.Sistemas.Where(p => p.IdPromotor == ejecutivo);
                    if (string.IsNullOrEmpty(filtro))
                        sist =  sist.OrderBy(p=>p.RazonSocial);
                    else
                        sist = sist.Where(p => p.RazonSocial.Contains(filtro) || p.Rfc.Contains(filtro)).OrderBy(p => p.RazonSocial).AsQueryable();
                    return sist.ToList();
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }

        }

        public List<ElementoCliente> ListaSistemasTimbre(string filtro)
        {

            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    
                        var dis =
                            db.Sistemas.Where(p => p.RazonSocial.Contains(filtro) || p.Rfc.Contains(filtro)).ToList();

                        return dis.Select(p =>
                                          new ElementoCliente()
                                          {
                                              IdSistema = Convert.ToInt32(p.IdSistema),

                                              Comsumidos = p.TimbresConsumidos,
                                              //Contratados = (p.TimbresContratados.HasValue ? p.TimbresContratados.Value : 0),
                                              //Porcentaje =
                                              //    Convert.ToDouble(((p.Consumidos
                                              //                      ) * 100 / (p.Contratados)
                                              //                     )),
                                              RazonSocial = p.RazonSocial,
                                              Rfc = p.Rfc,
                                          }).ToList();
                    

                }

            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }

        }


        public void IncrementaTimbres(long idSistema, int idempresa)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    int res = db.ExecuteStoreCommand(
                        "update sistemas set TimbresConsumidos = TimbresConsumidos + 1 where IdSistema = {0}",
                        idSistema);
                    res = db.ExecuteStoreCommand(
                        "update empresa set TimbresConsumidos = TimbresConsumidos + 1 where Idempresa = {0}",
                        idempresa);
                    
                }

            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
            }
        }

        public List<ElementoCliente> ListaTimbrado(int id)
        {

            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var timbra = db.vListaTimbre.Where(p=>p.IdSistema == id).OrderBy(p => p.IdSistema).ToList();
                    //var vventa = db.vventas.OrderBy(o => o.idventa).ToList();
                    return timbra.Select(p =>
                                      new ElementoCliente()
                                          {
                                              IdSistema = Convert.ToInt32(p.IdSistema),

                                              Comsumidos = p.Consumidos.HasValue ? p.Consumidos.Value : 0 ,
                                              Contratados = p.Contratados.HasValue ? p.Contratados.Value : 0,
                                              Porcentaje =p.porcentaje.HasValue ? p.porcentaje.Value: 0,
                                              RazonSocial = p.RazonSocial,
                                              Rfc = p.Rfc
                                          }).ToList();
                }

            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                if (ee.InnerException != null)
                    Logger.Error(ee.InnerException);
                return null;
            }

        }
        //----------------------------------------------------------------------------------
        private string CambiosEnSistemas(Sistemas sistema,Sistemas y)
        {
            string cadena = "ACTUALIZAR";
            if (y.TipoSistema != sistema.TipoSistema)
                cadena = cadena + "|TipoSistema:" + y.TipoSistema + " = " + sistema.TipoSistema;
            
            if (y.Rfc != sistema.Rfc)
                cadena = cadena + "|RFC:" + y.Rfc + " = " + sistema.Rfc;
         
            if (y.RazonSocial != sistema.RazonSocial)
                cadena = cadena + "|RazonSocial:" + y.RazonSocial + " = " + sistema.RazonSocial;
         
            if (y.RegimenFiscal != sistema.RegimenFiscal)
                cadena = cadena + "|RegimenFiscal:" + y.RegimenFiscal + " = " + sistema.RegimenFiscal;
         
            if (y.Direccion != sistema.Direccion)
                cadena = cadena + "|Direccion:" + y.Direccion + " = " + sistema.Direccion;
         
            if (y.Colonia != sistema.Colonia)
                cadena = cadena + "|Colonia:" + y.Colonia + " = " + sistema.Colonia;
         
            if (y.Estado != sistema.Estado)
                cadena = cadena + "|Estado:" + y.Estado + " = "  + sistema.Estado;
         
            if (y.Ciudad != sistema.Ciudad)
                cadena = cadena + "|Ciudad:" + y.Ciudad + " = " + sistema.Ciudad;
         
            if (y.Cp != sistema.Cp)
                cadena = cadena + "|CP:" + y.Cp + " = " + sistema.Cp;
         
            if (y.Telefono != sistema.Telefono)
                cadena = cadena + "|Telefono:" + y.Telefono + " = "  + sistema.Telefono;
         
            if (y.Email != sistema.Email)
                cadena = cadena + "|Email:" + y.Email + " = " + sistema.Email;
         
            if (y.Contacto != sistema.Contacto)
                cadena = cadena + "|Contacto:" + y.Contacto + " = " + sistema.Contacto;
         
            if (y.SaldoEmision != sistema.SaldoEmision)
                cadena = cadena + "|SaldoEmision:" + y.SaldoEmision + " = " + sistema.SaldoEmision;
         
            if (y.SaldoTimbrado != sistema.SaldoTimbrado)
                cadena = cadena + "|SaldoTimbrado:" + y.SaldoTimbrado + " = " + sistema.SaldoTimbrado;
         
            if (y.Bloqueado != sistema.Bloqueado)
                cadena = cadena + "|Bloqueado:" + y.Bloqueado + " = " + sistema.Bloqueado;
            if(y.IdPromotor!=sistema.IdPromotor)
                cadena = cadena + "|IdPromotor:" + y.IdPromotor + " = " + sistema.IdPromotor;
            if (cadena == "ACTUALIZAR")
                cadena = "|Sin cambios";
            return cadena;
        }
        //-----------------------------------------------------------------------------------------
        private string AltaEnSistemas(Sistemas sistema)
        {
            string cadena = "ALTA";
            cadena = cadena + "|TipoSistema:"  + sistema.TipoSistema;
            cadena = cadena + "|RFC:"  + sistema.Rfc;
            cadena = cadena + "|RazonSocial:" + sistema.RazonSocial;
            cadena = cadena + "|RegimenFiscal:" + sistema.RegimenFiscal;
            cadena = cadena + "|Email:" + sistema.Email;
            cadena = cadena + "|SaldoEmision:" + sistema.SaldoEmision;
            cadena = cadena + "|SaldoTimbrado:" + sistema.SaldoTimbrado;
            return cadena;
        }
    }
}
