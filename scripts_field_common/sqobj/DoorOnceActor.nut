// TODO match line infos

class DoorOnceActor extends BgobjActorBase {
    function CreateAndInit() {
        local flag = this.GetFlag()
        local switch_state = false
        if(flag > 0 && test_flag(flag)) {
            switch_state = true
        }

        this.SetSwitchState(switch_state)
        this.CreateActor()
    }

    function Activate() {
        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) return;

        set_camera_target(this.hself_, 20.0)

        wait(30)

        change_state_switch_actor(this.hself_, 1, false)

        wait(60)

        reset_camera_target()
        this.SetSelfFlag()
    }
}
