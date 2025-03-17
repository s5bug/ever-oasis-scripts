// TODO match line infos

class ShinySandActor extends BgobjActorBase {
    function CreateAndInit() {
        local sw_state = false
        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)
        this.CreateActor()
    }

    function OnSwitchChanged(switch_state) {
        if(switch_state) {
            PadOffWait(0)

            set_camera_target(this.hself_, 0.0)
            motion_wait_with_id(this.hself_, 697)
            reset_camera_target()

            PadOnWait(0)

            this.SendReaction()
        }

        return 0;
    }
}
