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
INSERT INTO `tbldnstemplate` VALUES (NULL,'<domain>.','A','<ip>',0,0);
INSERT INTO `tbldnstemplate` VALUES (NULL,'mail.<domain>.','A','<ip>',0,0);
INSERT INTO `tbldnstemplate` VALUES (NULL,'www.<domain>.','A','<ip>',0,0);
INSERT INTO `tbldnstemplate` VALUES (NULL,'webmail.<domain>.','A','<ip>',0,0);
INSERT INTO `tbldnstemplate` VALUES (NULL,'control.<domain>.','A','<ip>',0,0);
