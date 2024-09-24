// TODO match line infos

class CollectingObjActor extends BgobjActorBase {
    skill_action_ = 0
    __eff_id_ = 0
    __collect_frame_ = -1.0
    
    function CreateAndInit() {
        local flag = this.GetFlag()

        if(flag > 0 && test_flag(flag)) return;

        if(this.bgobj_id_ == 4206) {
            local collect_type = this.GetBgobjMode()

            if(collect_type == 0) {
                this.__eff_id_ = 3
                this.__collect_frame_ = 25.0
            } else if(collect_type == 2) {
                this.__eff_id_ = 2
                this.__collect_frame_ = 25.0
            }
        } else if(this.bgobj_id_ == 4218) {
            this.__eff_id_ = 3
            this.__collect_frame_ = 25.0
            this.SetBgobjMode(0)
        } else if(this.bgobj_id_ == 4216) {
            this.__eff_id_ = 2
            this.__collect_frame_ = 25.0
            this.SetBgobjMode(2)
        }

        this.CreateActor()

        if(this.hself_ <= 0) return;

        this.skill_action_ = this.__AddItemFromCollectObj

        local hide_flag = this.GetLockFlag()
        local disable_flag = this.GetFlag(1)

        if(hide_flag > 0 && disable_flag > 0) {
            print("ERROR:CollectingObjActor hide_flag and disable_flag also was set.")
        }

        if(hide_flag > 0) {
            if(test_flag(hide_flag) == false) {
                set_enable_bgobj_responder(this.hself_, false)
            }
        } else if(disable_flag > 0) {
            if(test_flag(disable_flag) == false) {
                set_enable_bgobj_responder(this.hself_, false)
            }
        }

        return true;
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        if(this.skill_action_) {
            this.skill_action_(hplayer, result)

            if(result == 0) {
                this.__FirstAccessNotify(30, true)
            } else {
                this.__FirstAccessNotify(15, false)
            }
        }
    }

    function __FirstAccessNotify(wait_frame, fail) {
        if(!check_mission_completed(9)) return;

        if(!check_optional_quest_completed(55)) {
            if(fail) {
                PadOffWait(0)

                set_enemy_sleep(true)

                PadOffWait(wait_frame)

                msg_sync(45219)

                PadOnWait(0)

                set_enemy_sleep(false)
            }
        }
    }

    function OnActorDeadEvent(hact) {
        this.__DestroyEvent()
    }

    function __DestroyEvent() {
        this.SetSelfFlag()
        SendCollectingObjEnd()
    }

    function __AddItemFromCollectObj(hplayer, result) {
        PadOffWait(0)

        begin_response_action(hplayer, 5, this.hself_, result, 1.0, false, this.__collect_frame_)

        wait_for_true1(is_response_action_finished, hplayer)

        if(result == 0) {
            this.EventSkillResponderFailure(hplayer, this.__eff_id_)
        }

        CallAfterPlayerActionEvent(this.hself_, this.layout_id_)

        PadOnWait(0)
    }

    function Activate() {
        set_enable_bgobj_responder(this.hself_, true)
    }

    function Deactivate() {
        set_enable_bgobj_responder(this.hself_, false)
    }
}
