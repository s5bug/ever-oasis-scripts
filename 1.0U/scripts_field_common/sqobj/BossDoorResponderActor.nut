// TODO match line infos

class BossDoorResponderActor extends BgobjActorBase {
    function CreateAndInit() {
        local key_flag = this.GetFlag()
        local disable_flag = this.GetLockFlag()

        if(disable_flag > 0 && test_flag(disable_flag)) return;

        this.CreateActor()

        if(this.hself_ > 0) {
            register_player_responder(this.hself_, 4, [20.0, 0.0, 0.0])

            if(key_flag > 0 && !test_flag(key_flag)) {
                set_enable_bgobj_responder(this.hself_, false)
            }
        }
    }

    function Activate() {
        set_enable_bgobj_responder(this.hself_, true)
    }

    function OnPlayerHatena(hplayer, htarget) {
        this.__BossDoorEvent(hplayer)
    }

    function __BossDoorEvent(hplayer) {
        local key_flag = this.GetFlag()

        if(key_flag > 0 && test_flag(key_flag)) {
            PadOffWait(0)

            local door_layout_id = this.GetIntegerParam(0)
            local door_actor = FindBgobjActorByLayoutId(door_layout_id)

            if(door_actor) {
                door_actor.CallDoorProcessBranch(hplayer, this.hself_)
            } else {
                print("ERROR:BossDoorResponderActor 鍵を開けるドアアクターがありません。\r\n連動ドアIDに同じ部屋のドアが指定されているかチェックしてください")
            }
        }
    }
}
