// TODO match line infos

class SwitchMonitorActor extends BgobjActorBase {
    function CreateAndInit() {
        local sw_state = false
        local flag = this.GetFlag()

        if(flag > 0 && test_flag(flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)
        this.SetSwitchMode(4)
        this.CreateActor()
    }
}
