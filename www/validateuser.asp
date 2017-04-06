<%@ LANGUAGE = VBScript.Encode %>

<!-- #include file="inc/lang.asp" -->
<!-- #INCLUDE FILE="inc/db.asp" -->
<!-- #INCLUDE FILE="inc/params.asp" -->
<!-- #INCLUDE FILE="inc/functions.asp" -->
<%
	userid= request("login_name")
	password = request("passwd")
	query = "select * from tblloginmaster where username='" & userid & "' and  password LIKE '" & password & "'"
	
	dim rs
	set rs = Server.createobject("ADODB.RecordSet")
	rs.Open query,con
	
	if(rs.EOF)then
		if(instr(userid,"@")) then
			mailuserArray = Split(userid,"@")
			query = "select * from tblmailaddress where mailname='" & mailuserArray(0) & "' and domainname='" & mailuserArray(1) & "'  and  mailpass LIKE '" & password & "'"
			set rsmail = Server.createobject("ADODB.RecordSet")
			rsmail.Open query,con
			if(rsmail.EOF) then
					con.close
					response.redirect "login.asp?mode=failed"
			else
					session("isalias") = rsmail("isalias")
					session("userid") = mailuserArray(0)
					session("maildomain") = mailuserArray(1)
					session("skin") = "default"
					session("logoname")="/logos/logo.gif"
					session("type") = "M"
					response.redirect "/mailuser/mailaccount.asp"
			end if			
		else
			response.redirect "login.asp?mode=failed"	
		end if
	else
		userstatus = rs("status")
		usertype = rs("usertype")
		if(userstatus = "1") then
			session("userid")=userid
			session("usertype") = usertype
			if (usertype = "a") then '<----------Here the type a is for the ADMINISTRATOR
				session("adminid")=rs("id")
				session("type") = usertype
				session("logoname")="/logos/logo.gif"
				response.redirect("/clients/clients.asp")
			elseif (usertype = "c") then '<------Here the type 'c' is for Reseller/Client
				session("reselid") = rs("id")
				session("type") = usertype
				session("clientname") = rs("username")
				session("resellername") = rs("username")

				query="select * from tblreseller where resellerid='" & session("reselid") & "'"
				set rslogo=Server.CreateObject("ADODB.Recordset")
				rslogo.open query,con
				
				session("skin")=rslogo("skinname")
				
				if(rslogo("logo")="") then
					session("logoname")="/logos/logo.gif"
				else
					session("logoname")="/logos/" & rslogo("logo")
				end if
				set rslogo=Nothing

				response.redirect("/domains/clientdomains.asp")
			else
				session("domain") = userid
				session("id")=rs("id")
				session("type") = usertype

				query="select resellerid from tbldomain where domainid='" & session("id") & "'"
				'response.write query
				set reseller=Server.CreateObject("ADODB.Recordset")
				reseller.open query,con
				reselid=reseller("resellerid")
				set reseller=Nothing
				session("reselid") = reselid
				query="select * from tblreseller where resellerid='" & reselid & "'"
				set rslogo=Server.CreateObject("ADODB.Recordset")
				rslogo.open query,con			
				session("skin")=rslogo("skinname")
				
				if(rslogo("logo")="") then
					session("logoname")="/logos/logo.gif"
				else
					session("logoname")="/logos/" & rslogo("logo")
				end if
				rslogo.close

				query="select * from tblloginmaster where id='" & reselid & "'"
				rslogo.open query,con	
				session("clientname") = rslogo("username")
				session("resellername") = session("clientname")
				writelogline session("resellername") & " : " & session("clientname")
				rslogo.close

				response.redirect("/domains/edit_domain.asp")
			end if
		else
			response.redirect "login.asp?mode=blocked"	
		end if
end if
%>