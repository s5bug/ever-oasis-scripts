// TODO match line infos

class WadjetSteleActor extends BgobjActorBase {
    function CreateAndInit() {
        local sw_state = false
        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)
        this.CreateActor()
    }

    function OnPlayerHatena(hplayer, htarget) {
        print("■■■■■ CheckWadjetStele ■■■■■")

        local hact = get_party_index(0)
        local item_id = get_equipped(hact, 2)
        local event_check = check_mission_completed(109)

        if(event_check) {
            set_enemy_sleep(true)

            PadOffWait(0)

            msg_sync(94229, 0, [0, false, 0, 3])

            PadOnWait(0)

            set_enemy_sleep(false)
        } else if(item_id == 6528) {
            SetSceneScriptData(this.hself_)
            CompletedSpiritMission(109)
        } else {
            local scene = GetCurrentSceneObj()
            scene.demo_obj.StartDemo(4, [])
        }
    }
}
