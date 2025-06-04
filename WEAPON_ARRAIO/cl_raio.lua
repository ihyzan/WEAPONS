local weaponHash = `WEAPON_SPECIALCARBINEMK2RAIO`
local muzzleFx = 'muz_xs_railgun'
local muzzleFxAsset = 'scr_xs_props'

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        if IsPedShooting(ped) and GetSelectedPedWeapon(ped) == weaponHash then
            UseParticleFxAssetNextCall(muzzleFxAsset)
            StartNetworkParticleFxNonLoopedOnEntityBone(muzzleFx, ped, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(ped, 0x6F06), 1.0, false, false, false)
        end
    end
end)

AddEventHandler('gameEventTriggered', function(name, args)
    if name == 'CEventNetworkEntityDamage' then
        local victim = args[1]
        local attacker = args[2]
        local weapon = args[5]
        if weapon == weaponHash and attacker == PlayerPedId() and IsEntityAPed(victim) then
            ApplyDamageToPed(victim, 10, false)
            UseParticleFxAssetNextCall('core')
            StartNetworkParticleFxNonLoopedOnEntity('ent_sht_electrical_box_sp', victim, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false)
        end
    end
end)

