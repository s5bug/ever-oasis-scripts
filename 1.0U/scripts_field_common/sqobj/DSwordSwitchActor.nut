// TODO match line infos

class DSwordSwitchActor extends BgobjActorBase {
    skill_action_ = null

    function CreateAndInit() {
        local bgobj_mode = this.GetBgobjMode()

        if(this.bgobj_id_ == 4166) {
            if(bgobj_mode == 0) {
                this.SetSwitchMode(1)

                this.skill_action_ = this.__SkillActionStateSwitch

                local was_on_flag = this.GetFlag()

                if(was_on_flag > 0 && test_flag(was_on_flag)) {
                    this.SetSwitchState(true)
                }
            } else if(bgobj_mode == 1) {
                this.SetSwitchMode(2)

                this.skill_action_ = this.__SkillActionStateSwitch

                local auto_off = this.GetAutoOffInterval()

                if(auto_off <= 0) {
                    print("ERROR:オフ時間が未設定です")
                    this.SetAutoOffInterval(13.0)
                }
            } else if(bgobj_mode == 2) {
                this.SetSwitchMode(2)

                this.skill_action_ = this.__SkillActionStateSwitch

                local auto_off = this.GetAutoOffInterval()

                if(auto_off <= 0) {
                    print("ERROR:オフ時間が未設定です")
                    this.SetAutoOffInterval(13.0)
                }
            }
        } else {
            assert(0)
        }

        this.CreateActor()
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        if(this.skill_action_) {
            this.skill_action_(hplayer, result)
        }
    }

    function __SkillActionStateSwitch(hplayer, result) {
        const neg1 = -1

        local eff_id = 7
        local mot_st = 1750
        local mot_lp = neg1
        local mot_ed = neg1
        local tribe = [3]
        local pos = [0.0, 0.0, 7.0, 0.0]
        local opt = [2, 3, 4]

        this.ReactResponderSwitchTypeContinueMain(hplayer, result, eff_id, mot_st, mot_lp, mot_ed, tribe, pos, opt, false)

        return 0;
    }
}
