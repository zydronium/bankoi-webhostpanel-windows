
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<%
If Session("Username") = "" Then Response.Redirect "default.asp"
	dim oDb,oRs
	set oDb = Session("oCon")

	dim rsSite
	set rsSite = server.CreateObject("ADODB.REcordSet")
	rsSite.open "select DomainName from cp_site_details where siteid=" & Session("siteid"), oDB
	domainName = ""
	if(not rsSite.eof ) then
		domainName = rsSite("DomainName")
	else
		domainName = "No site found"
	end if
		strLinuxConDB = "DSN=linux_cp_db;UID=controlpanel;PWD=qweasd;"
		dim linuxConn
		set linuxConn = Server.CreateObject("ADODB.Connection")
		linuxConn.Open strLinuxConDB
	message = ""
	mode = request("mode")
	if(mode = "add")then
		addhost = request("addhost")
		addip = request("addip")
		strQuery = " insert into dns_detail values (NULL, "& Session("siteid") & ", 'NS', '"& addhost &"', '"& addip &"',0)"
		linuxConn.execute strQuery, rowaffected
		if(rowaffected = 1) then message = "Name Server added " else message = "Name Server could not added "
		'message = message & rowaffected
		linuxConn.execute("update dns_master set action=2, status=1 where site_id="& Session("siteid"))
		set rsTest = nothing
	elseif(mode = "delete") then
		d_id = request("checkid")
		if(len(d_id)>0) then
			myQuery = "delete from dns_detail where id in ("& d_id &")"
			linuxConn.execute(myQuery)
			linuxConn.execute("update dns_master set action=2, status=1 where site_id="& Session("siteid"))
			message="Selected entried deleted"
		else
			message="No entries selected for deletion"
		end if
	else
		message = "Invalid mode"
	end if
	linuxConn.close
	set linuxConn = nothing
%>
<script>
alert('<%=message%>')
location.replace('managedns.asp')
</script>