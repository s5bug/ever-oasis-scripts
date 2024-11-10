// TODO match line infos

class SimpleSwitchActor extends BgobjActorBase {
    function CreateAndInit() {
        if(this.bgobj_id_ == 4245) {
            this.SetSwitchState(false)
            this.SetSwitchMode(1)
            
            local was_on_flag = this.GetFlag()

            if(was_on_flag > 0 && test_flag(was_on_flag)) {
                this.SetSwitchState(true)
            }
        } else if(this.bgobj_id_ == 4250) {
            local auto_off = this.GetAutoOffInterval()

            if(auto_off <= 0) {
                print("ERROR:オフ時間が未設定です")
                this.SetAutoOffInterval(1.0)
            }

            this.SetSwitchState(false)
            this.SetSwitchMode(2)
        } else if(this.bgobj_id_ == 4249 || this.bgobj_id_ == 4577) {
            this.SetSwitchState(false)
            this.SetSwitchMode(0)
            
            local was_on_flag = this.GetFlag()

            if(was_on_flag > 0 && test_flag(was_on_flag)) {
                this.SetSwitchState(true)
            }
        } else {
            assert(0)
        }

        this.CreateActor()
    }

    function OnSwitchChanged(switch_state) {
        this.SendReaction()
    }
}
