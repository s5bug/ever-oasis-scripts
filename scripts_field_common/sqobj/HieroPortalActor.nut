// TODO match line infos

class HieroPortalActor extends BgobjActorBase {
    function CreateAndInit() {
        this.CreateActor()
        if(this.hself_ <= 0) return;

        register_player_responder(this.hself_, 4, [12.0, 360.0, 360.0])
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
        PadOffWait(0)

        if(!test_flag(3928)) {
            ui_sync(5, [83203, 83204])
            set_flag(3928)
        }

        local result = ui_sync(60, [4398, 1])
        if(result[0] == 1) {
            local party_count = get_party_count()
            for(local i = 0; i < party_count; i++) {
                local hact = get_party_order(i)
                start_actor_motion(hact, 1787)
            }

            wait(90)
            
            ui_sync(67, [1])
            clear_fade_info()
            fadeout(0, 0, 2.0, 0, 1)

            const neg7 = -7
            wait(neg7)
            
            BackHieroJumpOnly()
        }

        PadOnWait(0)
    }
}
