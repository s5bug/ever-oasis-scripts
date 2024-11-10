// TODO match line infos

class FlagActor extends BgobjActorBase {
    function CreateAndInit() {
        this.CreateActor()

        print("FLAG_ACTOR_____________________________")

        if(this.hself_ != 0) {
            print("FLAG_ACTOR__MOTION_SATRT_____________________________")

            start_actor_motion(this.hself_, 702)
        }
    }
}
