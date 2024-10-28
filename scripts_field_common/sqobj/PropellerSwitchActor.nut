// TODO match line infos

class PropellerSwitchActor extends BgobjActorBase {
    function CreateAndInit() {
        if(this.bgobj_id_ == 4132 || this.bgobj_id_ == 4620 || this.bgobj_id_ == 4298) {
            this.SetSwitchState(false)
            this.SetSwitchMode(1)
        } else if(this.bgobj_id_ == 4212) {
            this.SetSwitchState(false)
            this.SetSwitchMode(2)
            this.SetNotificationInterval(0.0)
        } else if(this.bgobj_id_ == 4268) {
            if(this.IsValidOption(2) == false) {
                this.SetSwitchMode(2)
            }
            this.SetSwitchState(false)
            this.SetNotificationInterval(0.0)
        } else {
            assert(0)
        }

        this.CreateActor()
        set_event_stop(this.hself_, true)
    }

    function Activate() {
        set_enable_bgobj_responder(this.hself_, true)
    }

    function Deactivate() {
        set_enable_bgobj_responder(this.hself_, false)
    }

    function OnPlayerHatena(hplayer, htarget) {
        set_demo_event(true)

        local eff_id = 9
        local motion = 1779

        start_actor_motion_auto_idle(hplayer, motion)

        wait_for_true1(is_motion_finished, hplayer)

        this.EventSkillResponderFailure(hplayer, eff_id)

        set_demo_event(false)
    }
}
