// TODO match line infos

class HieroglyphStone extends BgobjActorBase {
    function CreateAndInit() {
        this.CreateActor()
    }

    function OnPlayerHatena(hplayer, htarget) {
        print("HieroglyphStone::OnPlayerHatena")

        local current_scene = GetCurrentSceneObj()
        local flag = this.GetFlag()
        local arg = this.__ZoneCheck()
        local h_player = get_player()

        PadOffWait(0)

        set_camera_target(this.hself_, 0.0, false, false)

        const neg9 = -9
        wait(neg9)

        turn_actor(h_player, 1, this.hself_, 5)

        wait_for_false1(is_actor_turning, h_player)

        if(!test_flag(2003)) {
            msg_sync(998)
        } else {
            if(flag > 0 && test_flag(flag)) {
                current_scene.demo_obj.StartDemo(arg[0], [])
            } else if(arg[1] != null) {
                current_scene.demo_obj.StartDemo(arg[0], [])
                add_item(arg[1], 1, true)
                send_to_bgobj(this.hself_, [1])
                SendHieroglyphStoneGet()
            } else {
                current_scene.demo_obj.StartDemo(arg[0], [])
            }
        }

        reset_camera_target()

        PadOnWait(0)

        return 0;
    }

    function __ZoneCheck() {
        local zone_id = get_zone_id()
        local arg = [0, 7718]

        if(zone_id == 34) {
            arg[0] = 0
            arg[1] = null
        } else if(zone_id == 36) {
            arg[0] = 3
            arg[1] = 7718
        } else if(zone_id == 54) {
            arg[0] = 0
            arg[1] = null
        } else if(zone_id == 37) {
            arg[0] = 9
            arg[1] = null
        } else if(zone_id == 55) {
            arg[0] = 0
            arg[1] = 7715
        } else if(zone_id == 53) {
            arg[0] = 2
            arg[1] = null
        } else if(zone_id == 59) {
            arg[0] = 0
            arg[1] = 7721
        } else if(zone_id == 56) {
            arg[0] = 3
            arg[1] = null
        } else if(zone_id == 42) {
            arg[0] = 1
            arg[1] = null
        }

        return arg;
    }
}
