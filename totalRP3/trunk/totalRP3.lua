--[[
	Total RP 3, by Telkostrasz (Kirin Tor - Eu/Fr)
--]]

local Globals = TRP3_GLOBALS;
local Utils = TRP3_UTILS;
local Comm = TRP3_COMM;
local Log = Utils.log;
local Config = TRP3_CONFIG;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- LOADING SEQUENCE
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

-- Called when TRP3 is loaded.
function Globals.addon:OnInitialize()
	
end

-- Called upon PLAYER_LOGIN after all addons are loaded.
function Globals.addon:OnEnable()
	Log.log("OnEnable() START");
	Globals.build(); -- Get info we can't have earlier
	
	TRP3_Flyway_Patches(); -- Adapt saved variables structures between versions
	TRP3_ModuleManagement_Init();
	TRP3_InitModules();
	
	-- Inits logic
	TRP3_InitLocalization();
	Comm.init();
	Comm.broadcast.init();
	TRP3_InitProfiles();
	TRP3_InitRegister();
	
	-- Inits UI
	TRP3_UI_InitToolbar();
	TRP3_TARGET_FRAME.init();
	TRP3_UI_InitMainPage();
	TRP3_UI_InitRegister();
	TRP3_UI_InitPopups();
	TRP3_InitMinimapButton();
	TRP3_UI_InitConfiguration();
	
	TRP3_LoadProfile(); -- Load profile
	TRP3_SelectMenu("main_00_player"); -- Select first menu
	print(TRP3_L("GEN_WELCOME_MESSAGE")); -- Welcome \o/
	-- Version \o/
	print(TRP3_L("GEN_WELCOME_VERSION"):format(Globals.version_display));
	TRP3_MainFrameVersionText:SetText(TRP3_L("GEN_VERSION"):format(Globals.version_display));
	
	TRP3_StartModules();
	
	-- Must be called after module start.
	TRP3_Configuration_OnModuleLoaded();
	
	Log.log("OnEnable() DONE");
end