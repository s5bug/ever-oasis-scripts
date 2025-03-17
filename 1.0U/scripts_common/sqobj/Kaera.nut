// TODO match line infos

class Kaera extends GenericNpc {
    function OnPlayerTalked(hplayer, htarget) {
        print("Kaera::OnPlayerTalked:" + hplayer + "," + htarget)

        local zone = get_zone_id()

        if(zone == 69) {
            PadOffWait(0)

            turn_actor(htarget, 1, hplayer, 5)

            wait_for_false1(is_actor_turning, htarget)

            msg_sync(94019, htarget)

            PadOnWait(0)

            return;
        }

        GenericNpc.OnPlayerTalked(hplayer, htarget)
    }
}
