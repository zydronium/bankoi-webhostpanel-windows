<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<html>
<head>
<title><%=lblclientlimits%></title>
<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<script>
function chk_form_data(f)
{
    if(validate(f))
	   {
			f.action = "/clients/setclientlimits.asp";
			f.submit();
			return true;
		}	
	else
	  return false
}
function validate(f)
{
  if(isNaN(f.ftpusers.value))
     {
        alert("Ftp users should be numbers Only");
        f.ftpusers.value="";
		f.ftpusers.focus()
	    return false;
      }
   if(isNaN(f.popmailaccount.value))
     {
        alert("Popmail account requires a numbers Only");
        f.popmailaccount.value="";
		f.popmailaccount.focus()
	    return false;
      }
   if(isNaN(f.sqldatabase.value))
     {
        alert("Sql database requires a numbers Only");
        f.sqldatabase.value="";
		f.sqldatabase.focus()
	    return false;
      }	  
   return true;
}

</script>
</head>
<%
id=session("reselid")
'---------------------------------------------------------------------------------------------
  'Here we are extracting the name of the reseller according to the id stored in the session
  query="select contactname from tblcontactinfo where id='" & session("reselid") & "'"
  'response.write query
  dim rs
  set rs=server.createobject("ADODB.Recordset")
  rs.open query,con
  username=rs("contactname")
  'response.write "amit yadav" &session("reselid")
  rs.close
  '----------------------------------------------------------------------------------------------
  query="select count(id) as flag from tblrights where id='" & session("reselid") & "'"
	  
  set rs=server.CreateObject("adodb.recordset")
  rs.open query,con
  
  if(cint(rs("flag"))>0) then
      rs.close
	  query ="select ftpusers,popmailaccount,sqldatabase,emailalias, mysql_server, mssql_server from tblrights where id='" & session("reselid") & "'"
	  rs.open query,con
	  ftpusers=rs("ftpusers")
	  popmailaccount=rs("popmailaccount")
	  sqldatabase=rs("sqldatabase")
	  alias=rs("emailalias")
	  mysql_server=rs("mysql_server")
  	  mssql_server=rs("mssql_server")
	  rs.close
  else
	  ftpusers="1"
	  popmailaccount="1"
	  sqldatabase="1"
	  alias="1"
	  mysql_server=0
 	  mssql_server=0
  end if	  
 %> 
<body>
<!-- #include file="../inc/header.asp" -->
<form  method='post' action = "/clients/setclientlimits.asp" name="mainform">
<!-- #include file="../clients/clientheader.asp" -->
      <table width="564" border="0" align="center" cellpadding=0 cellspacing=0>
        <tr > 
          <td colspan=2 height="19" valign="middle"><%=lblSetclient%> <font color="#CC0000" face="	vwerdana"><strong><%=" "&username&" "%></strong></font> 
            Limits</td>
          <td height="19" valign="middle"><div align="right"> 
<%	
    usertype=session("type")
	if(usertype="a") then
%>		  
              <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/server/domains.asp';" value="<%=lbluplevel%>" >
<%else%>
			  <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lbluplevel%>" >
<%end if%>			  
            </div></td>
        </tr>
        <br>
        <br>
        <br>
      </table>
	  <table align="center">
        <tr> 
          <td height="20" align="center"> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
            </div></td>
        </tr>
      </table>
      <table width="58%" border="0" align="center">
        <tr> 
          <td width="41%"><div align="right"><strong><%=lblFtpUsers%></strong></div></td>
		  <td width="4%">&nbsp;</td>
		  <td width="55%"> <div align="left"> 
              <input name="ftpusers" type="text" id="ftpusers" value="<%=ftpusers%>">
            </div></td>
		</tr>
        <tr> 
          <td><div align="right"><strong><%=lblPopmailAccount%></strong></div></td>
		  <td>&nbsp;</td>
		  <td> <div align="left"> 
              <input name="popmailaccount" type="text" id="popmailaccount" value="<%=popmailaccount%>">
            </div></td>
		</tr>
        <tr> 
          <td><div align="right"><strong><%=lblSqlDatabases%> </strong></div></td>
		  <td>&nbsp;</td>
		  <td> <div align="left"> 
              <input name="sqldatabase" type="text"  value="<%=sqldatabase%>">
            </div></td>
		</tr>
		<tr>
		  <td><div align="right"><strong><%=lblMySqlServer%></strong></div></td>
		  <td>&nbsp;</td>
		  <td><select name="mysql_server" id="mysql_server">
		  <option value="0" ><%=lbl726%></option>
		  <%
		  set rsMysql = server.CreateObject("ADODB.REcordSet")
		  rsMysql.open "select id, serverip from cp_db_servers where status=1 and servertype='mysql'", con
		  while (not rsMysql.eof)
		  %>
		  <option value="<%=rsMysql("id")%>" ><%=rsMysql("serverip")%></option>
			  <%
			  rsMysql.movenext
			  wend
			  set rsMysql=nothing
			  %>
			</select></td>
		</tr>
		<tr>
		  <td><div align="right"><strong><%=lblServer %> MsSql</strong></div></td>
		  <td>&nbsp;</td>
		  <td><select name="mssql_server" id="mssql_server">
			  <option value="0" selected><%=lbl726%></option>
<%
		  set rsMssql = server.CreateObject("ADODB.REcordSet")
		  rsMssql.open "select id, serverip from cp_db_servers where status=1 and servertype='mssql'", con
		  while (not rsMssql.eof)
%>
		  <option value="<%=rsMssql("id")%>" ><%=rsMssql("serverip")%></option>
			  <%
			  rsMssql.movenext
			  wend
			  set rsMssql=nothing
			  %>
			</select></td>
		</tr>
		        
		<tr> 
          <td><div align="right"><strong><%=lblEmailAlias%></strong></div></td>
		  <td>&nbsp;</td>
		  <td> <div align="left"> 
              <input name="alias" type="text"  value="<%=alias%>">
            </div></td>
		</tr>
        <tr> 
          <td colspan="3"> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
            </div></td>
		</tr>
        <tr> 
          <td colspan="3"><div align="center"> 
              <input name="Button22" type="button" class="commonButton" id="Button22" title="<%=lblSetLimits%>" onClick="chk_form_data(document.mainform)" value="<%=lblSetLimits%>" >
			  <%	
    usertype=session("type")
	'response.write "The type is " & usertype
	if(usertype="a") then
%>
              <input name="Button23" type="button" class="commonButton" id="Button23" title="<%=lblCancel%>" onClick="window.location='/server/domains.asp';" value="<%=lblCancel%>" >
			  <%else%>
			  <input name="Button23" type="button" class="commonButton" id="Button23" title="<%=lblCancel%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lblCancel%>" >
			  <%end if%>
            </div></td>
		</tr>
      </table>
      <p>&nbsp;</p></form>
	  <script language="javascript">
for (var i = 0; i < document.mainform.mysql_server.options.length; i++)
{
	if (document.mainform.mysql_server.options[i].value == "<%=mysql_server%>")
	{
		document.mainform.mysql_server.options[i].selected = true;
		break;
	}
}
for (var i = 0; i < document.mainform.mssql_server.options.length; i++)
{
	if (document.mainform.mssql_server.options[i].value == "<%=mssql_server%>")
	{
		document.mainform.mssql_server.options[i].selected = true;
		break;
	}
}
</script>
</body>
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->