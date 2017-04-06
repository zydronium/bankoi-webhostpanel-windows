<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->

<%
	'400  401  403  404  405  500 
	'c:\websites\cpwindows\www\404.htm
	Dim ArrayErrors
	redim ArrayErrors(32)
	Dim Cntr
	Cntr=0
	If(trim(request("u400"))="") then
		for i=Lbound(httperrors) to Ubound(httperrors)-1
		    ListErrors=Split(httperrors(i),",")
			if(ListErrors(0)="400") then
				ArrayErrors(Cntr)=httperrors(i)
				Cntr=Cntr+1
			end if
		Next
	Else
		ArrayErrors(Cntr)=("400,*,URL," & trim(request("u400")))
		Cntr=Cntr+1
	End if


	if(trim(request("u401"))="") then
		for i=Lbound(httperrors) to Ubound(httperrors)-1
		    ListErrors=Split(httperrors(i),",")
			if(ListErrors(0)="401") then
				ArrayErrors(Cntr)=httperrors(i)
				Cntr=Cntr+1
			end if
		Next
	Else
		ArrayErrors(Cntr)=("401,*,URL," & trim(request("u401")))
		Cntr=Cntr+1
	end if


	if(trim(request("u403"))="") then
		for i=Lbound(httperrors) to Ubound(httperrors)-1
		    ListErrors=Split(httperrors(i),",")
			if(ListErrors(0)="403") then
				ArrayErrors(Cntr)=httperrors(i)
				Cntr=Cntr+1
			end if
		Next
	Else
		ArrayErrors(Cntr)=("403,*,URL," & trim(request("u403")))
		Cntr=Cntr+1
	end if



	if(trim(request("u404"))="") then
		for i=Lbound(httperrors) to Ubound(httperrors)-1
		    ListErrors=Split(httperrors(i),",")
			if(ListErrors(0)="404") then
				ArrayErrors(Cntr)=httperrors(i)
				Cntr=Cntr+1
			end if
		Next
	Else
		ArrayErrors(Cntr)=("404,*,URL," & trim(request("u404")))
		Cntr=Cntr+1
	end if



	if(trim(request("u405"))="") then
		for i=Lbound(httperrors) to Ubound(httperrors)-1
		    ListErrors=Split(httperrors(i),",")
			if(ListErrors(0)="405") then
				ArrayErrors(Cntr)=httperrors(i)
				Cntr=Cntr+1
			end if
		Next
	Else
		ArrayErrors(Cntr)=("405,*,URL," & trim(request("u405")))
		Cntr=Cntr+1
	end if



	if(trim(request("u500"))="") then
		for i=Lbound(httperrors) to Ubound(httperrors)-1
		    ListErrors=Split(httperrors(i),",")
			if(ListErrors(0)="500") then
				ArrayErrors(Cntr)=httperrors(i)
				Cntr=Cntr+1
			end if
		Next
	Else
		ArrayErrors(Cntr)=("500,*,URL," & trim(request("u500")))
		Cntr=Cntr+1
	end if
	Cntr=Cntr-1
	redim PRESERVE ArrayErrors(Cntr)
	'For i=Lbound(ArrayErrors) to Ubound(ArrayErrors)
	'	Response.write ArrayErrors(i) & "<br>"
	'Next

	'The Custom errors are set here
	seterrors session("domain"),ArrayErrors
%>
<SCRIPT>
	alert(" <%=msg71 & " " & session("domain")%>");
	window.location="/domains/changecustomerrors.asp";
</SCRIPT>