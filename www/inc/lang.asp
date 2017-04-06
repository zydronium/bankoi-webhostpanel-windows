<%
if(session("lang")="es") then
%>
<!-- #include file="../lang/es.asp" -->
<%
elseif(session("lang")="po") then
%>
<!-- #include file="../lang/po.asp" -->
<%
elseif(session("lang")="be") then
%>
<!-- #include file="../lang/be.asp" -->
<%
elseif(session("lang")="fr") then
%>
<!-- #include file="../lang/fr.asp" -->
<%
else
%>
<!-- #include file="../lang/en.asp" -->
<%
end if
%>