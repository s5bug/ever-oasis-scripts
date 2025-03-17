// TODO match line infos

class SandpileActor extends BgobjActorBase {
    hide_obj_list_ = null

    function CreateAndInit() {
        local flag = this.GetFlag(0)
        if(flag > 0 && test_flag(flag)) return;

        this.hide_obj_list_ = []

        local responder_opt_array = []
        if(this.bgobj_id_ == 4142 || this.bgobj_id_ == 4628 || this.bgobj_id_ == 4630) {
            responder_opt_array = [15.0, 0.0, 0.0]
        } else if(this.bgobj_id_ == 4143 || this.bgobj_id_ == 4629 || this.bgobj_id_ == 4631) {
            responder_opt_array = [27.0, 0.0, 0.0]
        } else if(this.bgobj_id_ == 4137) {
            responder_opt_array = [12.0, 0.0, 0.0]
        }

        this.AfterCreateActionInGroup_ = this.__AfterCreateAction

        this.SetSwitchMode(4)
        this.SetSwitchState(false)
        this.CreateActor()

        if(this.hself_ > 0) {
            register_player_responder(this.hself_, 6, responder_opt_array)

            local hide_enemy_flag = this.GetFlag(1)
            if(hide_enemy_flag > 0 && test_flag(hide_enemy_flag)) {
                reset_flag(hide_enemy_flag)
            }
        }
    }

    function OnActorDeadEvent(hact) {
        this.__DestroyEvent()
    }

    function __DestroyEvent() {
        this.SetSelfFlag()

        local is_active_bgobj = 1

        if(is_hiero_sand_hill(this.hself_)) {
            if(get_hiero_sand_hill_type(this.hself_) != 3) {
                is_active_bgobj = 0
            }
        }

        if(is_active_bgobj) {
            foreach(hide_obj in this.hide_obj_list_) {
                if(hide_obj && hide_obj.hself_ != 0) {
                    hide_obj.Activate()
                }
            }
        }

        this.SendReaction()
    }

    function __AfterCreateAction() {
        if(this.hself_ == 0) return;

        local hide_obj_id = this.GetIntegerParam(0)
        local hide_obj_id2_array = this.GetLinkLayoutIdArray()

        if(hide_obj_id == 0 && hide_obj_id2_array == false) return;

        local hide_obj_array = []

        if(hide_obj_id != 0) {
            hide_obj_array.append(FindBgobjActorByLayoutId(hide_obj_id))
        }
        if(hide_obj_id2_array != false) {
            foreach(hide_obj_id2 in hide_obj_id2_array) {
                hide_obj_array.append(FindBgobjActorByLayoutId(hide_obj_id2))
            }
        }

        foreach(hide_obj in hide_obj_array) {
            if(hide_obj && hide_obj.hself_ != 0) {
                hide_obj.Deactivate()
                this.hide_obj_list_.append(hide_obj)
            }
        }
    }
}
