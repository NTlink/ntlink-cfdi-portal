<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NoBeneficiario.ascx.cs" Inherits="GafLookPaid.controles.NoBeneficiario" %>


<style type="text/css">
    .style1
    {
        text-align: right;
    }
</style>


<table width="100%">
<tr>
<td colspan="3"  style="text-align: left; font-weight: 700;" >

<asp:Label ID="Label1" runat="server" Text="No Beneficiarios" Font-Bold="True"  
        style="font-size: small"></asp:Label>
   </td>
</tr>
<tr>
<td class="style1"> 
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*"></asp:Label>
    PaisDeResidParaEfecFisc:</td><td style="text-align:left">
        <asp:DropDownList ID="ddlPaisDeResidParaEfecFisc" runat="server" CssClass="form-control2"
         ToolTip="Atributo requerido para expresar la clave del país de residencia del extranjero, conforme al catálogo de países publicado en el Anexo 10 de la RMF" >
          <asp:ListItem Value="AF">AF (AFGANISTAN (EMIRATO ISLAMICO DE))</asp:ListItem>
<asp:ListItem Value="AL">AL (ALBANIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="DE">DE (ALEMANIA (REPUBLICA FEDERAL DE))</asp:ListItem>
<asp:ListItem Value="AD">AD (ANDORRA (PRINCIPADO DE))</asp:ListItem>
<asp:ListItem Value="AO">AO (ANGOLA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="AI">AI (ANGUILA)</asp:ListItem>
<asp:ListItem Value="AQ">AQ (ANTARTIDA)</asp:ListItem>
<asp:ListItem Value="AG">AG (ANTIGUA Y BARBUDA (COMUNIDAD BRITANICA DE NACIONES))</asp:ListItem>
<asp:ListItem Value="AN">AN (ANTILLAS NEERLANDESAS (TERRITORIO HOLANDES DE ULTRAMAR))</asp:ListItem>
<asp:ListItem Value="SA">SA (ARABIA SAUDITA (REINO DE))</asp:ListItem>
<asp:ListItem Value="DZ">DZ (ARGELIA (REPUBLICA DEMOCRATICA Y POPULAR DE))</asp:ListItem>
<asp:ListItem Value="AR">AR (ARGENTINA (REPUBLICA))</asp:ListItem>
<asp:ListItem Value="AM">AM (ARMENIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="AW">AW (ARUBA (TERRITORIO HOLANDES DE ULTRAMAR))</asp:ListItem>
<asp:ListItem Value="AU">AU (AUSTRALIA (COMUNIDAD DE))</asp:ListItem>
<asp:ListItem Value="AT">AT (AUSTRIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="AZ">AZ (AZERBAIJAN (REPUBLICA AZERBAIJANI))</asp:ListItem>
<asp:ListItem Value="BS">BS (BAHAMAS (COMUNIDAD DE LAS))</asp:ListItem>
<asp:ListItem Value="BH">BH (BAHREIN (ESTADO DE))</asp:ListItem>
<asp:ListItem Value="BD">BD (BANGLADESH (REPUBLICA POPULAR DE))</asp:ListItem>
<asp:ListItem Value="BB">BB (BARBADOS (COMUNIDAD BRITANICA DE NACIONES))</asp:ListItem>
<asp:ListItem Value="BE">BE (BELGICA (REINO DE))</asp:ListItem>
<asp:ListItem Value="BZ">BZ (BELICE)</asp:ListItem>
<asp:ListItem Value="BJ">BJ (BENIN (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="BM">BM (BERMUDAS)</asp:ListItem>
<asp:ListItem Value="BY">BY (BIELORRUSIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="BO">BO (BOLIVIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="BA">BA (BOSNIA Y HERZEGOVINA)</asp:ListItem>
<asp:ListItem Value="BW">BW (BOTSWANA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="BR">BR (BRASIL (REPUBLICA FEDERATIVA DE))</asp:ListItem>
<asp:ListItem Value="BN">BN (BRUNEI (ESTADO DE) (RESIDENCIA DE PAZ))</asp:ListItem>
<asp:ListItem Value="BG">BG (BULGARIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="BF">BF (BURKINA FASO)</asp:ListItem>
<asp:ListItem Value="BI">BI (BURUNDI (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="BT">BT (BUTAN (REINO DE))</asp:ListItem>
<asp:ListItem Value="CV">CV (CABO VERDE (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="TD">TD (CHAD (REPUBLICA DEL))</asp:ListItem>
<asp:ListItem Value="KY">KY (CAIMAN (ISLAS))</asp:ListItem>
<asp:ListItem Value="KH">KH (CAMBOYA (REINO DE))</asp:ListItem>
<asp:ListItem Value="CM">CM (CAMERUN (REPUBLICA DEL))</asp:ListItem>
<asp:ListItem Value="CA">CA (CANADA)</asp:ListItem>
<asp:ListItem Value="CL">CL (CHILE (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="CN">CN (CHINA (REPUBLICA POPULAR))</asp:ListItem>
<asp:ListItem Value="CY">CY (CHIPRE (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="VA">VA (CIUDAD DEL VATICANO (ESTADO DE LA))</asp:ListItem>
<asp:ListItem Value="CC">CC (COCOS (KEELING, ISLAS AUSTRALIANAS))</asp:ListItem>
<asp:ListItem Value="CO">CO (COLOMBIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="KM">KM (COMORAS (ISLAS))</asp:ListItem>
<asp:ListItem Value="CG">CG (CONGO (REPUBLICA DEL))</asp:ListItem>
<asp:ListItem Value="CK">CK (COOK (ISLAS))</asp:ListItem>
<asp:ListItem Value="KP">KP (COREA (REPUBLICA POPULAR DEMOCRATICA DE) (COREA DEL NORTE))</asp:ListItem>
<asp:ListItem Value="KR">KR (COREA (REPUBLICA DE) (COREA DEL SUR))</asp:ListItem>
<asp:ListItem Value="CI">CI (COSTA DE MARFIL (REPUBLICA DE LA))</asp:ListItem>
<asp:ListItem Value="CR">CR (COSTA RICA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="HR">HR (CROACIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="CU">CU (CUBA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="DK">DK (DINAMARCA (REINO DE))</asp:ListItem>
<asp:ListItem Value="DJ">DJ (DJIBOUTI (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="DM">DM (DOMINICA (COMUNIDAD DE))</asp:ListItem>
<asp:ListItem Value="EC">EC (ECUADOR (REPUBLICA DEL))</asp:ListItem>
<asp:ListItem Value="EG">EG (EGIPTO (REPUBLICA ARABE DE))</asp:ListItem>
<asp:ListItem Value="SV">SV (EL SALVADOR (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="AE">AE (EMIRATOS ARABES UNIDOS)</asp:ListItem>
<asp:ListItem Value="ER">ER (ERITREA (ESTADO DE))</asp:ListItem>
<asp:ListItem Value="SI">SI (ESLOVENIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="ES">ES (ESPAÑA (REINO DE))</asp:ListItem>
<asp:ListItem Value="FM">FM (ESTADO FEDERADO DE MICRONESIA)</asp:ListItem>
<asp:ListItem Value="US">US (ESTADOS UNIDOS DE AMERICA)</asp:ListItem>
<asp:ListItem Value="EE">EE (ESTONIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="ET">ET (ETIOPIA (REPUBLICA DEMOCRATICA FEDERAL))</asp:ListItem>
<asp:ListItem Value="FJ">FJ (FIDJI (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="PH">PH (FILIPINAS (REPUBLICA DE LAS))</asp:ListItem>
<asp:ListItem Value="FI">FI (FINLANDIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="FR">FR (FRANCIA (REPUBLICA FRANCESA))</asp:ListItem>
<asp:ListItem Value="GA">GA (GABONESA (REPUBLICA))</asp:ListItem>
<asp:ListItem Value="GM">GM (GAMBIA (REPUBLICA DE LA))</asp:ListItem>
<asp:ListItem Value="GE">GE (GEORGIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="GH">GH (GHANA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="GI">GI (GIBRALTAR (R.U.))</asp:ListItem>
<asp:ListItem Value="GD">GD (GRANADA)</asp:ListItem>
<asp:ListItem Value="GR">GR (GRECIA (REPUBLICA HELENICA))</asp:ListItem>
<asp:ListItem Value="GL">GL (GROENLANDIA (DINAMARCA))</asp:ListItem>
<asp:ListItem Value="GP">GP (GUADALUPE (DEPARTAMENTO DE))</asp:ListItem>
<asp:ListItem Value="GU">GU (GUAM (E.U.A.))</asp:ListItem>
<asp:ListItem Value="GT">GT (GUATEMALA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="GG">GG (GUERNSEY)</asp:ListItem>
<asp:ListItem Value="GW">GW (GUINEA-BISSAU (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="GQ">GQ (GUINEA ECUATORIAL (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="GN">GN (GUINEA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="GF">GF (GUYANA FRANCESA)</asp:ListItem>
<asp:ListItem Value="GY">GY (GUYANA (REPUBLICA COOPERATIVA DE))</asp:ListItem>
<asp:ListItem Value="HT">HT (HAITI (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="HN">HN (HONDURAS (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="HK">HK (HONG KONG (REGION ADMINISTRATIVA ESPECIAL DE LA REPUBLICA))</asp:ListItem>
<asp:ListItem Value="HU">HU (HUNGRIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="IN">IN (INDIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="ID">ID (INDONESIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="IQ">IQ (IRAK (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="IR">IR (IRAN (REPUBLICA ISLAMICA DEL))</asp:ListItem>
<asp:ListItem Value="IE">IE (IRLANDA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="IS">IS (ISLANDIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="BV">BV (ISLA BOUVET)</asp:ListItem>
<asp:ListItem Value="IM">IM (ISLA DE MAN)</asp:ListItem>
<asp:ListItem Value="AX">AX (ISLAS ALAND)</asp:ListItem>
<asp:ListItem Value="FO">FO (ISLAS FEROE)</asp:ListItem>
<asp:ListItem Value="GS">GS (ISLAS GEORGIA Y SANDWICH DEL SUR)</asp:ListItem>
<asp:ListItem Value="HM">HM (ISLAS HEARD Y MCDONALD)</asp:ListItem>
<asp:ListItem Value="FK">FK (ISLAS MALVINAS (R.U.))</asp:ListItem>
<asp:ListItem Value="MP">MP (ISLAS MARIANAS SEPTENTRIONALES)</asp:ListItem>
<asp:ListItem Value="MH">MH (ISLAS MARSHALL)</asp:ListItem>
<asp:ListItem Value="UM">UM (ISLAS MENORES DE ULTRAMAR DE ESTADOS UNIDOS DE AMERICA)</asp:ListItem>
<asp:ListItem Value="SB">SB (ISLAS SALOMON (COMUNIDAD BRITANICA DE NACIONES))</asp:ListItem>
<asp:ListItem Value="SJ">SJ (ISLAS SVALBARD Y JAN MAYEN (NORUEGA))</asp:ListItem>
<asp:ListItem Value="TK">TK (ISLAS TOKELAU)</asp:ListItem>
<asp:ListItem Value="WF">WF (ISLAS WALLIS Y FUTUNA)</asp:ListItem>
<asp:ListItem Value="IL">IL (ISRAEL (ESTADO DE))</asp:ListItem>
<asp:ListItem Value="IT">IT (ITALIA (REPUBLICA ITALIANA))</asp:ListItem>
<asp:ListItem Value="JM">JM (JAMAICA)</asp:ListItem>
<asp:ListItem Value="JP">JP (JAPON)</asp:ListItem>
<asp:ListItem Value="JE">JE (JERSEY)</asp:ListItem>
<asp:ListItem Value="JO">JO (JORDANIA (REINO HACHEMITA DE))</asp:ListItem>
<asp:ListItem Value="KZ">KZ (KAZAKHSTAN (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="KE">KE (KENYA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="KI">KI (KIRIBATI (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="KW">KW (KUWAIT (ESTADO DE))</asp:ListItem>
<asp:ListItem Value="KG">KG (KYRGYZSTAN (REPUBLICA KIRGYZIA))</asp:ListItem>
<asp:ListItem Value="LS">LS (LESOTHO (REINO DE))</asp:ListItem>
<asp:ListItem Value="LV">LV (LETONIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="LB">LB (LIBANO (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="LR">LR (LIBERIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="LY">LY (LIBIA (JAMAHIRIYA LIBIA ARABE POPULAR SOCIALISTA))</asp:ListItem>
<asp:ListItem Value="LI">LI (LIECHTENSTEIN (PRINCIPADO DE))</asp:ListItem>
<asp:ListItem Value="LT">LT (LITUANIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="LU">LU (LUXEMBURGO (GRAN DUCADO DE))</asp:ListItem>
<asp:ListItem Value="MO">MO (MACAO)</asp:ListItem>
<asp:ListItem Value="MK">MK (MACEDONIA (ANTIGUA REPUBLICA YUGOSLAVA DE))</asp:ListItem>
<asp:ListItem Value="MG">MG (MADAGASCAR (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="MY">MY (MALASIA)</asp:ListItem>
<asp:ListItem Value="MW">MW (MALAWI (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="MV">MV (MALDIVAS (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="ML">ML (MALI (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="MT">MT (MALTA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="MA">MA (MARRUECOS (REINO DE))</asp:ListItem>
<asp:ListItem Value="MQ">MQ (MARTINICA (DEPARTAMENTO DE) (FRANCIA))</asp:ListItem>
<asp:ListItem Value="MU">MU (MAURICIO (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="MR">MR (MAURITANIA (REPUBLICA ISLAMICA DE))</asp:ListItem>
<asp:ListItem Value="YT">YT (MAYOTTE)</asp:ListItem>
<asp:ListItem Value="MX">MX (MEXICO (ESTADOS UNIDOS MEXICANOS))</asp:ListItem>
<asp:ListItem Value="MD">MD (MOLDAVIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="MC">MC (MONACO (PRINCIPADO DE))</asp:ListItem>
<asp:ListItem Value="MN">MN (MONGOLIA)</asp:ListItem>
<asp:ListItem Value="MS">MS (MONSERRAT (ISLA))</asp:ListItem>
<asp:ListItem Value="ME">ME (MONTENEGRO)</asp:ListItem>
<asp:ListItem Value="MZ">MZ (MOZAMBIQUE (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="MM">MM (MYANMAR (UNION DE))</asp:ListItem>
<asp:ListItem Value="NA">NA (NAMIBIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="NR">NR (NAURU)</asp:ListItem>
<asp:ListItem Value="CX">CX (NAVIDAD (CHRISTMAS) (ISLAS))</asp:ListItem>
<asp:ListItem Value="NP">NP (NEPAL (REINO DE))</asp:ListItem>
<asp:ListItem Value="NI">NI (NICARAGUA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="NE">NE (NIGER (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="NG">NG (NIGERIA (REPUBLICA FEDERAL DE))</asp:ListItem>
<asp:ListItem Value="NU">NU (NIVE (ISLA))</asp:ListItem>
<asp:ListItem Value="NF">NF (NORFOLK (ISLA))</asp:ListItem>
<asp:ListItem Value="NO">NO (NORUEGA (REINO DE))</asp:ListItem>
<asp:ListItem Value="NC">NC (NUEVA CALEDONIA (TERRITORIO FRANCES DE ULTRAMAR))</asp:ListItem>
<asp:ListItem Value="NZ">NZ (NUEVA ZELANDIA)</asp:ListItem>
<asp:ListItem Value="OM">OM (OMAN (SULTANATO DE))</asp:ListItem>
<asp:ListItem Value="PI">PIK (PACIFICO, ISLAS DEL (ADMON. E.U.A.))</asp:ListItem>
<asp:ListItem Value="NL">NL (PAISES BAJOS (REINO DE LOS) (HOLANDA))</asp:ListItem>
<asp:ListItem Value="PK">PK (PAKISTAN (REPUBLICA ISLAMICA DE))</asp:ListItem>
<asp:ListItem Value="PW">PW (PALAU (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="PS">PS (PALESTINA)</asp:ListItem>
<asp:ListItem Value="PA">PA (PANAMA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="PG">PG (PAPUA NUEVA GUINEA (ESTADO INDEPENDIENTE DE))</asp:ListItem>
<asp:ListItem Value="PY">PY (PARAGUAY (REPUBLICA DEL))</asp:ListItem>
<asp:ListItem Value="PE">PE (PERU (REPUBLICA DEL))</asp:ListItem>
<asp:ListItem Value="PN">PN (PITCAIRNS (ISLAS DEPENDENCIA BRITANICA))</asp:ListItem>
<asp:ListItem Value="PF">PF (POLINESIA FRANCESA)</asp:ListItem>
<asp:ListItem Value="PL">PL (POLONIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="PT">PT (PORTUGAL (REPUBLICA PORTUGUESA))</asp:ListItem>
<asp:ListItem Value="PR">PR (PUERTO RICO (ESTADO LIBRE ASOCIADO DE LA COMUNIDAD DE))</asp:ListItem>
<asp:ListItem Value="QA">QA (QATAR (ESTADO DE))</asp:ListItem>
<asp:ListItem Value="GB">GB (REINO UNIDO DE LA GRAN BRETAÑA E IRLANDA DEL NORTE)</asp:ListItem>
<asp:ListItem Value="CZ">CZ (REPUBLICA CHECA)</asp:ListItem>
<asp:ListItem Value="CF">CF (REPUBLICA CENTROAFRICANA)</asp:ListItem>
<asp:ListItem Value="LA">LA (REPUBLICA DEMOCRATICA POPULAR LAOS)</asp:ListItem>
<asp:ListItem Value="RS">RS (REPUBLICA DE SERBIA)</asp:ListItem>
<asp:ListItem Value="DO">DO (REPUBLICA DOMINICANA)</asp:ListItem>
<asp:ListItem Value="SK">SK (REPUBLICA ESLOVACA)</asp:ListItem>
<asp:ListItem Value="CD">CD (REPUBLICA POPULAR DEL CONGO)</asp:ListItem>
<asp:ListItem Value="RW">RW (REPUBLICA RUANDESA)</asp:ListItem>
<asp:ListItem Value="RE">RE (REUNION (DEPARTAMENTO DE LA) (FRANCIA))</asp:ListItem>
<asp:ListItem Value="RO">RO (RUMANIA)</asp:ListItem>
<asp:ListItem Value="RU">RU (RUSIA (FEDERACION RUSA))</asp:ListItem>
<asp:ListItem Value="EH">EH (SAHARA OCCIDENTAL (REPUBLICA ARABE SAHARAVI DEMOCRATICA))</asp:ListItem>
<asp:ListItem Value="WS">WS (SAMOA (ESTADO INDEPENDIENTE DE))</asp:ListItem>
<asp:ListItem Value="AS">AS (SAMOA AMERICANA)</asp:ListItem>
<asp:ListItem Value="BL">BL (SAN BARTOLOME)</asp:ListItem>
<asp:ListItem Value="KN">KN (SAN CRISTOBAL Y NIEVES (FEDERACION DE) (SAN KITTS-NEVIS))</asp:ListItem>
<asp:ListItem Value="SM">SM (SAN MARINO (SERENISIMA REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="MF">MF (SAN MARTIN)</asp:ListItem>
<asp:ListItem Value="PM">PM (SAN PEDRO Y MIQUELON)</asp:ListItem>
<asp:ListItem Value="VC">VC (SAN VICENTE Y LAS GRANADINAS)</asp:ListItem>
<asp:ListItem Value="SH">SH (SANTA ELENA)</asp:ListItem>
<asp:ListItem Value="LC">LC (SANTA LUCIA)</asp:ListItem>
<asp:ListItem Value="ST">ST (SANTO TOME Y PRINCIPE (REPUBLICA DEMOCRATICA DE))</asp:ListItem>
<asp:ListItem Value="SN">SN (SENEGAL (REPUBLICA DEL))</asp:ListItem>
<asp:ListItem Value="SC">SC (SEYCHELLES (REPUBLICA DE LAS))</asp:ListItem>
<asp:ListItem Value="SL">SL (SIERRA LEONA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="SG">SG (SINGAPUR (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="SY">SY (SIRIA (REPUBLICA ARABE))</asp:ListItem>
<asp:ListItem Value="SO">SO (SOMALIA)</asp:ListItem>
<asp:ListItem Value="LK">LK (SRI LANKA (REPUBLICA DEMOCRATICA SOCIALISTA DE))</asp:ListItem>
<asp:ListItem Value="ZA">ZA (SUDAFRICA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="SD">SD (SUDAN (REPUBLICA DEL))</asp:ListItem>
<asp:ListItem Value="SE">SE (SUECIA (REINO DE))</asp:ListItem>
<asp:ListItem Value="CH">CH (SUIZA (CONFEDERACION))</asp:ListItem>
<asp:ListItem Value="SR">SR (SURINAME (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="SZ">SZ (SWAZILANDIA (REINO DE))</asp:ListItem>
<asp:ListItem Value="TJ">TJ (TADJIKISTAN (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="TH">TH (TAILANDIA (REINO DE))</asp:ListItem>
<asp:ListItem Value="TW">TW (TAIWAN (REPUBLICA DE CHINA))</asp:ListItem>
<asp:ListItem Value="TZ">TZ (TANZANIA (REPUBLICA UNIDA DE))</asp:ListItem>
<asp:ListItem Value="IO">IO (TERRITORIOS BRITANICOS DEL OCEANO INDICO)</asp:ListItem>
<asp:ListItem Value="TF">TF (TERRITORIOS FRANCESES, AUSTRALES Y ANTARTICOS)</asp:ListItem>
<asp:ListItem Value="TL">TL (TIMOR ORIENTAL)</asp:ListItem>
<asp:ListItem Value="TG">TG (TOGO (REPUBLICA TOGOLESA))</asp:ListItem>
<asp:ListItem Value="TO">TO (TONGA (REINO DE))</asp:ListItem>
<asp:ListItem Value="TT">TT (TRINIDAD Y TOBAGO (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="TN">TN (TUNEZ (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="TC">TC (TURCAS Y CAICOS (ISLAS))</asp:ListItem>
<asp:ListItem Value="TM">TM (TURKMENISTAN (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="TR">TR (TURQUIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="TV">TV (TUVALU (COMUNIDAD BRITANICA DE NACIONES))</asp:ListItem>
<asp:ListItem Value="UA">UA (UCRANIA)</asp:ListItem>
<asp:ListItem Value="UG">UG (UGANDA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="UY">UY (URUGUAY (REPUBLICA ORIENTAL DEL))</asp:ListItem>
<asp:ListItem Value="UZ">UZ (UZBEJISTAN (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="VU">VU (VANUATU)</asp:ListItem>
<asp:ListItem Value="VE">VE (VENEZUELA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="VN">VN (VIETNAM (REPUBLICA SOCIALISTA DE))</asp:ListItem>
<asp:ListItem Value="VG">VG (VIRGENES. ISLAS (BRITANICAS))</asp:ListItem>
<asp:ListItem Value="VI">VI (VIRGENES. ISLAS (NORTEAMERICANAS))</asp:ListItem>
<asp:ListItem Value="YE">YE (YEMEN (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="ZM">ZM (ZAMBIA (REPUBLICA DE))</asp:ListItem>
<asp:ListItem Value="ZW">ZW (ZIMBABWE (REPUBLICA DE))</asp:ListItem>

        </asp:DropDownList>
        <br />
         </td>
    


</tr>
<tr>
<td class="style1"> 
    
    <asp:Label ID="Label9" runat="server" ForeColor="Red" Text="*"></asp:Label>
    ConceptoPago:<br /></td>
<td style="text-align: left" >
    <asp:DropDownList ID="ddlConceptoPago" runat="server" CssClass="form-control2"
      ToolTip="Atributo requerido para expresar  el tipo contribuyente sujeto a la retención, conforme al catálogo" >

    <asp:ListItem Value="1"> 1 (Artistas, deportistas y espectáculos públicos)</asp:ListItem>
    <asp:ListItem Value="2"> 2 (Otras personas físicas)</asp:ListItem>
    <asp:ListItem Value="3"> 3 (Persona moral)</asp:ListItem>
    <asp:ListItem Value="4"> 4 (Fideicomiso)</asp:ListItem>
    <asp:ListItem Value="5"> 5 (Asociación en participación)</asp:ListItem>
    <asp:ListItem Value="6"> 6 (Organizaciones Internacionales o de gobierno)</asp:ListItem>
    <asp:ListItem Value="7"> 7 (Organizaciones exentas)</asp:ListItem>
    <asp:ListItem Value="8"> 8 (Agentes pagadores)</asp:ListItem>
    <asp:ListItem Value="9"> 9 (Otros)</asp:ListItem>

    </asp:DropDownList>
    <br />

    </td>

</tr>
<tr>
<td class="style1">
    
    <asp:Label ID="Label10" runat="server" ForeColor="Red" Text="*"></asp:Label>
    DescripcionConcepto:</td>
<td style="text-align: left">
    <asp:TextBox ID="txtDescripcionConcepto" runat="server" Width="442px" CssClass="form-control2"
    ToolTip="Atributo requerido para expresar la descripción de la definición del pago del residente en el extranjero"
    ></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ErrorMessage="*Requerido" Display="Dynamic"
              ControlToValidate="txtDescripcionConcepto" ValidationGroup="GeneraRetencion" style="color: #F72020"></asp:RequiredFieldValidator>
             
     </td>

</tr>
</table>