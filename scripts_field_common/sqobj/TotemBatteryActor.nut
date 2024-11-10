// TODO match line infos

class TotemBatteryActor extends BgobjActorBase {
    function CreateAndInit() {
        this.CreateActor()
        if(this.hself_ > 0) {
            local was_on_flag = this.GetFlag(0)

            if(was_on_flag > 0 && test_flag(was_on_flag)) {
                change_state_switch_actor(this.hself_, 1, 0)
            }
        }
    }

    function Activate() {
        if(this.hself_ > 0) {
            change_state_switch_actor(this.hself_, 1, 0)
        }
    }
}
