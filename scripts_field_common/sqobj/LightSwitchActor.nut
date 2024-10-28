// TODO match line infos

class LightSwitchActor extends BgobjActorBase {
    skill_action_ = null

    function CreateAndInit() {
        local was_on_flag = this.GetFlag()

        local sw_state = false
        if(was_on_flag > 0 && test_flag(was_on_flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)
        this.SetFloatParam(0, 1.2)
        this.skill_action_ = this.__OnPlayerSkillAction
        this.CreateActor()
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        if(this.skill_action_) {
            this.skill_action_(hplayer, result)
        }
    }

    function __IsEventUse() {
        local event_flag = this.GetLockFlag()

        if(event_flag > 0 && test_flag(event_flag) == false) {
            return true;
        }

        return false;
    }

    function ToggleLinkSwitch() {
        local layout_id_array = this.GetIntegerParamArray()
        foreach(layout_id in layout_id_array) {
            if(layout_id <= 0) continue;

            local actor = FindBgobjActorByLayoutId(layout_id)
            
            if(actor && actor.act_type_ != 40) {
                change_state_switch_actor(actor.hself_, 2, false)
            }
        }
    }

    function __ToggleLightSwitch() {
        local layout_id_array = this.GetIntegerParamArray()
        foreach(layout_id in layout_id_array) {
            if(layout_id <= 0) continue;

            local actor = FindBgobjActorByLayoutId(layout_id)
            
            if(actor && actor.act_type_ == 40) {
                change_state_switch_actor(actor.hself_, 2, false)
            }
        }
    }

    function __ToggleAllSwitch() {
        local layout_id_array = this.GetIntegerParamArray()
        foreach(layout_id in layout_id_array) {
            if(layout_id <= 0) continue;

            local hact = FindBgobjHandleByLayoutId(layout_id)
            
            if(hact) {
                change_state_switch_actor(hact, 2, false)
            }
        }
    }

    function __OnPlayerSkillAction(hplayer, result) {
        if(this.__IsEventUse()) {
            this.BeginResponseAction(hplayer, 6, 0, result, -5.0, 6.0, true, this.__ToggleLightSwitch)
        } else {
            this.BeginResponseAction(hplayer, 6, 0, result, -5.0, 6.0, true, this.__ToggleAllSwitch)
        }
    }
}
