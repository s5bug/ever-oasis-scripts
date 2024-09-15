// TODO match line infos

class QuestNpc extends ActorBase {
    hquest = 0

    function OnPlayerTalked(hplayer, htarget) {
        print("QuestNpc::onPlayerTalked:" + hplayer + "," + htarget)

        PadOffWait(0)

        start_idle_town_npc()
        begin_talk_action(this.hself)

        func_wait(is_talk_ready)

        local scene_type = get_scene_type()
        if(scene_type == 5 || scene_type == 3) {
            party_weapon_in_out_sync(0, true)
        }

        local hquest = get_running_npc_quest_handle()
        if(0 <= hquest) {
            local message_id_list = get_quest_message_id(2, hquest)
            msg_sync(message_id_list[0], htarget)
        }

        end_idle_town_npc()

        PadOnWait(0)
    }
}
