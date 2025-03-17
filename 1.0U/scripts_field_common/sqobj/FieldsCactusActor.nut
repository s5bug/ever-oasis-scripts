// TODO match line infos

class FieldsCactusActor extends BgobjActorBase {
    function CreateAndInit() {
        local flag = this.GetFlag()
        if(flag > 0) {
            reset_flag(flag)
        }
        this.CreateActor()
    }
}
