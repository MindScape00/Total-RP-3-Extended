----------------------------------------------------------------------------------
-- Total RP 3: Extended features
--	---------------------------------------------------------------------------
--	Copyright 2015 Sylvain Cossement (telkostrasz@totalrp3.info)
--
--	Licensed under the Apache License, Version 2.0 (the "License");
--	you may not use this file except in compliance with the License.
--	You may obtain a copy of the License at
--
--		http://www.apache.org/licenses/LICENSE-2.0
--
--	Unless required by applicable law or agreed to in writing, software
--	distributed under the License is distributed on an "AS IS" BASIS,
--	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--	See the License for the specific language governing permissions and
--	limitations under the License.
----------------------------------------------------------------------------------

local Globals, Events, Utils, EMPTY = TRP3_API.globals, TRP3_API.events, TRP3_API.utils, TRP3_API.globals.empty;
local tostring, tonumber, tinsert, strtrim, pairs, assert, wipe = tostring, tonumber, tinsert, strtrim, pairs, assert, wipe;
local tsize = Utils.table.size;
local getFullID, getClass = TRP3_API.extended.getFullID, TRP3_API.extended.getClass;
local stEtN = Utils.str.emptyToNil;
local loc = TRP3_API.locale.getText;
local setTooltipForSameFrame = TRP3_API.ui.tooltip.setTooltipForSameFrame;
local setTooltipAll = TRP3_API.ui.tooltip.setTooltipAll;
local color = Utils.str.color;
local toolFrame, step, editor;

local TABS = {
	MAIN = 1,
	WORKFLOWS = 2,
	EXPERT = 3
}

local tabGroup, currentTab, linksStructure;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Logic
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local function editStep(stepID)
	editor.title:SetText(("%s: %s"):format(loc("DI_STEP_EDIT"), stepID));
	local data = toolFrame.specificDraft.DS[stepID];

	-- Load
	editor.text.scroll.text:SetText(data.TX or "");

	editor.stepID = stepID;
end

local function decorateStepLine(line, stepID)
	local data = toolFrame.specificDraft;
	local stepData = data.DS[stepID];

	line.Name:SetText("Step " .. stepID);
	line.Description:SetText(stepData.TX or "");
--	line.ID:SetText(loc("CA_NPC_ID") .. ": " .. stepID);
	line.click.stepID = stepID;
end

local function refreshStepList()
	local data = toolFrame.specificDraft;
	TRP3_API.ui.list.initList(step.list, data.DS, step.list.slider);
end

local function addStep()
	local data = toolFrame.specificDraft;
	tinsert(data.DS, {
		TX = "Hello"
	});
	refreshStepList();
	editStep(#data.DS);
end

local function saveStep(stepID)
	local data = toolFrame.specificDraft.DS[stepID];

	data.TX = stEtN(strtrim(editor.text.scroll.text:GetText()));

	refreshStepList();
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Script tab
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local function loadDataScript()
	-- Load workflows
	if not toolFrame.specificDraft.SC then
		toolFrame.specificDraft.SC = {};
	end
	TRP3_ScriptEditorNormal.loadList(TRP3_DB.types.DIALOG);
end

local function storeDataScript()
	-- TODO: compute all workflow order
	for workflowID, workflow in pairs(toolFrame.specificDraft.SC) do
		TRP3_ScriptEditorNormal.linkElements(workflow);
	end
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- Load ans save
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local function load()
	assert(toolFrame.rootClassID, "rootClassID is nil");
	assert(toolFrame.fullClassID, "fullClassID is nil");
	assert(toolFrame.rootDraft, "rootDraft is nil");
	assert(toolFrame.specificDraft, "specificDraft is nil");

	local data = toolFrame.specificDraft;
	if not data.BA then
		data.BA = {};
	end
	if not data.DS then
		data.DS = {};
	end

	loadDataScript();
	refreshStepList();
	editStep(1);

	tabGroup:SelectTab(TRP3_Tools_Parameters.editortabs[toolFrame.fullClassID] or TABS.MAIN);
end

local function saveToDraft()
	assert(toolFrame.specificDraft, "specificDraft is nil");

	local data = toolFrame.specificDraft;

	storeDataScript();
end

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- UI
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

local function onTabChanged(tabWidget, tab)
	assert(toolFrame.fullClassID, "fullClassID is nil");

	-- Hide all
	currentTab = tab or TABS.MAIN;
	step:Hide();
	editor:Hide();
	TRP3_ScriptEditorNormal:Hide();

	-- Show tab
	if currentTab == TABS.MAIN then
		step:Show();
		editor:Show();
	elseif currentTab == TABS.WORKFLOWS then
		TRP3_ScriptEditorNormal:SetParent(toolFrame.cutscene.normal);
		TRP3_ScriptEditorNormal:SetAllPoints();
		TRP3_ScriptEditorNormal:Show();
	end

	TRP3_Tools_Parameters.editortabs[toolFrame.fullClassID] = currentTab;
end

local function createTabBar()
	local frame = CreateFrame("Frame", "TRP3_ToolFrameCutsceneNormalTabPanel", toolFrame.cutscene.normal);
	frame:SetSize(400, 30);
	frame:SetPoint("BOTTOMLEFT", frame:GetParent(), "TOPLEFT", 15, 0);

	tabGroup = TRP3_API.ui.frame.createTabPanel(frame,
		{
			{ loc("EDITOR_MAIN"), TABS.MAIN, 150 },
			{ loc("WO_WORKFLOW"), TABS.WORKFLOWS, 150 },
		},
		onTabChanged
	);
end


--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- INIT
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

function TRP3_API.extended.tools.initCutsceneEditorNormal(ToolFrame)
	toolFrame = ToolFrame;
	toolFrame.cutscene.normal.load = load;
	toolFrame.cutscene.normal.saveToDraft = saveToDraft;

	createTabBar();

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- List
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	step = toolFrame.cutscene.normal.step;
	step.title:SetText(loc("DI_STEPS"));

	-- List
	step.list.widgetTab = {};
	for i=1, 5 do
		local line = step.list["line" .. i];
		tinsert(step.list.widgetTab, line);
		line.click:SetScript("OnClick", function(self, button)
			if button == "RightButton" then
				removeStep(self.stepID);
			else
				editStep(self.stepID);
			end
		end);
		line.click:SetScript("OnEnter", function(self)
			TRP3_RefreshTooltipForFrame(self);
			self:GetParent().Highlight:Show();
		end);
		line.click:SetScript("OnLeave", function(self)
			TRP3_MainTooltip:Hide();
			self:GetParent().Highlight:Hide();
		end);
		line.click:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		setTooltipForSameFrame(line.click, "RIGHT", 0, 5, loc("DI_STEP"),
			("|cffffff00%s: |cff00ff00%s\n"):format(loc("CM_CLICK"), loc("CM_EDIT")) .. ("|cffffff00%s: |cff00ff00%s"):format(loc("CM_R_CLICK"), REMOVE));
	end
	step.list.decorate = decorateStepLine;
	TRP3_API.ui.list.handleMouseWheel(step.list, step.list.slider);
	step.list.slider:SetValue(0);
	step.list.add:SetText(loc("DI_STEP_ADD"));
	step.list.add:SetScript("OnClick", function() addStep() end);

	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	-- Editor
	--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

	editor = toolFrame.cutscene.normal.editor;
	editor.text.title:SetText(loc("DI_STEP_TEXT"));
	editor.save:SetScript("OnClick", function(self)
		saveStep(self:GetParent().stepID);
	end);

end