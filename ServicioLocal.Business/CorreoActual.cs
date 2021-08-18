using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.IO;

/// <summary>
/// Descripción breve de CorreoActual
/// </summary>
public class CorreoActual
{
    public string correoA;////

    public CorreoActual()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }
    //-------------------------------------------------------
    public void escribirCorreoActual(string value)
    {
        string texto = actualizarCorreoActual(value);
        string ruta = ConfigurationManager.AppSettings["UserNameRuta"];
        if (!File.Exists(ruta))
        {
            System.IO.Directory.CreateDirectory(ruta);
        }

        ruta = Path.Combine(ConfigurationManager.AppSettings["UserNameRuta"], "CorreoActual.txt");
        System.IO.StreamWriter sw = new System.IO.StreamWriter(ruta);
        sw.WriteLine(texto);
        sw.Close();
    }


    //---------------------------------------------------
    public string leerCorreoActual()
    {
        try
        {
            string ruta = Path.Combine(ConfigurationManager.AppSettings["UserNameRuta"], "CorreoActual.txt");

            string texto;

            System.IO.StreamReader sr = new System.IO.StreamReader(ruta);
            texto = sr.ReadToEnd();
            sr.Close();
            texto = texto.Replace("\r\n", "");
            correoA = texto;
            return correoActual(texto);
        }
        catch (Exception)
        { return ConfigurationManager.AppSettings["UserNameGrupo1"]; }

    }
    //--------------------------------------------------------------------------
    private string correoActual(string value)
    {

        string Grupo = ConfigurationManager.AppSettings[value];
        if (string.IsNullOrEmpty(Grupo))
            Grupo = ConfigurationManager.AppSettings["UserNameGrupo1"];
        return Grupo;
    }
    //------------------------------------------------------------------
    //----------------se actualiza el correo actual --------------------------------------------
    private string actualizarCorreoActual(string value)
    {
        try
        {

            int entero = Convert.ToInt16(value.Replace("UserNameGrupo", ""));
            entero++;
            string Grupo = ConfigurationManager.AppSettings["UserNameGrupo" + entero];
            if (string.IsNullOrEmpty(Grupo))
                return "UserNameGrupo1";
            else
                return "UserNameGrupo" + entero;
        }

        catch (Exception)
        { return "UserNameGrupo1"; }
    }



}