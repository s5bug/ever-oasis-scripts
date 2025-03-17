// TODO match line infos

class SwitchObjActor extends BgobjActorBase {
    function CreateAndInit() {
        local sw_state = false
        local flag = this.GetFlag()

        if(flag > 0 && test_flag(flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)

        if(this.act_type_ == 56) {
            this.SetSwitchCameraShake(1)
        }

        this.CreateActor()
    }
}
