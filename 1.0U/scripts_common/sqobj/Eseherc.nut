// TODO match line infos

class Eseherc extends GenericNpc {
    function OnPlayerTalked(hplayer, htarget) {
        print("Eseherc::OnPlayerTalked:" + hplayer + "," + htarget)

        if(check_optional_quest_completed(25) && !test_flag(2000)) {
            PadOffWait(0)

            turn_actor(htarget, 1, hplayer, 5)

            wait_for_false1(is_actor_turning, htarget)

            msg_sync(93015, htarget)

            PadOnWait(0)

            return;
        }

        GenericNpc.OnPlayerTalked(hplayer, htarget)
    }

    function __ESEHERC_CHECK() {
        for(local i = 0; i < 3; i++) {
            local h_party = get_party_index(i)

            if(h_party != 0) {
                if(is_have_skill(h_party, 1)) {
                    return true;
                }
            }
        }

        return false;
    }
}
