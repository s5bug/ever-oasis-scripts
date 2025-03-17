// TODO match line infos

class GenericFenceActor extends BgobjActorBase {
    function CreateAndInit() {
        local type = this.GetBgobjMode()
        local was_locked_flag = this.GetFlag()

        local sw_state = false
        if(was_locked_flag > 0 && test_flag(was_locked_flag)) {
            sw_state = true
        }

        this.SetSwitchMode(4)
        this.SetSwitchState(sw_state)

        local b_camera_shake = false
        if(this.bgobj_id_ == 4215) {
            b_camera_shake = true
        }
        if(this.bgobj_id_ == 4569) {
            b_camera_shake = true
        }

        if(b_camera_shake) {
            this.SetSwitchCameraShake(1)
        }

        this.CreateActor()
    }
}
