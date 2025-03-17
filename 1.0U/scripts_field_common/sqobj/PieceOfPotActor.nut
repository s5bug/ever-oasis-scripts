// TODO match line infos

class PieceOfPotActor extends BgobjActorBase {
    function CreateAndInit() {
        local sw_flag = this.GetFlag()
        local pot_type = this.bgobj_id_

        if(pot_type == 4125) {
            if(sw_flag > 0 && test_flag(sw_flag)) {
                return;
            }
        }

        local sw_state = false
        if(sw_flag > 0 && test_flag(sw_flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)

        if(pot_type == 4125) {
            this.SetSwitchMode(3)
            this.SetFrame(1.0)
        } else if(pot_type == 4124) {
            this.SetSwitchMode(0)
        } else {
            print("ERROR:<<< CreatePieceOfPot : Error >>>")
        }

        this.CreateActor()
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        const neg1 = -1

        local eff_id = 5
        local mot_st = 1760
        local mot_lp = neg1
        local mot_ed = neg1

        local tribe = [2]
        local pos = [-29.0, 0.0, 0.0, 4.0]
        local opt = [2, 3, 4, 7]

        local pot_type = this.bgobj_id_
        local pot_flag = this.GetFlag()

        if(pot_type == 4124 || pot_type == 4242) {
            if(get_state_switch_actor(this.hself_)) {
                pos = [29.0, 0.0, 0.0]
            } else {
                pos = [-29.0, 0.0, 0.0]
            }
        } else if(pot_type == 4125) {
            pos = [-19.5, 0.0, -4.0, 3.0]
        } else {
            print("ERROR:Piece of pot type (bgobj_id) error = " + pot_type)
        }

        set_camera_target(htarget, 20.0)
        this.ReactResponderSwitchTypeContinueMain(hplayer, result, eff_id, mot_st, mot_lp, mot_ed, tribe, pos, opt)

        local hact = get_actor_by_layout(this.layout_id_)
        if(hact != 0) {
            const neg9 = -9
            wait(neg9)
        }

        reset_camera_target()
    }
}
