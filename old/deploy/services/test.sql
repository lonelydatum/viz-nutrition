CREATE TABLE `FOOD_GRP` (
  `FD_GRP_ID` int(11) NOT NULL,
  `FD_GRP_COD` int(11) default NULL,
  `FD_GRP_NME` text,
  `FD_GRP_NMF` text,
  PRIMARY KEY  (`FD_GRP_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;