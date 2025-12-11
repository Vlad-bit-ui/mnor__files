local canToggle = true
local keysReleased = true

hook.Add("Think", "ToggleMenuOnKeyPress", function()
    local ctrl = input.IsKeyDown(KEY_LCONTROL)
    local o = input.IsKeyDown(KEY_O)

    if ctrl and o and canToggle and keysReleased then
        keysReleased = false
        canToggle = false

        if IsValid(MenuFrame) then
            MenuFrame:Remove()
            MenuFrame = nil
        else
            MenuFrame = vgui.Create("DFrame")
            MenuFrame:SetSize(ScrW(), ScrH())
            MenuFrame:SetTitle("")
            MenuFrame:Center()
            MenuFrame:SetDraggable(false)
            MenuFrame:ShowCloseButton(false)
            MenuFrame:MakePopup()

            local html = vgui.Create("DHTML", MenuFrame)
            html:Dock(FILL)
            html:SetAllowLua(true)
            html:OpenURL("asset://garrysmod/addons/global_menu/Cef/index.min.html")
            html:AddFunction("menu", [[
                var link = document.createElement("link");
                link.rel = "stylesheet";
                link.type = "text/css";
                link.href = "asset://garrysmod/addons/global_menu/Cef/css/main.css";
                document.head.appendChild(link);
            ]])
        end

        timer.Simple(0.2, function() canToggle = true end)
    end

    if not ctrl and not o then
        keysReleased = true
    end
end)
