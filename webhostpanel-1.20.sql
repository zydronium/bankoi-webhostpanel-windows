# MySQL-Front 3.0


# Host: 192.168.0.2    Database: webhostpanel
# ------------------------------------------------------
# Server version 4.0.20a-nt

#
# Table structure for table cp_db_all
#

CREATE TABLE `cp_db_all` (
  `id` int(11) NOT NULL auto_increment,
  `domain_id` int(11) default NULL,
  `dbname` varchar(50) default NULL,
  `dbpassword` varchar(50) default NULL,
  `dbuser` varchar(50) default NULL,
  `type` varchar(50) default NULL,
  `dbserver` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;


#
# Dumping data for table cp_db_all
#


#
# Table structure for table cp_db_servers
#

CREATE TABLE `cp_db_servers` (
  `id` int(11) NOT NULL auto_increment,
  `serverip` varchar(100) default NULL,
  `serveruser` varchar(50) default NULL,
  `serverpassword` varchar(50) default NULL,
  `servertype` varchar(10) default NULL,
  `status` int(11) default NULL,
  `serverport` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;

#
# Table structure for table dns_data
#

CREATE TABLE `dns_data` (
  `domainid` int(11) NOT NULL default '0',
  `domain` varchar(128) NOT NULL default '',
  `host` varchar(64) NOT NULL default '',
  `modifier` varchar(128) NOT NULL default '',
  `rside` varchar(128) NOT NULL default '',
  `rectype` enum('NS','A','CNAME','MX') NOT NULL default 'A',
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;


#
# Dumping data for table dns_data
#


#
# Table structure for table manageusers
#

CREATE TABLE `manageusers` (
  `domainid` int(6) unsigned NOT NULL default '0',
  `username` varchar(30) NOT NULL default '0',
  `password` varchar(30) NOT NULL default '0',
  `type` enum('F','A') NOT NULL default 'F',
  `name` varchar(30) NOT NULL default ''
) TYPE=MyISAM;


#
# Dumping data for table manageusers
#


#
# Table structure for table tblcontactinfo
#

CREATE TABLE `tblcontactinfo` (
  `companyname` varchar(60) default NULL,
  `contactname` varchar(60) NOT NULL default '0',
  `cploginname` varchar(30) NOT NULL default '',
  `cppassword` varchar(30) NOT NULL default '',
  `phone` varchar(15) default NULL,
  `email` varchar(60) default NULL,
  `address` varchar(50) default NULL,
  `city` varchar(50) default NULL,
  `state` varchar(50) default NULL,
  `zipcode` varchar(15) default NULL,
  `country` char(2) default NULL,
  `id` int(6) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;


#
# Dumping data for table tblcontactinfo
#

#
# Table structure for table tblcountry
#

CREATE TABLE `tblcountry` (
  `code` varchar(4) default '0',
  `countryname` varchar(50) default NULL
) TYPE=MyISAM;


#
# Dumping data for table tblcountry
#

INSERT INTO `tblcountry` VALUES ('AF','Afghanistan');
INSERT INTO `tblcountry` VALUES ('AL','Albania');
INSERT INTO `tblcountry` VALUES ('DZ','Algeria');
INSERT INTO `tblcountry` VALUES ('AS','American Samoa');
INSERT INTO `tblcountry` VALUES ('AD','Andorra');
INSERT INTO `tblcountry` VALUES ('AO','Angola');
INSERT INTO `tblcountry` VALUES ('AI','Anguilla');
INSERT INTO `tblcountry` VALUES ('AQ','Antarctica');
INSERT INTO `tblcountry` VALUES ('AG','Antigua and Barbuda');
INSERT INTO `tblcountry` VALUES ('AR','Argentina');
INSERT INTO `tblcountry` VALUES ('AM','Armenia');
INSERT INTO `tblcountry` VALUES ('AW','Aruba');
INSERT INTO `tblcountry` VALUES ('AU','Australia');
INSERT INTO `tblcountry` VALUES ('AT','Austria');
INSERT INTO `tblcountry` VALUES ('AZ','Azerbaidjan');
INSERT INTO `tblcountry` VALUES ('BS','Bahamas');
INSERT INTO `tblcountry` VALUES ('BH','Bahrain');
INSERT INTO `tblcountry` VALUES ('BD','Banglades');
INSERT INTO `tblcountry` VALUES ('BB','Barbados');
INSERT INTO `tblcountry` VALUES ('BY','Belarus');
INSERT INTO `tblcountry` VALUES ('BE','Belgium');
INSERT INTO `tblcountry` VALUES ('BZ','Belize');
INSERT INTO `tblcountry` VALUES ('BJ','Benin');
INSERT INTO `tblcountry` VALUES ('BM','Bermuda');
INSERT INTO `tblcountry` VALUES ('BO','Bolivia');
INSERT INTO `tblcountry` VALUES ('BA','Bosnia-Herzegovina');
INSERT INTO `tblcountry` VALUES ('BW','Botswana');
INSERT INTO `tblcountry` VALUES ('BV','Bouvet Island');
INSERT INTO `tblcountry` VALUES ('BR','Brazil');
INSERT INTO `tblcountry` VALUES ('IO','British Indian O. Terr.');
INSERT INTO `tblcountry` VALUES ('BN','Brunei Darussalam');
INSERT INTO `tblcountry` VALUES ('BG','Bulgaria');
INSERT INTO `tblcountry` VALUES ('BF','Burkina Faso');
INSERT INTO `tblcountry` VALUES ('BI','Burundi');
INSERT INTO `tblcountry` VALUES ('BP','Buthan');
INSERT INTO `tblcountry` VALUES ('KH','Cambodia');
INSERT INTO `tblcountry` VALUES ('CM','Cameroon');
INSERT INTO `tblcountry` VALUES ('CA','Canada');
INSERT INTO `tblcountry` VALUES ('CV','Cape Verde');
INSERT INTO `tblcountry` VALUES ('KY','Cayman Islands');
INSERT INTO `tblcountry` VALUES ('CF','Central African Rep.');
INSERT INTO `tblcountry` VALUES ('TD','Chad');
INSERT INTO `tblcountry` VALUES ('CL','Chile');
INSERT INTO `tblcountry` VALUES ('CN','China');
INSERT INTO `tblcountry` VALUES ('CX','Christmas Island');
INSERT INTO `tblcountry` VALUES ('CC','Cocos (Keeling) Isl.');
INSERT INTO `tblcountry` VALUES ('CO','Colombia');
INSERT INTO `tblcountry` VALUES ('KM','Comoros');
INSERT INTO `tblcountry` VALUES ('CG','Congo');
INSERT INTO `tblcountry` VALUES ('CK','Cook Islands');
INSERT INTO `tblcountry` VALUES ('CR','Costa Rica');
INSERT INTO `tblcountry` VALUES ('HR','Croatia');
INSERT INTO `tblcountry` VALUES ('CU','Cuba');
INSERT INTO `tblcountry` VALUES ('CY','Cyprus');
INSERT INTO `tblcountry` VALUES ('CZ','Czech Republic');
INSERT INTO `tblcountry` VALUES ('CS','Czechoslovakia');
INSERT INTO `tblcountry` VALUES ('DK','Denmark');
INSERT INTO `tblcountry` VALUES ('DJ','Djibouti');
INSERT INTO `tblcountry` VALUES ('DM','Dominica');
INSERT INTO `tblcountry` VALUES ('DO','Dominican Republic');
INSERT INTO `tblcountry` VALUES ('TP','East Timor');
INSERT INTO `tblcountry` VALUES ('EC','Ecuador');
INSERT INTO `tblcountry` VALUES ('EG','Egypt');
INSERT INTO `tblcountry` VALUES ('SV','El Salvador');
INSERT INTO `tblcountry` VALUES ('GQ','Equatorial Guinea');
INSERT INTO `tblcountry` VALUES ('EE','Estonia');
INSERT INTO `tblcountry` VALUES ('ET','Ethiopia');
INSERT INTO `tblcountry` VALUES ('FK','Falkland Isl.(Malvinas)');
INSERT INTO `tblcountry` VALUES ('FO','Faroe Islands');
INSERT INTO `tblcountry` VALUES ('FJ','Fiji');
INSERT INTO `tblcountry` VALUES ('FI','Finland');
INSERT INTO `tblcountry` VALUES ('FR','France');
INSERT INTO `tblcountry` VALUES ('FX','France (European Ter.)');
INSERT INTO `tblcountry` VALUES ('TF','French Southern Terr.');
INSERT INTO `tblcountry` VALUES ('GA','Gabon');
INSERT INTO `tblcountry` VALUES ('GM','Gambia');
INSERT INTO `tblcountry` VALUES ('GE','Georgia');
INSERT INTO `tblcountry` VALUES ('DE','Germany');
INSERT INTO `tblcountry` VALUES ('GH','Ghana');
INSERT INTO `tblcountry` VALUES ('GI','Gibraltar');
INSERT INTO `tblcountry` VALUES ('GR','Greece');
INSERT INTO `tblcountry` VALUES ('GL','Greenland');
INSERT INTO `tblcountry` VALUES ('GD','Grenada');
INSERT INTO `tblcountry` VALUES ('GP','Guadeloupe (Fr.)');
INSERT INTO `tblcountry` VALUES ('GU','Guam (US)');
INSERT INTO `tblcountry` VALUES ('GT','Guatemala');
INSERT INTO `tblcountry` VALUES ('GN','Guinea');
INSERT INTO `tblcountry` VALUES ('GW','Guinea Bissau');
INSERT INTO `tblcountry` VALUES ('GY','Guyana');
INSERT INTO `tblcountry` VALUES ('GF','Guyana (Fr.)');
INSERT INTO `tblcountry` VALUES ('HT','Haiti');
INSERT INTO `tblcountry` VALUES ('HM','Heard & McDonald Isl.');
INSERT INTO `tblcountry` VALUES ('HN','Honduras');
INSERT INTO `tblcountry` VALUES ('HU','Hong Kong');
INSERT INTO `tblcountry` VALUES ('HU','Hungary');
INSERT INTO `tblcountry` VALUES ('IS','Iceland');
INSERT INTO `tblcountry` VALUES ('IN','India');
INSERT INTO `tblcountry` VALUES ('ID','Indonesia');
INSERT INTO `tblcountry` VALUES ('IR','Iran');
INSERT INTO `tblcountry` VALUES ('IQ','Iraq');
INSERT INTO `tblcountry` VALUES ('IE','Ireland');
INSERT INTO `tblcountry` VALUES ('IL','Israel');
INSERT INTO `tblcountry` VALUES ('IT','Italy');
INSERT INTO `tblcountry` VALUES ('CI','Ivory Coast');
INSERT INTO `tblcountry` VALUES ('JM','Jamaica');
INSERT INTO `tblcountry` VALUES ('JP','Japan');
INSERT INTO `tblcountry` VALUES ('JO','Jordan');
INSERT INTO `tblcountry` VALUES ('KZ','Kazakhstan');
INSERT INTO `tblcountry` VALUES ('KE','Kenya');
INSERT INTO `tblcountry` VALUES ('KG','Kyrgyzstan');
INSERT INTO `tblcountry` VALUES ('KI','Kiribati');
INSERT INTO `tblcountry` VALUES ('KP','Korea (North)');
INSERT INTO `tblcountry` VALUES ('KR','Korea (South)');
INSERT INTO `tblcountry` VALUES ('KW','Kuwait');
INSERT INTO `tblcountry` VALUES ('LA','Laos');
INSERT INTO `tblcountry` VALUES ('LV','Latvia');
INSERT INTO `tblcountry` VALUES ('LB','Lebanon');
INSERT INTO `tblcountry` VALUES ('LS','Lesotho');
INSERT INTO `tblcountry` VALUES ('LR','Liberia');
INSERT INTO `tblcountry` VALUES ('LY','Libya');
INSERT INTO `tblcountry` VALUES ('LI','Liechtenstein');
INSERT INTO `tblcountry` VALUES ('LT','Lithuania');
INSERT INTO `tblcountry` VALUES ('LU','Luxembourg');
INSERT INTO `tblcountry` VALUES ('MO','Macau');
INSERT INTO `tblcountry` VALUES ('MG','Madagascar');
INSERT INTO `tblcountry` VALUES ('MW','Malawi');
INSERT INTO `tblcountry` VALUES ('MY','Malaysia');
INSERT INTO `tblcountry` VALUES ('MV','Maldives');
INSERT INTO `tblcountry` VALUES ('ML','Mali');
INSERT INTO `tblcountry` VALUES ('MT','Malta');
INSERT INTO `tblcountry` VALUES ('MH','Marshall Islands');
INSERT INTO `tblcountry` VALUES ('MQ','Martinique (Fr.)');
INSERT INTO `tblcountry` VALUES ('MR','Mauritania');
INSERT INTO `tblcountry` VALUES ('MU','Mauritius');
INSERT INTO `tblcountry` VALUES ('MX','Mexico');
INSERT INTO `tblcountry` VALUES ('FM','Micronesia');
INSERT INTO `tblcountry` VALUES ('MD','Moldavia');
INSERT INTO `tblcountry` VALUES ('MC','Monaco');
INSERT INTO `tblcountry` VALUES ('MN','Mongolia');
INSERT INTO `tblcountry` VALUES ('MS','Montserrat');
INSERT INTO `tblcountry` VALUES ('MC','Morocco');
INSERT INTO `tblcountry` VALUES ('MZ','Mozambique');
INSERT INTO `tblcountry` VALUES ('MM','Myanmar');
INSERT INTO `tblcountry` VALUES ('NA','Namibia');
INSERT INTO `tblcountry` VALUES ('NR','Nauru');
INSERT INTO `tblcountry` VALUES ('NP','Nepal');
INSERT INTO `tblcountry` VALUES ('AN','Netherland Antilles');
INSERT INTO `tblcountry` VALUES ('NL','Netherlands');
INSERT INTO `tblcountry` VALUES ('NT','Neutral Zone');
INSERT INTO `tblcountry` VALUES ('NC','New Caledonia (Fr.)');
INSERT INTO `tblcountry` VALUES ('NZ','New Zealand');
INSERT INTO `tblcountry` VALUES ('NI','Nicaragua');
INSERT INTO `tblcountry` VALUES ('NE','Niger');
INSERT INTO `tblcountry` VALUES ('NG','Nigeria');
INSERT INTO `tblcountry` VALUES ('NU','Niue');
INSERT INTO `tblcountry` VALUES ('NF','Norfolk Island');
INSERT INTO `tblcountry` VALUES ('MP','Northern Mariana Isl.');
INSERT INTO `tblcountry` VALUES ('NO','Norway');
INSERT INTO `tblcountry` VALUES ('OM','Oman');
INSERT INTO `tblcountry` VALUES ('PK','Pakistan');
INSERT INTO `tblcountry` VALUES ('PW','Palau');
INSERT INTO `tblcountry` VALUES ('PA','Panama');
INSERT INTO `tblcountry` VALUES ('PG','Papua New');
INSERT INTO `tblcountry` VALUES ('PY','Paraguay');
INSERT INTO `tblcountry` VALUES ('PE','Peru');
INSERT INTO `tblcountry` VALUES ('PH','Philippines');
INSERT INTO `tblcountry` VALUES ('PN','Pitcairn');
INSERT INTO `tblcountry` VALUES ('PL','Poland');
INSERT INTO `tblcountry` VALUES ('PF','Polynesia (Fr.)');
INSERT INTO `tblcountry` VALUES ('PT','Portugal');
INSERT INTO `tblcountry` VALUES ('PR','Puerto Rico (US)');
INSERT INTO `tblcountry` VALUES ('QA','Qatar');
INSERT INTO `tblcountry` VALUES ('RE','Reunion (Fr.)');
INSERT INTO `tblcountry` VALUES ('RO','Romania');
INSERT INTO `tblcountry` VALUES ('RU','Russian Federation');
INSERT INTO `tblcountry` VALUES ('RW','Rwanda');
INSERT INTO `tblcountry` VALUES ('LC','Saint Lucia');
INSERT INTO `tblcountry` VALUES ('WS','Samoa');
INSERT INTO `tblcountry` VALUES ('SM','San Marino');
INSERT INTO `tblcountry` VALUES ('SA','Saudi Arabia');
INSERT INTO `tblcountry` VALUES ('SN','Senegal');
INSERT INTO `tblcountry` VALUES ('SC','Seychelles');
INSERT INTO `tblcountry` VALUES ('SL','Sierra Leone');
INSERT INTO `tblcountry` VALUES ('SG','Singapore');
INSERT INTO `tblcountry` VALUES ('SK','Slovak Republic');
INSERT INTO `tblcountry` VALUES ('SI','Slovenia');
INSERT INTO `tblcountry` VALUES ('SB','Solomon Islands');
INSERT INTO `tblcountry` VALUES ('SO','Somalia');
INSERT INTO `tblcountry` VALUES ('ZA','South Africa');
INSERT INTO `tblcountry` VALUES ('SU','Soviet Union');
INSERT INTO `tblcountry` VALUES ('ES','Spain');
INSERT INTO `tblcountry` VALUES ('LK','Sri Lanka');
INSERT INTO `tblcountry` VALUES ('SH','St. Helena');
INSERT INTO `tblcountry` VALUES ('PM','St. Pierre & Miquelon');
INSERT INTO `tblcountry` VALUES ('ST','St. Tome and Principe');
INSERT INTO `tblcountry` VALUES ('KN','St.Kitts Nevis Anguilla');
INSERT INTO `tblcountry` VALUES ('VC','St.Vincent & Grenadines');
INSERT INTO `tblcountry` VALUES ('SD','Sudan');
INSERT INTO `tblcountry` VALUES ('SR','Suriname');
INSERT INTO `tblcountry` VALUES ('SJ','Svalbard & Jan Mayen Is');
INSERT INTO `tblcountry` VALUES ('SZ','Swaziland');
INSERT INTO `tblcountry` VALUES ('SE','Sweden');
INSERT INTO `tblcountry` VALUES ('CH','Switzerland');
INSERT INTO `tblcountry` VALUES ('SY','Syria');
INSERT INTO `tblcountry` VALUES ('TJ','Tadjikistan');
INSERT INTO `tblcountry` VALUES ('TW','Taiwan');
INSERT INTO `tblcountry` VALUES ('TZ','Tanzania');
INSERT INTO `tblcountry` VALUES ('TH','Thailand');
INSERT INTO `tblcountry` VALUES ('TG','Togo');
INSERT INTO `tblcountry` VALUES ('TK','Tokelau');
INSERT INTO `tblcountry` VALUES ('TO','Tonga');
INSERT INTO `tblcountry` VALUES ('TT','Trinidad & Tobago');
INSERT INTO `tblcountry` VALUES ('TN','Tunisia');
INSERT INTO `tblcountry` VALUES ('TR','Turkey');
INSERT INTO `tblcountry` VALUES ('TM','Turkmenistan');
INSERT INTO `tblcountry` VALUES ('TC','Turks & Caicos Islands');
INSERT INTO `tblcountry` VALUES ('TV','Tuvalu');
INSERT INTO `tblcountry` VALUES ('UM','US Minor outlying Isl.');
INSERT INTO `tblcountry` VALUES ('UG','Uganda');
INSERT INTO `tblcountry` VALUES ('UA','Ukraine');
INSERT INTO `tblcountry` VALUES ('AE','United Arab Emirates');
INSERT INTO `tblcountry` VALUES ('GB','United Kingdom');
INSERT INTO `tblcountry` VALUES ('US','United States');
INSERT INTO `tblcountry` VALUES ('UY','Uruguay');
INSERT INTO `tblcountry` VALUES ('UZ','Uzbekistan');
INSERT INTO `tblcountry` VALUES ('VU','Vanuatu');
INSERT INTO `tblcountry` VALUES ('VA','Vatican City State');
INSERT INTO `tblcountry` VALUES ('VE','Venezuela');
INSERT INTO `tblcountry` VALUES ('VN','Vietnam');
INSERT INTO `tblcountry` VALUES ('VG','Virgin Islands (British)');
INSERT INTO `tblcountry` VALUES ('VI','Virgin Islands (US)');
INSERT INTO `tblcountry` VALUES ('WF','Wallis & Futuna Islands');
INSERT INTO `tblcountry` VALUES ('EH','Western Sahara');
INSERT INTO `tblcountry` VALUES ('YE','Yemen');
INSERT INTO `tblcountry` VALUES ('YU','Yugoslavia');
INSERT INTO `tblcountry` VALUES ('ZR','Zaire');
INSERT INTO `tblcountry` VALUES ('ZM','Zambia');
INSERT INTO `tblcountry` VALUES ('ZW','Zimbabwe');

#
# Table structure for table tbldatabase
#

CREATE TABLE `tbldatabase` (
  `domainid` int(6) default '0',
  `databasename` varchar(30) default NULL,
  `dbusername` varchar(30) NOT NULL default '',
  `dbpassword` varchar(30) NOT NULL default '',
  `dbtype` varchar(20) default NULL
) TYPE=MyISAM;


#
# Dumping data for table tbldatabase
#


#
# Table structure for table tbldirpass
#

CREATE TABLE `tbldirpass` (
  `Id` int(10) unsigned NOT NULL default '0',
  `domainname` varchar(60) NOT NULL default '',
  `dirname` varchar(30) default NULL,
  `username` varchar(25) NOT NULL default '',
   fulldirname` varchar(255) default NULL
) TYPE=MyISAM;


#
# Dumping data for table tbldirpass
#


#
# Table structure for table tbldnstemplate
#

CREATE TABLE `tbldnstemplate` (
  `id` int(6) unsigned NOT NULL auto_increment,
  `host` varchar(255) NOT NULL default '',
  `recordtype` varchar(255) NOT NULL default '',
  `value` varchar(255) NOT NULL default '',
  `resellerid` int(10) NOT NULL default '0',
  `mxpref` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;


#
# Dumping data for table tbldnstemplate
#

INSERT INTO `tbldnstemplate` VALUES (NULL,'ftp.<domain>.','CNAME','<domain>.',0,0);
INSERT INTO `tbldnstemplate` VALUES (NULL,'<domain>.','MX','mail.<domain>.',0,10);
INSERT INTO `tbldnstemplate` VALUES (NULL,'<domain>','A','<ip>',0,0);
INSERT INTO `tbldnstemplate` VALUES (NULL,'mail.<domain>','A','<ip>',0,0);
INSERT INTO `tbldnstemplate` VALUES (NULL,'www.<domain>','A','<ip>',0,0);
INSERT INTO `tbldnstemplate` VALUES (NULL,'webmail.<domain>','A','<ip>',0,0);
INSERT INTO `tbldnstemplate` VALUES (NULL,'control.<domain>','A','<ip>',0,0);


#
# Table structure for table tbldomain
#

CREATE TABLE `tbldomain` (
  `domainid` int(6) NOT NULL default '0',
  `domainname` varchar(255) NOT NULL default '',
  `resellerid` varchar(10) NOT NULL default '',
  `ipaddress` varchar(15) NOT NULL default '',
  `hdspace` int(5) NOT NULL default '0',
  `skinname` varchar(30) default 'default',
  PRIMARY KEY  (`domainid`)
) TYPE=MyISAM;


#
# Dumping data for table tbldomain
#


#
# Table structure for table tbldomainpref
#

CREATE TABLE `tbldomainpref` (
  `domainid` int(6) unsigned default '0',
  `pwdprotect` enum('Y','N') default 'N',
  `cgisupport` enum('Y','N') default 'N',
  `frontpageext` enum('Y','N') default 'N',
  `aspdotnetsupport` enum('Y','N') default 'N',
  `webstart` enum('Y','N') default 'N'
) TYPE=MyISAM;


#
# Dumping data for table tbldomainpref
#


#
# Table structure for table tbldsn
#

CREATE TABLE `tbldsn` (
  `id` int(6) unsigned NOT NULL default '0',
  `dsnname` varchar(30) default '0',
  `username` varchar(30) default '0',
  `password` varchar(20) default '0',
  `databasename` varchar(255) default '0',
  `dbtype` varchar(20) NOT NULL default ''
) TYPE=MyISAM;


#
# Dumping data for table tbldsn
#


#
# Table structure for table tblftpinfo
#

CREATE TABLE `tblftpinfo` (
  `domainid` int(6) NOT NULL default '0',
  `ftpusername` varchar(30) default NULL,
  `ftppassword` varchar(30) default NULL,
  `type` char(1) default NULL
) TYPE=MyISAM;



#
# Table structure for table tblhostheader
#

CREATE TABLE `tblhostheader` (
  `domainid` int(1) NOT NULL default '0',
  `hostheaderid` int(4) NOT NULL auto_increment,
  `hostheader` varchar(255) default NULL,
  `isdefault` tinyint(4) default NULL,
  PRIMARY KEY  (`hostheaderid`)
) TYPE=MyISAM;


#
# Dumping data for table tblhostheader
#


#
# Table structure for table tblloginmaster
#

CREATE TABLE `tblloginmaster` (
  `username` varchar(60) NOT NULL default '',
  `password` varchar(30) NOT NULL default '',
  `usertype` char(1) NOT NULL default '',
  `status` char(1) NOT NULL default '1',
  `id` int(6) NOT NULL default '0',
  `regdate` date default '2004-03-08',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;


#
# Dumping data for table tblloginmaster
#

INSERT INTO `tblloginmaster` VALUES ('admin','admin','a','1',1,'2004-06-24');

#
# Table structure for table tblmailaddress
#

CREATE TABLE `tblmailaddress` (
  `id` int(11) NOT NULL auto_increment,
  `domainname` varchar(255) default NULL,
  `domainid` int(11) default NULL,
  `mailname` varchar(255) default NULL,
  `mailpass` varchar(255) default NULL,
  `isalias` tinyint(4) default NULL,
  `redirectadd` varchar(255) default NULL,
  `actiontype` tinyint(4) default NULL,
  `processed` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;


#
# Dumping data for table tblmailaddress
#


#
# Table structure for table tblmaildomain
#

CREATE TABLE `tblmaildomain` (
  `id` int(11) NOT NULL default '0',
  `domainname` varchar(255) default NULL,
  `actiontype` tinyint(4) default NULL
) TYPE=MyISAM;


#
# Dumping data for table tblmaildomain
#



#
# Table structure for table tblreseller
#

CREATE TABLE `tblreseller` (
  `resellerid` int(6) NOT NULL default '0',
  `limit` int(5) default '0',
  `logo` varchar(30) default NULL,
  `supportlink` varchar(30) default NULL,
  `skinname` varchar(100) NOT NULL default 'default',
  PRIMARY KEY  (`resellerid`)
) TYPE=MyISAM;


#
# Dumping data for table tblreseller
#


#
# Table structure for table tblresellerip
#

CREATE TABLE `tblresellerip` (
  `resellerid` varchar(10) default '0',
  `ipaddress` int(6) unsigned default '0'
) TYPE=MyISAM;


#
# Dumping data for table tblresellerip
#

#
# Table structure for table tblrights
#

CREATE TABLE `tblrights` (
  `id` int(6) NOT NULL default '0',
  `popmailaccount` int(5) default NULL,
  `ftpusers` int(5) default NULL,
  `sqldatabase` int(5) default NULL,
  `pwdprotectdir` enum('Y','N') default 'N',
  `cgisupport` enum('Y','N') default 'N',
  `frontpageext` enum('Y','N') default 'N',
  `aspdotnetsupport` enum('Y','N') default 'N',
  `webstats` enum('Y','N') default 'N',
  `emailalias` int(5) unsigned default NULL,
  `mysql_server` int(4) unsigned zerofill NOT NULL default '0000',
  `mssql_server` int(4) unsigned zerofill NOT NULL default '0000',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;


#
# Dumping data for table tblrights
#

#
# Table structure for table tblserverip
#

CREATE TABLE `tblserverip` (
  `Id` int(6) unsigned NOT NULL auto_increment,
  `ipaddress` varchar(15) NOT NULL default '',
  `iptype` varchar(20) NOT NULL default '',
  `isavailable` enum('Y','N') default 'Y',
  PRIMARY KEY  (`Id`)
) TYPE=MyISAM;


#
# Dumping data for table tblserverip
#
