// TODO match line infos

class DieObjActor extends BgobjActorBase {
    function CreateAndInit() {
        local flag = this.GetFlag()

        if(flag > 0 && test_flag(flag)) return;

        this.CreateActor()
    }

    function OnActorDeadEvent(hact) {
        this.__DestroyEvent()
    }

    function __DestroyEvent() {
        this.SetSelfFlag()
    }
}
