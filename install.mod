## EasyMOD compliant
##############################################################
## MOD Title: MapBBCode
## MOD Author: Zverik <zverik@textual.ru> (Ilya Zverev)
## MOD Description: Adds [map] bbcode and its editor to phpBB 2
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
##      - MapBBCode 1.1.2
##      - simplified addons installation
##      - a link to administrator's guide
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
copy root/language/lang_mapbbcode.php to language/lang_english/lang_mapbbcode.php
copy root/language/lang_mapbbcode_russian.php to language/lang_russian/lang_mapbbcode.php
copy root/admin/admin_mapbbcode.php to admin/admin_mapbbcode.php
copy root/templates/admin/mapbbcode_body.tpl to templates/subSilver/admin/mapbbcode_body.tpl
copy root/mapbbcode_addons.php to includes/mapbbcode_addons.php
copy root/mapbbcode/*.* to includes/mapbbcode/*.*
#
#-----[ SQL ]------------------------------------------
#
# Upload and run as forum admin: db_install.php
#
# !!!!(Don't forget to delete db_install.php from the server after you have finished installing this mod!)!!!!
#
# or insert those records manually:
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_default_zoom','2');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_default_pos','22,11');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_view_width','600');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_view_height','300');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_full_height','600');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_always_full','');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_editor_height','400');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_window_width','800');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_window_height','500');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_editor_window','1');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_outer_link','');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_allowed_tags','[auib]|span|br|em|strong|tt');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_standard_switcher','1');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_enable_external','0');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_layers','OpenStreetMap');
#
#-----[ OPEN ]------------------------------------------
#
posting.php
#
#-----[ FIND ]------------------------------------------
#
generate_smilies('inline', PAGE_POSTING);
#
#-----[ AFTER, ADD ]------------------------------------------
#
$mapbbcode_present = TRUE;
#
#-----[ FIND ]------------------------------------------
#
	'L_EMPTY_MESSAGE' => $lang['Empty_message'],
#
#-----[ BEFORE, ADD ]------------------------------------------
#
	'L_BBCODE_MAP_HELP' => $lang['bbcode_map_help'],
#
#-----[ OPEN ]------------------------------------------
#
viewtopic.php
#
#-----[ FIND ]------------------------------------------
#
$resync = FALSE; 
if ($forum_topic_data['topic_replies'] + 1 < $start + count($postrow))
#
#-----[ BEFORE, ADD ]------------------------------------------
#
// 
// Check if MapBBCode scripts need to be added to the header
//
$mapbbcode_present = FALSE;
for($i = 0; $i < $total_posts; $i++)
{
	if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]|\[mapid\][a-z]+\[\/mapid\]/', $postrow[$i]['post_text'])) {
		$mapbbcode_present = TRUE;
		break;
	}
}

#
#-----[ OPEN ]------------------------------------------
#
privmsg.php
#
#-----[ FIND ]------------------------------------------
#
if ( $mode == 'newpm' )
{
#
#-----[ AFTER, ADD ]------------------------------------------
#
	$mapbbcode_present = TRUE;
#
#-----[ FIND ]------------------------------------------
#
	$page_title = $lang['Read_pm'];
#
#-----[ BEFORE, ADD ]------------------------------------------
#
	$mapbbcode_present = preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]|\[mapid\][a-z]+\[\/mapid\]/', $privmsg['privmsgs_text']);
#
#-----[ FIND ]------------------------------------------
#
	$page_title = $lang['Send_private_message'];
#
#-----[ BEFORE, ADD ]------------------------------------------
#
	$mapbbcode_present = TRUE;
#
#-----[ FIND ]------------------------------------------
#
		'L_EMPTY_MESSAGE' => $lang['Empty_message'],
#
#-----[ BEFORE, ADD ]------------------------------------------
#
		'L_BBCODE_MAP_HELP' => $lang['bbcode_map_help'],
#
#-----[ OPEN ]------------------------------------------
#
includes/bbcode.php
#
#-----[ FIND ]------------------------------------------
#
	$bbcode_tpl['email'] = str_replace('{EMAIL}', '\\1', $bbcode_tpl['email']);
#
#-----[ AFTER, ADD ]------------------------------------------
#

	$bbcode_tpl['map'] = str_replace('{DIVID}', '\\2', $bbcode_tpl['map']);
	$bbcode_tpl['map'] = str_replace('{MAPBBCODE}', '\\1\\3', $bbcode_tpl['map']);
	$bbcode_tpl['mapid'] = str_replace('{DIVID}', '\\1', $bbcode_tpl['mapid']);
	$bbcode_tpl['mapid'] = str_replace('{MAPID}', '\\2', $bbcode_tpl['mapid']);
#
#-----[ FIND ]------------------------------------------
#
	$replacements[] = $bbcode_tpl['email'];
#
#-----[ AFTER, ADD ]------------------------------------------
#

	// [map]...[/map] code. First prepare individual codes
	$mapre = '#(\[map(?:=[0-9,.-]+|id)?)(:[a-fA-F0-9]+)?(\].*?\[/map(?:id)?\])#si';
	$text = preg_replace_callback($mapre, create_function('$m','return $m[1].":".make_bbcode_uid().$m[3];'), $text);
	$mapre = '#(\[map(?:=[0-9,.-]+)?)(:[a-fA-F0-9]+)?(\].*?\[/map\])#si';
	$patterns[] = $mapre;
	$replacements[] = $bbcode_tpl['map'];

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
	//
	// Dump out the page header and load viewtopic body template
#
#-----[ BEFORE, ADD ]------------------------------------------
#
	//
	// Check if MapBBCode scripts need to be added to the header
	// 
	$sql = "SELECT pt.post_text
		FROM " . POSTS_TABLE . " p, " . USERS_TABLE . " u, " . POSTS_TEXT_TABLE . " pt
		WHERE p.topic_id = $topic_id
			AND p.poster_id = u.user_id
			AND p.post_id = pt.post_id
		ORDER BY p.post_time DESC
		LIMIT " . $board_config['posts_per_page'];

	$mapbbcode_present = FALSE;
	if ( $result = $db->sql_query($sql) )
	{
		while ( $row = $db->sql_fetchrow($result) )
		{
			if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]|\[mapid\][a-z]+\[\/mapid\]/', $row['post_text'])) {
				$mapbbcode_present = TRUE;
				break;
			}
		}
	}
	$db->sql_freeresult($result);

#
#-----[ OPEN ]------------------------------------------
#
includes/page_header.php
#
#-----[ FIND ]------------------------------------------
#
//
// Login box?
#
#-----[ BEFORE, ADD ]------------------------------------------
#
if( $mapbbcode_present )
{
	if ( @file_exists($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_mapbbcode.' . $phpEx) )
	{
		include($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_mapbbcode.' . $phpEx);
	}
	else
	{
		include($phpbb_root_path . 'language/lang_english/lang_mapbbcode.' . $phpEx);
	}
	include($phpbb_root_path . 'includes/mapbbcode_addons.' . $phpEx);

	function mapbb_array_to_array($line) {
		return "'".str_replace("'", "\\'", str_replace("\\", "\\\\", $line))."'";
	}

	$template->assign_vars(array(
		"L_MAPBB_LANG_JS" => $lang['MapBB_Lang_JS'],
		"L_MAPBB_JS_ADDONS" => str_replace('%base%', 'includes/mapbbcode', $lang['MapBB_JS_Addons']),
		"LAYERS" => $board_config['mapbb_layers'],
		"DEFAULT_ZOOM" => $board_config['mapbb_default_zoom'],
		"DEFAULT_POS" => $board_config['mapbb_default_pos'],
		"VIEW_WIDTH" => $board_config['mapbb_view_width'],
		"VIEW_HEIGHT" => $board_config['mapbb_view_height'],
		"FULL_HEIGHT" => $board_config['mapbb_full_height'],
		"EDITOR_HEIGHT" => $board_config['mapbb_editor_height'],
		"WINDOW_WIDTH" => $board_config['mapbb_window_width'],
		"WINDOW_HEIGHT" => $board_config['mapbb_window_height'],
		"OUTER_LINK" => $board_config['mapbb_outer_link'],
		"ALWAYS_FULL" => $board_config['mapbb_always_full'] ? 'true' : 'false',
 		"STANDARD_SWITCHER" => $board_config['mapbb_standard_switcher'] ? 'true' : 'false',
 		"ENABLE_EXTERNAL" => $board_config['mapbb_enable_external'] ? 'true' : 'false',
 		"EDITOR_WINDOW" => $board_config['mapbb_editor_window'] ? 'true' : 'false',
		"ALLOWED_TAGS" => $board_config['mapbb_allowed_tags'])
	);
	$template->assign_block_vars('switch_enable_mapbbcode', array());
}

#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/bbcode.tpl
#
#-----[ FIND ]------------------------------------------
#
<!-- BEGIN img --><img src="{URL}" border="0" /><!-- END img -->
#
#-----[ AFTER, ADD ]------------------------------------------
#

<!-- BEGIN map --><div id="map{DIVID}">{MAPBBCODE}</div><script language="javascript">mapBBcode.show('map{DIVID}');</script><!-- END map -->
<!-- BEGIN mapid --><div id="map{DIVID}"></div><script language="javascript">mapBBcode.showExternal('map{DIVID}', '{MAPID}');</script><!-- END mapid -->
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/posting_body.tpl
#
#-----[ FIND ]------------------------------------------
#
f_help = "{L_BBCODE_F_HELP}";
#
#-----[ AFTER, ADD ]------------------------------------------
#
map_help = "{L_BBCODE_MAP_HELP}";
#
#-----[ FIND ]------------------------------------------
# not needed if editor is always opened in a window
#
	  <td class="row2" valign="top"><span class="gen"> <span class="genmed"> </span>
#
#-----[ AFTER, ADD ]------------------------------------------
#
	  <div id="mapedit"></div>
#
#-----[ FIND ]------------------------------------------
#
			  <input type="button" class="button" accesskey="w" name="addbbcode16" value="URL" style="text-decoration: underline; width: 40px" onClick="bbstyle(16)" onMouseOver="helpline('w')" />
			  </span></td>
#
#-----[ AFTER, ADD ]------------------------------------------
#
			<td><span class="genmed"> 
			  <input type="button" class="button" accesskey="m" name="addbbcodemap" value="Map" style="width: 40px" onClick="{EDITOR_WINDOW} ? mapBBcode.editorWindow(document.post.message) : mapBBcode.editor('mapedit', document.post.message);" onMouseOver="helpline('map')" />
			  </span></td>
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/overall_header.tpl
#
#-----[ FIND ]------------------------------------------
#
{META}
#
#-----[ BEFORE, ADD ]------------------------------------------
#
<!-- BEGIN switch_enable_mapbbcode -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- END switch_enable_mapbbcode -->
#
#-----[ FIND ]------------------------------------------
#
<!-- END switch_enable_pm_popup -->
#
#-----[ AFTER, ADD ]------------------------------------------
#
<!-- BEGIN switch_enable_mapbbcode -->
<link rel="stylesheet" href="includes/mapbbcode/leaflet.css" />
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
<script src="includes/mapbbcode/lang/{L_MAPBB_LANG_JS}.js"></script>
{L_MAPBB_JS_ADDONS}
<script language="Javascript" type="text/javascript">
<!--
var mapBBcode = new MapBBCode({
	windowPath: 'includes/mapbbcode/',
	layers: '{LAYERS}'.split(','),
	defaultZoom: {DEFAULT_ZOOM}+0,
	defaultPosition: [{DEFAULT_POS}],
	viewWidth: {VIEW_WIDTH}+0,
	viewHeight: {VIEW_HEIGHT}+0,
	fullViewHeight: {FULL_HEIGHT}+0,
	editorHeight: {EDITOR_HEIGHT}+0,
	windowWidth: {WINDOW_WIDTH}+0,
	windowHeight: {WINDOW_HEIGHT}+0,
	fullFromStart: {ALWAYS_FULL},
	outerLinkTemplate: '{OUTER_LINK}',
	preferStandardLayerSwitcher: {STANDARD_SWITCHER},
	uploadButton: {ENABLE_EXTERNAL},
	hideInsideClasses: []
});
//-->
</script>
<!-- END switch_enable_mapbbcode -->
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/simple_header.tpl
#
#-----[ FIND ]------------------------------------------
#
{META}
#
#-----[ BEFORE, ADD ]------------------------------------------
#
<!-- BEGIN switch_enable_mapbbcode -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- END switch_enable_mapbbcode -->
#
#-----[ FIND ]------------------------------------------
#
</head>
#
#-----[ BEFORE, ADD ]------------------------------------------
#
<!-- BEGIN switch_enable_mapbbcode -->
<link rel="stylesheet" href="includes/mapbbcode/leaflet.css" />
<!--[if lte IE 8]>
	<link rel="stylesheet" href="includes/mapbbcode/leaflet.ie.css" />
<![endif]-->
<script src="includes/mapbbcode/leaflet.js"></script>
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/mapbbcode-config.js"></script>
<script src="includes/mapbbcode/proprietary/Bing.js"></script>
<script src="includes/mapbbcode/lang/{L_MAPBB_LANG_JS}.js"></script>
{L_MAPBB_JS_ADDONS}
<script language="Javascript" type="text/javascript">
<!--
var mapBBcode = new MapBBCode({
	layers: '{LAYERS}'.split(','),
	defaultZoom: {DEFAULT_ZOOM}+0,
	defaultPosition: [{DEFAULT_POS}],
	viewWidth: {VIEW_WIDTH}+0,
	viewHeight: {VIEW_HEIGHT}+0,
	fullViewHeight: {FULL_HEIGHT}+0,
	editorHeight: {EDITOR_HEIGHT}+0,
	windowWidth: {WINDOW_WIDTH}+0,
	windowHeight: {WINDOW_HEIGHT}+0,
	fullFromStart: {ALWAYS_FULL},
	outerLinkTemplate: '{OUTER_LINK}',
	preferStandardLayerSwitcher: {STANDARD_SWITCHER}
});
//-->
</script>
<!-- END switch_enable_mapbbcode -->
#
#-----[ SAVE/CLOSE ALL FILES ]------------------------------------------
#
# EoM
