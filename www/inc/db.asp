<%
dim con
Set con = Server.CreateObject("ADODB.Connection")
strConnection = "Driver={MySQL ODBC 3.51 Driver};server=localhost;uid=webhostpanel;pwd=guido55;database=webhostpanel;"
con.Open strConnection
%>