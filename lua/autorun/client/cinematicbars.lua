CreateClientConVar( "cinematicbar_barsize", "0.3", true, false )
CreateClientConVar( "cinematicbar_effects", "0", true, false )
CreateClientConVar( "cinematicbar_vertical", "0", true, false )
local amount = GetConVar( "cinematicbar_barsize" )
local effect = GetConVar( "cinematicbar_effects" )
local vertical = GetConVar( "cinematicbar_vertical" )

local function DrawNoGapRect( x, y, w, h )
	surface.DrawRect( x - 1, y - 1, w + 2, h + 2 )
end

local function DrawBars( vertical, scale )
	if vertical then
		local size = scale * ScrW() / 2
		DrawNoGapRect( 0, 0, size, ScrH() )
		DrawNoGapRect( ScrW() - size, 0, size, ScrH() )
	else
		local size = scale * ScrH() / 2
		DrawNoGapRect( 0, 0, ScrW(), size )
		DrawNoGapRect( 0, ScrH() - size, ScrW(), size )
	end
end

hook.Add( "RenderScreenspaceEffects", "DrawCinematicBars", function()
	local scale = amount:GetFloat()
	if scale > 0 then
		surface.SetDrawColor( 0, 0, 0 )
		DrawBars( vertical:GetBool(), scale )
		if effect:GetBool() then
			DrawBloom( 0.1, scale * 4, 22, 0, 1, 1, 0.8, 0.5, 0.2 )
		end
	end
end )

hook.Add( "PopulateToolMenu", "CinematicBarSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "Cinematic", "Cinematic_Bar_Options", "Cinematic Bars", "", "", function( panel )
		panel:ClearControls()
		panel:NumSlider( "Bar size", "cinematicbar_barsize", 0, 1 )
		panel:CheckBox( "Vertical bars", "cinematicbar_vertical" )
		panel:CheckBox( "Stereotypical movie effects", "cinematicbar_effects" )
	end )
end )
