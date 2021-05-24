using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Web.Security;
using System.Web;
using log4net.Repository.Hierarchy;
using ServicioLocalContract;
using System.IO;


namespace ServicioLocal.Business
{
    public class NtLinkUsuarios : NtLinkBusiness
    {

        public bool RecuperarMail(string rfc, string email)
        {
            try
            {
                var usuario = Membership.GetUser(email);
                if (usuario == null)
                    throw new FaultException("El email proporcionado no coincide con el RFC");

                var empresa = GetEmpresaByUserId(usuario.ProviderUserKey.ToString());
                if (empresa == null || empresa.RFC != rfc)
                    throw new FaultException("El email proporcionado no coincide con el RFC");



                if (!usuario.IsLockedOut)
                {
                    var profile = UserProfile.GetUserProfile(email);
                    profile.CambiarPassword = "1";
                    profile.Save();
                    Mailer m = new Mailer();
                    var pass = usuario.ResetPassword("dos");
                    
                    /*
                    List<string> recipients = new List<string>() { email };
                  
                    m.Send(recipients, new List<string>(),
                        "Estimado usuario " + empresa.RazonSocial + " su nuevo password es: <b>" + pass + "</b><br/><br/><br/>Recuerda cambiarlo al acceder al sistema con las politicas de contraseñas(una mayuscala, una minuscula, un numero y un caracter especial \"@#$%+_.-\" ). <br/><br/><br/><br/><br/><br/><br/> NT Link " + System.DateTime.Now.ToString("yyyy"),
                        "Cambio de contraseña NT Link Facturación",
                        "soporte@ntlink.com.mx",
                        "Soporte Nt Link");
                    */
                    var archivo = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Resources", "TextoEmailCambio.html");

                    var content = File.ReadAllText(archivo, Encoding.UTF8);
                    content = content.Replace("[RazonSocial]", empresa.RazonSocial).Replace("[UserName]", email).Replace(
                        "[Password]", pass);
                    Mailer mailer = new Mailer();
                    var recipients = new List<string>();
                    recipients.Add(email);
                    mailer.Send(recipients, new List<string>(), content,
                                "Notificacion: Cambio de contraseña NT Link Facturación - Facturación Electrónica",
                                "facturacion@ntlink.com.mx", "Servicio de Facturación Electrónica Nt Link");

                    return true;
                }
                else
                {

                    throw new FaultException("Usuario bloqueado, favor de comunicarse");
                    
                }
                return false;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
               if (ee.Message == "El email proporcionado no coincide con el RFC")
                   throw new FaultException("El email proporcionado no coincide con el RFC");
                if (ee.Message == "Usuario bloqueado, favor de comunicarse")
                    throw new FaultException("Usuario bloqueado, favor de comunicarse");
                else
                throw new FaultException("No se encontró el usuario");
            }
           

        }
        //---------------------------------------------------------------------
        public bool RecuperarMailAdministracion(string email)
        {
            try
            {
                var usuario = Membership.GetUser(email);
                if (usuario == null)
                    throw new FaultException("El email proporcionado no coincide con el RFC");
                var empresa = GetEmpresaByUserId(usuario.ProviderUserKey.ToString());
                
                var profile = UserProfile.GetUserProfile(email);
                profile.CambiarPassword = "1";
                profile.Save();
                Mailer m = new Mailer();
                var pass = usuario.ResetPassword("dos");
                /*
                List<string> recipients = new List<string>() { email };
                
                m.Send(recipients, new List<string>(),
                       "Estimado usuario " + empresa.RazonSocial + " su nuevo password es: <b>" + pass + "</b><br/><br/><br/>Recuerda cambiarlo al acceder al sistema con las politicas de contraseñas(una mayuscala, una minuscula, un numero y un caracter especial \"@#$%+_.-\" ). <br/><br/><br/><br/><br/><br/><br/> NT Link " + System.DateTime.Now.ToString("yyyy"),
                       "Cambio de contraseña NT Link Facturación",
                       "soporte@ntlink.com.mx",
                       "Soporte Nt Link");
                */

                var archivo = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, @"Resources", "TextoEmailCambio.html");

                var content = File.ReadAllText(archivo, Encoding.UTF8);
                content = content.Replace("[RazonSocial]", empresa.RazonSocial).Replace("[UserName]", email).Replace(
                    "[Password]", pass);
                Mailer mailer = new Mailer();
                var recipients = new List<string>();
                recipients.Add(email);
                mailer.Send(recipients, new List<string>(), content,
                            "Notificacion: Cambio de contraseña NT Link Facturación - Facturación Electrónica",
                            "facturacion@ntlink.com.mx", "Servicio de Facturación Electrónica Nt Link");

                return true;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                throw new FaultException("No se encontró el usuario");
            }


        }
        //-------------------------------------------------------------------------------
        public usuarios LoginAdmin(string usuario, string pass)
        {
            try
            {
                var passw = Utils.Sha1Hash(pass);
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var x = db.usuarios.FirstOrDefault(p => p.Nombre == usuario && p.pass == passw);
                    return x;
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return null;
            }
        }


        public usuarios AdminById(int idUsuario)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var x = db.usuarios.FirstOrDefault(p => p.idusuario == idUsuario);
                    return x;
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return null;
            }
        }

        //public SidetecUsuarios(int userId)
        //{
        //    if (userId != 0)
        //    {
        //        this.Usuario = Membership.GetUser(userId);
        //        var e = _entities.usuarios_empresas.Where(p => p.IdUsuarios_Empresas == userId).FirstOrDefault();
        //        Empresa = e == null ? new empresa() : _entities.empresa.Where(p => p.IdEmpresa == e.IdEmpresa).FirstOrDefault();
        //    }
        //    else
        //    {

        //    }

        //}



        public void Save()
        {

        }


        public static bool CreateUser(string userName, string password, string eMail, int idEmpresa, string perfil, string nombreCompleto, string iniciales)
        {
            MembershipCreateStatus status = MembershipCreateStatus.ProviderError;
            try
            {
                
                using (var db = new NtLinkLocalServiceEntities())
                {

                    Membership.CreateUser(userName, password, eMail, "uno", "dos", true, out status);
                    Logger.Debug(status.ToString());
                    if (status == MembershipCreateStatus.Success)
                    {
                        UserProfile p = UserProfile.GetUserProfile(userName);
                        p.NombreCompleto = nombreCompleto;
                        p.Iniciales = iniciales;
                        p.Save();                     

                        MembershipUser mu = Membership.GetUser(userName);
                        if (mu != null && mu.ProviderUserKey != null)
                        {
                            usuarios_empresas ue = new usuarios_empresas
                                                       {IdEmpresa = idEmpresa, UserId = mu.ProviderUserKey.ToString()};
                            db.usuarios_empresas.AddObject(ue);
                        }
                        db.SaveChanges();
                        Roles.AddUserToRole(userName, perfil);
                        return true;
                    }
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
            }
            if (status == MembershipCreateStatus.DuplicateEmail)
            {
                throw new FaultException("Email Duplicado");
            }
            if (status == MembershipCreateStatus.DuplicateUserName)
            {
                throw new FaultException("Usuario Duplicado");
            }
            if (status == MembershipCreateStatus.InvalidPassword)
            {
                throw new FaultException("El password no cumple con las politicas de seguridad");
            }
            return false;
        }





        public static bool UpdateUser(string userId, string nombreCompleto, string iniciales, string perfil)
        {
            try
            {

                MembershipUser usuario = Membership.GetUser(new Guid(userId));
               
                if (usuario != null && usuario.ProviderUserKey != null)
                {
                    AddUserToRoles(usuario.UserName, new[] { perfil });
                    UserProfile pr = UserProfile.GetUserProfile(usuario.UserName);
                    pr.NombreCompleto = nombreCompleto;
                    pr.Iniciales = iniciales;
                    pr.Save();
                    return true;
                }
                return false;
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                return false;
            }
        }


        public static List<MembershipUser> GetUserList()
        {
            var users = Membership.GetAllUsers();
            
            return users.Cast<MembershipUser>().ToList();
        }

       


        public static List<MembershipUser> GetUserList(int idEmpresa)
        {
            
            try
            {
                var users = Membership.GetAllUsers();
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var us_emp = db.usuarios_empresas.Where(p => p.IdEmpresa == idEmpresa).ToList();
                    var res = users.Cast<MembershipUser>().ToList();
                    var listaUsuarios = from re in res
                                        join u in us_emp on re.ProviderUserKey.ToString() equals u.UserId
                                        select re;
                    return listaUsuarios.ToList();
                }
            }
            catch (Exception eee)
            {
                Logger.Error(eee);
                return null;
            }
        }





        public static bool UpdateUserPassword(MembershipUser user, string newPass)
        {
            try
            {
                var pass = user.ResetPassword("dos");
                user.ChangePassword(pass, newPass);
                var profile = UserProfile.GetUserProfile(user.UserName);
                profile.CambiarPassword = "";
                profile.Save();
                return true;
            }
            catch (Exception ee)
            {
                Logger.Error(ee);
                return false;
            }

        }


        public static void CreateRole(string roleName)
        {
            Roles.CreateRole(roleName);
        }



        public static MembershipUser GetUser(string idUser)
        {
            return Membership.GetUser(new Guid(idUser.Replace("-", "")));
        }

        public static void DeleteUser(MembershipUser user)
        {
            Membership.DeleteUser(user.UserName);
        }

        public static string[] GetRoles()
        {
            return Roles.GetAllRoles();
        }

        public static vw_aspnet_MembershipUsers GetCountFalidos(string userName)
        {
               try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var ue = db.vw_aspnet_MembershipUsers.Where(p => p.Email == userName).FirstOrDefault();
                    if (ue != null)
                    {
                        return ue;
                    }
                    return null;
                }


            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                if (eee.InnerException != null)
                    Logger.Error(eee.InnerException);
                return null;
            }
         
        }

        public static string[] GetRolesForUser(string userName)
        {
            return Roles.GetRolesForUser(userName);
        }

        public static void AddUserToRoles(string userName, string[] roles)
        {
            string[] todosRoles = Roles.GetAllRoles();
            foreach (var rol in todosRoles)
            {
                if (Roles.IsUserInRole(userName, rol))
                    Roles.RemoveUserFromRole(userName, rol);
            }

            foreach (var s in roles)
            {
                if (!Roles.IsUserInRole(userName, s))
                {
                    Roles.AddUserToRole(userName, s);
                }
            }
        }

        public static empresa GetEmpresaByUserId(string userId = null)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    usuarios_empresas ue = db.usuarios_empresas.Where(p => p.UserId == userId).FirstOrDefault();
                    if (ue != null)
                    {
                        empresa emp = db.empresa.Where(p => p.IdEmpresa == ue.IdEmpresa).FirstOrDefault();
                        return emp;
                    }
                    return null;
                }


            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                if (eee.InnerException != null)
                    Logger.Error(eee.InnerException);
                return null;
            }
        }
        public static aspnet_Membership GetUserIdByEmpresa(int idempresa)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    usuarios_empresas ue = db.usuarios_empresas.Where(p => p.IdEmpresa == idempresa).FirstOrDefault();
                    if (ue != null)
                    {
                        var usu = Guid.Parse(ue.UserId);
                        var emp = db.aspnet_Membership.Where(p => p.UserId == usu).FirstOrDefault();
                        return emp;
                    }
                    return null;
                }


            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                if (eee.InnerException != null)
                    Logger.Error(eee.InnerException);
                return null;
            }
        }

        public static void DesbloquearUsuario(string userName)
        {
            try
            {
                var usuario = Membership.GetUser(userName);
                if (usuario != null) usuario.UnlockUser();
            }
            catch(Exception ex)
            {
                Logger.Error(ex.ToString());
            }
        }

        public static Distribuidores GetDisByUserId(string userId = null)
        {
            try
            {
                using (var db = new NtLinkLocalServiceEntities())
                {
                    usuarios_distribuidor ue = db.usuarios_distribuidor.Where(p => p.UserId == userId).FirstOrDefault();
                    if (ue != null)
                    {
                        Distribuidores dis = db.Distribuidores.Where(p => p.IdDistribuidor == ue.IdDistribuidor).FirstOrDefault();
                        return dis;
                    }
                    return null;
                }


            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                if (eee.InnerException != null)
                    Logger.Error(eee.InnerException);
                return null;
            }
        }


        public List<UsuarioLocal> ListaUsuarios(string patron)
        {
            try
            { 
                
                using (var db = new NtLinkLocalServiceEntities())
                {
                    var users = db.vUsuariosSistema.AsQueryable();
                    if (!string.IsNullOrEmpty(patron))
                        users = db.vUsuariosSistema.Where(p => p.LoweredEmail.Contains(patron));
                    var res = users.Select(p => new UsuarioLocal()
                    {
                        Bloqueado = p.IsLockedOut,
                        CambiarPassword = "Cambiar Password",
                        Email = p.Email,
                        RazonSocial = p.RazonSocial,
                        UserId = p.UserId, UserName = p.LoweredEmail

                    }).Take(20).ToList();
                    Logger.Info(res.Count);
                    return res;  
                }
            }
            catch (Exception eee)
            {
                Logger.Error(eee.Message);
                if (eee.InnerException != null)
                    Logger.Error(eee.InnerException);
                return null;
            }
        }

        public static bool CreateUserDis(string userName, string password, string eMail, int idDistribuidor, string perfil, string nombreCompleto, string iniciales)
        {
            MembershipCreateStatus status = MembershipCreateStatus.ProviderError;
            try
            {

                using (var db = new NtLinkLocalServiceEntities())
                {

                    Membership.CreateUser(userName, password, eMail, "uno", "dos", true, out status);
                    Logger.Debug(status.ToString());
                    if (status == MembershipCreateStatus.Success)
                    {
                        UserProfile p = UserProfile.GetUserProfile(userName);
                        p.NombreCompleto = nombreCompleto;
                        p.Iniciales = iniciales;
                        p.Save();

                        MembershipUser mu = Membership.GetUser(userName);
                        if (mu != null && mu.ProviderUserKey != null)
                        {
                            usuarios_distribuidor ue = new usuarios_distribuidor { IdDistribuidor = idDistribuidor, UserId = mu.ProviderUserKey.ToString() };
                            db.usuarios_distribuidor.AddObject(ue);
                        }
                        db.SaveChanges();
                        Roles.AddUserToRole(userName, perfil);
                        return true;
                    }
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
            }
            if (status == MembershipCreateStatus.DuplicateEmail)
            {
                throw new FaultException("Email Duplicado");
            }
            if (status == MembershipCreateStatus.DuplicateUserName)
            {
                throw new FaultException("Usuario Duplicado");
            }
            if (status == MembershipCreateStatus.InvalidPassword)
            {
                throw new FaultException("El password no cumple con las politicas de seguridad");
            }
            return false;
        }
    }
}
