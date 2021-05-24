using System;
using System.Collections.Generic;
using System.Linq;
using ServicioLocalContract;
using ServicioLocalContract.entities;

namespace ServicioLocal.Business
{
    public class NtLinkUsuariosAdmin : NtLinkBusiness
    {
        public List<usuarios> GetUserAdminList()
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {
                    return context.usuarios.ToList();
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return null;
            }
        }
        public List<UsuarioSistem> GetUserList(string email)
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {

                    List<UsuarioSistem> L = new List<UsuarioSistem>();
                    if (string.IsNullOrEmpty(email))
                    {
                        var user = context.aspnet_Membership.ToList().OrderBy(p => p.LastLoginDate).ToList();
                        if (user != null)
                        {
                            foreach (var u in user)
                            {
                                UsuarioSistem l = new UsuarioSistem();
                                l.Email = u.Email;
                                l.LastLoginDate = u.LastLoginDate.ToString();
                                L.Add(l);
                            }
                            return L;

                        }
                        else
                            return null;
                    }
                    else
                    {

                        var user = context.aspnet_Membership.Where(p=>p.Email.Contains(email)).OrderByDescending(p => p.LastLoginDate).ToList();
                        if (user != null)
                        {
                            foreach (var u in user)
                            {
                                UsuarioSistem l = new UsuarioSistem();
                                l.Email = u.Email;
                                l.LastLoginDate = u.LastLoginDate.ToString();
                                L.Add(l);
                            }
                            return L;

                        }
                        else
                            return null;
                    }
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return null;
            }
        }


        public usuarios GetUserAdminById(int id)
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {
                    return context.usuarios.FirstOrDefault(u => u.idusuario == id);
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return null;
            }
        }

        public int SaveAdmin(string alias, string name, string aPaterno, string aMaterno, string passwd)
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {
                    usuarios newUser = new usuarios();
                    newUser.Nombre = alias;
                    newUser.NombreReal = name;
                    newUser.apaterno = aPaterno;
                    newUser.aMaterno = aMaterno;
                    newUser.pass = Utils.Sha1Hash(passwd);
                    context.usuarios.AddObject(newUser);
                    context.SaveChanges();
                    return newUser.idusuario;
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return 0;
            }
        }

        public void UpdateAdmin(int id, string alias, string name, string aPaterno, string aMaterno, string newPasswd)
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {
                    var userAdmin = context.usuarios.FirstOrDefault(u => u.idusuario == id);
                    if (userAdmin != null)
                    {
                        userAdmin.Nombre = alias;
                        userAdmin.NombreReal = name;
                        userAdmin.apaterno = aPaterno;
                        userAdmin.aMaterno = aMaterno;
                        if (!String.IsNullOrEmpty(newPasswd))
                        {
                            userAdmin.pass = Utils.Sha1Hash(newPasswd);
                        }
                        context.SaveChanges();
                    }
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
            }
        }

        public bool CheckPasswd(int id, String passwd)
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {
                    var user = context.usuarios.FirstOrDefault(u => u.idusuario == id);
                    return (user.pass == Utils.Sha1Hash(passwd)) ? true : false;
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return false;
            }
        }

        public void NewPath(int idUser, string path)
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {
                    adminPantallas newScreen = new adminPantallas();
                    newScreen.pantalla = path;
                    newScreen.admin = idUser;
                    context.adminPantallas.AddObject(newScreen);
                    context.SaveChanges();
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
            }
        }

        public void DelPath(int idUser, string path)
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {
                    var delScreen = context.adminPantallas.FirstOrDefault(s => s.pantalla == path && s.admin == idUser);
                    context.adminPantallas.DeleteObject(delScreen);
                    context.SaveChanges();
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
            }
        }

        public bool FindPath(int idUser, string path)
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {
                    return context.adminPantallas.Any(s => s.pantalla == path && s.admin == idUser);
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return false;
            }
        }

        public List<adminPantallas> GetPantallas(int idusuario)
        {
            try
            {
                using (var context = new NtLinkLocalServiceEntities())
                {
                    var res = context.adminPantallas.Where(l => l.admin == idusuario);
                    return res.ToList();
                }
            }
            catch (Exception ee)
            {
                Logger.Error(ee.Message);
                return null;
            }

        }
    }
}