// TODO match line infos

class InvisibleWallActor extends BgobjActorBase {
    function CreateAndInit() {
        this.CreateActor()

        if(this.hself_ == 0) {
            print("error:アクター生成失敗")
            return;
        }

        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) {
            this.Deactivate()
        }
    }

    function Destroy() {
        this.SetSelfFlag()
        destroy_actor(this.hself_)
        this.hself_ = 0
    }

    function Activate() {
        set_actor_collision(this.hself_, true)
    }

    function Deactivate() {
        set_actor_collision(this.hself_, false)
    }
}
