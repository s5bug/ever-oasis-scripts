// TODO match line infos

class LeverSwitchActor extends LightSwitchActor {
    function CreateAndInit() {
        local bgobj_mode = this.GetBgobjMode()

        if(bgobj_mode == 0) {
            this.SetSwitchMode(0)
            this.SetFloatParam(0, 1.2)
        } else if(bgobj_mode == 1) {
            this.SetSwitchMode(1)
        }

        this.skill_action_ = this.__OnPlayerSkillAction

        local was_on_flag = this.GetFlag()

        if(was_on_flag > 0 && test_flag(was_on_flag)) {
            this.SetSwitchState(true)
        }

        this.CreateActor()
    }

    function OnPlayerHatena(hplayer, htarget) {
        this.BeginResponseAction(hplayer, 1, this.GetFlag(), 1, -5.0, 6.0, true)
    }

    function BeginResponseAction(hplayer, eff_id, flag, result, camera_offset_y, target_pos_range = 1.0, is_notify = false, link_action = null) {
        PadOffWait(1)

        if(flag > 0 && test_flag(flag)) {
            return false;
        }

        local is_switch = is_switch_actor(this.hself_)
        local old_switch_state = false
        if(is_switch) {
            old_switch_state = get_state_switch_actor(this.hself_)
        }

        set_camera_target(this.hself_, camera_offset_y)
        this.DoBeginEventAction()
        begin_response_action(hplayer, 5, this.hself_, result, target_pos_range, is_notify)

        if(link_action && result == 1) {
            link_action()
        }

        wait_for_true2(is_response_action_finished, hplayer, 0)

        if(is_demo_event_ready() == false) {
            set_demo_event(true)

            wait(1)

            idle_actor(hplayer)
            set_demo_event(false)
        } else {
            idle_actor(hplayer)
        }

        if(result == 1) {
            if(is_switch) {
                if(old_switch_state) {
                    wait_for_false1(get_state_switch_actor, this.hself_)
                } else {
                    wait_for_true1(get_state_switch_actor, this.hself_)
                }
            }

            if(flag > 0) {
                set_flag(flag)
            }

            this.SendReaction()
        } else {
            this.EventSkillResponderFailure(hplayer, eff_id)
        }

        this.DoEndEventAction()
        this.SetWasWatch()
        reset_camera_target()
        CallAfterPlayerActionEvent(this.hself_, this.layout_id_)

        return true;
    }
}
