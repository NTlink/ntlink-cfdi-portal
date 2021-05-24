using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ServicioLocalContract.Entities
{
    public class DatosRetenciones   //principal
    {
        public DatosIntereses intereses { get; set; }
        public DatosDividendos dividendos { get; set; }
        public DatosArrendamientoenfideicomiso arrendamientoenfideicomiso { get; set; }
        public DatosEnajenaciondeAcciones enajenaciondeAcciones { get; set; }

        public DatosFideicomisonoempresarial fideicomisonoempresarial { get; set; }
        public DatosIntereseshipotecarios intereseshipotecarios { get; set; }
        public DatosOperacionesconderivados operacionesconderivados { get; set; }
        public DatosPagosaextranjeros pagosaextranjeros { get; set; }
        public DatosPlanesderetiro planesderetiro { get; set; }
        public DatosPremios premios { get; set; }
        public DatosSectorFinanciero sectorFinanciero { get; set; }   
        
    }
    //------------------------------intereses
    public class DatosIntereses
    {
        public string activo { get; set; }
        public string versionField { get; set; }
        public string sistFinancieroField { get; set; }
        public string retiroAORESRetIntField { get; set; }
        public string operFinancDerivadField { get; set; }
        public string montIntNominalField { get; set; }
        public string montIntRealField { get; set; }
        public string perdidaField { get; set; }
    }
    //--------------------------dividendos
    public class DatosDividendos
    {
        public string activo { get; set; }
        public DatosDividendosDividOUtil dividendosDividOUtil { get; set; }
        public DatosDividendosRemanente remanenteField;
        public string versionField;
    }

    public class DatosDividendosDividOUtil
    {
        public string cveTipDivOUtilField;
        public string montISRAcredRetMexicoField;
        public string montISRAcredRetExtranjeroField;
        public string montRetExtDivExtField;
        public string tipoSocDistrDivField;
        public string montISRAcredNalField;
        public string montDivAcumNalField;
        public string montDivAcumExtField;
     }

    public class DatosDividendosRemanente
    {
        public string proporcionRemField;
        
    }
    //-----------------------------Arrendamientoenfideicomiso
    public class DatosArrendamientoenfideicomiso
    {
        public string activo { get; set; }
        public string versionField;
        public string pagProvEfecPorFiducField;
        public string rendimFideicomField;
        public string deduccCorrespField;
        public string montTotRetField;
        public string montResFiscDistFibrasField;
        public string montOtrosConceptDistrField;
       public string descrMontOtrosConceptDistrField;
    
    }
    //-------------------------------EnajenaciondeAcciones
    public class DatosEnajenaciondeAcciones
    {
        public string contratoIntermediacionField;
        public string gananciaField;
        public string perdidaField;
        public string activo { get; set; }
    }
    //------------------------------------------------Fideicomisonoempresarial
    public class DatosFideicomisonoempresarial
    {
        public string IntegracIngresosConcepto;
        public string MontTotEntradasPeriodo;
        public string PartPropAcumDelFideicom;
        public string IntegracIngresosPropDelMontTot;
        public string IntegracEgresosConceptoS;
        public string MontTotEgresPeriodo;
        public string PartPropDelFideicom;
        public string IntegracEgresosPropDelMontTot;
        public string DescRetRelPagFideic;
        public string MontRetRelPagFideic;
        public string Version;
        public string activo { get; set; }
    }
    //-------------------------------------------------
    public class DatosIntereseshipotecarios
      {
        public string CreditoDeInstFinanc;
        public string SaldoInsoluto;
        public string PropDeducDelCredit;
        public string MontTotIntNominalesDev;
        public string MontTotIntNominalesDevYPag;
        public string MontTotIntRealPagDeduc;
        public string NumContrato;
        public string Version;
        public string activo { get; set; }
      }
    //-------------------------------------------------
    public class DatosOperacionesconderivados
    {
        public string MontGanAcum;
        public string MontPerdDed;
        public string Version;
        public string activo { get; set; }
    }
    //-------------------------------------------------
    public class DatosPagosaextranjeros
    {
        public string EsBenefEfectDelCobro;
        public string PaisDeResidParaEfecFisc;
        public string Version;
        public string ConceptoPago;
        public string DescripcionConcepto;
        public string RFC;
        public string CURP;
        public string NomDenRazSocB;
        public string BeneficiarioConceptoPago;
        public string BeneficiarioDescripcionConcepto;
        public string activo { get; set; }
    }
    //-------------------------------------------------
    public class DatosPlanesderetiro
    {
        public string SistemaFinanc;
        public string MontTotAportAnioInmAnterior;
        public string MontIntRealesDevengAniooInmAnt;
        public string HuboRetirosAnioInmAntPer;
        public string MontTotRetiradoAnioInmAntPer;
        public string MontTotExentRetiradoAnioInmAnt;
        public string MontTotExedenteAnioInmAnt;
        public string HuboRetirosAnioInmAnt;
        public string MontTotRetiradoAnioInmAnt;
        public string Version;
        public string activo { get; set; }
        public string NumReferencia;
        public List<DatosAportacionesODepositos> AportacionesODepositos { get; set; }
         public DatosPlanesderetiro()
        {
            AportacionesODepositos = new List<DatosAportacionesODepositos>();
        }
       
    }
    //-------------------------------------------------

    public class DatosPremios
    {
        public string EntidadFederativa;
        public string MontTotPago;
        public string MontTotPagoGrav;
        public string MontTotPagoExent;
           public string Version;
           public string activo { get; set; }
    }
    //-------------------------------------------------

    public class DatosSectorFinanciero
    {
        public string IdFideicom;
        public string NomFideicom;
        public string DescripFideicom;
        public string Version;
        public string activo { get; set; }
    }
    //-------------------------------------------------


    public class DatosAportacionesODepositos
    {
        public string TipoAportacionODeposito;
        public string MontAportODep;
        public string RFCFiduciaria;
        public string activo { get; set; }
    }
    //-------------------------------------------------
}
