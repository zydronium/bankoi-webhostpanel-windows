	<%
	accessLevel = 10
	%>

	<!-- #INCLUDE FILE = "../inc/security.asp" -->
	<!-- #INCLUDE FILE="../inc/db.asp" -->
	<!-- #INCLUDE FILE="../inc/functions.asp" -->
		
	<%
			resellerid = session("reselid")
			
		
			ipadd = request("ipaddr")
			if(len(ipadd) = 0) then
					ipadd = "<ip>"
			end if
			RecordType  = request("recordType")		

			typeof1 = request("typeof")

			subnet=request("subnet")
			
			ns=request("ns")
			
			mx=request("mx")
		
			cnametype=request("cnametype")
			
			
			
			'------------------------------------------------------------------------------------------------------------------------------------------------
			if(RecordType = "A") then
					host = typeof1 & "." & "<domain>" & "."
					if(Not ipadd = "<ip>") then
							query = "select * from tbldnstemplate where host='" & host & "' and value='" & ipadd & "' and resellerid='0'"
							'Response.write query & "<BR>"
							set rsTypeA  = Server.CreateObject("ADODB.RecordSet")
							rsTypeA.open query,con
							if(Not rsTypeA.EOF) then
	%>
									<script>
										alert("<%=msg114%>");
										window.location = "/server/dnstemplate.asp";
									</script>
	<%
									Response.End
								End if
						End if
					query="insert into tbldnstemplate set resellerid='0',host='" & host & "',recordtype='" & RecordType & "',value='" & ipadd & "'"
					'Response.write query & "<BR>"
					con.Execute (query)
			End if
		
			'------------------------------------------------------------------------------------------------------------------------------------------------

			if(RecordType = "NS") then
					if(len(request("dmnname")) = 0) then
							stToDmn = ""
					else
							stToDmn = "<" & Request("dmnname") & ">" & "."
					end if
					host="<domain>" & "."
					val="ns" & ns & "." & stToDmn
					query = "select * from tbldnstemplate where host='" & host & "' and value='" & val & "' and resellerid='0'"
					'Response.write query & "<BR>"
					set rsTypeNS  = Server.CreateObject("ADODB.RecordSet")
					rsTypeNS.open query,con
							if(Not rsTypeNS.EOF) then
	%>
									<script>
										alert("<%=msg115%>");
										window.location = "/server/dnstemplate.asp";
									</script>
	<%
									Response.Write
							End if
		
					query="insert into tbldnstemplate set resellerid='0', host='" & host & "',recordtype='" & RecordType & "',value='" &val & "'"
					'Response.write query & "<BR>"
					con.Execute (query)
			 End if
		
		'------------------------------------------------------------------------------------------------------------------------------------------------
			if(RecordType = "MX") then
					if(len(Request("exchangeval")) = 0) then
							Exch  = "mail." & "<domain>"
					else
							Exch  = Request("exchangeval")
					end if
					host="<domain>" & "."
					record=RecordType
					val=Exch & "."
					query = "select * from tbldnstemplate where host='" & host & "' and recordtype='" & record & "' and resellerid='0' and mxpref = '" & mx & " '"
					'Response.write query & "<BR>"
					set rsTypeMX  = Server.CreateObject("ADODB.RecordSet")
					rsTypeMX.open query,con
					if(Not rsTypeMX.EOF) then
	%>
							<script>
								alert("<%=msg116%>");
								window.location = "/server/dnstemplate.asp";
							</script>
	<%
							Response.Write
					End if
						
					query="insert into tbldnstemplate set resellerid='0', host='" & host & "',recordtype='" & record & "',value='" & val & "',mxpref = '"& mx &"'"
					'Response.write query & "<BR>"
					con.Execute (query)
			End if
		
			'------------------------------------------------------------------------------------------------------------------------------------------------	
			if(RecordType = "CNAME") then				
					if(len(Request("cnameval")) = 0) then
							Exch  = "mail." & "<domain>"
					else
							Exch  = Request("cnameval")
					End if
					host= cnametype & "." & "<domain>" & "."
					val = Exch & "."
					query = "select * from tbldnstemplate where host='" & host & "' and value='" & val & "' and resellerid='0'"
					'Response.write query & "<BR>"
					set rsTypeCNAME  = Server.CreateObject("ADODB.RecordSet")
					rsTypeCNAME.open query,con
					if(Not rsTypeCNAME.EOF) then
	%>
							<script>
								alert("<%=msg117%>");
								window.location = "/server/dnstemplate.asp";
							</script>
	<%
							Response.Write
					End if

					query="insert into tbldnstemplate set resellerid='0', host='" & host & "',recordtype='" & RecordType & "',value='" & val & "'"
					'Response.write query & "<BR>"
					con.Execute (query)
				End if

	%>
		<script>
			alert("<%=msg118%>");
			window.location = "/server/dnstemplate.asp";
		</script>