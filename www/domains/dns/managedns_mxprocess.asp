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
		addhost = DomainName 'request("addhost")
		addip = request("addip") & "." & DomainName & "."
		rank = request("addrank")
		if(isnumeric(rank)) then
			query = "select count(host) as cntr from dns_data where rside = '" & addip & "' and domainid='" & domainid & "'  and modifier='" & rank & "'"
			'response.write query
			set rsCheckHost = Server.CreateObject("ADODB.RecordSet")
			rsCheckHost.open query,con
			if(not cint(rsCheckHost("cntr")) = 0) then
			%>
				<script>
				alert("The host name is already used by some entry");
				history.go (-1);
				</script>
			<%
				response.End
			end if
			'Here we are making a DNS entry to the DNS server
			'-----------------------------------------------------
				createNewMXRedord DomainName, "MX", addip, rank
			'-----------------------------------------------------
			strQuery = "select * from dns_data where domainid=" & domainid & " and host='" & addhost &"' and rside='"& addip &"'"
			set rsTest = Server.CreateObject("ADODB.recordset")
			rsTest.open strQuery, con
			if( rsTest.eof) then
				'strQuery = " insert into dns_data values ("& domainid & ", 'MX', '"& addhost &"', '"& addip &"',"& rank &")"
				strQuery = " insert into dns_data (domainid, domain, host, modifier, rside, rectype) values ("& domainid  & ", '"& DomainName &"',  '"& addhost &"','"& rank &"', '"& addip &"', 'MX')"
				con.execute strQuery, rowaffected
				if(rowaffected = 1) then message = msg147 else message = msg148
				'message = message & rowaffected
				'con.execute("update dns_master set action=2, status=1 where domainid="& domainid)
			else
				message = addhost & msg129
			end if
			set rsTest = nothing
		else
			message = msg130
		end if


	elseif(mode = "delete") then
		d_id = request("checkid")
		if(len(d_id)>0) then
			ids = Split(d_id, ",")
			'response.write "LBOUND IS " & lbound(ids) & "<br><br><br><br>"
			'response.write "UBOUND IS " & ubound(ids) & "<br><br><br><br>"
			for i = lbound(ids) to Ubound(ids)
				'DeleteMXRecords(Trim(ids(i)))
				query = "select * from dns_data where  id =" & Trim(ids(i))
				Set rsARecord = Server.CreateObject("ADODB.RecordSet")
				rsARecord.open query,con
				if(not rsARecord.EOF) then
							MailExchange = rsARecord("rside")
							Preference = rsARecord("modifier")
							DeleteMXRecords DomainName, MailExchange, Preference
				End if
			next
			myQuery = "delete from dns_data where id in ("& d_id &")"
			con.execute(myQuery)
			'con.execute("update dns_master set action=2, status=1 where domainid="& domainid)
			message=msg125
		else
			message=msg126
		end if


	elseif(mode = "modify") then
		ipcount = request("ipcount")
		for each Field in request.Form
			MyPos  = InStr(1,Field, "modmail_", 1)
			if( MyPos > 0)then
				ids = split(Field ,"_")
				val = request(Field)
				rank = request("rank_" & ids(ubound(ids)))
				rank1 = request("rank_" & ids(ubound(ids)))

				'UpdateMXRecord domainName, val, rank 
				'-----------------------------------------------------------------------------------------------------------------
				query = "select * from dns_data where  id =" & ids(ubound(ids))
				Set rsARecord = Server.CreateObject("ADODB.RecordSet")
				rsARecord.open query,con
				if(not rsARecord.EOF) then
							MailExchange = rsARecord("rside")
							Preference = rsARecord("modifier")
							UpdateMXRecord DomainName,val,rank,MailExchange,Preference
							myQuery = "update dns_data set rside='"& val &"' ,modifier='" & rank1 & "' where id=" & ids(ubound(ids))
							if(isnumeric(rank) = true) then
									con.execute(myQuery)
							end if
				end if
				'-----------------------------------------------------------------------------------------------------------------
			end if
		next
		'con.execute("update dns_master set action=2, status=1 where domainid="& domainid)
		message=msg131
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