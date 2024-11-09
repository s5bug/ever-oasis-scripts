// TODO match line infos

class HieroAtlarActor extends BgobjActorBase {
    effect_obj_hact_ = 0
    collision_obj_hact_ = 0
    event_flag = 0
    hiero_id = 0
    h_effect_ = 0
    h_effect_2_ = 0

    function CreateAndInit() {
        this.CreateActor()
        if(this.hself_ <= 0) return;

        local pos = this.GetPos()
        local angle = this.GetAngle()

        this.collision_obj_hact_ = create_temp_actor_in_bgobj_group(
            this.group_id_, 4110,
            pos[0], pos[1], pos[2], angle
        )
        start_actor_motion(this.hself_, 184)

        print("[HieroAtlarActor] x = " + pos[0] +
            " y = " + pos[1] +
            " z = " + pos[2] +
            " angle = " + angle)
        
        this.effect_obj_hact_ = create_temp_actor_in_bgobj_group(
            this.group_id_, 4059,
            pos[0], pos[1], pos[2], angle
        )
        set_disable_culling(this.effect_obj_hact_)
        start_actor_motion(this.effect_obj_hact_, 78)

        if(this.__IsAnkhDungeonAlter()) {
            if(!test_flag(588)) {
                register_player_responder(this.hself_, 4, [25.0, 270.0, 180.0])
                reset_ankh_altar_mesh(this.hself_)
            } else {
                this.__AnkhDungeonOpened()
            }

            this.event_flag = this.GetFlag()
            this.hiero_id = 0
        } else {
            register_player_responder(this.hself_, 4, [25.0, 270.0, 180.0])

            this.event_flag = this.GetFlag()
            this.hiero_id = this.GetIntegerParam(0)

            set_hiero_altar_mesh(this.hself_, this.hiero_id)
        }
    }

    function OnPlayerHatena(hplayer, htarget) {
        if(this.__IsAnkhDungeonAlter()) {
            this.__OnPlayerHatenaAnkhDungeon(hplayer, htarget)
        } else if(this.event_flag <= 0 || test_flag(this.event_flag)) {
            this.__HieroStoneInSlate(hplayer)
        } else {
            this.__HieroMessage(hplayer)
        }
    }

    function __HieroMessage(hplayer) {
        const neg8 = -8

        PadOffWait(1)

        init_petit()

        local pos = this.GetPos()
        local angle = this.GetAngle()

        local offset_cam = vector_rotate_y([33.87, 29.533, 24.021], angle - 90.0)
        local offset_lot = vector_rotate_y([33.114, 29.132, 23.504], angle - 90.0)

        set_petit_dst_param(
            pos[0] + offset_cam[0], pos[1] + offset_cam[1], pos[2] + offset_cam[2],
            pos[0] + offset_lot[0], pos[1] + offset_lot[1], pos[2] + offset_lot[2]
            0.0, 50.0
        )
        begin_petit(30)

        wait(1)
        wait(neg8)

        msg_sync(54084)
        set_petit_slide_dst_to_src()

        local reset_param = get_reset_param_of_behind_camera()

        set_petit_dst_param(reset_param)
        begin_petit(30)

        wait(neg8)

        end_petit()

        PadOnWait(1)
    }

    function __HieroStoneInSlate(hplayer) {
        const neg8 = -8

        local pos = this.GetPos()
        local angle_y = this.GetAngle()

        PadOffWait(1)

        local offset_cam = vector_rotate_y([0.0, 40.0, 30.0], angle_y - 0.0)
        local offset_lot = vector_rotate_y([0.0, 11.44, -0.728], angle_y - 0.0)

        init_petit()
        set_petit_dst_param(
            pos[0] + offset_cam[0], pos[1] + offset_cam[1], pos[2] + offset_cam[2],
            pos[0] + offset_lot[0], pos[1] + offset_lot[1], pos[2] + offset_lot[2]
            0.0, 50.0
        )
        begin_petit(30)

        wait(1)
        wait(neg8)

        if(!test_flag(782)) {
            msg_sync(999)
            set_flag(782)
        }

        offset_cam = vector_rotate_y([0.0, 23.526, 12.619], angle_y - 0.0)
        offset_lot = vector_rotate_y([0.0, 11.44, 0.0], angle_y - 0.0)

        set_petit_slide_dst_to_src()
        set_petit_dst_param(
            pos[0] + offset_cam[0], pos[1] + offset_cam[1], pos[2] + offset_cam[2],
            pos[0] + offset_lot[0], pos[1] + offset_lot[1], pos[2] + offset_lot[2]
            0.0, 50.0
        )
        begin_petit(30)

        wait(neg8)
        fadeout_sync(0, 0, 1.0)

        local player_pos_offset = vector_rotate_y([12.5, 0.0, 0.0], angle_y - 90.0)

        set_actor_position_with_hitbgobj(
            hplayer,
            pos[0] + player_pos_offset[0],
            pos[1] + player_pos_offset[1],
            pos[2] + player_pos_offset[2],
            0
        )
        set_actor_angleY(hplayer, 180.0 + angle_y)

        wait(1)

        reset_party_position()
        ui_push_env(2)

        func_wait(ui_env_finished)

        local fixed_hiero_panel = get_ui_hiero_fixed_panel(this.hiero_id)
        ui_set_hiero_fixed_panel(fixed_hiero_panel)

        ui_activate(37, [this.hiero_id])

        ui_wait(37)

        ui_pop_env()
        func_wait(ui_env_finished)

        local aResult = get_ui_results(37)
        if(aResult[0] == 1) {
            regist_hiero_item(aResult[1], aResult[2], aResult[3], this.hiero_id)
            set_hiero_altar_mesh(this.hself_, this.hiero_id)
        } else {
            fadein(0, 0, 1.0)
            set_petit_slide_dst_to_src()

            local reset_param = get_reset_param_of_behind_camera()
            set_petit_dst_param(reset_param)

            begin_petit(30)
            wait(neg8)
            end_petit()

            wait(5)

            PadOnWait(0)
            return;
        }

        this.__OpenDoorEvent2()
    }

    function __OpenDoorEvent2() {
        switch(this.hiero_id) {
            case 0:
                set_flag(3059)
                break;
            case 1:
                set_flag(3093)
                break;
            case 2:
                set_flag(3703)
                break;
        }

        this.__OpenDoorEventCore(false)

        switch(this.hiero_id) {
            case 0:
                request_jump_scene(678, 1350.0, 30.0, 2310.0, 180.0, 0)
                break;
            case 1:
                request_jump_scene(643, 450.0, 0.0, 2278.5, 180.0, 0)
                break;
            default:
                request_jump_scene(662, 1950.0, 18.0, 2055.0, 180.0, 0)
                break;
        }

        PadOnWait(1)

        this.__FinalizeOpenDoorEventCore()
    }

    function __OpenDoorEventSpecial() {
        set_flag(3284)
        this.__OpenDoorEventCore(true)
        set_flag(588)

        add_item(7718, -1)
        add_item(7715, -1)
        add_item(7721, -1)

        delete_extend_mission_map_symbol(97)
        set_mission_ui_to_do(77)
        clear_sub_mission(5)
        request_jump_scene(394, 750.0, 30.0, 2055.0, 180.0, 0)

        PadOnWait(1)
        this.__FinalizeOpenDoorEventCore()
    }

    function __OpenDoorEventCore(is_special) {
        local pos = this.GetPos()
        local angle_y = this.GetAngle()

        local offset_pos = this.GetPos()

        local player_tbl = [
            get_party_index(0),
            get_party_index(1),
            get_party_index(2)
        ]
        local player = 0

        player = player_tbl[0]
        if(player != 0) {
            offset_pos = vector_rotate_y([0.0, 0.0, 11.2], angle_y)
            offset_pos[0] = offset_pos[0] + pos[0]
            offset_pos[1] = offset_pos[1] + pos[1]
            offset_pos[2] = offset_pos[2] + pos[2]
            set_actor_position_angle_y(
                player,
                offset_pos[0], offset_pos[1], offset_pos[2],
                angle_y + 180.0
            )
        }

        player = player_tbl[1]
        if(player != 0) {
            offset_pos = vector_rotate_y([12.5, 0.0, 25.0], angle_y)
            offset_pos[0] = offset_pos[0] + pos[0]
            offset_pos[1] = offset_pos[1] + pos[1]
            offset_pos[2] = offset_pos[2] + pos[2]
            set_actor_position_angle_y(
                player,
                offset_pos[0], offset_pos[1], offset_pos[2],
                angle_y + 180.0
            )
        }

        player = player_tbl[2]
        if(player != 0) {
            offset_pos = vector_rotate_y([-12.5, 0.0, 25.0], angle_y)
            offset_pos[0] = offset_pos[0] + pos[0]
            offset_pos[1] = offset_pos[1] + pos[1]
            offset_pos[2] = offset_pos[2] + pos[2]
            set_actor_position_angle_y(
                player,
                offset_pos[0], offset_pos[1], offset_pos[2],
                angle_y + 180.0
            )
        }   

        wait(1)

        if(this.__IsAnkhDungeonAlter()) {
            local archive = find_archive(1, "O492")
            begin_demo_camera(archive, "hiero_open_cam", [pos[0], pos[1], pos[2], angle_y])
        } else {
            local archive = find_archive(1, "O301")
            begin_demo_camera(archive, "hiero_open_cam", [pos[0], pos[1], pos[2], angle_y])
        }

        fadein(0, 0, 1.0)

        wait(30)

        play_se(0x1000219)
        start_actor_motion(this.hself_, 185)

        if(is_special) {
            this.h_effect_ = create_eff(1091, 1, this.hself_)
        } else {
            this.h_effect_ = create_eff(1082, 1, this.hself_)
        }

        wait(10)

        if(this.effect_obj_hact_ > 0) {
            start_actor_motion(this.effect_obj_hact_, 77)
            if(is_special) {
                this.h_effect_2_ = create_eff(754, 1, this.effect_obj_hact_)
            } else {
                this.h_effect_2_ = create_eff(752, 1, this.effect_obj_hact_)
            }
        }

        wait(80)

        for(local i = 0; i < 3; ++i) {
            if(player_tbl[i] != 0) {
                set_actor_visible(player_tbl[i], false)
            }
        }

        wait(70)

        if(is_special) {
            start_actor_motion(this.hself_, 737)
        } else {
            start_actor_motion(this.hself_, 71)
        }

        play_se(0x100021A)

        wait(105)

        for(local i = 0; i < 3; ++i) {
            if(player_tbl[i] != 0) {
                set_actor_visible(player_tbl[i], true)
            }
        }

        func_wait(is_demo_camera_finished)

        set_bgobj_actor_collision(this.collision_obj_hact_, false)
        set_bgobj_actor_collision(this.hself_, false)
        default_player_run_event_move(60.0, 120)
        fadeout_sync(0, 0, 2.0)
    }

    function __FinalizeOpenDoorEventCore() {
        end_demo_camera()
        destroy_eff(this.h_effect_)
        destroy_eff(this.h_effect_2_)
    }

    function __IsAnkhDungeonAlter() {
        if(this.bgobj_id_ == 4638) {
            return true;
        }
        return false;
    }

    function __OnPlayerHatenaAnkhDungeon(hplayer, htarget) {
        PadOffWait(0)

        local h_isuna_and_scarab = SimpleScarabAndIsunaCreateOnly()

        local item_check1 = 1 <= get_item_count(7715)
        local item_check2 = 1 <= get_item_count(7718)
        local item_check3 = 1 <= get_item_count(7721)
        local oasis_check = 16 <= get_var(100)
        local event_check = check_mission_completed(112)

        if(item_check1 && item_check2 && item_check3 && oasis_check && event_check) {
            local h_talk_actors = StartScarabIsunaTalkEventAppear()

            msg_sync_talk_event(94144, h_talk_actors[1])
            EndScarabIsunaTalkEventLeave(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
            
            local result = ui_sync(17, [1, 0, 3, 0, 94147, 94148])

            switch(result[0]) {
                case 0:
                    break;
                default:
                    SimpleScarabAndIsunaDestroyOnly(h_isuna_and_scarab[0], h_isuna_and_scarab[1])
                    PadOnWait(0)
                    return;
            }

            fadeout_sync(0, 0, 1.0)
            set_hiero_altar_mesh_special(this.hself_)
            this.__OpenDoorEventSpecial()
        } else {
            local h_talk_actors = StartScarabIsunaTalkEventAppear()

            local item_check4 = 1 <= get_item_count(7342)

            if(item_check4) {
                set_actor_facial(h_talk_actors[0], 3)
                set_actor_facial(h_talk_actors[1], 3)
                msg_sync_talk_event(94142, h_talk_actors[1])
            } else {
                msg_sync_talk_event(94037, h_talk_actors[1])
            }

            EndScarabIsunaTalkEventLeave(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
        }

        SimpleScarabAndIsunaDestroyOnly(h_isuna_and_scarab[0], h_isuna_and_scarab[1])
        PadOnWait(0)
    }

    function __AnkhDungeonOpened() {
        start_actor_motion(this.hself_, 72)
        set_bgobj_actor_collision(this.collision_obj_hact_, false)
        set_bgobj_actor_collision(this.hself_, false)
        set_hiero_altar_mesh_special(this.hself_)
    }
}
