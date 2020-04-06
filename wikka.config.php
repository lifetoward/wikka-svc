<?php
/**
 * WikkaWiki configuration file 
 * 
 * This template was created for the Synthetic hosting model to work with env.sh.
 * Do not manually change wakka_version if you wish to keep your engine up-to-date.
 * Documentation is available at: http://docs.wikkawiki.org/ConfigurationOptions
 */

$WikiURI = getenv('WikiURI');
$WikiURI = '';
$DOMAIN = getenv('DOMAIN');

$wakkaConfig = array(
	'behind_reverse_proxy'=>!strlen($DOMAIN),
	'table_prefix' => getenv('WikiDBTablePrefix'),
	'root_page' => (getenv('WikiRootPage') ? : 'HomePage'),
	'wakka_name' => getenv('WikiTitle'),
	'base_url' => ($WikiURI ? "/$WikiURI/" : '/'),
	'wiki_suffix' => "@".getenv('SiteHandle'),
	'theme' => getenv('WikiTheme'),
	'dbms_database'=>'/data/wiki/wikka.sqlite',
	'admin_email' => "wiki.admin@$DOMAIN",
	'upload_path' => "/data/wiki/uploads",
	'dbms_type'=>'sqlite',
	'rewrite_mode' => '1',
	'enable_user_host_lookup' => '1',
	'action_path' => 'plugins/actions,actions',
	'handler_path' => 'plugins/handlers,handlers',
	'gui_editor' => '1',
	'wikka_formatter_path' => 'plugins/formatters,formatters',
	'wikka_highlighters_path' => 'formatters',
	'geshi_path' => '3rdparty/plugins/geshi',
	'geshi_languages_path' => '3rdparty/plugins/geshi/geshi',
	'wikka_template_path' => 'plugins/templates,templates',
	'safehtml_path' => '3rdparty/core/safehtml',
	'referrers_purge_time' => '30',
	'pages_purge_time' => '0',
	'xml_recent_changes' => '10',
	'hide_comments' => '0',
	'require_edit_note' => '0',
	'anony_delete_own_comments' => '1',
	'public_sysinfo' => '0',
	'double_doublequote_html' => 'safe',
	'sql_debugging' => '0',
	'admin_users' => 'WikiAdmin',
	'mime_types' => 'mime_types.txt',
	'geshi_header' => 'div',
	'geshi_line_numbers' => '1',
	'geshi_tab_width' => '4',
	'grabcode_button' => '1',
	'wikiping_server' => '',
	'default_write_acl' => '+',
	'default_read_acl' => '*',
	'default_comment_acl' => '+',
	'allow_user_registration' => '0',
	'enable_version_check' => '1',
	'version_check_interval' => '1h',
	'meta_keywords' => '',
	'meta_description' => '',
	'stylesheet_hash' => 'c1079');
?>
