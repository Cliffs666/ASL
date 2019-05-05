state("AI")
{
	int fadeState : 0x15D24B4;
	float fadeNum : 0x15D24B8;
	byte gameFlowState : 0x12F0C88, 0x48, 0x8;
	int levelManagerState : 0x12F0C88, 0x3C, 0x4C;
	byte loadingIcon : 0x134A7D0, 0x1D;
	int missionNum : 0x17E4814, 0x4, 0x4E8;
}

startup
{
	vars.loading = false;
	vars.final = false;
	vars.mission = null;
}

init
{
	vars.loading = false;
	vars.final = false;
}

start
{
	vars.loading = false;
	vars.final = false;
	vars.mission = null;
	return current.fadeState == 2 && current.fadeNum > 0 || old.gameFlowState == 6 && current.gameFlowState == 4;
}

update
{
	if (old.levelManagerState == 5 && current.levelManagerState == 7 || current.gameFlowState == 6)
	{
		vars.loading = true;
	}
	else if (current.fadeState == 2 && old.fadeNum < 0.2 && current.fadeNum > 0.2)
	{
		vars.loading = false;
	}
	if (current.missionNum == 19 && current.fadeState == 2 && old.fadeNum < 0.5 && current.fadeNum > 0.5)
	{
		vars.final = true;
	}
	if (vars.mission == null && current.fadeState == 2 && old.fadeNum < 0.5 && current.fadeNum > 0.5)
	{
		vars.mission = current.missionNum;
	}
}

split
{
	if (vars.mission != null && current.missionNum > vars.mission)
	{
		vars.mission = current.missionNum;
		return true;
	}
	else if (vars.final == true && current.fadeState == 1 && current.gameFlowState == 4)
	{
		vars.final = false;
		return true;
	}
}

isLoading
{
	return vars.loading;
}