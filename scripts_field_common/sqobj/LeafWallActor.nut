// TODO match line infos

class LeafWallActor extends BgobjActorBase {
    function CreateAndInit() {
        this.CreateActor()
    }

    function OnSwitchChanged(switch_state) {
        if(!switch_state) {
            local skill_panel = FindBgobjActorByActType(45, this.group_id_)
            if(skill_panel != null) {
                set_enable_bgobj_responder(skill_panel.hself_, true)
                start_actor_motion(skill_panel.hself_, 660)
            }
        }
        
        return 0;
    }
}
