<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
 <!-- #include file="../inc/header.asp" -->
<head>
<title>Add Hosting Plans</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>

<body>
<p>&nbsp;</p>
<form name="form1" method="post" action="">
<table width="49%" border="0" align="center">
  <tr bgcolor="#15105A"> 
    <td colspan="3"><div align="center"><font color="#FFFFFF" size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Submit 
        New Plans</strong></font></div></td>
  </tr>
  <tr> 
    <td width="52%"><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">Plan 
        Name:</font></strong></div></td>
    <td width="3%">&nbsp;</td>
    <td width="45%"><input name="planname" type="text" id="diskstorage3"></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">Disk 
        Storage:</font></strong></div></td>
    <td width="3%">&nbsp;</td>
    <td width="45%"><input name="diskstorage" type="text" id="diskstorage2"></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">Monthly 
        Bandwidth Limit:</font></strong></div></td>
    <td>&nbsp;</td>
    <td><input name="monthlybandwidth" type="text" id="monthlybandwidth"></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">File 
        Size Limit:</font></strong></div></td>
    <td>&nbsp;</td>
    <td><input name="filelimit" type="text" id="filelimit"></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">Pop 
        Email Accounts &amp; Aliases:</font></strong></div></td>
    <td>&nbsp;</td>
    <td><input name="popmail accounts" type="text" id="popmail accounts"></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">FTP 
        Access:</font></strong></div></td>
    <td>&nbsp;</td>
    <td><select name="ftp" id="ftp">
        <option value="1">Yes</option>
        <option value="0">No</option>
      </select></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">MS 
        Front Page Extensions:</font></strong></div></td>
    <td>&nbsp;</td>
    <td><select name="frontpageext" id="frontpageext">
        <option value="1">Yes</option>
        <option value="0">No</option>
      </select></td>
  </tr>
  <tr> 
    <td><div align="right"><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>ASP.NET 
        Support:</strong></font></div></td>
    <td>&nbsp;</td>
    <td><select name="aspnetsupport" id="select2">
        <option value="1">Yes</option>
        <option value="0">No</option>
      </select></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">CGI 
        Support:</font></strong></div></td>
    <td>&nbsp;</td>
    <td><select name="supports" id="supports">
        <option value="1">Yes</option>
        <option value="0">No</option>
      </select></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">MySQL 
        Database Support:</font></strong></div></td>
    <td>&nbsp;</td>
    <td><select name="mysqldatabase" id="mysqldatabase">
        <option value="1">Yes</option>
        <option value="0">No</option>
      </select></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">MSSQL 
        Database Support:<br>
        </font></strong></div></td>
    <td>&nbsp;</td>
    <td> <select name="mssqlsupport" id="mssqlsupport">
        <option value="1">Yes</option>
        <option value="0">No</option>
      </select></td>
  </tr>
  <tr> 
    <td><div align="right"><strong><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif">Password 
        Protected Directories :</font></strong></div></td>
    <td>&nbsp;</td>
    <td><select name="pwddir" id="select">
        <option value="1">Yes</option>
        <option value="0">No</option>
      </select> </td>
  </tr>
  <tr>
    <td><div align="right"><font color="#003366" size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Web 
        Statics:</strong></font></div></td>
    <td>&nbsp;</td>
    <td><select name="webstats" id="select3">
        <option value="1">Yes</option>
        <option value="0">No</option>
      </select></td>
  </tr>
  <tr> 
    <td colspan="3"> <div align="center"> 
        <input type="submit" name="Submit2" value="Add" class="commonButton">
        <input type="button" name="Button" value="Cancel" onClick="history.go(-1)" class="commonButton">
      </div></td>
  </tr>
  <tr bgcolor="#15105A"> 
    <td colspan="3">&nbsp;</td>
  </tr>
</table>
</body>
</form>
</html>
<br>
<br>
<!-- #include file="../inc/footer.asp" -->