<%
	'----------------------------------------------------------------------------------------------
	lbl500 = "Criar Base Dados Mysql"
	lbl501 = "Nome Base de Dados"
	lbl502 = "Utilizador BD"
	lbl503 = "Password BD"
	lbl504 = "MySql Host"
	lbl505 = "Criar"
	lbl506 = "Criar Base Dados MSSQL"
	lbl507 = "MsSql Host"
	lbl508 = "Eliminar Base Dados"
	lbl509 = "Dom�nio de"
	lbl510 = "Tipo"
	lbl511 = "Prosseguir"
	lbl512 = "Cancelar"
	lbl513 = "Adicionar Host"
	lbl514 = "Adicionar novo Host"
	lbl515 = "Endere�o IP"
	lbl516 = "Porta"
	lbl517 = "Hostname"
	lbl518 = "Adicionar entrada"
	lbl519 = "Suporte ASP.NET"
	lbl520 = "Suporte ASP.NET para o dom�nio"
	lbl521 = "Activar"
	lbl522 = "Desactivar"
	lbl523 = "Suporte CGI"
	lbl524 = "Suporte Cgi para o dom�nio"
	lbl525 = "Alterar erro por defeito"
	lbl526 = "Erro No"
	lbl527 = "URL"
	lbl528 = "Definir p�gina de erro para"
	lbl529 = "Definir erros"
	lbl530 = "Alterar documentos por defeito"
	lbl531 = "Documentos por defeito"
	lbl532 = "NOTA"
	lbl533 = "Actualizar"
	lbl534 = "Alterar Password"
	lbl535 = "Alterar Password para"
	lbl536 = "Password Antiga"
	lbl537 = "Password Nova"
	lbl538 = "Confirmar Password Nova"
	lbl539 = "Definir Password"
	lbl540 = "Alterar endere�o redireccionamento do alias"
	lbl541 = "O endere�o de email n�o est� correctamente"
	lbl542 = "Email de redireccionamento em branco"
	lbl543 = "Alterar endere�o de redireccionamento para"
	lbl544 = "Nome do Alias"
	lbl545 = "Endere�o redireccionamento"
	lbl546 = "Dom�nios"
	lbl547 = "Remover dom�nios seleccionados"
	lbl548 = "Remover seleccionados"
	lbl549 = "Nome dom�nio"
	lbl550 = "Sel"
	lbl551 = "Data"
	lbl552 = "S"
	lbl553 = "P"
	lbl554 = "N�O h� dom�nios para "
	lbl555 = "Seleccione o tipo de base dados"
	lbl556 = "Base Dados SQL Server"
	lbl557 = "Base Dados MySql"
	lbl558 = "Base Dados Access"
	lbl559 = "Continuar..."
	lbl560 = "Detalhes do dom�nio"
	lbl561 = "Dom�nio"
	lbl562 = "In�cio Dom�nio"
	lbl563 = "Ir para dom�nios"
	lbl564 = "Conta de Email"
	lbl565 = "Conta de email para"
	lbl566 = "Alias de Email"
	lbl567 = "Criar Alias de Email para"
	lbl568 = "Utilizadores Ftp"
	lbl569 = "Criar utilizadores Ftp para"
	lbl570 = "Gerir Base de Dados para"
	lbl571 = "Suporte Cgi para"
	lbl572 = "Suporte ASP.NET para"
	lbl573 = "Ext. Frontpage"
	lbl574 = "Ext. Frontpage para"
	lbl575 = "Estat�sticas Web"
	lbl576 = "Estat�sticas Web para"
	lbl577 = "Proteger directoria"
	lbl578 = "Proteger directoria para"
	lbl579 = "Alterar Password"
	lbl580 = "Alterar Password para"
	lbl581 = "Gerir DSN"
	lbl582 = "Gerir DSN para"
	lbl583 = "Gerir utilizadores"
	lbl584 = "Gerir utilizadores de"
	lbl585 = "Cabe�alho do host"
	lbl586 = "Entradas do Host para"
	lbl587 = "Erro personaliz�veis"
	lbl588 = "Erro personaliz�veis para"
	lbl589 = "Documento por defeito"
	lbl590 = "Personalizar documento por defeito para"
	lbl591 = "Bem vindo"
	lbl592 = "IP atribu�do"
	lbl593 = "Nome pessoal"
	lbl594 = "Username de FTP"
	lbl595 = "Password de Painel Controlo/Utilizador FTP"
	lbl596 = "Nome da empresa"
	lbl597 = "Conta de email de pop"
	lbl598 = "Aliases de Email"
	lbl599 = "Base Dados MS SQL"
	lbl600 = "Proteger com Password"
	lbl601 = "Ext. Frontpage"
	lbl602 = "Telefone"
	lbl603 = "E-mail"
	lbl604 = "Endere�o"
	lbl605 = "Cidade"
	lbl606 = "Estado/Prov�ncia"
	lbl607 = "C�digo Postal"
	lbl608 = "Pa�s"
	lbl609 = "Editar Contar Mail"
	lbl610 = "Editar Utilizador NT"
	lbl611 = "Criar Alias de Email"
	lbl612 = "Definir Password Pasta"
	lbl613 = "Escolha um nome de uma pasta!"
	lbl614 = "O Utilizador est� em branco!"
	lbl615 = "Directorias protegidas por password"
	lbl616 = "Nome da directoria"
	lbl617 = "Utilizador"
	lbl618 = "Directorias"
	lbl619 = "Primeiro adicione utilizadores."
	lbl620 = "Definir Password"
	lbl621 = "Actualizar Extens�es FrontPage"
	lbl622 = "Extens�es Frontpage para o dom�nio"
	lbl623 = "Adicionar utilizador FTP"
	lbl624 = "Utilizador FTP por defeito"
	lbl625 = "CRIAR CONTA DE FTP"
	lbl626 = "Criar Conta FTP "
	lbl627 = "Entradas Host"
	lbl628 = "Adicionar novo cabe�alho do host"
	lbl629 = "Gerir cabe�alhos do host para o dom�nio"
	lbl630 = "Eliminar"
	lbl631 = "Desculpe n�o h� entradas para este dom�nio"
	lbl632 = "Informa��o Dom�nio"
	lbl633 = "N�vel superior"
	lbl634 = "Seleccionar endere�o IP"
	lbl635 = "OK"
	lbl636 = "Criar conta de email"
	lbl637 = "Contas de email"
	lbl638 = "Nome email"
	lbl639 = "Admin"
	lbl640 = "Criar conta"
	lbl641 = "Nome do DSN"
	lbl642 = "CRIAR DSN"
	lbl643 = "N�o conseguiu abrir a pasta"
	lbl644 = "Nome da pasta"
	lbl645 = "Pasta anterior"
	lbl646 = "Nome do servidor"
	lbl647 = "Gerir utilizadores"
	lbl648 = "Utilizador n�o pr�prio"
	lbl649 = "Utilizadores para o dom�nio"
	lbl650 = "Nome completo"
	lbl651 = "Estado dispon�vel"
	lbl652 = "Utilizador gr�tis"
	lbl653 = "Utilizado"
	lbl654 = "Criar novo utilizador para o dom�nio"
	lbl655 = "Criar utilizador"
	lbl656 = "Eliminar Alias de Email"
	lbl657 = "N�o h� alias de email para remover"
	lbl658 = "Os seguintes aliases de email v�o ser eliminados"
	lbl659 = "Eliminar DSN"
	lbl660 = "O seguinte DSN vai ser eliminado"
	lbl661 = "Eliminar utilizador FTP"
	lbl662 = "A seguinte conta FTP vai ser eliminada"
	lbl663 = "Eliminar Contas de Email"
	lbl664 = "As seguintes contas de email v�o ser eliminadas"
	lbl665 = "Eliminar Utilizadores NT"
	lbl666 = "Os seguintes utilizadores v�o ser eliminados"
	lbl667 = "Lista Base Dados"
	lbl668 = "Criou 0 base dados de "
	lbl669 = "IP Servidor"
	lbl670 = "Tipo BD"
	lbl671 = "N�o h� base dados para este dom�nio"
	lbl672 = "Criar nova base dados"
	lbl673 = "Base Dados MySql"
	lbl674 = "Base Dados MsSql"
	lbl675 = "Dom�nios para"
	lbl676 = "Novo dom�nio"
	lbl677 = "Sem dom�nios"
	lbl678 = "Actualizar ESTAT�STICAS"
	lbl679 = "estat�sticas para o dom�nio"
	lbl680 = "O endere�o IP est� atribu�do a"
	lbl681 = "Eliminar endere�os IP"
	lbl682 = "Endere�os IP v�o ser eliminados"
	lbl683 = "Gerir servidores Base Dados"
	lbl684 = "Adicionar novo servidor base dados"
	lbl685 = "Servidores existentes"
	lbl686 = "Adicionar novo servidor"
	lbl687 = "Tipo base dados"
	lbl688 = "MS Sql"
	lbl689 = "MySql"
	lbl690 = "Activo"
	lbl691 = "Desactivo"
	lbl692 = "Adicionar"
	lbl693 = "Modificar"
	lbl694 = "Servidor adicionado"
	lbl695 = "Imposs�vel adicionar servidor"
	lbl696 = "Esse servidor j� existe"
	lbl697 = "Directoria acima"
	lbl698 = "Criar novo dom�nio para"
	lbl699 = "Nome contacto"
	lbl700 = "Utilizadores FTP existentes"
	lbl701 = "Criar dom�nio"
	lbl702 = "Menu administra��o"
	lbl703 = "Gerir IP"
	lbl704 = "Adicionar IP"
	lbl705 = "Reiniciar Servidor IIS"
	lbl706 = "N�o � poss�vel reiniciar o ISS se a vers�o for inferior � 5"
	lbl707 = "Servidores Base Dados"
	lbl708 = "Reiniciar"
	lbl709 = "Recome�ar"
	lbl710 = "�"	
	lbl711 = "Ajuste A Permiss�o"
	lbl712 = "Ajuste A Permiss�o Do Dobrador"
	lbl713 = "Ajuste Escrevem A Permiss�o"
	lbl714 = "Nome do in�cio de uma sess�o do painel de controle"
	lbl715 = "Campos requeridos"
	lbl716 = "Incorpore dados novos do cliente"
	lbl717 = "Clientes"
	lbl718 = "para"
	lbl719 = "Mude A Permiss�o"
	lbl720 = "O email ali�s"
	lbl721 = "criado"
	lbl722 = "Lido"
	lbl723 = "Modifique (Escreva)"
	lbl724 = "Emita por Email"
	lbl725 = "Comece A Senha"
	lbl726 = "Selecione O Usu�rio"
	lbl727 = "O usu�rio existe j� com nome"
	lbl728 = "Use um outro nome"
	lbl729 = "Cliente Novo"
	
	
	
	'Add 8-09-2004
	'-----------------------------------
	lbl730 = "Controle o Dns"
	lbl731 = "Molde do Dns"
	lbl732 = "Adicione um registro do DNS"
	lbl733 = "Tipo Record"
	lbl734 = "Submeta "
	lbl735 = "Hospede "
	lbl736 = "Avalie"
	lbl737 = "Adicione a entrada do DNS para o recordtype 'A'"
	lbl738 = "Forne�a por favor o IP address na caixa de texto arrastando, se licen�a de u ele o espa�o em branco ent�o '&lt;ip&gt;' ser� feito exame como o defeito"
	lbl739 = "adicionam o molde do DNS"
	lbl740 = "Para tr�s ao molde"
	lbl741 = "A entrada da troca do correio para o recordtype 'MX'"
	lbl742 = "Que a prioridade seleta da troca do correio"
	lbl743 = "Adiciona a entrada conhecida de Cononical para o administrador do recordtype 'CNAME'"
	lbl744 = "Menu Do Administrador"
	lbl745 = "Molde do Dns"
	lbl746 = "suprimido"
	lbl747 = "Endere�os do IP (A)"
	lbl748 = "Usu�rios Do Correio (MX)"
	lbl749 = "Pseud�nimos (CNAME)"
	lbl750 = "Nome Real"
	lbl751 = "Vista"
	lbl752 = "� um outro nome para"
	lbl753 = "Nome"
	lbl754 = "Supress�o"
	lbl755 = "Adicione Novo"
	lbl756 = "IP Num�rico"
	lbl757 = "Mail Server"
	'-----------------------------------
	




	'Here the messages are constructed
	'----------------------------------------------------------------------------------------------
	msg1 = "N�o foi poss�vel ligar ao servidor MySQL"
	msg2 = "utilizador j� existe."
	msg3 = "Erro ao criar base dados"
	msg4 = "Base Dados criada com sucesso"
	msg5 = "Servidor n�o encontrado"
	msg6 = "Erro ao criar login"
	msg7 = "Servidor inexistente"
	msg8 = "Forne�a nome base dados"
	msg9 = "Forne�a utilizador"
	msg10 = "Utilizador Base Dados inv�lido. Apenas caracteres alfanum�ricos e num m�ximo de 15."
	msg11 = "Forne�a password"
	msg12 = "Password Base Dados inv�lida. Apenas caracteres alfanum�ricos e num m�ximo de 15."
	msg13 = "N�o est� nenhum servidor de SQL dispon�vel"
	msg14 = "Desculpe, You dont have rights to create My SQL Database"
	msg15 = "O cliente j� existe nos tblrights : "
	msg16 = "Desculpe, mas n�o tem permiss�es para criar uma base dados MS SQL"
	msg17 = "N�o h� base dados para remover"
	msg18 = "As seguintes base dados v�o ser eliminadas"
	msg19 = "Dom�nio inv�lido"
	msg20 =	"A entrada vai criar um duplicado do cabe�alho do host! Por favor escolha outro nome." 
	msg21 =	"Entrada duplicada, por favor escolha outro nome!"
	msg22 = "Entrada com sucesso!"
	msg23 =	"Documentos por defeito para o dom�nio"
	msg24 =	"A nova password n�o pode ser em branco"
	msg25 =	"As duas passwords n�o coincidem"
	msg26 =	"A sua antiga password est� incorrecta"
	msg27 =	"Password alterada"
	msg28 =	"N�o existe nenhum alias com este nome! Talvez esse registo tenha sido eliminado."
	msg29 =	"Endere�o de redireccionamento actualizado"
	msg30 =	"estado Activo"
	msg31 =	"estado Inactivo"
	msg32 =	"N�o pode criar base de dados! Atingiu o limite. Por favor contacte o seu revendedor"
	msg33 =	"J� existe uma base dados com esse nome! Escolha outro nome."
	msg34 =	"N�o pode criar alias de email! Atingiu o limite. Por favor contacte o seu revendedor"
	msg35 =	"Esse alias j� existe"
	msg36 =	"N�o pode criar um alias de FTP! Atingiu o limite. Por favor contacte o seu revendedor"
	msg37 =	"O utilizador FTP j� existe"
	msg38 =	"N�o pode criar contas de email! Atingiu o limite"
	msg39 =	"Desculpe - Esse email j� existe!"
	msg40 =	"Conta de email criada com o nome "
	msg41 =	"Utilizador j� consta da base dados!"
	msg42 =	"Novo utilizador criado!"
	msg43 =	"Entrada do host eliminada com sucesso!"
	msg44 =	"A password antiga est� em branco"
	msg45 =	"O alias de nome n�o pode estar em branco"
	msg46 =	"O utilizador FTP n�o pode estar em branco!"
	msg47 = "O Email n�o pode estar em branco"
	msg48 = "A password n�o pode estar em branco"
	msg49 = "DSN est� em branco"
	msg50 = "Escolha uma base dados"
	msg51 = "O utilizador n�o pode estar em branco"
	msg52 = "Alguns campos est�o vazios"
	msg53 = "DSN j� existe, por favor escolha outro nome"
	msg54 = "Criado um DSN"
	msg55 = "Password impr�pria"
	msg56 = "Password impr�pria"
	msg57 = "O utilizador n�o pode ficar em branco!"
	msg58 = "O primeiro nome n�o pode ficar em branco!"
	msg59 = "A password tem que estar compreendida entre 5 e 20 caracteres"
	msg60 = "alias de email eliminado"
	msg61 = "password da directoria removida"
	msg62 = "N�o h� DSN para remover"
	msg63 = "DSN's eliminados"
	msg64 = "N�o h� contas FTP para remover"
	msg65 = "Contas FTP eliminadas"
	msg66 = "N�o h� conta de email para remover"
	msg67 = "contas de email eliminadas"
	msg68 = "N�o utilizador para remover"
	msg69 = "mail alias eliminado"
	msg70 = "Suporte ASP.NET n�o pode ser activado. Talvez a ASP Net framework n�o esteja instalada no servidor"
	msg71 = "Erros personaliz�veis definidos para o dom�nio"
	msg571 = "Ext. Frontpage Activadas"
	msg572 = "Ext. Frontpage Desactivadas"
	msg73 = "A directoria j� se encontra protegida por password"
	msg74 = "Utilizador e password definidas para a directoria"
	msg75 = "Estat�sticas Activadas"
	msg76 = "Estat�sticas Desactivadas"
	msg77 = "N�o foi seleccionado nenhum endere�o IP para ser eliminado"
	msg78 = "Forne�a o IP da base dados"
	msg79 = "Apenas n�meros"
	msg80 = "O Dom�nio est� vazio"
	msg81 = "O n�mero de utilizadores FTP tem que ser pelo menos 1"
	msg82 = "Utilizador FTP em branco"
	msg83 = "Seleccione o Pa�s"
	msg84 = "Dom�nio inv�lido."
	msg85 = "Isto vai matar todos os processos e reiniciar o servidor. Tem a certeza que deseja prosseguir?"
	msg86 = "Isto vai matar todos os processos e reiniciar o IIS, tem a certeza que deseja prosseguir??!!??"
	msg87 = "N�o foi seleccionado um endere�o UP para ser eliminado"
	msg88 = "Eliminados os endere�os IP na totalidade"
	msg89 = "N�o foram eliminados endere�os IP"
	msg90 = "A permiss�o mudou sobre"
	msg91 = "O cliente e seu dom�nio s�o permitidos"
	msg92 = "O cliente e seu dom�nio s�o disabled"
	msg93 = "Pesaroso n�o h� nenhum dom�nio para o cliente selecionado, mas o status do cliente ser� mudado"
	msg94 = "Usu�rio do ftp criado"
	msg95 = "Os nomes devem ser separados com linha rupturas"
	msg96 = "Esqueceu-se de sua senha?"
	msg97 = "Se voc� se esquecer de voc� senha n�s tentaremos ajudar-lhe emitindo a para fora a seu email."
	msg98 = "Emitir a senha pelo email � insecure!"
	msg99 = "O nome do in�cio de uma sess�o � em branco"
	msg100 = "Use somente s�mbolos alfanum�ricos, do tra�o, do ponto e do underscore no in�cio de uma sess�o."
	msg542 = "Um Usu�rio Criado"
	msg101 = "N�o use cita��es, o espa�o e os car�teres nacionais do alfabeto em uma senha de password.The devem estar entre 5 e 14 car�teres e n�o devem ser o mesmo que o nome do in�cio de uma sess�o."
	msg102 = "O nome do in�cio de uma sess�o n�o � apropriado"
	msg103 = "Forne�a por favor o nome do contato"
	msg104 = "IP address atribu�do a"
	msg105 = "Os endere�os seguindo do IP ser�o suprimidos para"
	msg106 = "Os endere�os seguindo do IP n�o podem ser suprimidos para"
	msg107 = "Informa��o do cliente atualizada"
	msg108 = "Isto permitir� todos os locais para o cliente."
	msg109 = "Isto parar� todo o local de funcionar para o cliente."
	msg110 = "A senha do diret�rio removeu j�"
	msg111 = "Incorpore o nome e a senha do in�cio de uma sess�o para entrar."
	msg112 = "Suas direitas foram modificadas pelo administrator.You n�o podem alcan�ar esta p�gina"
	
	'Add 8-09-2004
	'-----------------------------------
	msg113 = "Nenhum molde do DNS seleted para o apagamento!!!"
	msg114 = "Esta entrada do mapa de endere�o existe j�"
	msg115 = "Esta entrada do nameserver existe j�"
	msg116 = "Esta entrada do mailexchange existe j�"
	msg117 = "Esta entrada conhecida de Cononical existe j�"
	msg118 = "Entrada do DNS adicionada com sucesso para o ADMIN"
	msg119 = "A entrada do DNS adicionou com sucesso para o reseller"
	msg120 = "Identifica��o do reseller n�o ajustada!!!"
	msg121 = "Rank"
	msg122 = "Voc� deve selecionar ao menos um ali�s para suprimir"
	msg123 = "Forne�a por favor o dom�nio real!!!"
	msg124 = "Forne�a por favor o valor do anfitri�o!!!"
	msg125 = "Selecionado entried suprimido"
	msg126 = "Nenhumas entradas selecionadas para o apagamento"
	msg127 = "Modalidade inv�lida"
	msg128 = "O anfitri�o existe j�"
	msg129 = "O anfitri�o com o mesmo mail server existe j�"
	msg130 = "O Rank n�o � num�rico"
	msg131 = "Usu�rios do correio modificados"
	msg132 = "O nome de anfitri�o � usado j� por alguma entrada!!!"
	msg133 = "O IP address n�o est� correto"
	msg134 = "O IP address modificou"
	msg135 = "O nome de anfitri�o � em branco!!!"
	msg136 = "Voc� deve selecionar ao menos um IP para suprimir"
	msg137 = "Voc� deve fornecer o IP"
	msg138 = "O IP address deve estar correto"
	msg139 = "Voc� deve selecionar ao menos um MX Record para suprimir"
	msg140 = "Voc� deve fornecer um mail server"
	msg141 = "Voc� deve fornecer o Rank"
	msg142 = "O Rank deve ser num�rico"
	msg143 = "IP address adicionado "
	msg144 = "O IP address n�o poderia adicionado "
	msg145 = "Adicionado ali�s"
	msg146 = "O pseud�nimo n�o poderia adicionado "
	msg147 = "Endere�o do mail server adicionado"
	msg148 = "O mail server n�o poderia adicionado"
	msg149 = "Users deleted"
	'-----------------------------------



	'----------------------------------------------------------------------------------------------
	msgAddClient="Um cliente adicionado com sucesso"
	msgclientdis="Estado do cliente Inactivo"
	msgclientsen="Estado do cliente Activo"
	msgclientpref="Prefer�ncias definidas para o cliente"
	msgipadd="Endere�o IP adicionado com sucesso!"
	msgchooseip="Por favor escolha outro endere�o IP. Isto vai criar uma entrada duplicada!"
	msgoldpwd="A password antiga est� incorrecta"
	msgadminpwd="Password do Admin alterada"
	msgclientseldel="N�o seleccionou nenhum cliente para ser eliminado"
	msglogin="Introduza o seu login.\n"
	msgpwd="Introduza a sua password.\n"
	msghloginpwd="Introduza o login e a password.\n"
	msgproblem="Ocorreu um problema ao criar o seu dom�nio, contacte o administrador"
	msgsory="Desculpe o cliente n�o tem contas de FTP suficientes."
	msgsorry="Desculpe o cliente n�o tem contas de email suficientes."
	msgsorry1="Desculpe o cliente n�o tem alias de email suficientes."
	msgsorry2="Desculpe o cliente n�o tem suficientes Base de Dados"
	msgftperror="O utilizador FTP j� existe! Utilize outro nome"
	msgftperror1="Utilizador FTP j� utilizador. Por favor escolha outro nome"
	msgdomainerror="Dom�nio j� existente! Por favor escolha outro nome"
	msgdomainadded="Dom�nio adicionado com sucesso"
	msgclientadded="cliente eliminado com sucesso"
	msgdomaindel="Um ou mais dom�nios n�o podem ser eliminados"
	msgdomainde11="dom�nios eliminados com sucesso"
	msgnodomsel="Nenhum dom�nio seleccionado"
	msgupdatedomain="Dom�nio actualizado com sucesso"
	msgdomaindel1 = "O Dom�nio Suprimiu"

	'-------------------------------------------------------------------------------

	lblLogin="In�cio de uma sess�o"
	lblPass="Senha"
	lblDatabases = "Base de Dados"
	lblback = "Voltar"
	lblAddClient="Adicionar cliente"
	lblmenu="Menu"
	lblNewDomain="Novo dom�nio "
	lblLimits="Limites"
	lblContactInfo="Informa��es Contacto"
	lblPreference="Prefer�ncias"
	lblIPPool="IP Pool"
	lblclientcontinfo="Informa��es Contacto do Cliente"
	lblstatusname="nome estado"
	lblclientinfo="Informa��o para o cliente"
	lblup1level="Um n�vel acima"
	lbluplevel="N�vel superior"
	lblclientname="Nome do cliente:"
	lblassignedIP="Endere�o IP atribu�do:"
	lblpersonalname="Nome pessoal:"
	lblftpusername="Utilizador FTP:"
	lblcpftpuserpasswd="Password Painel Controlo/Utilizador FTP:"
	lblcompanyname="Empresa:"
	lblphone="Telefone:"
	lblemail="E-mail:"
	lbladdress="Morada:"
	lblcity="Localidade:"
	lblstate="Distrito:"
	lblzipcode="C�digo Postal:"
	lblCountry="Pa�s:"
	lblUpdate="Actualizar"
	lblOk="Ok"
	lblclientlimits="Limites do Cliente"
	lblFtpUsers="Utilizadores FTP:"
	lblSqlDatabases="Base Dados SQL:"
	lblMySqlServer="Servidor MySql"
	lblEmailAlias="Alias Email"
	lblSetLimits="Definir Limites"
	lblCancel="Cancelar"
	lblPopmailAccount="Conta de email pop:"
	lblSetclient="Definir cliente"
	lblClientPreferences="Prefer�ncias do cliente"
	lblClient="Cliente"
	lblUploadLogo="Upload Logo"
	lblSkins="Skins"
	lblNewClient="Novo Cliente"
	lblLogout="Sair"
	lblSetclient="Definir Cliente"
	lblMySqlDatabases="Base Dados MySql:"
	lblSetClientLimits="Definir limites cliente"
	lblNewDomainfor="Novo dom�nio para"
	lblContactInfofor="Informa��es de contacto para"
	lblPreferencefor="Prefer�ncias para"
	lblSetClientPreferences="Definir prefer�ncias cliente"
	lblPreferencesforclient="Prefer�ncias do cliente"
	lblUpdateClientInformation="Actualizar informa��es cliente"
	lblFTPPassword="Password de FTP:"
	lblRemoveIp="Remover Ip"
	lblRemoveIpAddress="Remover endere�o IP"
	lblAddnewIPaddress="Adicionar novo endere�o IP"
	lblthere="S� pode haver um"
	lblNewIP="Novo endere�o IP"
	lblIPType="Tipo de IP"
	lblShared="Partilhado"
	lblExclusive="Exclusivo"
	lbladdip="Adicionar IP"
	lbladmininfo="Informa��es sobre o administrador"
	lblperiodicmails="Desejo receber emails da SWsoft, Inc. com novidades de produtos, descontos, e mais."
	lblipassignedto="O endere�o IP atribu�do a "
	lblRemoveSelected="Remover o seleccionado"
	lblremoveselip="Remover IP seleccionado para"
	lblselectip="Seleccione o endere�o IP"
	lblAssign="Atribuir"
	lblAssignIP="Atribuir IP"
	lblchadminpwd="Alterar password de admin"
	lblOldPassword="Password Antiga"
	lblNewPassword="Nova Password"
	lblreqfields="Campos obrigat�rios."
	lblChangePassword="Alterar Password"
	lblChange="Alterar"
	lbldelclient="Clientes v�o ser eliminados"
	lblProceed="Proceder"
	lblcontactname="Nome contacto:"
	lblcppasswd="Password Painel Controlo:"
	lblconfirmpwd="Confirmar Password:"
	lblFax="Fax:"
	lblCreate="Criar"
	lblinterlang="Idioma do Interface:"
	lblselcountry="Seleccionar Pa�s"
	lblwill="ser� eliminado!"
	lbldel="Eliminar"
	lblThedomain="O dom�nio"
	lbldomaininfo="Informa��o Dom�nio"
	lblAssigned="Atribu�do"
	lblPersonal="Pessoal"
	lblmssqldb="Base Dados MS SQL:"
	lblpwdprotect="Proteger com Password:"
	lblcgisupport="Activar suporte CGI:"
	lblfrontpage="Activar Ext. FrontPage:"
	lblaspsupport="Suporte ASP.Net:"
	lblwebstart="Web:"
	lblStatus="Estado"
	lblnodomain="Sem dom�nios"
	lblDomains="Dom�nios"
	lblAssignedIP="IP atribu�do"
	lblLimitsfor="Limites para"
	lblalldomains="Todos os dom�nios"
	lblServer="Servidor"
%>
