<%
Const fsoForReading = 1
Const fsoForWriting = 2
Const fsoForAppending = 8
Const boolDebugging = True

'from address which will be used to send emails
dim mailfrom : mailfrom="support@bankoi.com"
' Root Directory for Hosting
dim sHostingDir : sHostingDir = "C:\webspace"
'Control panel Home Directory
Dim sCpHomeDir : sCpHomeDir = "C:\webhostpanel"
'Windows Home Directory
Dim sWinHomeDir : sWinHomeDir = "C:\WINNT"
' Name of the computer
dim sComputerName : sComputerName =  "SERVERHOSTING"
' ftpSiteIndex is server dependent, it must be ID of default Ftp Site 
dim ftpSiteIndex : ftpSiteIndex =1		
' constant to get domainIndex of IIS, It will be added to dom_id
dim wwwSiteIndex : wwwSiteIndex = 5		

' Type of mailserver, qmail, imail
'---------------------------------------------------------------------
'dim sMailServer : sMailServer = "IMAIL" ' if server is Imail
'dim sMailServer : sMailServer = "QMAIL"  'if server is QMAIL on some other linux machine'
dim sMailServer : sMailServer = "ME"	' if mailserver is Mail Enable
'---------------------------------------------------------------------
'Home dir for the mail enable mail servers folders 
dim sMailServerPath : sMailServerPath = "C:\Archivos de programa\Mail Enable\Postoffices"
'dim sMailServerPath : sMailServerPath = "c:\Imail"

'---------------------------------------------------------------------
Dim sArrDefaultDecuments : sArrDefaultDecuments = Array("default.asp", "default.php", "default.aspx", "default.htm", "default.html", "index.asp", "index.php", "index.aspx", "index.htm", "index.html")
'Access driver, to create DSN
dim sAccessDriver : sAccessDriver = sWinHomeDir &"\system32\odbcjt32.dll"
'SQL Server driver to create DSN
dim sMsSQLDriver : sMsSQLDriver = sWinHomeDir &"\system32\sqlsrv32.dll"
'My SQL driver to create DSN
dim sMySQLDriver : sMySQLDriver = sWinHomeDir &"\System32\myodbc.dll"
dim sMySQLDriverName : sMySQLDriverName = "MySQL ODBC 3.51 Driver"
'Front Page Server Extension Executable Path
dim frontPageExtPath : frontPageExtPath = "C:\Archivos de programa\Common Files\Microsoft Shared\web server extensions\50\bin\owsadm.exe" 
dim domainperpage : domainperpage = 20
dim ClientsPerPage  : ClientsPerPage = 20

'*----------------------------------No Need To Edit Below -------------------------------
' New domain Files must be copied from
Dim newDomFiles : newDomFiles = sCpHomeDir & "\www\newdomfiles\"
' Log file must be copied from
Dim cpLogFilePath : cpLogFilePath = sCpHomeDir & "\log\cplog.txt"

dim logFSO
set logFSO = Server.createobject("Scripting.FileSystemObject")

' Webalizer Configuartion Files Dir for all domains
dim sWebalizerConfDir : sWebalizerConfDir = sCpHomeDir & "\webalizer\"
' Webalizer Conf File Template
dim sWebalizerTempFile : sWebalizerTempFile = sCpHomeDir & "\stattemplate\webalizer.conf"
' Log File Format
dim sLogFileFormat : sLogFileFormat= "W3C Extended Log File Format"   ' "NCSA Common Log File Format" 

dim httperrors(32)

httperrors(0)=("400,*,FILE,"& sWinHomeDir &"\help\iisHelp\common\400.htm")
httperrors(1)=("401,1,FILE,"& sWinHomeDir &"\help\iisHelp\common\401-1.htm")
httperrors(2)=("401,2,FILE,"& sWinHomeDir &"\help\iisHelp\common\401-2.htm")
httperrors(3)=("401,3,FILE,"& sWinHomeDir &"\help\iisHelp\common\401-3.htm")
httperrors(4)=("401,4,FILE,"& sWinHomeDir &"\help\iisHelp\common\401-4.htm")
httperrors(5)=("401,5,FILE,"& sWinHomeDir &"\help\iisHelp\common\401-5.htm")
httperrors(6)=("403,1,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-1.htm")
httperrors(7)=("403,2,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-2.htm")
httperrors(8)=("403,3,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-3.htm")
httperrors(9)=("403,4,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-4.htm")
httperrors(10)=("403,5,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-5.htm")
httperrors(11)=("403,6,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-6.htm")
httperrors(12)=("403,7,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-7.htm")
httperrors(13)=("403,8,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-8.htm")
httperrors(14)=("403,9,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-9.htm")
httperrors(15)=("403,10,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-10.htm")
httperrors(16)=("403,11,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-11.htm")
httperrors(17)=("403,12,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-12.htm")
httperrors(18)=("403,13,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-13.htm")
httperrors(19)=("403,15,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-15.htm")
httperrors(20)=("403,16,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-16.htm")
httperrors(21)=("403,17,FILE,"& sWinHomeDir &"\help\iisHelp\common\403-17.htm")
httperrors(22)=("404,*,FILE,"& sWinHomeDir &"\help\iisHelp\common\404b.htm")
httperrors(23)=("405,*,FILE,"& sWinHomeDir &"\help\iisHelp\common\405.htm")
httperrors(24)=("406,*,FILE,"& sWinHomeDir &"\help\iisHelp\common\406.htm")
httperrors(25)=("407,*,FILE,"& sWinHomeDir &"\help\iisHelp\common\407.htm")
httperrors(26)=("412,*,FILE,"& sWinHomeDir &"\help\iisHelp\common\412.htm")
httperrors(27)=("414,*,FILE,"& sWinHomeDir &"\help\iisHelp\common\414.htm")
httperrors(28)=("500,12,FILE,"& sWinHomeDir &"\help\iisHelp\common\500-12.htm")
httperrors(29)=("500,13,FILE,"& sWinHomeDir &"\help\iisHelp\common\500-13.htm")
httperrors(30)=("500,15,FILE,"& sWinHomeDir &"\help\iisHelp\common\500-15.htm")
httperrors(31)=("500,100,URL,/iisHelp/common/500-100.asp")

'=====================
'Added in version 1.20
' If you wants to use webalizer support then set isWebalizerStats = "YES" else set it to "NO"
dim isWebalizerStats : isWebalizerStats = "NO" 
' If you wants to use awstats support then set isAwstats = "YES" else set it to "NO"
dim isAwstats : isAwstats = "YES" 
' Webalizer Conf File Template
dim sAwstatTempFile : sAwstatTempFile = sCpHomeDir & "\stattemplate\awstat.conf"
' If awstats support is used then the home dir of awstats, it is shipped with webhostpanel and this is the default value
' sCpHomeDir & "\awstats-6.1"
dim awstatsDir : awstatsDir= sCpHomeDir & "\awstats-6.1"
' Awstats datadir. This is the dir where awstat put the data and dns cache files. It will consumes the space according to the hits of 
' domains. The size of this folder increases daily.
dim awstatsCacheDir : awstatsCacheDir= sCpHomeDir & "\awstats-6.1\cache"
' Awstats requires perl. So path to the perl.exe
dim perlExePath : perlExePath = "c:\perl\bin\perl.exe"

Dim strServer : strServer="200.63.16.226"
' If you wants to use dns servers support then set dnsSupport = "Y" else set it to "N"
Dim dnsSupport : dnsSupport = "Y"
' Name servers to use for dns zone
Dim nameServer1 : nameServer1 = "ns1.eldns.com."
Dim nameServer2 : nameServer2= "ns2.eldns.com."
' Windows version 2000 or 2003
Dim SERVER_VERSION : SERVER_VERSION = "2000"
%>