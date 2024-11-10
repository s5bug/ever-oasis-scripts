// TODO match line infos

class PropellerCactus extends BgobjActorBase {
    function CreateAndInit() {
        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) return;

        if(this.bgobj_id_ == 4126) {
            local bgobj_mode = this.GetBgobjMode()

            if(bgobj_mode == 1) {
                this.SetDropTableId(0)
            }
        } else if(this.bgobj_id_ == 4214) {
            this.SetBgobjMode(2)

            local action_frame = this.GetFrame()
            this.SetFrame(0.0)

            local attack_pow = this.GetFloatParam(0)
            if(attack_pow <= 0) {
                print("ERROR:プロペラサボテン爆弾にAttackPowerが設定されていません")
                this.SetFloatParam(0, 1.0)
            }

            this.SetFloatParam(1, 3.0)
        } else {
            assert(0)
        }

        this.CreateActor()
    }

    function OnActorDeadEvent(hact) {
        print("PropellerCactus::OnActorDeadEvent [act:" + hact + "]")
    }
}
