// TODO match line infos

class DoorWadjetActor extends DoorActor {
    function CreateAndInit() {
        DoorActor.CreateAndInit()
        if(this.hself_ <= 0) return;

        this.door_open_action_ = this.__DoorOpenAction_wadjet
    }

    function __DoorOpenAction_wadjet(next_door_hact, responder_hact) {
        const neg8 = -8

        local aS = []
        local aE = []

        if(GetAreaId() != 1) {
            aS = [750.494, 50.971, 390.982, 750.47, 51.36, 390.061, 0.0, 50.0]
            aE = [749.884, 41.511, 423.509, 749.887, 41.712, 422.53, 0.0, 50.0]
        } else {
            aS = [750.221, 22.622, 221.691, 750.211, 22.92, 222.646, 0.0, 50.0]
            aE = [750.635, 44.303, 205.227, 750.637, 44.006, 206.182, 0.0, 50.0]
        }

        init_petit()
        set_petit_dst_param(
            aS[0], aS[1], aS[2],
            aS[3], aS[4], aS[5],
            0.0, 50.0
        )
        begin_petit(60)

        wait(neg8)
        wait(20)

        QuakeStart(0)

        set_petit_src_param(
            aS[0], aS[1], aS[2],
            aS[3], aS[4], aS[5],
            0.0, 50.0
        )
        set_petit_dst_param(
            aE[0], aE[1], aE[2],
            aE[3], aE[4], aE[5],
            0.0, 50.0
        )
        begin_petit(165)

        change_door(this.hself_, 1, true, true)
        wait(15)
        change_door(next_door_hact, 1, true, true)
        wait(15)
        QuakeEnd()
        wait(60)
        QuakeStart(0)
        wait(45)
        QuakeEnd()

        wait_for_true2(is_door_actor_state, this.hself_, 3)

        wait(neg8)

        end_petit()
    }

    function __LocalCamera(cam_type, quake_type, frame1, frame2, frame3, aCam) {
        ChangeSwitchEventSetting_Remake([], 0, 101, quake_type, 301, -1, frame1, frame2, frame3, -1, 0.0, aCam, cam_type)
    }
}
