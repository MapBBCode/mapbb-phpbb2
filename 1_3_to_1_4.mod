## EasyMOD compliant
##############################################################
## MOD Title: MapBBCode Upgrade from 1.3
## MOD Author: Zverik <zverik@textual.ru> (Ilya Zverev)
## MOD Description: Upgrade [map] bbcode MOD from 1.3 to 1.4
## MOD Version: 1.4
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
##   2013-12-22 - Version 1.4
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
copy root/mapbbcode/*.* to includes/mapbbcode/*.*
#
#-----[ OPEN ]------------------------------------------
#
admin/admin_mapbbcode.php
#
#-----[ FIND ]------------------------------------------
#
	"L_LAYERS" => $lang['MapBB_Layers'],
#
#-----[ REPLACE WIDTH ]------------------------------------------
#
	"L_LAYERS" => str_replace("'", "\\'", $lang['MapBB_Layers']),
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/admin/mapbbcode_body.tpl
#
#-----[ FIND ]------------------------------------------
#
<!--[if lte IE 8]>
    <link rel="stylesheet" href="../includes/mapbbcode/leaflet.ie.css" />
<![endif]-->
<script src="../includes/mapbbcode/leaflet.js"></script>
<script src="../includes/mapbbcode/mapbbcode-config.js"></script>
<script src="../includes/mapbbcode/lang/{L_MAPBB_LANG_JS}.Config.js"></script>
<script src="../includes/mapbbcode/proprietary/Bing.js"></script>
#
#-----[ REPLACE WITH ]------------------------------------------
# note the lowercase "config"
#
<script src="../includes/mapbbcode/leaflet.js"></script>
<script src="../includes/mapbbcode/mapbbcode-config.js"></script>
<script src="../includes/mapbbcode/lang/{L_MAPBB_LANG_JS}.config.js"></script>
#
#-----[ OPEN ]------------------------------------------
#
language/lang_english/lang_mapbbcode.php
#
#-----[ FIND ]------------------------------------------
#
$lang['MapBB_Lang_JS'] = 'English';
#
#-----[ REPLACE WITH ]------------------------------------------
#
$lang['MapBB_Lang_JS'] = 'en';
#
#-----[ OPEN ]------------------------------------------
#
language/lang_russian/lang_mapbbcode.php
#
#-----[ FIND ]------------------------------------------
#
$lang['MapBB_Lang_JS'] = 'Russian';
#
#-----[ REPLACE WITH ]------------------------------------------
#
$lang['MapBB_Lang_JS'] = 'ru';
#
#-----[ OPEN ]------------------------------------------
#
includes/bbcode.php
#
#-----[ FIND ]------------------------------------------
#
	$bbcode_tpl['mapid'] = str_replace('{MAPID}', '\\2', $bbcode_tpl['mapid']);
#
#-----[ REPLACE WITH ]------------------------------------------
#

	$bbcode_tpl['mapid'] = str_replace('{MAPID}', '\\3', $bbcode_tpl['mapid']);
#
#-----[ FIND ]------------------------------------------
#
	$mapre = '#(\[map(?:=[0-9,.-]+|id)?)(:[a-fA-F0-9]+)?(\].*?\[/map(?:id)?\])#si';
	$text = preg_replace_callback($mapre, create_function('$m','return $m[1].":".make_bbcode_uid().$m[3];'), $text);
	$mapre = '#(\[map(?:=[0-9,.-]+)?)(:[a-fA-F0-9]+)?(\].*?\[/map\])#si';
	$patterns[] = $mapre;
	$replacements[] = $bbcode_tpl['map'];

	global $board_config;
	if (isset($board_config) && $board_config['mapbb_enable_external'])
	{
		$patterns[] = '#\[mapid(:[a-fA-F0-9]+)?\]([a-z]+)\[/mapid\]#i';
#
#-----[ REPLACE WITH ]------------------------------------------
#
	$mapre = '#(\[map(?:=[0-9,.-]+)?)(:[a-fA-F0-9]+)?(\].*?\[/map\])#si';
	$text = preg_replace_callback($mapre, create_function('$m','return $m[1].":".make_bbcode_uid().$m[3];'), $text);
	$patterns[] = $mapre;
	$replacements[] = $bbcode_tpl['map'];

	global $board_config;
	if (isset($board_config) && $board_config['mapbb_enable_external'])
	{
		$mapre = '#\[mapid(:[a-fA-F0-9]+)?(\]([a-z]+)\[/mapid\])#i';
		$text = preg_replace_callback($mapre, create_function('$m','return "[mapid:".make_bbcode_uid().$m[2];'), $text);
		$patterns[] = $mapre;
#
#-----[ OPEN ]------------------------------------------
#
includes/mapbbcode_addons.php
#
#-----[ FIND ]------------------------------------------
#
// put MapBBCode add-ons here
#
#-----[ AFTER, ADD ]------------------------------------------
#
$lang['MapBB_JS_Addons'] .= '<script src="%base%/proprietary/Bing.js"></script>';
#
#-----[ OPEN ]------------------------------------------
#
includes/page_header.php
#
#-----[ FIND ]------------------------------------------
#
		"LAYERS" => $board_config['mapbb_layers'],
#
#-----[ REPLACE WITH ]------------------------------------------
#
		"LAYERS" => str_replace("'", "\\'", $board_config['mapbb_layers']),
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/overall_header.tpl
#
#-----[ FIND ]------------------------------------------
#
<!--[if lte IE 8]>
	<link rel="stylesheet" href="includes/mapbbcode/leaflet.ie.css" />
	<link rel="stylesheet" href="includes/mapbbcode/leaflet.draw.ie.css" />
<![endif]-->
<script src="includes/mapbbcode/leaflet.js"></script>
<script src="includes/mapbbcode/leaflet.draw.js"></script>
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/mapbbcode-config.js"></script>
<script src="includes/mapbbcode/proprietary/Bing.js"></script>
#
#-----[ REPLACE WITH ]------------------------------------------
#
<script src="includes/mapbbcode/leaflet.js"></script>
<script src="includes/mapbbcode/leaflet.draw.js"></script>
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/LayerList.js"></script>
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/simple_header.tpl
#
#-----[ FIND ]------------------------------------------
#
<link rel="stylesheet" href="includes/mapbbcode/leaflet.draw.css" />
<!--[if lte IE 8]>
	<link rel="stylesheet" href="includes/mapbbcode/leaflet.ie.css" />
	<link rel="stylesheet" href="includes/mapbbcode/leaflet.draw.ie.css" />
<![endif]-->
<script src="includes/mapbbcode/leaflet.js"></script>
<script src="includes/mapbbcode/leaflet.draw.js"></script>
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/mapbbcode-config.js"></script>
<script src="includes/mapbbcode/proprietary/Bing.js"></script>
#
#-----[ REPLACE WITH ]------------------------------------------
#
<script src="includes/mapbbcode/leaflet.js"></script>
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/LayerList.js"></script>
#
#-----[ SAVE/CLOSE ALL FILES ]------------------------------------------
#
# EoM
