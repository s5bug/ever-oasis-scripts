// TODO match line infos

class HookObjActor extends BgobjActorBase {
    action_call_back_func = null

    function CreateAndInit() {
        local mode = this.GetBgobjMode()

        if(mode == 1) {
            this.CreateActor()

            if(this.hself_ <= 0) return;

            local enable_flag = this.GetFlag()

            if(enable_flag > 0) {
                if(!test_flag(enable_flag)) {
                    set_enable_bgobj_responder(this.hself_, false)
                }
            }
        } else if(mode == 0 || mode == 2) {
            local apper_flag = this.GetFlag()

            if(apper_flag > 0) {
                if(test_flag(apper_flag)) {
                    this.SetBgobjMode(1)
                }
            }
            
            this.CreateActor()
        }
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        local eff_id = 5
        local mot_st = 1756
        local mot_lp = 1757
        local mot_ed = 1758
        local tribe = [2]
        local pos = [0.0, 0.0, 9.2, 0.0]
        local opt = [2, 3]

        this.ReactResponderSwitchTypeContinueMain(
            hplayer, result,
            eff_id, mot_st, mot_lp, mot_ed,
            tribe, pos, opt, true,
            this.action_call_back_func
        )
    }

    function Activate() {
        set_enable_bgobj_responder(this.hself_, true)
    }

    function SetActionCallBackFunc(call_back_func) {
        this.action_call_back_func = call_back_func
    }
}
