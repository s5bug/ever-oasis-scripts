// TODO match line infos

class OldmanRikos extends ActorBase {
    function OnPlayerTalked(hplayer, htarget) {
        print("OldmanRikos::OnPlayerTalked:" + hplayer + "," + htarget)

        PadOffWait(0)

        start_idle_town_npc()
        start_invisible_town_npc()
        set_actor_visible(htarget, true)
        begin_talk_camera_zoom_in(htarget)
        begin_talk_action(htarget)

        func_wait(is_talk_ready)
        func_wait(is_talk_camera_ready)

        if(!check_mission_completed(87)) {
            msg_sync(81030, htarget, [0, false, 0, 5])
        } else if(check_mission_completed(87) && !check_mission_completed(91)) {
            msg_sync(81036, htarget, [0, false, 0, 5])
        } else if(check_mission_completed(91) && !test_flag(1966)) {
            msg_sync(81037, htarget, [0, false, 0, 5])
        } else if(test_flag(1966) && !check_mission_completed(110)) {
            msg_sync(81038, htarget, [0, false, 0, 5])
        } else if(check_mission_completed(110) && !check_mission_completed(113)) {
            msg_sync(81039, htarget, [0, false, 0, 5])
        } else if(check_mission_completed(113)) {
            if(test_flag(72) && test_flag(495)) {
                local rate = get_random(100)
                local mes = [81040, 81096]
                local no = get_random(2)

                print("OldmanRikos::Random Message :" + mes[no])

                msg_sync(mes[no], htarget)
            } else if(test_flag(72) && !test_flag(495)) {
                msg_sync(81096, htarget)
                set_flag(495)
            } else {
                msg_sync(81040, htarget, [0, false, 0, 5])
            }
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
