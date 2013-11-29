## EasyMOD compliant
##############################################################
## MOD Title: MapBBCode Upgrade from 1.0
## MOD Author: Zverik <zverik@textual.ru> (Ilya Zverev)
## MOD Description: Upgrade [map] bbcode MOD from 1.0 to 1.3
## MOD Version: 1.3
##
## Installation Level: Easy
## Installation Time: 15 Minutes
## Files To Edit: 10
##		posting.php
##		privmsg.php
##		viewtopic.php
##		includes/bbcode.php
##		includes/page_header.php
##		includes/topic_review.php
##		templates/subSilver/bbcode.tpl
##		templates/subSilver/posting_body.tpl
##		templates/subSilver/overall_header.tpl
##		templates/subSilver/simple_header.tpl
## Included Files: 5 + 16 js,css,png
##		db_install.php
##		language/lang_mapbbcode.php
##		language/lang_mapbbcode_russian.php
##		admin/admin_mapbbcode.php
##		templates/subSilver/admin/mapbbcode_body.tpl
##		includes/mapbbcode/*
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
# It is much simpler to copy those files than to modify them
#
copy root/language/lang_mapbbcode.php to language/lang_english/lang_mapbbcode.php
copy root/language/lang_mapbbcode_russian.php to language/lang_russian/lang_mapbbcode.php
copy root/admin/admin_mapbbcode.php to admin/admin_mapbbcode.php
copy root/templates/admin/mapbbcode_body.tpl to templates/subSilver/admin/mapbbcode_body.tpl
copy root/mapbbcode_addons.php to includes/mapbbcode_addons.php
copy root/mapbbcode/*.* to includes/mapbbcode/*.*
#
#-----[ SQL ]------------------------------------------
#
# insert those records manually:
#
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_enable_external','0');
#
#-----[ OPEN ]------------------------------------------
#
viewtopic.php
#
#-----[ FIND ]------------------------------------------
#
	if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]/', $postrow[$i]['post_text'])) {
#
#-----[ REPLACE WITH ]------------------------------------------
#
	if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]|\[mapid\][a-z]+\[\/mapid\]/', $postrow[$i]['post_text'])) {
#
#-----[ OPEN ]------------------------------------------
#
privmsg.php
#
#-----[ FIND ]------------------------------------------
#
	$mapbbcode_present = preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]/', $privmsg['privmsgs_text']);
#
#-----[ REPLACE WITH ]------------------------------------------
#
	$mapbbcode_present = preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]|\[mapid\][a-z]+\[\/mapid\]/', $privmsg['privmsgs_text']);
#
#-----[ OPEN ]------------------------------------------
#
includes/bbcode.php
#
#-----[ FIND ]------------------------------------------
#
	$bbcode_tpl['map'] = str_replace('{MAPBBCODE}', '\\1\\3', $bbcode_tpl['map']);
#
#-----[ AFTER, ADD ]------------------------------------------
#
	$bbcode_tpl['mapid'] = str_replace('{DIVID}', '\\1', $bbcode_tpl['mapid']);
	$bbcode_tpl['mapid'] = str_replace('{MAPID}', '\\2', $bbcode_tpl['mapid']);
#
#-----[ FIND ]------------------------------------------
#
	$mapre = '#(\[map(?:=[0-9,.-]+)?)(:[a-fA-F0-9]+)?(\].*?\[/map\])#si';
	$text = preg_replace_callback($mapre, create_function('$m','return $m[1].":".make_bbcode_uid().$m[3];'), $text);
#
#-----[ REPLACE WITH ]------------------------------------------
#
	$mapre = '#(\[map(?:=[0-9,.-]+|id)?)(:[a-fA-F0-9]+)?(\].*?\[/map(?:id)?\])#si';
	$text = preg_replace_callback($mapre, create_function('$m','return $m[1].":".make_bbcode_uid().$m[3];'), $text);
	$mapre = '#(\[map(?:=[0-9,.-]+)?)(:[a-fA-F0-9]+)?(\].*?\[/map\])#si';
#
#-----[ FIND ]------------------------------------------
#
	$replacements[] = $bbcode_tpl['map'];
#
#-----[ AFTER, ADD ]------------------------------------------
#

	global $board_config;
	if (isset($board_config) && $board_config['mapbb_enable_external'])
	{
		$patterns[] = '#\[mapid(:[a-fA-F0-9]+)?\]([a-z]+)\[/mapid\]#i';
		$replacements[] = $bbcode_tpl['mapid'];
	}
	
#
#-----[ OPEN ]------------------------------------------
#
includes/topic_review.php
#
#-----[ FIND ]------------------------------------------
#
			if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]/', $row['post_text'])) {
#
#-----[ REPLACE WITH ]------------------------------------------
#
			if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]|\[mapid\][a-z]+\[\/mapid\]/', $row['post_text'])) {
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
		'L_MAPBB_CLOSE' => $lang['MapBB_close'],
		'L_MAPBB_REMOVE' => $lang['MapBB_remove'],
		'L_MAPBB_APPLY' => $lang['MapBB_apply'],
		'L_MAPBB_CANCEL' => $lang['MapBB_cancel'],
		'L_MAPBB_TITLE' => $lang['MapBB_title'],
		'L_MAPBB_BING' => $lang['MapBB_bing'],
		'L_MAPBB_ZOOMINTITLE' => $lang['MapBB_zoomInTitle'],
		'L_MAPBB_ZOOMOUTTITLE' => $lang['MapBB_zoomOutTitle'],
		'L_MAPBB_APPLYTITLE' => $lang['MapBB_applyTitle'],
		'L_MAPBB_CANCELTITLE' => $lang['MapBB_cancelTitle'],
		'L_MAPBB_FULLSCREENTITLE' => $lang['MapBB_fullScreenTitle'],
		'L_MAPBB_HELPTITLE' => $lang['MapBB_helpTitle'],
		'L_MAPBB_OUTERTITLE' => $lang['MapBB_outerTitle'],
		'L_MAPBB_POLYLINETITLE' => $lang['MapBB_polylineTitle'],
		'L_MAPBB_POLYGONTITLE' => $lang['MapBB_polygonTitle'],
		'L_MAPBB_MARKERTITLE' => $lang['MapBB_markerTitle'],
		'L_MAPBB_DRAWCANCELTITLE' => $lang['MapBB_drawCancelTitle'],
		'L_MAPBB_MARKERTOOLTIP' => $lang['MapBB_markerTooltip'],
		'L_MAPBB_POLYLINESTARTTOOLTIP' => $lang['MapBB_polylineStartTooltip'],
		'L_MAPBB_POLYLINECONTINUETOOLTIP' => $lang['MapBB_polylineContinueTooltip'],
		'L_MAPBB_POLYLINEENDTOOLTIP' => $lang['MapBB_polylineEndTooltip'],
		'L_MAPBB_POLYGONSTARTTOOLTIP' => $lang['MapBB_polygonStartTooltip'],
		'L_MAPBB_POLYGONCONTINUETOOLTIP' => $lang['MapBB_polygonContinueTooltip'],
		'L_MAPBB_POLYGONENDTOOLTIP' => $lang['MapBB_polygonEndTooltip'],
		'L_MAPBB_HELPCONTENTS' => implode(',', array_map('mapbb_array_to_array', $lang['MapBB_helpContents'])),

#
#-----[ REPLACE WITH ]------------------------------------------
#
		"L_MAPBB_LANG_JS" => $lang['MapBB_Lang_JS'],
		"L_MAPBB_JS_ADDONS" => str_replace('%base%', 'includes/mapbbcode', $lang['MapBB_JS_Addons']),
		"S_ENABLE_EXTERNAL" => $board_config['mapbb_enable_external'],
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/bbcode.tpl
#
#-----[ FIND ]------------------------------------------
#
<!-- BEGIN map --><div id="map{DIVID}">{MAPBBCODE}</div><script language="javascript">mapBBcode.show('map{DIVID}');</script><!-- END map -->
#
#-----[ AFTER, ADD ]------------------------------------------
#
<!-- BEGIN mapid --><div id="map{DIVID}"></div><script language="javascript">mapBBcode.showExternal('map{DIVID}', '{MAPID}');</script><!-- END mapid -->
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/overall_header.tpl
#
#-----[ FIND ]------------------------------------------
#
<script src="includes/mapbbcode/Bing.js"></script>
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/mapbbcode-config.js"></script>
#
#-----[ REPLACE WITH ]------------------------------------------
#
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/mapbbcode-config.js"></script>
<script src="includes/mapbbcode/proprietary/Bing.js"></script>
<script src="includes/mapbbcode/lang/{L_MAPBB_LANG_JS}.js"></script>
{L_MAPBB_JS_ADDONS}
#
#-----[ FIND ]------------------------------------------
#
	libPath: 'includes/mapbbcode/',
#
#-----[ REPLACE WITH ]------------------------------------------
#
	windowPath: 'includes/mapbbcode/',
#
#-----[ FIND ]------------------------------------------
#
	fullFromStart: isTrue('{ALWAYS_FULL}'),
#
#-----[ AFTER, ADD ]------------------------------------------
#
	outerLinkTemplate: '{OUTER_LINK}',
	uploadButton: isTrue('{S_ENABLE_EXTERNAL}'),
#
#-----[ FIND ]------------------------------------------
#
mapBBcode.setStrings({
	close: '{L_MAPBB_CLOSE}',
	remove: '{L_MAPBB_REMOVE}',
	apply: '{L_MAPBB_APPLY}',
	cancel: '{L_MAPBB_CANCEL}',
	title: '{L_MAPBB_TITLE}',
	bing: '{L_MAPBB_BING}',
	zoomInTitle: '{L_MAPBB_ZOOMINTITLE}',
	zoomOutTitle: '{L_MAPBB_ZOOMOUTTITLE}',
	applyTitle: '{L_MAPBB_APPLYTITLE}',
	cancelTitle: '{L_MAPBB_CANCELTITLE}',
	fullScreenTitle: '{L_MAPBB_FULLSCREENTITLE}',
	helpTitle: '{L_MAPBB_HELPTITLE}',
	outerTitle: '{L_MAPBB_OUTERTITLE}',
	polylineTitle: '{L_MAPBB_POLYLINETITLE}',
	polygonTitle: '{L_MAPBB_POLYGONTITLE}',
	markerTitle: '{L_MAPBB_MARKERTITLE}',
	drawCancelTitle: '{L_MAPBB_DRAWCANCELTITLE}',
	markerTooltip: '{L_MAPBB_MARKERTOOLTIP}',
	polylineStartTooltip: '{L_MAPBB_POLYLINESTARTTOOLTIP}',
	polylineContinueTooltip: '{L_MAPBB_POLYLINECONTINUETOOLTIP}',
	polylineEndTooltip: '{L_MAPBB_POLYLINEENDTOOLTIP}',
	polygonStartTooltip: '{L_MAPBB_POLYGONSTARTTOOLTIP}',
	polygonContinueTooltip: '{L_MAPBB_POLYGONCONTINUETOOLTIP}',
	polygonEndTooltip: '{L_MAPBB_POLYGONENDTOOLTIP}',
	helpContents: [{L_MAPBB_HELPCONTENTS}]
});
#
#-----[ REPLACE WITH ]------------------------------------------
#
// no strings
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/simple_header.tpl
#
#-----[ FIND ]------------------------------------------
#
<script src="includes/mapbbcode/Bing.js"></script>
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/mapbbcode-config.js"></script>
#
#-----[ REPLACE WITH ]------------------------------------------
#
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/mapbbcode-config.js"></script>
<script src="includes/mapbbcode/proprietary/Bing.js"></script>
<script src="includes/mapbbcode/lang/{L_MAPBB_LANG_JS}.js"></script>
{L_MAPBB_JS_ADDONS}
#
#-----[ FIND ]------------------------------------------
#
	fullFromStart: isTrue('{ALWAYS_FULL}'),
#
#-----[ AFTER, ADD ]------------------------------------------
#
	outerLinkTemplate: '{OUTER_LINK}',
	uploadButton: isTrue('{S_ENABLE_EXTERNAL}'),
#
#-----[ SAVE/CLOSE ALL FILES ]------------------------------------------
#
# EoM
