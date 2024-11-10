// TODO match line infos

class FixedArtilleryActor extends BgobjActorBase {
    function CreateAndInit() {
        local was_broken_flag = this.GetFlag(1)
        if(was_broken_flag > 0 && test_flag(was_broken_flag)) return;

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

    function OnActorDeadEvent(hact) {
        this.SetSelfFlag(1)
        this.SendReaction()
    }

    function Destroy() {
        this.SetSelfFlag(1)
        destroy_actor(this.hself_)
        this.hself_ = 0
    }
}
