max_line_length = false

exclude_files = {
	"totalRP3_Extended/libs",
	"totalRP3_Extended/script/Operands/_tests",
};

ignore = {
	-- Ignore global writes/accesses/mutations on anything prefixed with
	-- "TRP3_". This is the standard prefix for all of our global frame names
	-- and mixins.
	"11./^TRP3_",

	-- Ignore unused self. This would popup for Mixins and Objects
	"212/self",
};

globals = {
	"AddOn_TotalRP3",
	"BINDING_NAME_TRP3_EXTENDED_TOOLS",
	"BINDING_NAME_TRP3_INVENTORY",
	"BINDING_NAME_TRP3_MAIN_CONTAINER",
	"BINDING_NAME_TRP3_QUEST_ACTION",
	"BINDING_NAME_TRP3_QUEST_LISTEN",
	"BINDING_NAME_TRP3_QUEST_LOOK",
	"BINDING_NAME_TRP3_QUEST_TALK",
	"BINDING_NAME_TRP3_QUESTLOG",
	"BINDING_NAME_TRP3_SEARCH_FOR_ITEMS",
	"Ellyb",
	"StaticPopupDialogs",
	"UISpecialFrames",
};

read_globals = {
	C_Map = {
		fields = {
			"GetBestMapForUnit",
		},
	},

	C_MountJournal = {
		fields = {
			"GetMountInfoByID",
			"GetMountInfoExtraByID",
			"SummonByID",
		},
	},

	C_PetJournal = {
		fields = {
			"GetSummonedPetGUID",
			"SummonPetByGUID",
			"SummonRandomPet",
		},
	},

	C_Timer = {
		fields = {
			"After",
			"NewTicker",
		},
	},

	C_ToyBox = {
		fields = {
			"GetToyLink",
		},
	},

	"APIDocumentation",
	"APIDocumentation_LoadUI",
	"BROWSE",
	"CameraZoomIn",
	"CameraZoomOut",
	"CANCEL",
	"CASTING_BAR_ALPHA_STEP",
	"CASTING_BAR_FLASH_STEP",
	"CASTING_BAR_HOLD_TIME",
	"CastingBarFrame_ApplyAlpha",
	"CastingBarFrame_FinishSpell",
	"CastingBarFrame_GetEffectiveStartColor",
	"CHARACTER",
	"ChatEdit_GetActiveWindow",
	"ChatFontNormal",
	"ChatTypeInfo",
	"CheckInteractDistance",
	"CombatLogGetCurrentEventInfo",
	"CreateFrame",
	"CreateMacro",
	"date",
	"DELETE",
	"DestinyFontHuge",
	"DismissCompanion",
	"DoEmote",
	"EmoteList",
	"Enum",
	"ERR_BAG_FULL",
	"ERR_DROP_BOUND_ITEM",
	"ERR_ITEM_COOLDOWN",
	"ERR_TRADE_BOUND_ITEM",
	"ERR_TRADE_CANCELLED",
	"floor",
	"GameFontNormal",
	"GameFontNormalLarge",
	"GameFontNormalSmall",
	"GameTooltip",
	"GameTooltipHeader",
	"GetAchievementInfo",
	"GetCoinTextureString",
	"GetItemInfo",
	"GetMacroIndexByName",
	"GetMouseFocus",
	"GetNumMacros",
	"GetPlayerInfoByGUID",
	"GetSpellBookItemName",
	"GetSpellInfo",
	"GetTime",
	"GetUnitSpeed",
	"hooksecurefunc",
	"HTML_END",
	"HTML_START",
	"INTERRUPTED",
	"INVENTORY_TOOLTIP",
	"IsAddOnLoaded",
	"IsAltKeyDown",
	"IsControlKeyDown",
	"IsModifiedClick",
	"issecurevariable",
	"IsShiftKeyDown",
	"ITEM_BIND_QUEST",
	"ITEM_CREATED_BY",
	"ITEM_QUALITY0_DESC",
	"ITEM_QUALITY1_DESC",
	"ITEM_QUALITY2_DESC",
	"ITEM_QUALITY3_DESC",
	"ITEM_QUALITY4_DESC",
	"ITEM_QUALITY5_DESC",
	"ITEM_QUALITY6_DESC",
	"ITEM_QUALITY7_DESC",
	"ITEM_SOULBOUND",
	"ITEM_UNIQUE",
	"LibStub",
	"min",
	"Mixin",
	"ModelFrameMixin",
	"MouseIsOver",
	"NavBar_AddButton",
	"NavBar_ButtonOnEnter",
	"NavBar_ButtonOnLeave",
	"NavBar_Initialize",
	"NavBar_Reset",
	"ObjectiveTrackerBlocksFrame",
	"PickupMacro",
	"PROFESSIONS_USED_IN_COOKING",
	"QUEST_LOG",
	"QUEST_OBJECTIVES",
	"QuestFont_Huge",
	"ReloadUI",
	"REMOVE",
	"RESET",
	"ResetCursor",
	"SAVE",
	"SaveView",
	"SEARCH",
	"SECURITY_LEVEL",
	"SendChatMessage",
	"SetCursor",
	"SetView",
	"SPELL_FAILED_BAD_IMPLICIT_TARGETS",
	"SPELL_FAILED_MOVING",
	"SpellBook_GetSpellBookSlot",
	"SpellBookFrame",
	"sqrt",
	"StackSplitFrame",
	"StackSplitFrameLeft_Click",
	"StackSplitFrameRight_Click",
	"StaticPopup_Show",
	"strcmputf8i",
	"strconcat",
	"strjoin",
	"strsplit",
	"strtrim",
	"TargetFrameTextureFrameName",
	"tContains",
	"TextEmoteSpeechList",
	"time",
	"tinsert",
	"tInvert",
	"ToggleFrame",
	"ToggleSheath",
	"TRADE",
	"tremove",
	"UIParent",
	"UnitClass",
	"UnitExists",
	"UnitFactionGroup",
	"UnitIsPlayer",
	"UnitIsUnit",
	"UnitName",
	"UnitPosition",
	"UnitRace",
	"UnitSex",
	"UNKNOWN",
	"UNKOWN",
	"USE",
	"wipe",
	"WorldMapFrame",
	"WoWUnit",
};

std = "lua51";
