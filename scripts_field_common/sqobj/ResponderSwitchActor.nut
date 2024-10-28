// TODO match line infos

class ResponderSwitchActor extends BgobjActorBase {
    function CreateAndInit() {
        local mode = this.GetBgobjMode()

        if(mode == 0) {
            if(this.bgobj_id_ == 4219) {
                warning("Warning:通常の人工スイッチがトグルで配置されています。トグルの場合はトグル用人工スイッチを配置してください")
            }
            this.SetSwitchMode(0)
            this.__Create()
        } else if(mode == 1) {
            local waiting_flag = this.GetLockFlag()

            local isWait = false
            if(waiting_flag > 0) {
                if(!test_flag(waiting_flag)) {
                    isWait = true
                }
            }

            this.SetSwitchMode(1)
            this.__Create()

            if(isWait) {
                set_enable_bgobj_responder(this.hself_, false)
            }
        } else if(mode == 2) {
            local apper_flag = this.GetLockFlag()

            if(apper_flag <= 0) {
                print("ERROR:>>>>> ResponderSwitchActor apper_flag is None. Plz set some flag. <<<<< ")
            }

            this.SetSwitchMode(1)
            this.__Create()

            if(apper_flag > 0 && !test_flag(apper_flag)) {
                set_enable_bgobj_responder(this.hself_, false)
            }
        } else if(mode == 3) {
            this.SetSwitchMode(2)
            this.__Create()
        } else if(mode == 4) {
            this.SetSwitchMode(2)
            this.__Create()
        }
    }

    function OnPlayerHatena(hplayer, htarget) {
        if(this.GetBgobjMode() == 0) {
            this.BeginResponseAction(hplayer, 1, 0, 1, -5.0, 6.0, true)
        } else {
            this.BeginResponseAction(hplayer, 1, this.GetFlag(), 1, -5.0, 6.0, true)
        }
    }

    function Activate() {
        set_enable_bgobj_responder(this.hself_, true)
    }

    function Deactivate() {
        set_enable_bgobj_responder(this.hself_, false)
    }

    function __Create() {
        local sw_flag = this.GetFlag()

        local sw_state = false
        if(sw_flag > 0 && test_flag(sw_flag)) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)
        this.CreateActor()
    }
}
