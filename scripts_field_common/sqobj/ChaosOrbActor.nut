// TODO match line infos

class ChaosOrbActor extends BgobjActorBase {
    function CreateAndInit() {
        local was_broken_flag = this.GetFlag()

        if(was_broken_flag > 0 && test_flag(was_broken_flag)) return;

        this.CreateActor()
    }

    function Activate() {
        if(this.hself_ > 0) {
            change_state_switch_actor(this.hself_, 1, 0)
        }
    }

    function OnActorDeadEvent(hact) {
        this.SetSelfFlag(0)
    }

    function Destroy() {
        this.SetSelfFlag(0)
        destroy_actor(this.hself_)
        this.hself_ = 0
    }
}
