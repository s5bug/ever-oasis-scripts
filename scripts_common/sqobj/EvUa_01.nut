// TODO match line infos

class EvUa_01 extends ActorBase {
    function OnPlayerTalked(hplayer, htarget) {
        print("EvUa_01::OnPlayerTalked:" + hplayer + "," + htarget)

        PadOffWait(0)

        local chara_id = get_charaid(this.hself)
        if(chara_id == 88) {
            set_enemy_sleep(true)
            turn_actor(htarget, 1, hplayer, 5)

            wait_for_false1(is_actor_turning, htarget)

            if(!check_optional_quest_completed(113)) {
                ForceStartOptionalQuestEvent_SetEventMode(113, false)
            } else {
                msg_sync(94175, htarget)
            }

            set_enemy_sleep(false)
        } else {
            start_idle_town_npc()
            start_invisible_town_npc()
            set_actor_visible(htarget, true)
            begin_talk_camera_zoom_in(htarget)
            begin_talk_action(htarget)

            func_wait(is_talk_ready)
            func_wait(is_talk_camera_ready)

            local chara_id = get_charaid(this.hself)
            switch(chara_id) {
                case 767:
                    if(!test_flag(2002)) {
                        msg_sync(81069, htarget, [0, false, 0, 5])
                    } else if(test_flag(2002) && !test_flag(1967)) {
                        msg_sync(81070, htarget, [0, false, 0, 5])
                    } else if(test_flag(1967) && !check_mission_completed(113)) {
                        msg_sync(81071, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(113)) {
                        msg_sync(81072, htarget, [0, false, 0, 5])
                    }
                    break;
                case 771:
                    if(!test_flag(2002)) {
                        msg_sync(81073, htarget, [0, false, 0, 5])
                    } else if(test_flag(2002) && !test_flag(1967)) {
                        msg_sync(81074, htarget, [0, false, 0, 5])
                    } else if(test_flag(1967) && !check_mission_completed(113)) {
                        msg_sync(81075, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(113)) {
                        msg_sync(81076, htarget, [0, false, 0, 5])
                    }
                    break;
                case 772:
                    if(!test_flag(2002)) {
                        msg_sync(81077, htarget, [0, false, 0, 5])
                    } else if(test_flag(2002) && !test_flag(1967)) {
                        msg_sync(81078, htarget, [0, false, 0, 5])
                    } else if(test_flag(1967) && !check_mission_completed(113)) {
                        msg_sync(81079, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(113)) {
                        msg_sync(81080, htarget, [0, false, 0, 5])
                    }
                    break;
                case 773:
                    if(!test_flag(2002)) {
                        msg_sync(81081, htarget, [0, false, 0, 5])
                    } else if(test_flag(2002) && !test_flag(1967)) {
                        msg_sync(81082, htarget, [0, false, 0, 5])
                    } else if(test_flag(1967) && !check_mission_completed(113)) {
                        msg_sync(81083, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(113)) {
                        msg_sync(81084, htarget, [0, false, 0, 5])
                    }
                    break;
                // this case is unreachable
                case 88:
                    if(!check_optional_quest_completed(113)) {
                        ForceStartOptionalQuestEvent_SetEventMode(113, false)
                    } else {
                        msg_sync(94175, htarget)
                    }
                    break;
            }

            begin_talk_camera_zoom_out()
            end_invisible_town_npc()
            ui_deactivate(14)

            func_wait(is_talk_camera_finished)

            end_talk_camera()
            end_idle_town_npc()
        }

        PadOnWait(0)
    }
}
