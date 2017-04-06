<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl540%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script>

function validate(f)
{
    emailExp= /^\w+(\-\w+)*(\.\w+(\-\w+)*)*@\w+(\-\w+)*(\.\w+(\-\w+)*)+$/;
   if (!(emailExp.test(f.redirectadd.value)))
      { 
		   alert("<%=lbl541%>");
		   f.redirectadd.focus();
		   return false;  
	  }
    if(f.redirectadd.value=="")
	   {
			alert("<%=lbl542%>");
			f.email.focus();
			return false;
	   }
    f.action='/domains/changeredirectadd1.asp';
	f.submit();
    return true;
}
</script>

</head>
<%
	'---------------------------------------------------------------------------------------------
	id=session("id")
	'---------------------------------------------------------------------------------------------
	username=session("resellername")
	'---------------------------------------------------------------------------------------------

	query="select redirectadd from tblmailaddress where domainid='" & id & "' and isalias='1' and mailname='" & request("alias") & "' order by mailname"
	'response.write query
	dim rsalias
	set rsalias=server.createobject("ADODB.Recordset")
	rsalias.open query,con
	redirectadd=rsalias("redirectadd")
%>

<!-- #INCLUDE FILE = "../inc/header.asp" -->


<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!----------------------------------------------------------------------------
The header of reseller prepared here-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<!--
----------------------------------------------------------------------------
The header ends here
-->
<body>
<form  method="post" name="mainform" >
  <table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td colspan="2"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
      <td colspan="3"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    
    <tr> 
      <th colspan="5"><font color="#003366" size="2" face="Verdana"><strong><%=lbl543%> <font color="red"><%=session("domain")%></font></strong></font> </tr>

    <tr> 
      <td width="287" height="28"><div align="right"><font size="2" face="Verdana"><strong><%=lbl544%></strong></font></div>
        <div align="center"> </div></td>
      <td width="25">&nbsp;</td>
      <td colspan="3"><font size="2" color="red" face="Verdana"><strong><%=request("alias")%></strong></font></td>
    </tr>

    <tr> 
      <td width="287" height="28"><div align="right"><font size="2" face="Verdana"><strong><%=lbl545%> </strong></font></div>
        <div align="center"> </div></td>
      <td width="25">&nbsp;</td>
      <td colspan="3"><input name="redirectadd" type="text" value="<%=redirectadd%>" id="email"></td>
    </tr>
 
      <td colspan="5"><div align="right"></div>
        <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
        </div></td>
    </tr>
    <tr> 
      <td colspan="5"><div align="center"> 
          <input type="button" name="Button35" value="<%=lbl533%>" class="commonButton" onclick="return validate(document.mainform)">
        </div></td>
    </tr> <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr> <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
  </table>
<input type="hidden" name="alias" value="<%=request("alias")%>">
<input type="hidden" name="cgi" value="<%=cgi%>">
</form>
</body>
</html><!-- #INCLUDE FILE = "../inc/footer.asp" -->