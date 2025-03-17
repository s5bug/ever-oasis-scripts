// TODO match line infos

class SpearSwitchActor extends BgobjActorBase {
    skill_action_ = null

    function CreateAndInit() {
        if(this.bgobj_id_ == 4076) {
            local bgobj_mode = this.GetBgobjMode()

            if(bgobj_mode == 0) {
                this.SetSwitchMode(1)

                this.skill_action_ = this.__OnPlayerSkillAction

                local was_on_flag = this.GetFlag()

                if(was_on_flag > 0 && test_flag(was_on_flag)) {
                    this.SetSwitchState(true)
                }
            } else if(bgobj_mode == 1) {
                this.SetSwitchMode(2)

                this.skill_action_ = this.__OnPlayerSkillAction

                local auto_off = this.GetAutoOffInterval()

                if(auto_off <= 0) {
                    print("ERROR:オフ時間が未設定です")
                    this.SetAutoOffInterval(13.0)
                }
            } else if(bgobj_mode == 2) {
                this.SetSwitchMode(2)

                this.skill_action_ = this.__OnPlayerSkillAction

                local auto_off = this.GetAutoOffInterval()

                if(auto_off <= 0) {
                    print("ERROR:オフ時間が未設定です")
                    this.SetAutoOffInterval(13.0)
                }
            }
        } else if(this.bgobj_id_ == 4213 || this.bgobj_id_ == 4166) {
            this.SetSwitchMode(0)

            this.skill_action_ = this.__SkillActionStateSwitch
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

    function __OnPlayerSkillAction(hplayer, result) {
        const neg1 = -1

        local eff_id = 5
        local mot_st = 1756
        local mot_lp = neg1
        local mot_ed = 1759
        local tribe = [2]
        local pos = [0.0, 0.0, 9.2, 0.0]
        local opt = [2, 3, 4]

        this.ReactResponderSwitchTypeContinueMain(hplayer, result, eff_id, mot_st, mot_lp, mot_ed, tribe, pos, opt)
    }

    function __SkillActionStateSwitch(hplayer, result) {
        local eff_id = 5
        local mot_st = 1756
        local mot_lp = 1757
        local mot_ed = 1759
        local tribe = [2]
        local pos = [0.0, 0.0, 9.2, 0.0]
        local opt = [2, 3]

        this.ReactResponderSwitchTypeContinueMain(hplayer, result, eff_id, mot_st, mot_lp, mot_ed, tribe, pos, opt, false)

        return 0;
    }
}
