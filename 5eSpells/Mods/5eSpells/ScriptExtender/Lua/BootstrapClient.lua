Ext.Require("S5E_BootstrapShared.lua")

local function OnSessionLoaded()

    _P("client load")
    Ext.Audio.LoadBank("pipes.bnk")

    Ext.Events.NetMessage:Subscribe(function(e) 

        --_D(e)
        if (e.Channel == "pipes") then
            --_P("pipes")
            Ext.Audio.PlayExternalSound("HUD","Splash_Logo_Larian","",4) --how does this work? good question
            -- i actually just yoinked the video_init bank and replaced the sound inside cause it was convenient 
        end
    
    
    
    
    end)


end
   
Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded)