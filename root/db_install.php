<?php

define('IN_PHPBB', true);
$phpbb_root_path = './';

include($phpbb_root_path . 'extension.inc');
include($phpbb_root_path . 'common.'.$phpEx);

$userdata = session_pagestart($user_ip, PAGE_INDEX);
init_userprefs($userdata);

if ( $userdata['user_level'] != ADMIN )
{
	message_die(GENERAL_ERROR, "You are not authorised");
}
else
{
        $default_values = array(
		'default_zoom' => 2,
		'default_pos' => '22,11',
		'view_width' => 600,
		'view_height' => 300,
		'full_height' => 600,
		'always_full' => '',
		'editor_height' => 400,
		'window_width' => 800,
		'window_height' => 500,
		'editor_window' => 1,
		'outer_link' => '',
		'allowed_tags' => '[auib]|span|br|em|strong|tt',
                'standard_switcher' => '1',
                'enable_external' => '0',
		'layers' => 'OpenStreetMap'
	);

	$n=1;
	$message='</span></td><td align="left"><span class="gen"><b>Install results:</b><br/><br/>';
	foreach($default_values as $key => $value)
	{
		$sql = "INSERT INTO ".CONFIG_TABLE." (config_name, config_value) VALUES ('mapbb_$key','$value')";
		//$sql = "UPDATE ".CONFIG_TABLE." SET config_value='$value' WHERE config_name='mapbb_$key'";
		$result = $db->sql_query($sql);
		$restxt = $result ? 'done' : 'failed';
		$message .="<b>[$restxt]</b> line: $n , $sql<br />";
		$n++;
	}

	message_die(GENERAL_MESSAGE, $message);
}
?>
