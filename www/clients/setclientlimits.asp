<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/params.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->
<html>
<head>
<title><%=lblSetClientLimits%></title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<%
'---------------------------------------------------------------------------------------------
  'Here we are extracting the name of the reseller according to the id stored in the session
  query="select contactname from tblcontactinfo where id='" & session("reselid") & "'"
  'response.write query
  dim rs
  set rs=server.createobject("ADODB.Recordset")
  rs.open query,con
  username=rs("contactname")
  'response.write "amit yadav" &session("reselid")
  '----------------------------------------------------------------------------------------------
 %> 
<body>
<!-- #include file="../inc/header.asp" -->
<form  method='post' enctype="multipart/form-data" name="mainform">
<!-- #include file="../clients/clientheader.asp" -->
<%
      ftpusers=request("ftpusers")
	  popmailaccount=request("popmailaccount")
	  sqldatabase=request("sqldatabase")
	  alias=request("alias")
	  mysql_server=request("mysql_server")
	  mssql_server=request("mssql_server")
	  
	  query="select count(id) as flag from tblrights where id='" & session("reselid") & "'"
	  
	  set rs=server.CreateObject("adodb.recordset")
	  rs.open query,con
	  if(cint(rs("flag"))>0) then
	      query="update tblrights set id='" & session("reselid") & "',ftpusers='" & ftpusers & "',popmailaccount='" & popmailaccount & "',sqldatabase='" & sqldatabase & "',emailalias='" & alias & "', mysql_server='"& mysql_server &"', mssql_server='"& mssql_server &"'  where id='" & session("reselid")& "'"
      else 		    
	  	  query="insert into tblrights set id='" & session("reselid") & "',ftpusers='" & ftpusers & "',popmailaccount='" & popmailaccount & "',sqldatabase='" & sqldatabase & "',emailalias='" & alias & "', mysql_server='"& mysql_server &"', mssql_server='"& mssql_server &"' "
	  end if	  
	  'response.write query
	  con.execute(query)
%>	  	  
      <table width="564" border="0" align="center" cellpadding=0 cellspacing=0>
        <tr > 
          <td colspan=2 height="19" valign="middle">&nbsp;</td>
          <td height="19" valign="middle"><div align="right"> 
<%	
    usertype=session("type")
	'response.write "The type is " & usertype
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
          <td height="21" align="center"> <div align="center"><%=lblLimitsfor & " " & lblClient%> 
              <font color="#CC0000" face="	vwerdana"><strong><%=" "&username&" "%> 
              </strong></font>set </div></td>
        </tr>
      </table>
      <table width="58%" border="0" align="center">
        <tr> 
          <td colspan="3"><div align="left"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
            </div></td>
        </tr>
        <tr> 
          <td width="52%"> <div align="right"><strong> <%=lblFtpUsers%> </strong> </div></td>
          <td width="2%">&nbsp; </td>
          <td width="46%"><strong><font color="#FF0000"><%=ftpusers%></font></strong></td>
        </tr>
        <tr> 
          <td><div align="right"><strong><%=lblPopmailAccount%></strong></div></td>
          <td>&nbsp;</td>
          <td><strong><font color="#FF0000"><%=popmailaccount%></font></strong></td>
        </tr>
        <tr> 
          <td><div align="right"><strong><%=lblSqlDatabases%></strong></div></td>
          <td>&nbsp;</td>
          <td><strong><font color="#FF0000"><%=sqldatabase%></font></strong></td>
        </tr>
		<tr> 
          <td><div align="right"><strong><%=lblMySqlServer%></strong></div></td>
          <td>&nbsp;</td>
          <td><strong><font color="#FF0000"><%=GetDBServerIp(mysql_server,con)%></font></strong></td>
        </tr>
		<tr> 
          <td><div align="right"><strong><%=lblMySqlServer%></strong></div></td>
          <td>&nbsp;</td>
          <td><strong><font color="#FF0000"><%=GetDBServerIp(mssql_server,con)%></font></strong></td>
        </tr>
		<tr> 
          <td><div align="right"><strong><%=lblEmailAlias%></strong></div></td>
          <td>&nbsp;</td>
          <td><strong><font color="#FF0000"><%=alias%></font></strong></td>
        </tr>
        <tr> 
          <td colspan="3"><div align="center"><strong><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></strong></div></td>
        </tr>
        <tr> 
          <td colspan="3"><div align="center"> 
<%	
    usertype=session("type")
	'response.write "The type is " & usertype
	if(usertype="a") then
%>
              <input name="Button23" type="button" class="commonButton" id="Button23" title="<%=lblOk%>" onClick="window.location='/server/domains.asp';" value="<%=lblOk%>" >
<%else%>
			  <input name="Button23" type="button" class="commonButton" id="Button23" title="<%=lblOk%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lblOk%>" >
<%end if%>            </div></td>
        </tr>
      </table>
      <p>&nbsp;</p></form>
</body>
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->