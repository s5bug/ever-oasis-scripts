// TODO match line infos

class HieroSymbolSwitchActor extends BgobjActorBase {
    function CreateAndInit() {
        this.CreateActor()

        if(this.hself_ <= 0) return;
    }

    function OnPlayerHatena(hplayer, htarget) {
        set_demo_event_sync()
        idle_actor(hplayer, 0)
        
        wait_for_false1(is_actor_equipping_weapon, hplayer)

        turn_actor(hplayer, 1, this.hself_, 5)

        wait_for_false1(is_actor_turning, hplayer)

        start_actor_motion_auto_idle(hplayer, 1753)
        request_hiero_symbol_switch_on(this.hself_)
        
        wait_for_true2(is_motion_finished, hplayer, 1753)

        request_hiero_symbol_switch_on_step2(this.hself_)

        wait(1)

        set_demo_event(false)
    }
}
