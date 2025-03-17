// TODO match line infos

class WeightSwitchActor extends BgobjActorBase {
    function CreateAndInit() {
        this.SetSwitchMode(1)
        
        local sw_state = false
        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)
        this.CreateActor()
    }
}
