// TODO match line infos

class HieroRecoveryObjectActor extends BgobjActorBase {
    use_flag_ = 0

    function CreateAndInit() {
        this.CreateActor()
        if(this.hself_ <= 0) return;

        register_player_responder(this.hself_, 4, [12.0, 360.0, 270.0])
        set_player_responder_caption(this.hself_, 4, 4781)

        this.use_flag_ = this.GetFlag()
        if(this.use_flag_ > 0 && test_flag(this.use_flag_)) {
            set_enable_bgobj_responder(this.hself_, false)
            start_actor_motion(this.hself_, 674)
        } else {
            start_actor_motion(this.hself_, 672)
        }
    }

    function OnPlayerHatena(hplayer, htarget) {
        PadOffWait(0)

        if(!test_flag(3927)) {
            ui_sync(5, [83205, 83206])
            set_flag(3927)
        }

        heal_party_emit_effect()
        recovery_abnormal()

        if(this.use_flag_ > 0) {
            set_flag(this.use_flag_)
            set_enable_bgobj_responder(this.hself_, false)
            start_actor_motion(this.hself_, 673)
        }

        wait(60)

        PadOnWait(0)
    }
}
