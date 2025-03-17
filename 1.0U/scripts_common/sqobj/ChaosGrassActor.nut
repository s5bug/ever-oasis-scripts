// TODO match line infos

class ChaosGrassActor extends BgobjActorBase {
    layout_id_list_ = null

    function CreateAndInit() {
        this.layout_id_list_ = this.GetLinkLayoutIdArray()

        local sw_state = false
        local flag = this.GetFlag()

        if(flag > 0 && test_flag(flag)) {
            sw_state = true
        }

        if(sw_state == true) {
            if(this.IsAliveLinkEnemyGroup() == false) {
                sw_state = false
            }
        }

        if(!sw_state) {
            return;
        }

        this.SetSwitchState(sw_state)
        this.SetOffDrawDisable(true)
        this.CreateActor()
    }

    function IsAliveLinkEnemyGroup() {
        if(this.layout_id_list_ == false) {
            return true;
        } else {
            foreach(layout_id in this.layout_id_list_) {
                check_enemy_respawn(layout_id)
                if(get_rest_enemy_num_in_group(layout_id) != 0) {
                    return true;
                }
            }
        }
        
        return false;
    }
}
