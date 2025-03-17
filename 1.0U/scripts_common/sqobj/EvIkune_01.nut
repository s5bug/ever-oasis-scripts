// TODO match line infos

class EvIkune_01 extends ActorBase {
    function OnPlayerTalked(hplayer, htarget) {
        print("EvIkune_01::OnPlayerTalked:" + hplayer + "," + htarget)

        PadOffWait(0)

        start_idle_town_npc()
        start_invisible_town_npc()
        set_actor_visible(htarget, true)
        begin_talk_camera_zoom_in(htarget)
        begin_talk_action(htarget)

        func_wait(is_talk_ready)
        func_wait(is_talk_camera_ready)

        local chara_id = get_charaid(this.hself)
        switch(chara_id) {
            case 783:
                if(!check_mission_completed(87)) {
                    msg_sync(81041, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(87) && !check_mission_completed(91)) {
                    msg_sync(81042, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(91) && !test_flag(1966)) {
                    msg_sync(81043, htarget, [0, false, 0, 5])
                } else if(test_flag(1966) && !check_mission_completed(110)) {
                    msg_sync(81044, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(110) && !check_mission_completed(113)) {
                    msg_sync(81045, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(113)) {
                    msg_sync(81046, htarget, [0, false, 0, 5])
                }
                break;
            case 784:
                if(!check_mission_completed(87)) {
                    msg_sync(81047, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(87) && !check_mission_completed(91)) {
                    msg_sync(81048, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(91) && !test_flag(1966)) {
                    msg_sync(81049, htarget, [0, false, 0, 5])
                } else if(test_flag(1966) && !check_mission_completed(110)) {
                    msg_sync(81050, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(110) && !check_mission_completed(113)) {
                    msg_sync(81051, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(113)) {
                    msg_sync(81052, htarget, [0, false, 0, 5])
                }
                break;
            case 785:
                if(!check_mission_completed(87)) {
                    msg_sync(81053, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(87) && !check_mission_completed(91)) {
                    msg_sync(81054, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(91) && !test_flag(1966)) {
                    msg_sync(81055, htarget, [0, false, 0, 5])
                } else if(test_flag(1966) && !check_mission_completed(110)) {
                    msg_sync(81056, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(110) && !check_mission_completed(113)) {
                    msg_sync(81057, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(113)) {
                    msg_sync(81058, htarget, [0, false, 0, 5])
                }
                break;
            case 786:
                if(!check_mission_completed(87)) {
                    msg_sync(81059, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(87) && !check_mission_completed(91)) {
                    msg_sync(81060, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(91) && !test_flag(1966)) {
                    msg_sync(81061, htarget, [0, false, 0, 5])
                } else if(test_flag(1966) && !check_mission_completed(110)) {
                    msg_sync(81062, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(110) && !check_mission_completed(113)) {
                    msg_sync(81063, htarget, [0, false, 0, 5])
                } else if(check_mission_completed(113)) {
                    msg_sync(81064, htarget, [0, false, 0, 5])
                }
                break;
        }

        begin_talk_camera_zoom_out()
        end_invisible_town_npc()
        ui_deactivate(14)

        func_wait(is_talk_camera_finished)

        end_talk_camera()
        end_idle_town_npc()

        PadOnWait(0)
    }
}
