// TODO match line infos

class SpiderWebActor extends BgobjActorBase {
    skill_action_ = null
    chain_door_id_ = 0

    function CreateAndInit() {
        local was_broken_flag = this.GetFlag()
        local sw_state = false

        if(was_broken_flag > 0 && test_flag(was_broken_flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)
        this.SetSwitchMode(1)

        this.skill_action_ = this.__OnPlayerSkillAction

        this.CreateActor()

        this.chain_door_id_ = this.GetIntegerParam(0)
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        if(this.skill_action_) {
            this.skill_action_(hplayer, result)
        }
    }

    function __OnPlayerSkillAction(hplayer, result) {
        const neg1 = -1

        local eff_id = 7
        local mot_st = 1751
        local mot_lp = neg1
        local mot_ed = neg1
        local tribe = [3]
        local pos = []
        local opt = [2, 3, 4]

        PadOffWait(0)

        set_camera_target(this.hself_, 6.0)

        local b_success = this.ReactResponderSwitchTypeContinueMain(
            hplayer, result, eff_id,
            mot_st, mot_lp, mot_ed,
            tribe, pos, opt
        )

        reset_camera_target()

        if(b_success == true && result == 1) {
            this.__ActivateLinkDoor()
        }
    }

    function __ActivateLinkDoor() {
        if(this.chain_door_id_) {
            ActivateBgobj(this.chain_door_id_)
        }
    }
}
