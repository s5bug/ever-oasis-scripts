// TODO match line infos

class CreateWhenFlagOffActor extends BgobjActorBase {
    function CreateAndInit() {
        local flag = this.GetFlag()

        if(flag > 0 && test_flag(flag)) return;

        this.CreateActor()
    }

    function OnActorDeadEvent(hact) {
        this.SetSelfFlag()
    }

    function Destroy() {
        this.SetSelfFlag()
        destroy_actor(this.hself_)
        this.hself_ = 0
    }
}
