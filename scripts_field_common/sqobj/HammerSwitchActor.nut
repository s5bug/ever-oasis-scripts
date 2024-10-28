// TODO match line infos

class HammerSwitchActor extends BgobjActorBase {
    skill_action_ = null

    function CreateAndInit() {
        local bgobj_mode = this.GetBgobjMode()

        if(bgobj_mode == 0) {
            this.SetSwitchMode(1)

            local was_on_flag = this.GetFlag()

            if(was_on_flag > 0 && test_flag(was_on_flag)) {
                this.SetSwitchState(true)
            }
        } else if(bgobj_mode == 1) {
            this.SetSwitchMode(2)

            local auto_off = this.GetAutoOffInterval()

            if(auto_off <= 0) {
                this.SetAutoOffInterval(13.0)
            }
        } else if(bgobj_mode == 2) {
            this.SetSwitchMode(2)

            local auto_off = this.GetAutoOffInterval()

            if(auto_off <= 0) {
                this.SetAutoOffInterval(13.0)
            }
        } else {
            assert(0)
        }

        this.skill_action_ = this.__OnPlayerSkillAction

        this.CreateActor()
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        if(this.skill_action_) {
            this.skill_action_(hplayer, result)
        }
    }

    function __OnPlayerSkillAction(hplayer, result) {
        this.BeginResponseAction(hplayer, 4, this.GetFlag(), result, -5.0, 6.0, true)
    }
}
