<%
accessLevel = 1
%>
<!-- #INCLUDE FILE = "../../inc/security.asp" -->
<!-- #INCLUDE FILE = "../../inc/db.asp" -->
<!-- #INCLUDE FILE = "../../inc/params.asp" -->
<!-- #INCLUDE FILE = "../../inc/functions.asp" -->
<!-- #INCLUDE FILE = "../../inc/dnsfunctions.asp" -->

<%
function parseIP(par)
	ipArr = split(par, ".")
	parseIP= true
	if( ubound(ipArr)-lbound(ipArr) <> 3) then
		parseIP= false
	else
		for j=lbound(ipArr) to ubound(ipArr)
			if(( not isnumeric(ipArr(j))) or (ipArr(j) > 255) or (ipArr(j) < 0) )then
				parseIP= false
			end if
		next
	end if
end function	
	domainid = Session("id")
	domainName = Session("domain")		
	message = ""
	mode = request("mode")
	if(mode = "add")then
		addhost = request("addhost") & "." & domainName
		addip = request("addip")
		if(addhost="") then
%>
				<script>
				alert("<%=msg135%>");
				history.go (-1);
				</script>
<%
				response.End
		end if
		if(parseIP(addip) = true) then
			query = "select count(host) as cntr from dns_data where domainid='" & domainid & "'  and host='" & addhost & "'"
			set rsCheckHost = Server.CreateObject("ADODB.RecordSet")
			rsCheckHost.open query,con
			if(not rsCheckHost("cntr") = 0) then
%>
				<script>
				alert("<%=msg132%>");
				history.go (-1);
				</script>
			<%
				response.End
			end if
			'Here we are making a DNS entry to the DNS server
			'-----------------------------------------------------
				createNewARedord DomainName, addhost, addip
			'-----------------------------------------------------
			strQuery = " insert into dns_data (domainid, domain, host, modifier, rside, rectype) values ("& domainid  & ", '"& DomainName &"',  '"& addhost &"','', '"& addip &"', 'A')"
			con.execute strQuery, rowaffected
			if(rowaffected = 1) then message = msg143 else message = msg144
			'message = message & rowaffected
			'con.execute("update dns_master set action=2, status=1 where site_id="& domainid)
		else
			message = msg133
		end if
		
		
	elseif(mode = "delete") then
			d_id = request("checkid")
			if(len(d_id)>0) then
				ids = Split(d_id, ",")
			for i = lbound(ids) to Ubound(ids)
				query = "select * from dns_data where  id =" & Trim(ids(i))
				Set rsARecord = Server.CreateObject("ADODB.RecordSet")
				rsARecord.open query,con
				if(not rsARecord.EOF) then
							ownerName = rsARecord("host")
							if(right(ownerName,1)=".") then
								ownerName = left(ownerName,len(ownerName)-1)
							end if
							oldIpAddress = rsARecord("rside")
							DeleteARecords DomainName, oldIpAddress,ownerName
				End if
			next
			myQuery = "delete from dns_data where id in ("& d_id &")"
			con.execute(myQuery)
			message = msg125
		else
			message = msg126
		end if
		
		
	elseif(mode = "modify") then
		ipcount = request("ipcount")
		for each Field in request.Form
			MyPos  = InStr(1,Field, "modip_", 1)
			if( MyPos > 0)then
				ids = split(Field ,"_")				
				val = request(Field)				
				query = "select * from dns_data where  id =" & ids(ubound(ids))
				'writelogline(query)
				Set rsARecord = Server.CreateObject("ADODB.RecordSet")
				rsARecord.open query,con
				if(not rsARecord.EOF) then
							ownerName = rsARecord("host")
							oldIpAddress = rsARecord("rside")
							if(right(ownerName,1)=".") then
								ownerName = left(ownerName,len(ownerName)-1)
							end if
							UpdateARecord domainName,val,oldIpAddress,ownerName
							if(parseIP(val) = true) then
									myQuery = "update dns_data set host='"& ownerName &"', rside='"& val &"' where id=" & ids(ubound(ids))
									'response.write myQuery
									con.execute(myQuery)
							end if
				end if
				
				
				'-----------------------------------------------------------------------------------------------------------------
			end if
		next
		'con.execute("update dns_master set action=2, status=1 where site_id="& domainid)
		message = msg134
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