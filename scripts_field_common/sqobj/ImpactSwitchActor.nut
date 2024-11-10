// TODO match line infos

class ImpactSwitchActor extends BgobjActorBase {
    function CreateAndInit() {
        local mode = this.GetBgobjMode()

        if(mode == 0) {
            // empty
        } else if(mode == 1) {
            this.SetSwitchMode(1)
        } else if(mode == 2) {
            this.SetSwitchMode(2)

            local auto_off = this.GetAutoOffInterval()
            if(auto_off <= 0) {
                this.SetAutoOffInterval(13.0)
            }
        } else if(mode == 3) {
            this.SetSwitchMode(2)

            local auto_off = this.GetAutoOffInterval()
            if(auto_off <= 0) {
                this.SetAutoOffInterval(13.0)
            }
        } else if(mode == 4) {
            local interval = this.GetNotificationInterval()
            if(interval <= 0) {
                this.SetNotificationInterval(6.7)
            }
        }

        local sw_state = false
        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)
        this.CreateActor()
    }

    function OnSwitchChanged(switch_state) {
        this.SendReaction()
    }

    function Activate() {
        set_enable_bgobj_responder(this.hself_, true)
        set_actor_collision(this.hself_, true)
    }

    function Deactivate() {
        set_enable_bgobj_responder(this.hself_, false)
        set_actor_collision(this.hself_, false)
    }
}
