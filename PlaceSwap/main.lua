local function swapPcs(ref)
	-- gets player current cell
	local current_cell = tes3.getPlayerCell()
	-- get copy of the player's position
	local player_pos = tes3.mobilePlayer.position:copy()
	-- get copy of the npc's position
	local npc_pos = ref.position:copy()
	-- swaps both using position cell
	tes3.positionCell(
		{
		  reference = tes3.mobilePlayer,
		  cell = current_cell,
		  position = npc_pos,
		  forceCellChange = false,
		  suppressFader = true,
		  teleportCompanions = false
		}
	)
	tes3.positionCell(
		{
		  reference = ref,
		  cell = current_cell,
		  position = player_pos,
		  forceCellChange = false,
		  suppressFader = true,
		  teleportCompanions = false
		}
	)
end

--local function moveAway(ref)
--	local npc = ref
--end

local function isRefValid(ref)
	if (ref ~= nil and ref.object.objectType == tes3.objectType.npc) then
		if not (ref.object.mobile.inCombat) then
			return true
		end
	end
	return false
end

local function checkTarget(e)
	local target_ref = tes3.getPlayerTarget()
	if (e.isShiftDown and isRefValid(target_ref)) then
		swapPcs(target_ref)
	end
	--if (e.isAltDown and isRefValid(target_ref)) then
	--	moveAway(target_ref)
	--end
end

local function init()
	event.register("keyDown", checkTarget, { filter = tes3.scanCode.q } )
	mwse.log("[Jay's Place Swap] Initialized!")
end

event.register('initialized', init)