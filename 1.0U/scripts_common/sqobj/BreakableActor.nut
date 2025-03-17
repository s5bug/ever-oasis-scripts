// TODO match line infos

class BreakableActor extends BgobjActorBase {
    function CreateAndInit() {
        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) return;

        local motion_type = 0
        local motion_array = []
        local responder_opt_array = [12.0, 0.0, 0.0]

        if(this.bgobj_id_ == 4094) {
            responder_opt_array = [17.0, 0.0, 0.0]
            motion_type = 1
        } else if(this.bgobj_id_ == 4000 || this.bgobj_id_ == 4665) {
            responder_opt_array = [17.0, 0.0, 0.0]
            motion_type = 3
        } else if(this.bgobj_id_ == 4135 || this.bgobj_id_ == 4114) {
            motion_type = 1
        } else if(this.bgobj_id_ == 4178 || this.bgobj_id_ == 4666) {
            responder_opt_array = [22.0, 0.0, 0.0]
            motion_type = 2
        } else if(this.bgobj_id_ == 4179 || this.bgobj_id_ == 4667) {
            responder_opt_array = [17.0, 0.0, 0.0]
            motion_type = 3
        } else if(this.bgobj_id_ == 4201) {
            responder_opt_array = [22.0, 0.0, 0.0]
            motion_type = 4
        } else if(this.bgobj_id_ == 4265) {
            motion_type = 5
        } else if(this.bgobj_id_ == 4599) {
            motion_type = 6
        }

        if(motion_type == 0) {
            motion_array = [259, 260, 261]
        } else if(motion_type == 1) {
            motion_array = [262, 263, 264]
        } else if(motion_type == 2) {
            motion_array = [408, 409, 410]
        } else if(motion_type == 3) {
            motion_array = [411, 412, 413]
        } else if(motion_type == 4) {
            motion_array = [405, 406, 407]
        } else if(motion_type == 5) {
            motion_array = [583, 584, 585]
        } else if(motion_type == 6) {
            motion_array = [640, 641, 642]
        }

        if(motion_array.len() == 3) {
            this.SetMotion(motion_array)
        }

        this.CreateActor()

        if(this.hself_ > 0) {
            register_player_responder(this.hself_, 6, responder_opt_array)
        }
    }

    function OnActorDeadEvent(hact) {
        this.__DestroyEvent()
    }

    function __DestroyEvent() {
        this.SetSelfFlag()
        this.SendReaction()
    }
}
