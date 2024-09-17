// TODO match line infos

const neg1 = -1

class PortalActor extends BgobjActorBase {
    profile_ = null
    state_ = 0
    db_key_ = neg1
    is_warp_only_ = 0

    function CreateAndInit() {
        this.profile_ = SaveProfile()
        this.is_warp_only_ = this.GetIntegerParam(0)

        this.CreateActor()

        if(this.hself_ <= 0) return;

        register_player_responder(this.hself_, 4, [12.0, 360.0, 360.0])
        set_player_responder_caption(this.hself_, 4, 4781)

        this.db_key_ = get_portal_database_key(this.hself_)

        print("_/_/_/_/_/_/_/_/_/_/_/_/_/_/ Portal DataBaseKey = [" + this.db_key_ + "] _/_/_/_/_/_/_/_/_/_/_/_/_/_/")

        if(!test_flag(328)) {
            this.state_ = 2
            start_actor_motion(this.hself_, 401)
            end_bgobj_effect(this.hself_)
        } else if(is_portal_activate(this.db_key_)) {
            this.state_ = 1
            start_actor_motion(this.hself_, 403)
        } else if(this.is_warp_only_) {
            this.state_ = 1
            start_actor_motion(this.hself_, 403)
        } else {
            this.state_ = 0
            start_actor_motion(this.hself_, 401)
            end_bgobj_effect(this.hself_)
        }
    }

    function OnPlayerHatena(hplayer, htarget) {
        PadOffWait(0)
        set_enemy_sleep(true)
        set_flag(2026)

        local result = false
        switch(this.state_) {
            case 0:
                result = this.__StateFirst()
                break;
            case 1:
                result = this.__StateSelect()
                break;
            case 2:
                result = this.__StateTutorial()
                break;
        }

        if(result == false) {
            set_enemy_sleep(false)
            PadOnWait(0)
        }
    }

    function __StateFirst() {
        start_bgobj_effect(this.hself_)
        start_actor_motion(this.hself_, 402)

        wait_for_true1(is_motion_finished, this.hself_)

        start_actor_motion(this.hself_, 403)
        set_portal_active_flag(this.db_key_)

        wait(60)

        msg_argv_sync(516, 0, 0, [get_portal_message_id(this.db_key_)])
        this.state_ = 1

        if(!is_party_hp_full()) {
            heal_party()
            recovery_abnormal()
        }

        if(this.is_warp_only_ == 0) {
            save_to_memory()
        }

        return false;
    }

    function __StateSelect() {
        if(!is_party_hp_full()) {
            heal_party_emit_effect()
            recovery_abnormal()
            wait(30)
        }

        if(this.is_warp_only_ == 0) {
            save_to_memory()
        }

        start_portal_pause()

        local result = false
        result = this.__SelectWarpOrSave()

        end_portal_pause()

        return result;
    }

    function __StateTutorial() {
        set_flag(328)
        this.state_ = 0
        return this.__StateFirst();
    }

    function __SelectWarpOrSave() {
        if(this.is_warp_only_) {
            return this.__SelectWarpArea();
        } else while(true) {
            local result = ui_sync(17, [1, 0, 3, 0, 4789, 4153, 4169])
            local func_result = true

            switch(result[0]) {
                case 0:
                    if(this.__SelectWarpArea()) {
                        return true;
                    }
                    break;
                case 1:
                    func_result = this.__Save()
                    break;
                default:
                    break;
            }

            if(func_result) break;
        }

        return false;
    }

    function __SelectWarpArea() {
        local result = false

        if(this.__CheckEvent(933, 750, 92117, 92025)) {
            return result;
        }

        if(this.__CheckEvent(1995, 733, 93107, 93106)) {
            ui_sync(5, [83075, 83076])
            return result;
        }

        if(this.__CheckEvent(934, 779, 93073, 93071)) {
            return result;
        }

        if(this.__CheckEvent(1004, 728, 55050, 55051)) {
            return result;
        }

        if(this.__CheckEvent(1015, 705, 45067, 45067)) {
            return result;
        }

        if(this.__CheckEvent(1017, 729, 92152, 92151)) {
            return result;
        }

        if(this.__CheckEvent(1016, 710, 93209, 93210)) {
            return result;
        }

        if(check_mission_running(65)) {
            this.__CheckEventScarab(92161)
            return result;
        }

        result = PortalProsess(this.db_key_, false)

        if(result) {
            start_actor_motion(this.hself_, 404)
        } else {
            start_portal_pause()
            result = this.__SelectWarpOrSave()
        }

        return result;
    }

    function __Save() {
        return this.profile_.Save();
    }

    function __CheckEvent(flag, chara_id, msg_player, msg_npc) {
        if(test_flag(flag)) {
            end_portal_pause()

            local party_index = is_exist_chara_id_in_party(chara_id)
            if(party_index != -1) {
                local hact = get_party_order(party_index)
                if(party_index == 0) {
                    msg_sync(msg_player, hact)
                } else {
                    msg_sync(msg_npc, hact)
                }

                return true;
            }
        }

        return false;
    }

    function __CheckEventScarab(msg_scarab) {
        end_portal_pause()
        EventStart(0)

        local h_player = get_player()
        local h_scarab_and_isuna = CreateSimpleScarabAndIsuna(h_player)
        local h_talk_actors = StartScarabIsunaTalkEventAppear()

        msg_sync_talk_event(msg_scarab, h_scarab_and_isuna[1])
        EndScarabIsunaTalkEventDestroyOnly(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
        DestroySimpleScarabAndIsuna(h_scarab_and_isuna[0], h_scarab_and_isuna[1])
        EventEnd()
    }
}
