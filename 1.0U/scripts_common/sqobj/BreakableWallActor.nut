// TODO match line infos

class BreakableWallActor extends BgobjActorBase {
    function CreateAndInit() {
        local mode = this.GetBgobjMode()
        if(mode == 0 || mode == 2) {
            local flag = this.GetFlag()

            if(flag > 0 && test_flag(flag)) {
                this.SetBgobjMode(1)
            }
        }

        this.CreateActor()
    }
}
