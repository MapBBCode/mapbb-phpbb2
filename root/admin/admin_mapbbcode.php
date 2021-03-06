<?php
/***************************************************************************
 *                            admin_mapbbcode.php
 *                            -------------------
 *   begin                : Saturday, Oct 5, 2013
 *   copyright            : (c) 2013 Ilya Zverev, 2005 The phpBB Group
 *   email                : zverik@textual.ru
 *
 ***************************************************************************/

define('IN_PHPBB', 1);

if( !empty($setmodules) )
{
	$file = basename(__FILE__);
	$module['General']['MapBBCode'] = $file;
	return;
}

//
// Let's set the root dir for phpBB
//
$phpbb_root_path = "./../";
require($phpbb_root_path . 'extension.inc');
require('./pagestart.' . $phpEx);
include($phpbb_root_path . 'includes/functions_selects.'.$phpEx);

// Load mapbbcode language file
if ( @file_exists($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_mapbbcode.' . $phpEx) )
{
	include($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_mapbbcode.' . $phpEx);
}
else
{
	include($phpbb_root_path . 'language/lang_english/lang_mapbbcode.' . $phpEx);
}
include($phpbb_root_path . 'includes/mapbbcode_addons.' . $phpEx);

//
// Pull all config data
//
$sql = "SELECT *
	FROM " . CONFIG_TABLE . " WHERE config_name LIKE 'mapbb_%'";
if(!$result = $db->sql_query($sql))
{
	message_die(CRITICAL_ERROR, "Could not query config information in admin_mapbbcode", "", __LINE__, __FILE__, $sql);
}
else
{
	while( $row = $db->sql_fetchrow($result) )
	{
		$config_name = $row['config_name'];
		$config_value = $row['config_value'];
		$default_config[$config_name] = isset($HTTP_POST_VARS['submit']) ? str_replace("'", "\'", $config_value) : $config_value;
		
		$var_name = str_replace('mapbb_', '', $config_name);
		$new[$config_name] = ( isset($HTTP_POST_VARS[$var_name]) ) ? $HTTP_POST_VARS[$var_name] : $default_config[$config_name];

		if( isset($HTTP_POST_VARS['submit']) )
		{
			$sql = "UPDATE " . CONFIG_TABLE . " SET
				config_value = '" . str_replace("\'", "''", $new[$config_name]) . "'
				WHERE config_name = '$config_name'";
			if( !$db->sql_query($sql) )
			{
				message_die(GENERAL_ERROR, "Failed to update general configuration for $config_name", "", __LINE__, __FILE__, $sql);
			}
		}
	}

	if( isset($HTTP_POST_VARS['submit']) )
	{
		$message = $lang['Config_updated'] . "<br /><br />" . sprintf($lang['Click_return_mapbbcode_config'], "<a href=\"" . append_sid("admin_mapbbcode.$phpEx") . "\">", "</a>") . "<br /><br />" . sprintf($lang['Click_return_admin_index'], "<a href=\"" . append_sid("index.$phpEx?pane=right") . "\">", "</a>");

		message_die(GENERAL_MESSAGE, $message);
	}
}

$template->set_filenames(array(
	"body" => "admin/mapbbcode_body.tpl")
);

$std_switcher_yes = ( $new['mapbb_standard_switcher'] ) ? "checked=\"checked\"" : "";
$std_switcher_no = ( !$new['mapbb_standard_switcher'] ) ? "checked=\"checked\"" : "";
$enable_external_yes = ( $new['mapbb_enable_external'] ) ? "checked=\"checked\"" : "";
$enable_external_no = ( !$new['mapbb_enable_external'] ) ? "checked=\"checked\"" : "";

//
// Escape any quotes in the site description for proper display in the text
// box on the admin page 
//
$template->assign_vars(array(
	"S_CONFIG_ACTION" => append_sid("admin_mapbbcode.$phpEx"),

	"L_YES" => $lang['Yes'],
	"L_NO" => $lang['No'],
	"L_MAPBB_LANG_JS" => $lang['MapBB_Lang_JS'],
	"L_MAPBB_JS_ADDONS" => str_replace('%base%', '../includes/mapbbcode', $lang['MapBB_JS_Addons']),
	"L_MAPBBCODE_CONFIG" => $lang['MapBB_Config'],
	"L_MAPBBCODE_CONFIG_EXPLAIN" => $lang['MapBB_Config_explain'],
	"L_PANEL_CONFIG" => $lang['MapBB_Panel_Config'],
	"L_LAYERS" => str_replace("'", "\\'", $lang['MapBB_Layers']),
	"L_DEFAULT_ZOOM_POS" => $lang['MapBB_Default_zoom_pos'],
	"L_PANEL_SIZE" => $lang['MapBB_Panel_size'],
	"L_FULL_HEIGHT" => $lang['MapBB_Full_height'],
	"L_WINDOW_SIZE" => $lang['MapBB_Window_size'],
	"L_EDITOR_HEIGHT" => $lang['MapBB_Editor_height'],
	"L_ADD_LAYER" => $lang['MapBB_Add_layer'],
	"L_BING_KEY" => $lang['MapBB_Bing_key'],
	"L_KEY_NEEDED" => $lang['MapBB_Key_needed'],
	"L_SELECT_LAYER" => $lang['MapBB_Select_layer'],
	"L_STANDARD_SWITCHER" => $lang['MapBB_Standard_switcher'],
	"L_ENABLE_EXTERNAL" => $lang['MapBB_Enable_external'],
	"L_OUTER_LINK" => $lang['MapBB_Outer_link'],
	"L_OUTER_LINK_EXAMPLE" => $lang['MapBB_Outer_link_example'],
	"L_ALLOWED_TAGS" => $lang['MapBB_Allowed_tags'],
	"L_SUBMIT" => $lang['Submit'], 
	"L_RESET" => $lang['Reset'], 

	"LAYERS" => $new['mapbb_layers'],
	"DEFAULT_ZOOM" => $new['mapbb_default_zoom'],
	"DEFAULT_POS" => $new['mapbb_default_pos'],
	"VIEW_WIDTH" => $new['mapbb_view_width'],
	"VIEW_HEIGHT" => $new['mapbb_view_height'],
	"FULL_HEIGHT" => $new['mapbb_full_height'],
	"EDITOR_HEIGHT" => $new['mapbb_editor_height'],
	"WINDOW_WIDTH" => $new['mapbb_window_width'],
	"WINDOW_HEIGHT" => $new['mapbb_window_height'],
	"OUTER_LINK" => $new['mapbb_outer_link'],
	"ALWAYS_FULL" => $new['mapbb_always_full'],
	"S_STANDARD_SWITCHER_YES" => $std_switcher_yes,
	"S_STANDARD_SWITCHER_NO" => $std_switcher_no,
	"S_ENABLE_EXTERNAL_YES" => $enable_external_yes,
	"S_ENABLE_EXTERNAL_NO" => $enable_external_no,
	"EDITOR_WINDOW" => $new['mapbb_editor_window'],
	"ENABLE_EXTERNAL" => $new['mapbb_enable_external'],
	"ALLOWED_TAGS" => $new['mapbb_allowed_tags'])
);

$template->pparse("body");

include('./page_footer_admin.'.$phpEx);

?>
