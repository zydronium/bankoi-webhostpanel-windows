<%
	accessLevel = 10
%>
<html>
<head> <title><%=lbladmininfo%></title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/middle/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/middle/layout.css">

</head>

<body leftmargin=0 topmargin=0 onLoad='top.SetContext("admin_ed"); top.helpPerm=true; ' onUnload='top.helpPerm=false; '>
<form action='/server/admin_ed.php3' name=form1 method='post'>
  <table border="0" cellpadding=0 cellspacing=0 width="564" align="center">
<tr>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="558" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
</tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="6" border="0"></td></tr>
<tr><td></td>
<td><table border="0" cellpadding=0 cellspacing=0 width="558" align="left">
<tr>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="436" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="115" height="1" border="0"></td>
</tr>
<tr>
<td>Edit administrator information.</td>
<td></td>
<td><input type="button" class="commonButton" id="bid-up-level" value="<%=lbluplevel%>" title="<%=lbluplevel%>"   onMouseOver="top.mouse_move('b_to_server');"  onMouseOut="top.mouse_move();"  onClick="top.mainFrame.workFrame.location='/server/server.php3';;"  ></td>
</tr>
</table>
</td>
</tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="7" border="0"></td></tr>
<tr>
<td></td>
<td><table border="0" cellpadding=0 cellspacing=0 width="558" align="left">
<tr>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="140" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="17" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="401" height="1" border="0"></td>
</tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td align='right'>Company name:</td>
<td align='center'><span class="requiredfield">*</span></td>
<td><input type='text' name='cname' size=25 maxlength=100 value="BNOPL"></td></tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td align='right'>Contact name:</td>
<td align='center'><span class="requiredfield">*</span></td>
<td><input type='text' name='pname' size=25 maxlength=60 value="Kumarpal Jain"></td></tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td align='right'>Phone:</td>
<td align='center'><span class="requiredfield">*</span></td>
<td><input type='text' name='phone' size=25 maxlength=30 value="919829160327"></td></tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td align='right'>Fax:</td>
<td align='center'></td>
<td><input type='text' name='fax' size=25 maxlength=30 value=""></td></tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td align='right'>E-mail:</td>
<td align='center'><span class="requiredfield">*</span></td>
<td><input type='text' name='email' size=25 maxlength=255 value="kumarpal@kumarpal.com"></td></tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td align='right'>Address:</td>
<td align='center'><span class="requiredfield">*</span></td>
<td><input type='text' name='address' size=25 maxlength=255 value="Minerva"></td></tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td align='right'>City:</td>
<td align='center'><span class="requiredfield">*</span></td>
<td><input type='text' name='city' size=25 maxlength=50 value="Delhi"></td></tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td align='right'>State/Province:</td>
<td align='center'><span class="requiredfield">*</span></td>
<td><input type='text' name='state' size=25 maxlength=255 value="Delhi"></td></tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td align='right'>Postal/ZIP code:</td>
<td align='center'><span class="requiredfield">*</span></td>
<td><input type='text' name='pcode' size=25 maxlength=10 value="301010"></td></tr>
</table>
</td>
</tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="7" border="0"></td></tr>
<tr>
<td></td>
<td><table border="0" cellpadding=0 cellspacing=0 width="558" align="left">
<tr>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="140" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="17" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="279" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="115" height="1" border="0"></td>
</tr>
<tr>
<td align='right'>Country:</td>
<td></td>
<td colspan=3><select name="country" >
<option value="AF">Afghanistan
<option value="AL">Albania
<option value="DZ">Algeria
<option value="AS">American Samoa
<option value="AD">Andorra
<option value="AO">Angola
<option value="AI">Anguilla
<option value="AQ">Antarctica
<option value="AG">Antigua and Barbuda
<option value="AR">Argentina
<option value="AM">Armenia
<option value="AW">Aruba
<option value="AU">Australia
<option value="AT">Austria
<option value="AZ">Azerbaidjan
<option value="BS">Bahamas
<option value="BH">Bahrain
<option value="BD">Banglades
<option value="BB">Barbados
<option value="BY">Belarus
<option value="BE">Belgium
<option value="BZ">Belize
<option value="BJ">Benin
<option value="BM">Bermuda
<option value="BO">Bolivia
<option value="BA">Bosnia-Herzegovina
<option value="BW">Botswana
<option value="BV">Bouvet Island
<option value="BR">Brazil
<option value="IO">British Indian O. Terr.
<option value="BN">Brunei Darussalam
<option value="BG">Bulgaria
<option value="BF">Burkina Faso
<option value="BI">Burundi
<option value="BT">Buthan
<option value="KH">Cambodia
<option value="CM">Cameroon
<option value="CA">Canada
<option value="CV">Cape Verde
<option value="KY">Cayman Islands
<option value="CF">Central African Rep.
<option value="TD">Chad
<option value="CL">Chile
<option value="CN">China
<option value="CX">Christmas Island
<option value="CC">Cocos (Keeling) Isl.
<option value="CO">Colombia
<option value="KM">Comoros
<option value="CG">Congo
<option value="CK">Cook Islands
<option value="CR">Costa Rica
<option value="HR">Croatia
<option value="CU">Cuba
<option value="CY">Cyprus
<option value="CZ">Czech Republic
<option value="CS">Czechoslovakia
<option value="DK">Denmark
<option value="DJ">Djibouti
<option value="DM">Dominica
<option value="DO">Dominican Republic
<option value="TP">East Timor
<option value="EC">Ecuador
<option value="EG">Egypt
<option value="SV">El Salvador
<option value="GQ">Equatorial Guinea
<option value="EE">Estonia
<option value="ET">Ethiopia
<option value="FK">Falkland Isl.(Malvinas)
<option value="FO">Faroe Islands
<option value="FJ">Fiji
<option value="FI">Finland
<option value="FR">France
<option value="FX">France (European Ter.)
<option value="TF">French Southern Terr.
<option value="GA">Gabon
<option value="GM">Gambia
<option value="GE">Georgia
<option value="DE">Germany
<option value="GH">Ghana
<option value="GI">Gibraltar
<option value="GR">Greece
<option value="GL">Greenland
<option value="GD">Grenada
<option value="GP">Guadeloupe (Fr.)
<option value="GU">Guam (US)
<option value="GT">Guatemala
<option value="GN">Guinea
<option value="GW">Guinea Bissau
<option value="GY">Guyana
<option value="GF">Guyana (Fr.)
<option value="HT">Haiti
<option value="HM">Heard & McDonald Isl.
<option value="HN">Honduras
<option value="HK">Hong Kong
<option value="HU">Hungary
<option value="IS">Iceland
<option value="IN" SELECTED>India
<option value="ID">Indonesia
<option value="IR">Iran
<option value="IQ">Iraq
<option value="IE">Ireland
<option value="IL">Israel
<option value="IT">Italy
<option value="CI">Ivory Coast
<option value="JM">Jamaica
<option value="JP">Japan
<option value="JO">Jordan
<option value="KZ">Kazakhstan
<option value="KE">Kenya
<option value="KG">Kyrgyzstan
<option value="KI">Kiribati
<option value="KP">Korea (North)
<option value="KR">Korea (South)
<option value="KW">Kuwait
<option value="LA">Laos
<option value="LV">Latvia
<option value="LB">Lebanon
<option value="LS">Lesotho
<option value="LR">Liberia
<option value="LY">Libya
<option value="LI">Liechtenstein
<option value="LT">Lithuania
<option value="LU">Luxembourg
<option value="MO">Macau
<option value="MG">Madagascar
<option value="MW">Malawi
<option value="MY">Malaysia
<option value="MV">Maldives
<option value="ML">Mali
<option value="MT">Malta
<option value="MH">Marshall Islands
<option value="MQ">Martinique (Fr.)
<option value="MR">Mauritania
<option value="MU">Mauritius
<option value="MX">Mexico
<option value="FM">Micronesia
<option value="MD">Moldavia
<option value="MC">Monaco
<option value="MN">Mongolia
<option value="MS">Montserrat
<option value="MA">Morocco
<option value="MZ">Mozambique
<option value="MM">Myanmar
<option value="NA">Namibia
<option value="NR">Nauru
<option value="NP">Nepal
<option value="AN">Netherland Antilles
<option value="NL">Netherlands
<option value="NT">Neutral Zone
<option value="NC">New Caledonia (Fr.)
<option value="NZ">New Zealand
<option value="NI">Nicaragua
<option value="NE">Niger
<option value="NG">Nigeria
<option value="NU">Niue
<option value="NF">Norfolk Island
<option value="MP">Northern Mariana Isl.
<option value="NO">Norway
<option value="OM">Oman
<option value="PK">Pakistan
<option value="PW">Palau
<option value="PA">Panama
<option value="PG">Papua New
<option value="PY">Paraguay
<option value="PE">Peru
<option value="PH">Philippines
<option value="PN">Pitcairn
<option value="PL">Poland
<option value="PF">Polynesia (Fr.)
<option value="PT">Portugal
<option value="PR">Puerto Rico (US)
<option value="QA">Qatar
<option value="RE">Reunion (Fr.)
<option value="RO">Romania
<option value="RU">Russian Federation
<option value="RW">Rwanda
<option value="LC">Saint Lucia
<option value="WS">Samoa
<option value="SM">San Marino
<option value="SA">Saudi Arabia
<option value="SN">Senegal
<option value="SC">Seychelles
<option value="SL">Sierra Leone
<option value="SG">Singapore
<option value="SK">Slovak Republic
<option value="SI">Slovenia
<option value="SB">Solomon Islands
<option value="SO">Somalia
<option value="ZA">South Africa
<option value="SU">Soviet Union
<option value="ES">Spain
<option value="LK">Sri Lanka
<option value="SH">St. Helena
<option value="PM">St. Pierre & Miquelon
<option value="ST">St. Tome and Principe
<option value="KN">St.Kitts Nevis Anguilla
<option value="VC">St.Vincent & Grenadines
<option value="SD">Sudan
<option value="SR">Suriname
<option value="SJ">Svalbard & Jan Mayen Is
<option value="SZ">Swaziland
<option value="SE">Sweden
<option value="CH">Switzerland
<option value="SY">Syria
<option value="TJ">Tadjikistan
<option value="TW">Taiwan
<option value="TZ">Tanzania
<option value="TH">Thailand
<option value="TG">Togo
<option value="TK">Tokelau
<option value="TO">Tonga
<option value="TT">Trinidad & Tobago
<option value="TN">Tunisia
<option value="TR">Turkey
<option value="TM">Turkmenistan
<option value="TC">Turks & Caicos Islands
<option value="TV">Tuvalu
<option value="UM">US Minor outlying Isl.
<option value="UG">Uganda
<option value="UA">Ukraine
<option value="AE">United Arab Emirates
<option value="GB">United Kingdom
<option value="US">United States
<option value="UY">Uruguay
<option value="UZ">Uzbekistan
<option value="VU">Vanuatu
<option value="VA">Vatican City State
<option value="VE">Venezuela
<option value="VN">Vietnam
<option value="VG">Virgin Islands (British)
<option value="VI">Virgin Islands (US)
<option value="WF">Wallis & Futuna Islands 
<option value="EH">Western Sahara
<option value="YE">Yemen
<option value="YU">Yugoslavia
<option value="ZR">Zaire
<option value="ZM">Zambia
<option value="ZW">Zimbabwe
</select>
</td>
</tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr>
<td><span class="requiredfield">*</span> Required fields.</td></tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td colspan=5><table border="0" cellpadding=0 cellspacing=0 width="558" align="left">
<tr>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="15" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="536" height="1" border="0"></td>
</tr>
<tr><td class="verttop"><input type=checkbox name=send_announce ></td><td></td><td><%=lblperiodicmails%></td></tr></table>
</td></tr><tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
<tr><td colspan=5 align=right><input type="button" class="commonButton" id="bid-update" value="<%=lblUpdate%>" title="<%=lblUpdate%>"   onMouseOver="top.mouse_move('b_update');"  onMouseOut="top.mouse_move();"  onClick="document.forms[0].submit(); return false;;"  ></td>
</tr>
</table>
</td>
</tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
</table>

<input type="hidden" name="cmd" value="edit">
<input type="hidden" name="start" value="">
</form>
</body>
</html>