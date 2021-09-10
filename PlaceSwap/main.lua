local function swapPcs(target)
	
	-- gets player current cell
	local current_cell = tes3.getPlayerCell()
	
	-- get copy of the player's position
	local player_pos = tes3.mobilePlayer.position:copy()
	
	-- get copy of the npc's position
	local npc_pos = target.position:copy()
	
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
		  reference = target, 
		  cell = current_cell, 
		  position = player_pos, 
		  forceCellChange = false, 
		  suppressFader = true, 
		  teleportCompanions = false 
		}
	)
end

local function checkTarget(e)
	if (e.isShiftDown) then
		local target = tes3.getPlayerTarget()
		if (target ~= nil and target.object.objectType == tes3.objectType.npc) then
			if not (target.object.mobile.inCombat) then
				swapPcs(target)
			end
		end
	end
	-- to do move away code
end

local function init()
	event.register("keyDown", checkTarget, { filter = tes3.scanCode.q } )
	mwse.log("[Jay's Place Swap] Initialized!")
end

event.register('initialized', init)