// TODO match line infos

class Ebio extends GenericNpc {
    function OnPlayerTalked(hplayer, htarget) {
        print("Ebio::OnPlayerTalked:" + hplayer + "," + htarget)

        if(get_town_account(htarget) == 1) {
            local ds = EbioDrinkSequence()
            local drink_state = ds.GetState(0)

            const neg1 = -1
            if(drink_state != neg1) {
                PadOffWait(0)

                this.__StartTownTalkAction(this.hplayer_, this.hself)

                func_wait(is_talk_camera_ready)
            }

            switch(drink_state) {
                case 0:
                    local exist_shop = exist_own_shop_by_oasis(this.hself)
                    if(exist_shop) {
                        this.__DrinkEvent_Start()
                    } else {
                        this.__DrinkEvent_NoShop()
                    }
                    break;
                case 1:
                    this.__DrinkEvent_NoMaterial()
                    break;
                case 2:
                    this.__DrinkEvent_MaterialComplete()
                    break;
                case 3:
                    this.__DrinkEvent_Making()
                    break;
                case 4:
                    this.__DrinkEvent_DrinkComplete()
                    break;
            }

            if(drink_state != neg1) {
                this.__EndTownTalkAction(this.hplayer_, this.hself)
                
                PadOnWait(0)

                return;
            }
        }

        GenericNpc.OnPlayerTalked(hplayer, htarget)
    }

    function __DrinkEvent_NoShop() {
        local h_talk_acts = TalkDemo_1_1_Initialize(0, 701, 2)
        local h_talk_player = h_talk_acts[0]
        local h_talk_target = h_talk_acts[1]

        msg_sync_talk_event(93048, h_talk_target)
        start_actor_motion_auto_idle(h_talk_player, 231)
        start_actor_lip(h_talk_player, 2)
        
        wait_for_true2(is_motion_finished, h_talk_player, 231)

        msg_sync_talk_event(93049, h_talk_target)
        msg_sync_talk_event(93050, h_talk_target)
        msg_sync_talk_event(93051, h_talk_target)

        local h_talk_acts = [h_talk_player, h_talk_target]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
    }

    function __DrinkEvent_Start() {
        ForceStartOptionalQuestEventArgs_SetEventMode(30, [this.hself, 0], false)
    }

    function __DrinkEvent_NoMaterial() {
        local h_talk_acts = TalkDemo_1_1_Initialize(0, 701, 2)
        local h_talk_player = h_talk_acts[0]
        local h_talk_target = h_talk_acts[1]

        msg_sync_talk_event(93059, h_talk_target)
        msg_sync_talk_event(93057, h_talk_target)
        msg_sync_talk_event(93058, h_talk_target)

        local h_talk_acts = [h_talk_player, h_talk_target]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
    }

    function __DrinkEvent_MaterialComplete() {
        ForceStartOptionalQuestEventArgs_SetEventMode(39, [this.hself, 0], false)
    }

    function __DrinkEvent_Making() {
        local h_talk_acts = TalkDemo_1_1_Initialize(0, 701, 2)
        local h_talk_player = h_talk_acts[0]
        local h_talk_target = h_talk_acts[1]

        msg_sync_talk_event(93063, h_talk_target)

        local h_talk_acts = [h_talk_player, h_talk_target]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
    }

    function __DrinkEvent_DrinkComplete() {
        local h_talk_acts = TalkDemo_1_1_Initialize(0, 701, 2)
        local h_talk_player = h_talk_acts[0]
        local h_talk_target = h_talk_acts[1]

        msg_sync_talk_event(93115, h_talk_target)

        local h_talk_acts = [h_talk_player, h_talk_target]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
    }
}
