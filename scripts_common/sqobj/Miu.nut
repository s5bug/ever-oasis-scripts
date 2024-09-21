// TODO match line infos

class Miu extends GenericNpc {
    function OnPlayerTalked(hplayer, htarget) {
        print("Miu::OnPlayerTalked:" + hplayer + "," + htarget)

        local zone = get_zone_id()
        local event_check1 = test_flag(2016)
        local event_check2 = !check_mission_completed(106)

        if(zone == 19 && event_check1 && event_check2) {
            PadOffWait(0)

            turn_actor(htarget, 1, hplayer, 5)

            wait_for_false1(is_actor_turning, htarget)

            msg_sync(94293, htarget)

            PadOnWait(0)
        } else {
            GenericNpc.OnPlayerTalked(hplayer, htarget)
        }
    }
}
