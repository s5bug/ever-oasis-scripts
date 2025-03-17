// TODO match line infos

class WarpGateActor extends BgobjActorBase {
    function CreateAndInit() {
        this.CreateActor()
        if(this.hself_ <= 0) return;

        register_player_responder(this.hself_, 4, [12.0, 0.0, 0.0])
        set_player_responder_caption(this.hself_, 4, 4781)
        
        local flag = this.GetFlag()
        if(flag <= 0 || test_flag(flag)) {
            start_actor_motion(this.hself_, 97)
        } else {
            start_actor_motion(this.hself_, 98)
            set_enable_bgobj_responder(this.hself_, false)
        }
    }

    function Activate() {
        start_actor_motion(this.hself_, 182)
        set_enable_bgobj_responder(this.hself_, true)
        this.SetSelfFlag()
    }

    function OnPlayerHatena(hplayer, htarget) {
        set_flag(873)
        this.OpenGateDialog(956, this.hself_)
    }

    function OpenGateDialog(mes_id, target_hact) {
        print("WarpGateActor::OpenGateDialog")

        PadOffWait(0)

        local dlog_res = ui_sync(60, [mes_id, 1])
        local result = false

        if(dlog_res[0] == 1) {
            if(__GetEnterRandomDungeon() || __GetEnterField()) {
                local party_count = get_party_count()
                for(local i = 0; i < party_count; ++i) {
                    local hact = get_party_order(i)
                    start_actor_motion(hact, 1787)
                }

                wait(15)
                
                local scene_id = get_scene_id_from_zone(4, -1, -1)

                clear_fade_info()
                fadeout_sync(0, 0, 2.0, 0, 1)
                request_jump_scene(scene_id, 0.0, 0.0, 0.0, 0.0, 0)
            } else {
                result = PortalProsess(10, true)
                if(!result) {
                    PadOnWait(0)
                }
            }
        } else {
            PadOnWait(0)
        }

        return result;
    }
}
