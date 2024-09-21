// TODO match line infos

class OldmanUa extends ActorBase {
    function OnPlayerTalked(hplayer, htarget) {
        print("OldmanUa::OnPlayerTalked:" + hplayer + "," + htarget)

        PadOffWait(0)

        start_idle_town_npc()
        start_invisible_town_npc()
        set_actor_visible(htarget, true)
        begin_talk_camera_zoom_in(htarget)
        begin_talk_action(htarget)

        func_wait(is_talk_ready)
        func_wait(is_talk_camera_ready)

        if(check_mission_completed(103) && !test_flag(2002)) {
            EventStart(0)

            local h_talk_acts = TalkDemo_1_1_Initialize(0, 85, 2)
            local h_player_talk = h_talk_acts[0]
            local h_oldman_ua_talk = h_talk_acts[1]

            wait(30 * 0.25)

            start_actor_motion_auto_idle(h_oldman_ua_talk, 270)

            wait(30 * 0.25)

            start_actor_motion_auto_idle(h_player_talk, 325)
            msg_sync_talk_event(94014, h_oldman_ua_talk)
            msg_sync_talk_event(94226, h_oldman_ua_talk)
            msg_sync_talk_event(94015, h_oldman_ua_talk)

            local h_talk_acts = [h_player_talk, h_oldman_ua_talk]
            TalkDemo_1_1_Finalize(h_talk_acts, 2)

            h_player_talk = 0
            h_oldman_ua_talk = 0

            EventEnd()
            set_demo_event(true)
        } else if(test_flag(2002) && !test_flag(1967)) {
            msg_sync(94191, htarget)
        } else if(test_flag(1967) && !check_mission_completed(113)) {
            msg_sync(81067, htarget)
        } else if(check_mission_completed(113)) {
            if(test_flag(72) && test_flag(496)) {
                local rate = get_random(100)
                local mes = [81068, 81097]
                local no = get_random(2)

                print("OldmanUa::Random Message :" + mes[no])

                msg_sync(mes[no], htarget)
            } else if(test_flag(72) && !test_flag(496)) {
                msg_sync(81097, htarget)
                set_flag(496)
            } else {
                msg_sync(81068, htarget)
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
