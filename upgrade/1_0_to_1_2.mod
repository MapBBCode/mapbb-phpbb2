## EasyMOD compliant
##############################################################
## MOD Title: MapBBCode
## MOD Author: Zverik <zverik@textual.ru> (Ilya Zverev)
## MOD Description: Upgrade [map] bbcode MOD to 1.2
## MOD Version: 1.2
##
## Installation Level: Easy
## Installation Time: 5 Minutes
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
##   2013-11-14 - Version 1.2
##      - MapBBCode 1.1.0
##      - reworked translations
##
##   2013-10-29 - Version 1.1
##      - Support for MapBBCode Share
##
##   2013-10-08 - Version 1.0
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
copy root/mapbbcode/*.* to includes/mapbbcode/*.*
#
#-----[ SQL ]------------------------------------------
#
# Upload and run as forum admin: db_install.php
#
# !!!!(Don't forget to delete db_install.php from the server after you have finished installing this mod!)!!!!
#
# or insert those records manually:
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_enable_external','0');
#
#-----[ OPEN ]------------------------------------------
#
root/admin/admin_mapbbcode.php
#
#-----[ FIND ]------------------------------------------
#
$std_switcher_no = ( !$new['mapbb_standard_switcher'] ) ? "checked=\"checked\"" : "";
#
#-----[ AFTER, ADD ]------------------------------------------
#
$enable_external_yes = ( $new['mapbb_enable_external'] ) ? "checked=\"checked\"" : "";
$enable_external_no = ( !$new['mapbb_enable_external'] ) ? "checked=\"checked\"" : "";
#
#-----[ FIND ]------------------------------------------
#
	"L_STANDARD_SWITCHER" => $lang['MapBB_Standard_switcher'],
#
#-----[ AFTER, ADD ]------------------------------------------
#
	"L_ENABLE_EXTERNAL" => $lang['MapBB_Enable_external'],
#
#-----[ FIND ]------------------------------------------
#
	"S_STANDARD_SWITCHER_NO" => $std_switcher_no,
#
#-----[ AFTER, ADD ]------------------------------------------
#
	"S_ENABLE_EXTERNAL_YES" => $enable_external_yes,
	"S_ENABLE_EXTERNAL_NO" => $enable_external_no,
#
#-----[ OPEN ]------------------------------------------
#
root/templates/admin/mapbbcode_body.tpl
#
#-----[ FIND ]------------------------------------------
#
		<td class="row2"><input type="radio" name="standard_switcher" value="1" {S_STANDARD_SWITCHER_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="standard_switcher" value="0" {S_STANDARD_SWITCHER_NO} /> {L_NO}</td>
	</tr>
#
#-----[ AFTER, ADD ]------------------------------------------
#
	<tr>
		<td class="row1">{L_ENABLE_EXTERNAL}</td>
		<td class="row2"><input type="radio" name="enable_external" value="1" {S_ENABLE_EXTERNAL_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="enable_external" value="0" {S_ENABLE_EXTERNAL_NO} /> {L_NO}</td>
	</tr>
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
	$patterns[] = '#(\[map(?:=[0-9,.-]+)?)(:[a-fA-F0-9]+)?(\].*?\[/map\])#si';
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
	fullFromStart: {ALWAYS_FULL},
#
#-----[ AFTER, ADD ]------------------------------------------
#
	outerLinkTemplate: '{OUTER_LINK}',
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
#
#-----[ FIND ]------------------------------------------
#
	fullFromStart: {ALWAYS_FULL},
#
#-----[ AFTER, ADD ]------------------------------------------
#
	outerLinkTemplate: '{OUTER_LINK}',
#
#-----[ SAVE/CLOSE ALL FILES ]------------------------------------------
#
# EoM