// TODO match line infos

class ChaosFenceActor extends BgobjActorBase {
    function CreateAndInit() {
        local type = this.GetBgobjMode()
        local was_cleaned_flag = this.GetLockFlag()

        if(type == 0) {
            local appeared_flag = this.GetFlag()

            if(was_cleaned_flag <= 0) {
                print("ERROR:>>>>> ChaosFenceActor appear_flag2 is None. Plz set some flag. <<<<< ")
            }

            if((appeared_flag > 0 && test_flag(appeared_flag)) && !test_flag(was_cleaned_flag)) {
                type = 1
            }
        } else if(type == 1) {
            if(was_cleaned_flag > 0 && test_flag(was_cleaned_flag)) {
                type = 0
            }
        }

        if(__GetEnterRandomDungeon()) {
            local area_id = GetAreaId()
            local aGroup_id = GetPopGroup(area_id)
            local is_alive = is_enemy_alive_inside_area(area_id)

            if(aGroup_id[0] == -1 && is_alive == false) {
                type = 0
                print("ERROR: ChaosFenceActor エリア" + area_id + "に敵が設定されていません。非表示でPOPさせます。")
            }
        }

        this.SetSwitchCameraShake(0)

        local sw_state = false
        if(type == 1) {
            sw_state = true
        }

        this.SetSwitchState(sw_state)
        this.CreateActor()
    }
}
