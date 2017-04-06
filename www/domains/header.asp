<script language = "javascript">
function chkadd()
{
	document.forms[0].action = "../domains/new_domain.asp";
	document.forms[0].submit();
	return true;
}

</script>
  <table width="564" border="0" align="center" cellpadding="0" cellspacing="0">
   
	  <td colspan="4">&nbsp;</td>
	</tr>
    <tr>
	  <td><div align="center">
		  <input type="submit" name="Button1" value="Add Domain" class="commonButton" onclick = "return chkadd(this);">
		</div></td>
	  
	  <td><div align="center">
		  <input type="button" name="Button1" value="Logout" class="commonButton"
		  onClick="window.location='../logout.asp'">
		</div></td>
	</tr>
	<tr>	 
	  <td colspan=5><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0>	  
	  </td>
	</tr>
  </table>