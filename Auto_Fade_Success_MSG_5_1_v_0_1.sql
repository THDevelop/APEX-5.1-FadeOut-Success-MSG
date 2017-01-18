set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_050100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.0.00.45'
,p_default_workspace_id=>220060456998961112
,p_default_application_id=>62012
,p_default_owner=>'THDEVELOP'
);
end;
/
prompt --application/ui_types
begin
null;
end;
/
prompt --application/shared_components/plugins/dynamic_action/auto_fade_success_message
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(2786018211924511806)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'AUTO FADE SUCCESS MESSAGE'
,p_display_name=>'Auto Fade Success Message 5.1'
,p_category=>'EXECUTE'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- Developed by Tim Halbach - https://thalbachdevelop.blogspot.de/',
'FUNCTION render_autoFadeOut (p_dynamic_action IN apex_plugin.t_dynamic_action, p_plugin IN apex_plugin.t_plugin)',
'  RETURN apex_plugin.t_dynamic_action_render_result',
'AS',
'  -- Return variable',
'  l_result                      apex_plugin.t_dynamic_action_render_result;',
'',
'  -- Save plugin-parameter in local variables',
'  l_view_time           apex_application_page_regions.attribute_01%type := p_dynamic_action.attribute_01;',
'',
'  ',
'  -- Variables for javascript parts',
'  l_complete_code varchar2(4000);',
'',
'begin',
'/* During plug-in development it''s very helpful to have some debug information */',
'  IF APEX_APPLICATION.g_debug THEN',
'    apex_plugin_util.debug_dynamic_action (p_plugin => p_plugin, p_dynamic_action => p_dynamic_action);',
'  END IF;',
'',
'/* Escaping der Parameter */',
'  l_view_time          := apex_plugin_util.escape(l_view_time, true);',
'',
'/* Function declaration */',
'  ',
'  l_complete_code := q''[function(){',
'// The node to be monitored',
'var target = $( "#APEX_SUCCESS_MESSAGE" )[0];',
'',
'// Configuration of the observer:',
'var config = { ',
'  attributes: true, ',
'  childList: true, ',
'  characterData: true ',
'};',
'',
'// Create an observer instance',
'var observer = new MutationObserver(function( mutations ) {',
'  mutations.forEach(function( mutation ) {',
'    var newNodes = mutation.addedNodes; // DOM NodeList',
'    if( newNodes !== null ) { // If there are new nodes added',
'      var $nodes = $( newNodes ); // jQuery set',
'      $nodes.each(function() {',
'        var $node = $( this );',
'        if(  $(''#APEX_SUCCESS_MESSAGE'').hasClass( "u-visible" ) ) {',
'          // do something',
'            $(''#t_Alert_Success'').ready(function() { ',
'                setTimeout(function() { ',
'                   $(''#t_Alert_Success .t-Button--closeAlert'').click();',
'                     }, ]'' || l_view_time || q''[ ); // here u can change the view time',
'            });',
'        }',
'      });',
'    }',
'  });    ',
'});',
' ',
'// Pass in the target node, as well as the observer options',
'observer.observe(target, config);',
']'';',
'  ',
'/* Finish Code */',
'  l_complete_code := l_complete_code || ''}'';',
'',
'  l_result.javascript_function := l_complete_code;',
'  return l_result;',
'end render_autoFadeOut;'))
,p_api_version=>2
,p_render_function=>'render_autoFadeOut'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'0.1'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(2787526441735662049)
,p_plugin_id=>wwv_flow_api.id(2786018211924511806)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Display Time'
,p_attribute_type=>'NUMBER'
,p_is_required=>false
,p_default_value=>'1500'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_help_text=>'Enter your display time for the success message'
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
