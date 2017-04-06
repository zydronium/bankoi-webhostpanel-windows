<%
accessLevel = 1
%>
<!-- #INCLUDE FILE = "../../inc/security.asp" -->
<!-- #INCLUDE FILE = "../../inc/db.asp" -->
<!-- #INCLUDE FILE = "../../inc/params.asp" -->
<!-- #INCLUDE FILE = "../../inc/functions.asp" -->
<!-- #INCLUDE FILE = "../../inc/dnsfunctions.asp" -->

<%
domainid = Session("id")
domainName = Session("domain")		
	message = ""
	mode = request("mode")
	if(mode = "add")then
		addhost = request("addhost") & "." & DomainName
				
		addip = request("addip")
		strQuery = "select * from dns_data where domainid=" & domainid & " and host='" & addhost &"'"
		set rsTest = Server.CreateObject("ADODB.recordset")
		rsTest.open strQuery, con
		if(rsTest.eof) then
			'Here we are making a DNS entry to the DNS server
			'-----------------------------------------------------
				createNewCNAMERedord DomainName, addhost, addip
			'-----------------------------------------------------
			addhost = addhost '& "."
			addip = addip & "."
			strQuery = " insert into dns_data (domainid, domain, host, modifier, rside, rectype) values ("& domainid  & ", '"& DomainName &"',  '"& addhost &"','', '"& addip &"', 'CNAME')"
			con.execute strQuery, rowaffected
			if(rowaffected = 1) then message = msg145 else message = msg146
		else
			message = addhost & msg128
		end if
		
		set rsTest = nothing
	elseif(mode = "delete") then
		d_id = request("checkid")
		if(len(d_id)>0) then
			ids = Split(d_id, ",")
			for i = lbound(ids) to Ubound(ids)
				'DeleteCNAMERecords (Trim(ids(i)))
				query = "select * from dns_data where  id =" & Trim(ids(i))
				Set rsARecord = Server.CreateObject("ADODB.RecordSet")
				rsARecord.open query,con
				if(not rsARecord.EOF) then
							ownerName = rsARecord("host")
							oldIpAddress = rsARecord("rside")
							DeleteCNAMERecords DomainName, ownerName
				End if
			next
			myQuery = "delete from dns_data where id in ("& d_id &")"
			con.execute(myQuery)
			message=msg125
		else
			message=msg126
		end if
	else
		message = msg127
	end if
	con.close
	set con = nothing
%>
<script>
alert('<%=message%>')
location.replace('managedns.asp')
</script>