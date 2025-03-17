// TODO match line infos

class OldmanCeruke extends ActorBase {
    function OnPlayerTalked(hplayer, htarget) {
        print("OldmanCeruke::OnPlayerTalked:" + hplayer + "," + htarget)

        PadOffWait(0)

        start_idle_town_npc()
        start_invisible_town_npc()
        set_actor_visible(htarget, true)
        begin_talk_camera_zoom_in(htarget)
        begin_talk_action(htarget)

        func_wait(is_talk_ready)
        func_wait(is_talk_camera_ready)

        if(check_mission_completed(113)) {
            if(test_flag(72) && test_flag(494)) {
                local rate = get_random(100)
                local mes = [81006, 81095]
                local no = get_random(2)

                print("OldmanCeruke::Random Message :" + mes[no])

                msg_sync(mes[no], htarget)
            } else if(test_flag(72) && !test_flag(494)) {
                msg_sync(81095, htarget)
                set_flag(494)
            } else {
                msg_sync(81006, htarget, [0, false, 0, 5])
            }
        } else if(check_mission_completed(110) && !check_mission_completed(113)) {
            msg_sync(81005, htarget, [0, false, 0, 5])
        } else if(check_mission_completed(104) && !check_mission_completed(110)) {
            msg_sync(81004, htarget, [0, false, 0, 5])
        } else if(check_mission_completed(91) && !check_mission_completed(104)) {
            msg_sync(81003, htarget, [0, false, 0, 5])
        } else if(test_flag(1965) && !check_mission_completed(91)) {
            msg_sync(81002, htarget, [0, false, 0, 5])
        } else if(check_mission_completed(63) && !test_flag(1965)) {
            msg_sync(92188, htarget, [0, false, 0, 5])
        } else {
            msg_sync(92032, htarget, [0, false, 0, 5])
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
