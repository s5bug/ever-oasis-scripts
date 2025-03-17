// TODO match line infos

class SignPanelActor extends BgobjActorBase {
    chain_obj_id_list_ = null

    function CreateAndInit() {
        this.CreateActor()

        this.chain_obj_id_list_ = []

        local layout_id_array = this.GetIntegerParamArray()

        local i = 0
        foreach(layout_id in layout_id_array) {
            if(layout_id <= 0) continue;

            this.chain_obj_id_list_.append(layout_id)

            i += 1
        }

        if(this.chain_obj_id_list_.len() <= 0) {
            print("ERROR:SignPanelActor 連動LayoutIDがすべて 0")
        }
    }

    function AppearChainObj() {
        local flag = this.GetFlag()

        if(flag > 0 && test_flag(flag)) return;

        PadOffWait(1)

        local first_box = 0

        foreach(chain_obj_id in this.chain_obj_id_list_) {
            if(chain_obj_id == 0) continue;

            local box_actor = FindBgobjActorByLayoutId(chain_obj_id)

            if(box_actor && box_actor.hself_) {
                if(first_box == 0) {
                    first_box = box_actor.hself_
                }
                box_actor.Appear()
            } else {
                print("ERROR:SignPanelActor 連動objectがありません layoutID = " + this.box_lyt_id_)
            }
        }

        if(first_box) {
            set_camera_target(first_box, 10.0)

            wait(60)

            reset_camera_target()
            play_se(0x1000227)

            wait(15)
        }

        PadOnWait(1)
    }
}
