// TODO match line infos

class HammerStakeActor extends BgobjActorBase {
    skill_action_ = null
    h_player_ = 0

    function CreateAndInit() {
        local was_changed_flag = this.GetFlag()
        local state = false
        if(was_changed_flag >= 0 && test_flag(was_changed_flag)) {
            state = true
        }

        this.SetSwitchState(state)

        this.skill_action_ = this.__OnPlayerSkillAction

        this.CreateActor()
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        if(this.skill_action_) {
            this.skill_action_(hplayer, result)
        }
    }

    function __OnPlayerSkillAction(hplayer, result) {
        const neg1 = -1

        this.h_player_ = hplayer

        local eff_id = 4
        local mot_st = 1751
        local mot_lp = neg1
        local mot_ed = neg1
        local tribe = [1]
        local pos = [0.0, 0.0, 0.0, 10.0]
        local opt = [8, 3, 4, 7]
        local link_action = this.ToggleLinkSwitch

        PadOffWait(0)

        local can_request = can_switch_link_action(hplayer, tribe)
        if(can_request) {
            this.DoBeginEventAction()
        }

        local check = request_switch_link_action(
            hplayer, this.hself_,
            mot_st, mot_lp, mot_ed,
            tribe, pos, opt
        )

        if(!check) {
            PadOffWait(0)

            begin_response_action(hplayer, 5, this.hself_, result)
            
            wait_for_true1(is_response_action_finished, hplayer)

            this.EventSkillResponderFailure(hplayer, eff_id)

            PadOnWait(0)
            return;
        }

        if(link_action) {
            if(result == 1) {
                link_action()
            }
        }

        wait_for_true1(is_response_action_finished, hplayer)

        this.SendReaction()
        this.DoEndEventAction()
        this.SetWasWatch()
        CallAfterPlayerActionEvent(this.hself_, this.layout_id_)

        PadOnWait(0)

        this.h_player_ = 0
    }

    function ToggleLinkSwitch() {
        wait(1)

        if(this.h_player_ != 0) {
            wait_for_false1(is_actor_equipping_weapon, this.h_player_)

            if(is_actor_equipping_weapon(this.h_player_) == false) {
                wait(1)

                wait_for_false1(is_actor_equipping_weapon, this.h_player_)
            }
        }

        local layout_id_array = this.GetLinkLayoutIdArray()

        if(layout_id_array != false) {
            foreach(layout_id in layout_id_array) {
                if(layout_id <= 0) continue;

                local hact = FindBgobjHandleByLayoutId(layout_id)
                if(hact) {
                    change_state_switch_actor(hact, 2, false)
                }
            }
        }
    }
}
