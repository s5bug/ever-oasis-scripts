// TODO match line infos

class CreateWhenFlagOnActor extends BgobjActorBase {
    function CreateAndInit() {
        local flag = this.GetFlag()

        if(flag > 0 && test_flag(flag) == false) return;

        this.CreateActor()
    }
}
