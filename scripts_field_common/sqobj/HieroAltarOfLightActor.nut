// TODO match line infos

class HieroAltarOfLightActor extends BgobjActorBase {
    hiero_id_ = 0

    function CreateAndInit() {
        this.CreateActor()

        if(this.hself_ <= 0) return;

        if(is_hieroglyph_dungeon()) {
            this.hiero_id_ = get_current_hiero_id()
        } else {
            this.hiero_id_ = this.GetIntegerParam(0)
        }

        if(is_enable_active_hiero_alter_of_light(this.hiero_id_)) {
            register_player_responder(this.hself_, 4, [25.0, 270.0, 180.0])
        }

        GetCurrentSceneObj().SetListenerEnabled(0, true)
    }

    function DestroyActor() {
        GetCurrentSceneObj().SetListenerEnabled(0, false)
        BgobjActorBase.DestroyActor()
    }

    function OnPlayerHatena(hplayer, htarget) {
        local current_scene = GetCurrentSceneObj()

        if(hiero_altar_of_light_is_hit_tornado(this.hself_)) {
            // empty
        } else {
            set_demo_event(true)

            local eff_id = 9
            local motion = 1779

            start_actor_motion_auto_idle(hplayer, motion)

            wait_for_true1(is_motion_finished, hplayer)

            this.EventSkillResponderFailure(hplayer, eff_id)
            set_demo_event(false)
        }
    }

    function OnHitWindowMasic(hplayer, htarget) {
        switch(this.hiero_id_) {
            case 0:
                ForceStartOptionalQuestEventArgs_SetEventMode(47, null, false)
                break;
            case 1:
                ForceStartOptionalQuestEventArgs_SetEventMode(48, null, false)
                break;
            case 2:
                ForceStartOptionalQuestEventArgs_SetEventMode(49, null, false)
                break;
        }

        CallAfterPlayerActionEvent(this.hself_, this.layout_id_)
    }
}
