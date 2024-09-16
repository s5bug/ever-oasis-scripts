// TODO match line infos

class EventResponderActor extends BgobjActorBase {
    hatena_action_ = null

    function CreateAndInit() {
        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) return;

        local type = this.GetBgobjMode()
        if(type == 0) {
            this.hatena_action_ = this.SendReaction
        } else if(type == 1) {
            this.hatena_action_ = this.__HatenaActionOnce
        } else if(type == 2) {
            this.hatena_action_ = this.SendReaction
        } else if(type == 3) {
            this.hatena_action_ = this.__HatenaActionOnce
        } else {
            print("ERROR:EventResponderActor bgobj mode out of range")
        }

        this.CreateActor()
        if(this.hself_ <= 0) return;

        register_player_responder(this.hself_, 4, [15.0, 0.0, 0.0])
        if(type == 2 || type == 3) {
            local activated_flag = this.GetFlag(1)
            if(activated_flag > 0 && !test_flag(activated_flag)) {
                set_enable_bgobj_responder(this.hself_, false)
            }
        }
    }

    function OnPlayerHatena(hplayer, htarget) {
        if(this.hatena_action_) {
            this.hatena_action_()
        }
    }

    function Activate() {
        set_enable_bgobj_responder(this.hself_, true)
        this.SetSelfFlag(1)
    }

    function Deactivate() {
        set_enable_bgobj_responder(this.hself_, false)
        this.ResetSelfFlag(1)
    }

    function __HatenaActionOnce() {
        this.SetSelfFlag()
        destroy_actor(this.hself_)
        this.SendReaction()
    }
}
