--------------------------------------------------------------------------------
-- Kui Nameplates
-- By Kesava at curse.com
-- All rights reserved
--------------------------------------------------------------------------------
-- Base element script handler & base frame element registrar
-- Fetch state of the base nameplate elements, update registered elements
-- and dispatch messages
--------------------------------------------------------------------------------
local addon = KuiNameplates
local kui = LibStub('Kui-1.0')
local wipe = wipe

addon.Nameplate = {}
addon.Nameplate.__index = addon.Nameplate

-- Element registrar
-- TODO now that elements are external, element files should register which
-- elements they provide so that they can be called when disabled/enabled etc
function addon.Nameplate.RegisterElement(frame, element_name, element_frame)
    frame = frame.parent
    if frame[element_name] then return end
    frame.elements[element_name] = true
    frame[element_name] = element_frame
end
function addon.Nameplate.DisableElement(frame, element_name)
    frame = frame.parent
    if frame.elements[element_name] then
        frame.elements[element_name] = false
    end
end
function addon.Nameplate.EnableElement(frame, element_name)
    frame = frame.parent
    if frame.elements[element_name] == false then
        frame.elements[element_name] = true
    end
end
-------------------------------------------------------- Frame event handlers --
function addon.Nameplate.OnUnitAdded(f,unit)
    f = f.parent
    f.unit = unit
    f.handler:OnShow()
end
------------------------------------------------------- Frame script handlers --
function addon.Nameplate.OnShow(f)
    f = f.parent

    --[[ TODO
    if f.default.eliteIcon:IsVisible() then
        if f.default.eliteIcon:GetTexture() == "Interface\Tooltips\EliteNameplateIcon"
        then
            f.state.elite = true
        else
            f.state.rare = true
        end
    end
    ]]

    if f.elements.BossIcon then
        f.BossIcon:Show()
    end

    addon:DispatchMessage('Show', f)
    f:Show()
end
function addon.Nameplate.OnHide(f)
    f = f.parent
    if not f:IsShown() then return end

    f:Hide()
    addon:DispatchMessage('Hide', f)

    wipe(f.state)
end
function addon.Nameplate.Create(f)
    f = f.parent
    addon:DispatchMessage('Create', f)
end
