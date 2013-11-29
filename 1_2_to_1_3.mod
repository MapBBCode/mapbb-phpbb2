## EasyMOD compliant
##############################################################
## MOD Title: MapBBCode Upgrade from 1.2
## MOD Author: Zverik <zverik@textual.ru> (Ilya Zverev)
## MOD Description: Upgrade [map] bbcode MOD from 1.2 to 1.3
## MOD Version: 1.3
##
## Installation Level: Easy
## Installation Time: 5 Minutes
## Files To Edit: 5
##		admin/admin_mapbbcode.php
##		templates/subSilver/admin/mapbbcode_body.tpl
##		includes/page_header.php
##		templates/subSilver/overall_header.tpl
##		templates/subSilver/simple_header.tpl
## Included Files: 1 + 16 js,css,png
##		includes/mapbbcode/*
##		includes/mapbbcode_addons.php
##
## License: http://www.wtfpl.net/ WTFPL
##############################################################
## Author Notes:
##    This MOD was tested on phpBB 2.0.21 and 2.0.23.
##    And yes, it is EasyMOD friendly.
##############################################################
## MOD History:
##
##   2013-11-29 - Version 1.3
##      - initial release
##
##############################################################
## Before Adding This MOD To Your Forum, You Should Back Up All Files Related To This MOD
##############################################################

#
#-----[ COPY ]------------------------------------------------
#
# Copy new script and update MapBBCode library
#
copy root/mapbbcode_addons.php to includes/mapbbcode_addons.php
copy root/mapbbcode/*.* to includes/mapbbcode/*.*
#
#-----[ OPEN ]------------------------------------------
#
admin/admin_mapbbcode.php
#
#-----[ FIND ]------------------------------------------
#
	include($phpbb_root_path . 'language/lang_english/lang_mapbbcode.' . $phpEx);
}
#
#-----[ AFTER, ADD ]------------------------------------------
#
include($phpbb_root_path . 'includes/mapbbcode_addons.' . $phpEx);
#
#-----[ FIND ]------------------------------------------
#
	"L_MAPBB_LANG_JS" => $lang['MapBB_Lang_JS'],
#
#-----[ AFTER, ADD ]------------------------------------------
#
	"L_MAPBB_JS_ADDONS" => str_replace('%base%', '../includes/mapbbcode', $lang['MapBB_JS_Addons']),
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/admin/mapbbcode_body.tpl
#
#-----[ FIND ]------------------------------------------
#
<script src="../includes/mapbbcode/proprietary/Bing.js"></script>
#
#-----[ AFTER, ADD ]------------------------------------------
#
{L_MAPBB_JS_ADDONS}
#
#-----[ OPEN ]------------------------------------------
#
includes/page_header.php
#
#-----[ FIND ]------------------------------------------
#
		include($phpbb_root_path . 'language/lang_english/lang_mapbbcode.' . $phpEx);
	}
#
#-----[ AFTER, ADD ]------------------------------------------
#
	include($phpbb_root_path . 'includes/mapbbcode_addons.' . $phpEx);
#
#-----[ FIND ]------------------------------------------
#
		"L_MAPBB_LANG_JS" => $lang['MapBB_Lang_JS'],
#
#-----[ AFTER, ADD ]------------------------------------------
#
		"L_MAPBB_JS_ADDONS" => str_replace('%base%', 'includes/mapbbcode', $lang['MapBB_JS_Addons']),
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/overall_header.tpl
#
#-----[ FIND ]------------------------------------------
#
<script src="includes/mapbbcode/lang/{L_MAPBB_LANG_JS}.js"></script>
#
#-----[ AFTER, ADD ]------------------------------------------
#
{L_MAPBB_JS_ADDONS}
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/simple_header.tpl
#
#-----[ FIND ]------------------------------------------
#
<script src="includes/mapbbcode/lang/{L_MAPBB_LANG_JS}.js"></script>
#
#-----[ AFTER, ADD ]------------------------------------------
#
{L_MAPBB_JS_ADDONS}
#
#-----[ SAVE/CLOSE ALL FILES ]------------------------------------------
#
# EoM
