// TODO match line infos

class TreasureBoxActor extends BgobjActorBase {
    hatena_action_ = null
    bgobj_mode_ = 0
    __wait_motion_id_ = 0

    function CreateAndInit() {
        this.bgobj_mode_ = this.GetBgobjMode()

        if(this.bgobj_mode_ == 1 || this.bgobj_mode_ == 7 ||
            this.bgobj_mode_ == 8 || this.bgobj_mode_ == 9) {
            this.hatena_action_ = this.__OnOpen_Key
        } else if(this.bgobj_mode_ == 2) {
            this.hatena_action_ = this.__OnOpen_BossKey
        } else if(this.bgobj_mode_ == 3) {
            print("ERROR:クォーツのかけらは入手できません")
        } else if(this.bgobj_mode_ == 4) {
            this.hatena_action_ = this.__OnOpen_Result

            local wasopend_flag = this.GetFlag(0)
            if(wasopend_flag > 0 && !test_flag(wasopend_flag)) {
                GetCurrentSceneObj().SetListenerEnabled(0, true)
            }
        } else if(this.bgobj_mode_ == 5) {
            this.hatena_action_ = this.__OnOpen_HieroGoal
        } else {
            this.hatena_action_ = this.__OnOpen_Normal
        }

        this.CreateActor()

        if(this.hself_ == 0) return;

        local apper_flag = this.GetFlag(1)

        if(apper_flag > 0 && test_flag(apper_flag) == false) {
            start_actor_motion(this.hself_, 396)
            set_enable_bgobj_responder(this.hself_, false)
        }

        if(this.bgobj_id_ == 4034 || this.bgobj_id_ == 4141) {
            this.__wait_motion_id_ = 6
            if(this.bgobj_mode_ == 6) {
                this.__wait_motion_id_ = 727
            }
        } else if(this.bgobj_id_ == 4080) {
            this.__wait_motion_id_ = 183
        } else if(this.bgobj_id_ == 4324) {
            this.__wait_motion_id_ = 451
        } else if(this.bgobj_id_ == 4081) {
            this.__wait_motion_id_ = 646
        } else {
            print("ERROR:想定外のBgobjIDです")
            assert(0)
        }
    }

    function DestroyActor() {
        if(this.bgobj_mode_ == 4) {
            GetCurrentSceneObj().SetListenerEnabled(0, false)
        }
        BgobjActorBase.DestroyActor()
    }

    function Appear() {
        start_actor_motion(this.hself_, 8)
        set_enable_bgobj_responder(this.hself_, true)
        set_flag(this.GetFlag(1))
    }

    function OnPlayerHatena(hplayer, htarget) {
        local flag = this.GetFlag()
        if(flag > 0 && test_flag(flag)) {
            return false;
        }

        if(this.hatena_action_) {
            PadOffWait(0)
            this.hatena_action_(hplayer)
            CallAfterPlayerActionEvent(this.hself_, this.layout_id_)
            PadOnWait(0)
            this.SendReaction()
        }
        
        return 0;
    }

    function __OnOpen_Normal(hplayer) {
        set_camera_target(this.hself_, -10.0)
        change_state_switch_actor(this.hself_, true, true)
        motion_wait_with_id(this.hself_, this.__wait_motion_id_)
        reset_camera_target()
    }

    function __OnOpen_Key(hplayer) {
        set_camera_target(this.hself_, -10.0)
        change_state_switch_actor(this.hself_, true, true)
        motion_wait_with_id(this.hself_, this.__wait_motion_id_)
        start_jingle_bgm(0x1000044)

        local item_name = 7340
        local key_bgobj_id = 4089
        local bgobj_mode = this.GetBgobjMode()

        if(bgobj_mode == 7) {
            item_name = 7340
            key_bgobj_id = 4089
        } else if(bgobj_mode == 8) {
            item_name = 7338
            key_bgobj_id = 4088
        } else if(bgobj_mode == 9) {
            item_name = 7339
            key_bgobj_id = 4090
        }

        wait(1)

        local key_hact = get_hactor_by_bgobj_id(key_bgobj_id)
        if(key_hact) {
            motion_wait_with_id(key_hact, 569)
        }

        if(item_name > 0) {
            msg_argv_sync(4043, 0, 0, [item_name])
        }

        send_to_bgobj(this.hself_, [])
        reset_camera_target()
    }

    function __OnOpen_BossKey(hplayer) {
        set_camera_target(this.hself_, -10.0)
        change_state_switch_actor(this.hself_, true, true)
        motion_wait_with_id(this.hself_, this.__wait_motion_id_)
        start_jingle_bgm(0x100003F)

        wait(1)

        local key_boss_hact = get_hactor_by_bgobj_id(4107)
        if(key_boss_hact) {
            motion_wait_with_id(key_boss_hact, 187)
        }

        msg_argv_sync(4043, 0, 0, [7343])
        send_to_bgobj(this.hself_, [])
        reset_camera_target()
    }

    function __OnOpen_Result(hplayer) {
        local enable_tornado = get_bgobj_user_data(this.hself_, 0)
        if(enable_tornado == 0) {
            local eff_id = 9
            local motion = 1779

            start_actor_motion(hplayer, motion)
            
            wait_for_true1(is_motion_finished, hplayer)
            
            this.EventSkillResponderFailure(hplayer, eff_id)
        } else {
            // empty
        }
    }

    function __OnOpen_HieroGoal(hplayer) {
        const neg1 = -1
        const neg7 = -7
        const neg8 = -8

        set_demo_event(true)
        unregister_player_responder(this.hself_, 4)
        set_camera_target(this.hself_, -20.0)

        wait(15)

        change_state_switch_actor(this.hself_, true, true)

        wait(15)
        wait(15)

        fadeout_sync(0, 0, 0.25)
        reset_camera_target()

        local target_pos = get_actor_position(this.hself_)
        local target_rot = get_actor_angle_y(this.hself_)

        local dir_x = null
        local dir_z = null

        if(target_rot <= -135.0) {
            dir_x = 0.0
            dir_z = -1.0
        } else if(target_rot <= -45.0) {
            dir_x = -1.0
            dir_z = 0.0
        } else if(target_rot <= 45.0) {
            dir_x = 0.0
            dir_z = 1.0
        } else if(target_rot <= 135.0) {
            dir_x = 1.0
            dir_z = 0.0
        } else {
            dir_x = 0.0
            dir_z = -1.0
        }

        local POS_MAIN_1 = [0.0, 0.505, 9.99, 180.0]
        local POS_SUB1_1 = [7.78, 0.05, 7.922, 227.3]
        local POS_SUB2_1 = [-7.78, 0.05, 7.922, 132.8]
        local POS_MAIN_2 = [0.0, 0.0, 19.6, 0.0]
        local POS_SUB1_2 = [11.5, 0.0, 14.6, 320.0]
        local POS_SUB2_2 = [-11.5, 0.0, 14.6, 40.0]
        local POS_CAM_1 = [0.0, 6.305, -2.1, 0.0, 12.905, 6.5, 50.0]
        local POS_CAM_2 = [0.0, 9.59, 40.595, 0.0, 5.4, 18.5, 50.0]
        local POS_MAIN = [0.0, 0.0, 0.0, 0.0]
        local POS_SUB1 = [0.0, 0.0, 0.0, 0.0]
        local POS_SUB2 = [0.0, 0.0, 0.0, 0.0]
        local MOTION_HAKO_NOZOKU_WAIT = [394, 394, 394, 394]
        local MOTION_HAKO_NOZOKU = [376, 376, 376, 376]
        local MOTION_LOOK_UP = [251, 251, 251, 251]
        local POS_CAM = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        POS_MAIN = [
            (target_pos[0] + (dir_x * POS_MAIN_1[2])) + (dir_z * POS_MAIN_1[0]),
            target_pos[1] + POS_MAIN_1[1],
            (target_pos[2] + (dir_z * POS_MAIN_1[2])) + (-dir_x * POS_MAIN_1[0]),
            Clamp0To2PI(target_rot + POS_MAIN_1[3])
        ]
        POS_SUB1 = [
            (target_pos[0] + (dir_x * POS_SUB1_1[2])) + (dir_z * POS_SUB1_1[0]),
            target_pos[1] + POS_SUB1_1[1],
            (target_pos[2] + (dir_z * POS_SUB1_1[2])) + (-dir_x * POS_SUB1_1[0]),
            Clamp0To2PI(target_rot + POS_SUB1_1[3])
        ]
        POS_SUB2 = [
            (target_pos[0] + (dir_x * POS_SUB2_1[2])) + (dir_z * POS_SUB2_1[0]),
            target_pos[1] + POS_SUB2_1[1],
            (target_pos[2] + (dir_z * POS_SUB2_1[2])) + (-dir_x * POS_SUB2_1[0]),
            Clamp0To2PI(target_rot + POS_SUB2_1[3])
        ]
        POS_CAM = [
            (target_pos[0] + (dir_x * POS_CAM_1[2])) + (dir_z * POS_CAM_1[0]),
            target_pos[1] + POS_CAM_1[1],
            (target_pos[2] + (dir_z * POS_CAM_1[2])) + (-dir_x * POS_CAM_1[0]),
            (target_pos[0] + (dir_x * POS_CAM_1[5])) + (dir_z * POS_CAM_1[3]),
            target_pos[1] + POS_CAM_1[4],
            (target_pos[2] + (dir_z * POS_CAM_1[5])) + (-dir_x * POS_CAM_1[3]),
            POS_CAM_1[6]
        ]

        local aHact = [
            get_party_index(0),
            get_party_index(1),
            get_party_index(2)
        ]
        local alive = [
            false,
            false,
            false
        ]
        local tribe = [
            0,
            -1,
            -1
        ]

        for(local i = 0; i < aHact.len(); ++i) {
            if(aHact[i] == 0) {
                // empty
            } else {
                alive[i] = is_player_alive(aHact[i])
                if(alive[i] == false) {
                    set_actor_visible(aHact[i], false)
                } else {
                    demo_reset_actor_collision(aHact[i])
                    set_disable_gravity(aHact[i])
                    idle_actor(aHact[i], 0, false)

                    wait_for_false1(is_actor_equipping_weapon, aHact[i])

                    tribe[i] = get_charadb(aHact[i], 54)
                }
            }
        }

        if(aHact[0] != 0 && alive[0] == true) {
            set_actor_position_angle_y(
                aHact[0],
                POS_MAIN[0],
                POS_MAIN[1],
                POS_MAIN[2],
                POS_MAIN[3],
                1
            )
            set_player_along_slope(aHact[0], false)
            set_actor_shape_angleX(aHact[0], -18.0)

            wait(1)

            start_actor_motion(aHact[0], MOTION_HAKO_NOZOKU_WAIT[tribe[0]])
        }

        if(aHact[1] != 0 && alive[1] == true) {
            set_actor_position_angle_y(
                aHact[1],
                POS_SUB1[0],
                POS_SUB1[1],
                POS_SUB1[2],
                POS_SUB1[3],
                1
            )
            set_player_along_slope(aHact[1], false)
            set_actor_shape_angleX(aHact[1], -24.8)
            set_actor_shape_angleZ(aHact[1], 0.0)

            wait(1)

            start_actor_motion(aHact[1], MOTION_HAKO_NOZOKU_WAIT[tribe[1]])
        }

        if(aHact[2] != 0 && alive[2] == true) {
            set_actor_position_angle_y(
                aHact[2],
                POS_SUB2[0],
                POS_SUB2[1],
                POS_SUB2[2],
                POS_SUB2[3],
                1
            )
            set_player_along_slope(aHact[2], false)
            set_actor_shape_angleX(aHact[2], -24.8)
            set_actor_shape_angleZ(aHact[2], 0.0)

            wait(1)

            start_actor_motion(aHact[2], MOTION_HAKO_NOZOKU_WAIT[tribe[2]])
        }

        wait(1)

        init_petit()
        set_petit_dst_param(
            POS_CAM[0], POS_CAM[1], POS_CAM[2],
            POS_CAM[3], POS_CAM[4], POS_CAM[5],
            0.0, POS_CAM[6]
        )
        begin_petit(0)

        wait(neg8)
        wait(10)

        fadein(0, 0, 1.0)

        wait_for_true1(is_motion_finished, this.hself_)

        for(local i = 0; i < aHact.len(); ++i) {
            if(alive[i] == true) {
                start_actor_motion(aHact[i], MOTION_HAKO_NOZOKU[tribe[i]])
                wait(8)
            }
        }

        local eff = create_eff(1156, 1, this.hself_)

        play_se3D_handle(0x1000224, this.hself_)

        wait(30 * 2)
        fadeout_sync(1, 1, 1.0)

        destroy_eff(eff)

        wait(10)

        POS_MAIN = [
            (target_pos[0] + (dir_x * POS_MAIN_2[2])) + (dir_z * POS_MAIN_2[0]),
            target_pos[1] + POS_MAIN_2[1],
            (target_pos[2] + (dir_z * POS_MAIN_2[2])) + (-dir_x * POS_MAIN_2[0]),
            Clamp0To2PI(target_rot + POS_MAIN_2[3])
        ]
        POS_SUB1 = [
            (target_pos[0] + (dir_x * POS_SUB1_2[2])) + (dir_z * POS_SUB1_2[0]),
            target_pos[1] + POS_SUB1_2[1],
            (target_pos[2] + (dir_z * POS_SUB1_2[2])) + (-dir_x * POS_SUB1_2[0]),
            Clamp0To2PI(target_rot + POS_SUB1_2[3])
        ]
        POS_SUB2 = [
            (target_pos[0] + (dir_x * POS_SUB2_2[2])) + (dir_z * POS_SUB2_2[0]),
            target_pos[1] + POS_SUB2_2[1],
            (target_pos[2] + (dir_z * POS_SUB2_2[2])) + (-dir_x * POS_SUB2_2[0]),
            Clamp0To2PI(target_rot + POS_SUB2_2[3])
        ]
        POS_CAM = [
            (target_pos[0] + (dir_x * POS_CAM_2[2])) + (dir_z * POS_CAM_2[0]),
            target_pos[1] + POS_CAM_2[1],
            (target_pos[2] + (dir_z * POS_CAM_2[2])) + (-dir_x * POS_CAM_2[0]),
            (target_pos[0] + (dir_x * POS_CAM_2[5])) + (dir_z * POS_CAM_2[3]),
            target_pos[1] + POS_CAM_2[4],
            (target_pos[2] + (dir_z * POS_CAM_2[5])) + (-dir_x * POS_CAM_2[3]),
            POS_CAM_2[6]
        ]

        if(aHact[0] != 0 && alive[0] == true) {
            set_actor_position_angle_y(
                aHact[0],
                POS_MAIN[0],
                POS_MAIN[1],
                POS_MAIN[2],
                POS_MAIN[3]
            )
        }

        if(aHact[1] != 0 && alive[1] == true) {
            set_actor_position_angle_y(
                aHact[1],
                POS_SUB1[0],
                POS_SUB1[1],
                POS_SUB1[2],
                POS_SUB1[3]
            )
            reset_player_along_slope(aHact[1])
            set_actor_shape_angleZ(aHact[1], 0.0)
        }

        if(aHact[2] != 0 && alive[2] == true) {
            set_actor_position_angle_y(
                aHact[2],
                POS_SUB2[0],
                POS_SUB2[1],
                POS_SUB2[2],
                POS_SUB2[3]
            )
            reset_player_along_slope(aHact[2])
            set_actor_shape_angleZ(aHact[2], 0.0)
        }

        wait(1)

        for(local i = 0; i < aHact.len(); ++i) {
            if(alive[i] == true) {
                if(i > 0) {
                    wait(5)
                }
                start_actor_motion(aHact[i], MOTION_LOOK_UP[tribe[i]])
            }
        }

        wait(10)

        set_petit_slide_dst_to_src()
        set_petit_dst_param(
            POS_CAM[0], POS_CAM[1], POS_CAM[2],
            POS_CAM[3], POS_CAM[4], POS_CAM[5],
            0.0, POS_CAM[6]
        )
        begin_petit(0)

        wait(neg8)
        fadein_sync(1, 1, 0.5)
        wait(30)

        start_jingle_bgm(0x100003D)

        wait(30)

        local item_ids = get_hiero_goal_treasure_box_item()
        local item_index = 0
        for(local i = 0; i < 5; ++i) {
            if(item_ids[i] != neg1) {
                add_item(item_ids[i], 1)
            } else {
                break;
            }
        }

        check_quest_get_item()

        while(true) {
            if(item_ids[item_index] == neg1) {
                break;
            }
            
            if(item_index >= 4 || item_ids[item_index + 1] == neg1) {
                msg_argv_sync(4077, 0, 0, [item_ids[item_index]])
                break;
            } else {
                msg_argv_sync(4065, 0, 0, [item_ids[item_index], item_ids[item_index + 1]])
            }

            item_index = item_index + 2

            if(item_index >= 5) break;
        }

        wait(15)
        fadeout_sync(1, 1, 1.0)

        for(local i = 0; i < aHact.len(); ++i) {
            demo_revive_actor_collision(aHact[i])
            set_party_gravity_scale(1.0)
            idle_actor(aHact[i])
            if(aHact[i] != 0 && alive[i] == false) {
                set_actor_visible(aHact[i], true)
            }
        }

        fadein_sync(1, 1, 1.0)

        local party_count = get_party_count()
        for(local i = 0; i < party_count; i++) {
            local hact = get_party_order(i)
            start_actor_motion(hact, 1787)
        }

        wait(90)
        ui_sync(67, [0])

        fadeout(0, 0, 2.0, 0, 1)

        wait(neg7)

        BackHieroJumpOnly()
        end_petit()
        ui_pop_env()

        func_wait(ui_env_finished)

        set_demo_event(false)
        check_hiero_achieve()
        set_flag(358)

        switch(get_current_hiero_id()) {
            case 0:
                set_flag(3951)
                break;
            case 1:
                set_flag(3952)
                break;
            case 2:
                set_flag(3953)
                break;
        }
    }

    function ItemGetDemo(h_item, item_idle_motion) {
        const neg8 = -8

        set_demo_event(true)
        unregister_player_responder(this.hself_, 4)
        set_camera_target(this.hself_, -20.0)

        wait(15)

        fadeout_sync(0, 0, 0.25)
        ui_pop_env()
        ui_push_env(0)

        func_wait(ui_env_finished)

        reset_camera_target()

        local target_pos = get_actor_position(this.hself_)

        local dir_x = null
        local dir_z = null

        local target_rot = get_actor_angle_y(this.hself_)

        if(target_rot <= 0.0) {
            dir_x = 0.0
            dir_z = 1.0
        } else if(target_rot <= 90.0) {
            dir_x = 1.0
            dir_z = 0.0
        } else if(target_rot <= 180.0) {
            dir_x = 0.0
            dir_z = -1.0
        } else if(target_rot <= 270.0) {
            dir_x = -1.0
            dir_z = 0.0
        } else {
            dir_x = 0.0
            dir_z = 1.0
        }

        local POS_MAIN_1 = [0.0, 0.0, 10.0, 180.0]
        local POS_SUB1_1 = [6.5, 0.25, 9.6, 153.0]
        local POS_SUB2_1 = [-6.5, 0.25, 9.6, 207.0]
        local POS_MAIN_2 = [0.0, 0.0, 9.5, 0.0]
        local POS_SUB1_2 = [10.0, 0.0, 10.0, 40.0]
        local POS_SUB2_2 = [-10.0, 0.0, 10.0, -40.0]
        local POS_ITEM_1 = [0.0, 14.0, 17.0, 0.0]
        local POS_CAM_1 = [0.0, 0.1255, -4.4221, 0.0, 8.7531, 1.7402, 50.0]
        local POS_CAM_2 = [0.0, 12.0, 40.0, 0.0, 11.0, 17.0, 50.0]
        local POS_CAM_3 = [11.0, 30.9, -38.3, 10.7, 30.5, -37.5, 50.0]
        local POS_MAIN = [0.0, 0.0, 0.0, 0.0]
        local POS_SUB1 = [0.0, 0.0, 0.0, 0.0]
        local POS_SUB2 = [0.0, 0.0, 0.0, 0.0]
        local MOTION_HAKO_NOZOKU = [376, 376, 376, 376]
        local MOTION_GOOD_FLIER = [250, 250, 250, 250]
        local POS_CAM = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        POS_MAIN = [
            (target_pos[0] + (dir_x * POS_MAIN_1[2])) + (-dir_z * POS_MAIN_1[0]),
            target_pos[1] + POS_MAIN_1[1],
            (target_pos[2] + (dir_z * POS_MAIN_1[2])) + (dir_x * POS_MAIN_1[0]),
            Clamp0To2PI(target_rot + POS_MAIN_1[3])
        ]
        POS_SUB1 = [
            (target_pos[0] + (dir_x * POS_SUB1_1[2])) + (-dir_z * POS_SUB1_1[0]),
            target_pos[1] + POS_SUB1_1[1],
            (target_pos[2] + (dir_z * POS_SUB1_1[2])) + (dir_x * POS_SUB1_1[0]),
            Clamp0To2PI(target_rot + POS_SUB1_1[3])
        ]
        POS_SUB2 = [
            (target_pos[0] + (dir_x * POS_SUB2_1[2])) + (-dir_z * POS_SUB2_1[0]),
            target_pos[1] + POS_SUB2_1[1],
            (target_pos[2] + (dir_z * POS_SUB2_1[2])) + (dir_x * POS_SUB2_1[0]),
            Clamp0To2PI(target_rot + POS_SUB2_1[3])
        ]
        local POS_ITEM = [
            (target_pos[0] + (dir_x * POS_ITEM_1[2])) + (-dir_z * POS_ITEM_1[0]),
            target_pos[1] + POS_ITEM_1[1],
            (target_pos[2] + (dir_z * POS_ITEM_1[2])) + (dir_x * POS_ITEM_1[0]),
            Clamp0To2PI(target_rot + POS_ITEM_1[3])
        ]
        POS_CAM = [
            (target_pos[0] + (dir_x * POS_CAM_1[2])) + (-dir_z * POS_CAM_1[0]),
            target_pos[1] + POS_CAM_1[1],
            (target_pos[2] + (dir_z * POS_CAM_1[2])) + (dir_x * POS_CAM_1[0]),
            (target_pos[0] + (dir_x * POS_CAM_1[5])) + (-dir_z * POS_CAM_1[3]),
            target_pos[1] + POS_CAM_1[4],
            (target_pos[2] + (dir_z * POS_CAM_1[5])) + (dir_x * POS_CAM_1[3]),
            POS_CAM_1[6]
        ]

        local aHact = [
            get_party_index(0),
            get_party_index(1),
            get_party_index(2)
        ]
        local alive = [
            false,
            false,
            false
        ]
        local tribe = [
            0,
            -1,
            -1
        ]

        for(local i = 0; i < aHact.len(); ++i) {
            if(aHact[i] == 0) {
                // empty
            } else {
                alive[i] = is_player_alive(aHact[i])
                if(alive[i] == false) {
                    set_actor_visible(aHact[i], false)
                } else {
                    idle_actor(aHact[i], 0, false)

                    wait_for_false1(is_actor_equipping_weapon, aHact[i])

                    tribe[i] = get_charadb(aHact[i], 54)
                }
            }
        }

        if(aHact[0] != 0 && alive[0] == true) {
            set_actor_position_angle_y(
                aHact[0],
                POS_MAIN[0],
                POS_MAIN[1],
                POS_MAIN[2],
                POS_MAIN[3]
            )
        }

        if(aHact[1] != 0 && alive[1] == true) {
            set_actor_position_angle_y(
                aHact[1],
                POS_SUB1[0],
                POS_SUB1[1],
                POS_SUB1[2],
                POS_SUB1[3]
            )
            set_player_along_slope(aHact[1], false)
            set_actor_shape_angleZ(aHact[1], -18.0)
        }

        if(aHact[2] != 0 && alive[2] == true) {
            set_actor_position_angle_y(
                aHact[2],
                POS_SUB2[0],
                POS_SUB2[1],
                POS_SUB2[2],
                POS_SUB2[3]
            )
            set_player_along_slope(aHact[2], false)
            set_actor_shape_angleZ(aHact[2], 18.0)
        }

        wait(1)

        init_petit()
        set_petit_dst_param(
            POS_CAM[0], POS_CAM[1], POS_CAM[2],
            POS_CAM[3], POS_CAM[4], POS_CAM[5],
            0.0, POS_CAM[6]
        )
        begin_petit(0)

        wait(neg8)
        wait(10)

        fadein(0, 0, 2.0)

        start_actor_motion(this.hself_, 183)
        wait_for_true1(is_motion_finished, this.hself_)

        for(local i = 0; i < aHact.len(); ++i) {
            if(alive[i] == true) {
                start_actor_motion(aHact[i], MOTION_HAKO_NOZOKU[tribe[i]])
                wait(8)
            }
        }

        local eff = create_eff(1168, 1, this.hself_)

        wait(30 * 2)
        fadeout_sync(1, 1, 1.0)

        destroy_eff(eff)

        wait(10)

        POS_MAIN = [
            (target_pos[0] + (dir_x * POS_MAIN_2[2])) + (-dir_z * POS_MAIN_2[0]),
            target_pos[1] + POS_MAIN_2[1],
            (target_pos[2] + (dir_z * POS_MAIN_2[2])) + (dir_x * POS_MAIN_2[0]),
            Clamp0To2PI(target_rot + POS_MAIN_2[3])
        ]
        POS_SUB1 = [
            (target_pos[0] + (dir_x * POS_SUB1_2[2])) + (-dir_z * POS_SUB1_2[0]),
            target_pos[1] + POS_SUB1_2[1],
            (target_pos[2] + (dir_z * POS_SUB1_2[2])) + (dir_x * POS_SUB1_2[0]),
            Clamp0To2PI(target_rot + POS_SUB1_2[3])
        ]
        POS_SUB2 = [
            (target_pos[0] + (dir_x * POS_SUB2_2[2])) + (-dir_z * POS_SUB2_2[0]),
            target_pos[1] + POS_SUB2_2[1],
            (target_pos[2] + (dir_z * POS_SUB2_2[2])) + (dir_x * POS_SUB2_2[0]),
            Clamp0To2PI(target_rot + POS_SUB2_2[3])
        ]
        POS_CAM = [
            (target_pos[0] + (dir_x * POS_CAM_2[2])) + (-dir_z * POS_CAM_2[0]),
            target_pos[1] + POS_CAM_2[1],
            (target_pos[2] + (dir_z * POS_CAM_2[2])) + (dir_x * POS_CAM_2[0]),
            (target_pos[0] + (dir_x * POS_CAM_2[5])) + (-dir_z * POS_CAM_2[3]),
            target_pos[1] + POS_CAM_2[4],
            (target_pos[2] + (dir_z * POS_CAM_2[5])) + (dir_x * POS_CAM_2[3]),
            POS_CAM_2[6]
        ]

        if(aHact[0] != 0 && alive[0] == true) {
            set_actor_position_angle_y(
                aHact[0],
                POS_MAIN[0],
                POS_MAIN[1],
                POS_MAIN[2],
                POS_MAIN[3]
            )
        }

        if(aHact[1] != 0 && alive[1] == true) {
            set_actor_position_angle_y(
                aHact[1],
                POS_SUB1[0],
                POS_SUB1[1],
                POS_SUB1[2],
                POS_SUB1[3]
            )
            reset_player_along_slope(aHact[1])
            set_actor_shape_angleZ(aHact[1], 0.0)
        }

        if(aHact[2] != 0 && alive[2] == true) {
            set_actor_position_angle_y(
                aHact[2],
                POS_SUB2[0],
                POS_SUB2[1],
                POS_SUB2[2],
                POS_SUB2[3]
            )
            reset_player_along_slope(aHact[2])
            set_actor_shape_angleZ(aHact[2], 0.0)
        }

        wait(1)

        if(h_item != 0 && item_idle_motion != -1) {
            start_actor_motion(h_item, item_idle_motion)
        }

        for(local i = 0; i < aHact.len(); ++i) {
            if(alive[i] == true) {
                if(i > 0) {
                    wait(5)
                }
                start_actor_motion(aHact[i], MOTION_GOOD_FLIER[tribe[i]])
            }
        }

        wait(10)

        set_petit_slide_dst_to_src()
        set_petit_dst_param(
            POS_CAM[0], POS_CAM[1], POS_CAM[2],
            POS_CAM[3], POS_CAM[4], POS_CAM[5],
            0.0, POS_CAM[6]
        )
        begin_petit(0)

        wait(neg8)
        fadein_sync(1, 1, 1.0)

        start_jingle_bgm(0x100003D)

        wait(30 * 1)

        play_se(0x100008E)

        wait(15)
    }

    function ItemGetDemoHiero() {
        const neg8 = -8

        set_demo_event(true)
        unregister_player_responder(this.hself_, 4)

        fadeout_sync(0, 0, 0.25)
        ui_pop_env()
        ui_push_env(0)

        func_wait(ui_env_finished)

        local target_pos = get_actor_position(this.hself_)

        local dir_x = null
        local dir_z = null

        local target_rot = get_actor_angle_y(this.hself_)

        if(target_rot <= 0.0) {
            dir_x = 0.0
            dir_z = 1.0
        } else if(target_rot <= 90.0) {
            dir_x = 1.0
            dir_z = 0.0
        } else if(target_rot <= 180.0) {
            dir_x = 0.0
            dir_z = -1.0
        } else if(target_rot <= 270.0) {
            dir_x = -1.0
            dir_z = 0.0
        } else {
            dir_x = 0.0
            dir_z = 1.0
        }

        local POS_MAIN_2 = [0.0, 0.0, 9.5, 0.0]
        local POS_SUB1_2 = [10.0, 0.0, 10.0, 40.0]
        local POS_SUB2_2 = [-10.0, 0.0, 10.0, -40.0]
        local POS_CAM_2 = [0.0, 12.0, 40.0, 0.0, 11.0, 17.0, 50.0]
        local POS_MAIN = [0.0, 0.0, 0.0, 0.0]
        local POS_SUB1 = [0.0, 0.0, 0.0, 0.0]
        local POS_SUB2 = [0.0, 0.0, 0.0, 0.0]
        local MOTION_GOOD_FLIER = [250, 250, 250, 250]
        local POS_CAM = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        local aHact = [
            get_party_index(0),
            get_party_index(1),
            get_party_index(2)
        ]
        local alive = [
            false,
            false,
            false
        ]
        local tribe = [
            0,
            -1,
            -1
        ]

        for(local i = 0; i < aHact.len(); ++i) {
            if(aHact[i] == 0) {
                // empty
            } else {
                alive[i] = is_player_alive(aHact[i])
                if(alive[i] == false) {
                    set_actor_visible(aHact[i], false)
                } else {
                    idle_actor(aHact[i], 0, false)

                    wait_for_false1(is_actor_equipping_weapon, aHact[i])

                    tribe[i] = get_charadb(aHact[i], 54)
                }
            }
        }

        init_petit()

        wait(10)

        POS_MAIN = [
            (target_pos[0] + (dir_x * POS_MAIN_2[2])) + (-dir_z * POS_MAIN_2[0]),
            target_pos[1] + POS_MAIN_2[1],
            (target_pos[2] + (dir_z * POS_MAIN_2[2])) + (dir_x * POS_MAIN_2[0]),
            Clamp0To2PI(target_rot + POS_MAIN_2[3])
        ]
        POS_SUB1 = [
            (target_pos[0] + (dir_x * POS_SUB1_2[2])) + (-dir_z * POS_SUB1_2[0]),
            target_pos[1] + POS_SUB1_2[1],
            (target_pos[2] + (dir_z * POS_SUB1_2[2])) + (dir_x * POS_SUB1_2[0]),
            Clamp0To2PI(target_rot + POS_SUB1_2[3])
        ]
        POS_SUB2 = [
            (target_pos[0] + (dir_x * POS_SUB2_2[2])) + (-dir_z * POS_SUB2_2[0]),
            target_pos[1] + POS_SUB2_2[1],
            (target_pos[2] + (dir_z * POS_SUB2_2[2])) + (dir_x * POS_SUB2_2[0]),
            Clamp0To2PI(target_rot + POS_SUB2_2[3])
        ]
        POS_CAM = [
            (target_pos[0] + (dir_x * POS_CAM_2[2])) + (-dir_z * POS_CAM_2[0]),
            target_pos[1] + POS_CAM_2[1],
            (target_pos[2] + (dir_z * POS_CAM_2[2])) + (dir_x * POS_CAM_2[0]),
            (target_pos[0] + (dir_x * POS_CAM_2[5])) + (-dir_z * POS_CAM_2[3]),
            target_pos[1] + POS_CAM_2[4],
            (target_pos[2] + (dir_z * POS_CAM_2[5])) + (dir_x * POS_CAM_2[3]),
            POS_CAM_2[6]
        ]

        if(aHact[0] != 0 && alive[0] == true) {
            set_actor_position_angle_y(
                aHact[0],
                POS_MAIN[0],
                POS_MAIN[1],
                POS_MAIN[2],
                POS_MAIN[3]
            )
        }

        if(aHact[1] != 0 && alive[1] == true) {
            set_actor_position_angle_y(
                aHact[1],
                POS_SUB1[0],
                POS_SUB1[1],
                POS_SUB1[2],
                POS_SUB1[3]
            )
            reset_player_along_slope(aHact[1])
            set_actor_shape_angleZ(aHact[1], 0.0)
            set_actor_shape_angleX(aHact[1], 0.0)
        }

        if(aHact[2] != 0 && alive[2] == true) {
            set_actor_position_angle_y(
                aHact[2],
                POS_SUB2[0],
                POS_SUB2[1],
                POS_SUB2[2],
                POS_SUB2[3]
            )
            reset_player_along_slope(aHact[2])
            set_actor_shape_angleZ(aHact[2], 0.0)
            set_actor_shape_angleX(aHact[2], 0.0)
        }

        wait(1)

        for(local i = 0; i < aHact.len(); ++i) {
            if(alive[i] == true) {
                if(i > 0) {
                    wait(5)
                }
                start_actor_motion(aHact[i], MOTION_GOOD_FLIER[tribe[i]])
            }
        }

        wait(10)

        set_petit_slide_dst_to_src()
        set_petit_dst_param(
            POS_CAM[0], POS_CAM[1], POS_CAM[2],
            POS_CAM[3], POS_CAM[4], POS_CAM[5],
            0.0, POS_CAM[6]
        )
        begin_petit(0)

        wait(neg8)
        fadein_sync(0, 1, 1.0)

        start_jingle_bgm(0x100003D)

        wait(30 * 1)
        wait(15)
    }

    function OnHitWindowMasic(hplayer, htarget) {
        PadOffWait(0)
        wait(60)

        this.__QuazeGetDemo(hplayer)

        CallAfterPlayerActionEvent(this.hself_, this.layout_id_)

        PadOnWait(0)
        this.SendReaction()
    }

    function __QuazeGetDemo(hplayer) {
        PadOffWait(0)

        unregister_player_responder(this.hself_, 4)
        set_camera_target(this.hself_, -20.0)

        wait(15)

        change_state_switch_actor(this.hself_, true, true)

        wait(62)
        fadeout_sync(0, 0, 0.25)

        reset_camera_target()

        local target_pos = get_actor_position(this.hself_)
        local target_rot = get_actor_angle_y(this.hself_)

        local dir_x = null
        local dir_z = null

        if(target_rot <= -135.0) {
            dir_x = 0.0
            dir_z = -1.0
        } else if(target_rot <= -45.0) {
            dir_x = -1.0
            dir_z = 0.0
        } else if(target_rot <= 45.0) {
            dir_x = 0.0
            dir_z = 1.0
        } else if(target_rot <= 135.0) {
            dir_x = 1.0
            dir_z = 0.0
        } else {
            dir_x = 0.0
            dir_z = -1.0
        }

        local POS_MAIN_1 = [0.0, 0.0, 10.0, 180.0]
        local POS_SUB1_1 = [6.5, -0.25, 9.6, 207.0]
        local POS_SUB2_1 = [-6.5, -0.25, 9.6, 153.0]
        local POS_MAIN_2 = [0.0, 0.0, 14.0, 0.0]
        local POS_SUB1_2 = [13.0, 0.0, 12.0, 210.0]
        local POS_SUB2_2 = [-12.0, 0.0, 12.0, 150.0]
        local POS_QUARTZ_1 = [0.0, 12.0, 15.0, 0.0]
        local POS_QUARTZ_2 = [0.0, 24.0, 17.0, 0.0]
        local POS_CAM_1 = [0.0, 0.1255, -4.4221, 0.0, 8.7531, 1.7402, 50.0]
        local POS_CAM_2 = [0.0, 8.0, 48.0, 0.0, 11.0, 17.0, 50.0]
        local POS_CAM_3 = [0.0, 22.0, 44.0, 0.0, 25.0, 17.0, 50.0]
        local POS_CAM_4 = [9.0, 25.5, -19.8, 8.8, 25.1, -18.8, 50.0]
        local POS_MAIN = [0.0, 0.0, 0.0, 0.0]
        local POS_SUB1 = [0.0, 0.0, 0.0, 0.0]
        local POS_SUB2 = [0.0, 0.0, 0.0, 0.0]
        local MOTION_HAKO_NOZOKU_WAIT = [394, 394, 394, 394]
        local MOTION_HAKO_NOZOKU = [376, 376, 376, 376]
        local MOTION_LOOK_UP = [1500, 1500, 1500, 1500]

        local curt_zone_id = get_zone_id()

        local quartz_bgobj_sqid = -1
        local quartz_item_sqid = -1
        local quartz_eff_id = -1

        if(curt_zone_id == 20) {
            quartz_bgobj_sqid = 4536
            quartz_item_sqid = 7331
            quartz_eff_id = 1170
        } else if(curt_zone_id == 21) {
            quartz_bgobj_sqid = 4537
            quartz_item_sqid = 7332
            quartz_eff_id = 1174
        } else if(curt_zone_id == 22) {
            quartz_bgobj_sqid = 4538
            quartz_item_sqid = 7333
            quartz_eff_id = 1181
        }

        local POS_QUARTZ = [0.0, 0.0, 0.0, 0.0]
        local POS_CAM = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        POS_MAIN = [
            (target_pos[0] + (dir_x * POS_MAIN_1[2])) + (dir_z * POS_MAIN_1[0]),
            target_pos[1] + POS_MAIN_1[1],
            (target_pos[2] + (dir_z * POS_MAIN_1[2])) + (-dir_x * POS_MAIN_1[0]),
            Clamp0To2PI(target_rot + POS_MAIN_1[3])
        ]
        POS_SUB1 = [
            (target_pos[0] + (dir_x * POS_SUB1_1[2])) + (dir_z * POS_SUB1_1[0]),
            target_pos[1] + POS_SUB1_1[1],
            (target_pos[2] + (dir_z * POS_SUB1_1[2])) + (-dir_x * POS_SUB1_1[0]),
            Clamp0To2PI(target_rot + POS_SUB1_1[3])
        ]
        POS_SUB2 = [
            (target_pos[0] + (dir_x * POS_SUB2_1[2])) + (dir_z * POS_SUB2_1[0]),
            target_pos[1] + POS_SUB2_1[1],
            (target_pos[2] + (dir_z * POS_SUB2_1[2])) + (-dir_x * POS_SUB2_1[0]),
            Clamp0To2PI(target_rot + POS_SUB2_1[3])
        ]
        local POS_QUARTZ = [
            (target_pos[0] + (dir_x * POS_QUARTZ_1[2])) + (-dir_z * POS_QUARTZ_1[0]),
            target_pos[1] + POS_QUARTZ_1[1],
            (target_pos[2] + (dir_z * POS_QUARTZ_1[2])) + (dir_x * POS_QUARTZ_1[0]),
            Clamp0To2PI(target_rot + POS_QUARTZ_1[3])
        ]
        POS_CAM = [
            (target_pos[0] + (dir_x * POS_CAM_1[2])) + (dir_z * POS_CAM_1[0]),
            target_pos[1] + POS_CAM_1[1],
            (target_pos[2] + (dir_z * POS_CAM_1[2])) + (-dir_x * POS_CAM_1[0]),
            (target_pos[0] + (dir_x * POS_CAM_1[5])) + (dir_z * POS_CAM_1[3]),
            target_pos[1] + POS_CAM_1[4],
            (target_pos[2] + (dir_z * POS_CAM_1[5])) + (-dir_x * POS_CAM_1[3]),
            POS_CAM_1[6]
        ]

        local aHact = [
            get_party_index(0),
            get_party_index(1),
            get_party_index(2)
        ]
        local alive = [
            false,
            false,
            false
        ]
        local tribe = [
            0,
            -1,
            -1
        ]

        for(local i = 0; i < aHact.len(); ++i) {
            if(aHact[i] == 0) {
                // empty
            } else {
                alive[i] = is_player_alive(aHact[i])
                if(alive[i] == false) {
                    set_actor_visible(aHact[i], false)
                } else {
                    idle_actor(aHact[i], 0, false)

                    wait_for_false1(is_actor_equipping_weapon, aHact[i])

                    tribe[i] = get_charadb(aHact[i], 54)
                }
            }
        }

        if(aHact[0] != 0 && alive[0] == true) {
            set_actor_position_angle_y(
                aHact[0],
                POS_MAIN[0],
                POS_MAIN[1],
                POS_MAIN[2],
                POS_MAIN[3]
            )

            wait(1)

            start_actor_motion(aHact[0], MOTION_HAKO_NOZOKU_WAIT[tribe[0]])
        }

        if(aHact[1] != 0 && alive[1] == true) {
            set_actor_position_angle_y(
                aHact[1],
                POS_SUB1[0],
                POS_SUB1[1],
                POS_SUB1[2],
                POS_SUB1[3]
            )
            set_player_along_slope(aHact[1], false)

            wait(1)

            set_actor_shape_angleZ(aHact[1], 18.0)
            set_actor_shape_angleX(aHact[1], 0.0)

            wait(1)

            start_actor_motion(aHact[1], MOTION_HAKO_NOZOKU_WAIT[tribe[1]])
        }

        if(aHact[2] != 0 && alive[2] == true) {
            set_actor_position_angle_y(
                aHact[2],
                POS_SUB2[0],
                POS_SUB2[1],
                POS_SUB2[2],
                POS_SUB2[3]
            )
            set_player_along_slope(aHact[2], false)

            wait(1)

            set_actor_shape_angleZ(aHact[2], -18.0)
            set_actor_shape_angleX(aHact[2], 0.0)

            wait(1)

            start_actor_motion(aHact[2], MOTION_HAKO_NOZOKU_WAIT[tribe[2]])
        }

        wait(1)

        init_petit()
        set_petit_dst_param(
            POS_CAM[0], POS_CAM[1], POS_CAM[2],
            POS_CAM[3], POS_CAM[4], POS_CAM[5],
            0.0, POS_CAM[6]
        )
        begin_petit(0)

        wait(neg8)
        wait(10)

        fadein(0, 0, 1.0)

        for(local i = 0; i < aHact.len(); ++i) {
            if(alive[i] == true) {
                start_actor_motion(aHact[i], MOTION_HAKO_NOZOKU[tribe[i]])
                wait(8)
            }
        }

        local eff = create_eff(1168, 1, this.hself_)

        wait(30 * 2)
        fadeout_sync(1, 1, 1.0)

        destroy_eff(eff)

        wait(10)

        POS_MAIN = [
            (target_pos[0] + (dir_x * POS_MAIN_2[2])) + (dir_z * POS_MAIN_2[0]),
            target_pos[1] + POS_MAIN_2[1],
            (target_pos[2] + (dir_z * POS_MAIN_2[2])) + (-dir_x * POS_MAIN_2[0]),
            Clamp0To2PI(target_rot + POS_MAIN_2[3])
        ]
        POS_SUB1 = [
            (target_pos[0] + (dir_x * POS_SUB1_2[2])) + (dir_z * POS_SUB1_2[0]),
            target_pos[1] + POS_SUB1_2[1],
            (target_pos[2] + (dir_z * POS_SUB1_2[2])) + (-dir_x * POS_SUB1_2[0]),
            Clamp0To2PI(target_rot + POS_SUB1_2[3])
        ]
        POS_SUB2 = [
            (target_pos[0] + (dir_x * POS_SUB2_2[2])) + (dir_z * POS_SUB2_2[0]),
            target_pos[1] + POS_SUB2_2[1],
            (target_pos[2] + (dir_z * POS_SUB2_2[2])) + (-dir_x * POS_SUB2_2[0]),
            Clamp0To2PI(target_rot + POS_SUB2_2[3])
        ]
        POS_CAM = [
            (target_pos[0] + (dir_x * POS_CAM_2[2])) + (dir_z * POS_CAM_2[0]),
            target_pos[1] + POS_CAM_2[1],
            (target_pos[2] + (dir_z * POS_CAM_2[2])) + (-dir_x * POS_CAM_2[0]),
            (target_pos[0] + (dir_x * POS_CAM_2[5])) + (dir_z * POS_CAM_2[3]),
            target_pos[1] + POS_CAM_2[4],
            (target_pos[2] + (dir_z * POS_CAM_2[5])) + (-dir_x * POS_CAM_2[3]),
            POS_CAM_2[6]
        ]

        local hact_quartz = create_temp_actor_in_bgobj_group(
            this.group_id_, quartz_bgobj_sqid,
            POS_QUARTZ[0], POS_QUARTZ[1], POS_QUARTZ[2], POS_QUARTZ[3]
        )

        if(aHact[0] != 0 && alive[0] == true) {
            set_actor_position_angle_y(
                aHact[0],
                POS_MAIN[0],
                POS_MAIN[1],
                POS_MAIN[2],
                POS_MAIN[3]
            )

            begin_actor_look_target(aHact[0], hact_quartz)
        }

        if(aHact[1] != 0 && alive[1] == true) {
            set_actor_position_angle_y(
                aHact[1],
                POS_SUB1[0],
                POS_SUB1[1],
                POS_SUB1[2],
                POS_SUB1[3]
            )
            reset_player_along_slope(aHact[1])
            set_actor_shape_angleZ(aHact[1], 0.0)
            begin_actor_look_target(aHact[1], hact_quartz)
        }

        if(aHact[2] != 0 && alive[2] == true) {
            set_actor_position_angle_y(
                aHact[2],
                POS_SUB2[0],
                POS_SUB2[1],
                POS_SUB2[2],
                POS_SUB2[3]
            )
            reset_player_along_slope(aHact[2])
            set_actor_shape_angleZ(aHact[2], 0.0)
            begin_actor_look_target(aHact[2], hact_quartz)
        }

        wait(1)

        start_actor_motion(hact_quartz, 255)

        local quartz_eff = create_eff(quartz_eff_id, 1, hact_quartz)

        for(local i = 0; i < aHact.len(); ++i) {
            if(alive[i] == true) {
                if(i > 0) {
                    wait(5)
                }
                start_actor_motion(aHact[i], MOTION_LOOK_UP[tribe[i]])
            }
        }

        wait(10)

        set_petit_slide_dst_to_src()
        set_petit_dst_param(
            POS_CAM[0], POS_CAM[1], POS_CAM[2],
            POS_CAM[3], POS_CAM[4], POS_CAM[5],
            0.0, POS_CAM[6]
        )
        begin_petit(0)

        wait(neg8)
        
        POS_CAM = [
            (target_pos[0] + (dir_x * POS_CAM_3[2])) + (dir_z * POS_CAM_3[0]),
            target_pos[1] + POS_CAM_3[1],
            (target_pos[2] + (dir_z * POS_CAM_3[2])) + (-dir_x * POS_CAM_3[0]),
            (target_pos[0] + (dir_x * POS_CAM_3[5])) + (dir_z * POS_CAM_3[3]),
            target_pos[1] + POS_CAM_3[4],
            (target_pos[2] + (dir_z * POS_CAM_3[5])) + (-dir_x * POS_CAM_3[3]),
            POS_CAM_3[6]
        ]

        fadein_sync(1, 1, 0.5)

        wait(30)

        POS_QUARTZ = [
            (target_pos[0] + (dir_x * POS_QUARTZ_2[2])) + (dir_z * POS_QUARTZ_2[0]),
            target_pos[1] + POS_QUARTZ_2[1],
            (target_pos[2] + (dir_z * POS_QUARTZ_2[2])) + (-dir_x * POS_QUARTZ_2[0]),
            Clamp0To2PI(target_rot + POS_QUARTZ_2[3])
        ]

        request_moving_bgobj_spline_move(hact_quartz, POS_QUARTZ[0], POS_QUARTZ[1], POS_QUARTZ[2], 60)
        set_petit_slide_dst_to_src()
        set_petit_dst_param(
            POS_CAM[0], POS_CAM[1], POS_CAM[2],
            POS_CAM[3], POS_CAM[4], POS_CAM[5],
            0.0, POS_CAM[6]
        )
        begin_petit(60)

        wait(neg8)

        start_jingle_bgm(0x100003D)

        wait(30)

        msg_argv_sync(4039, 0, 0, [quartz_item_sqid])

        wait(15)

        play_se(0x10000A6)

        fadeout_sync(1, 1, 1.0)

        for(local i = 0; i < 3; ++i) {
            if(aHact[i] != 0 && alive[i] == true) {
                end_actor_look_target(aHact[i])
            }
        }

        destroy_eff(quartz_eff)
        start_actor_motion(hact_quartz, 256)

        wait_for_true1(is_motion_finished, hact_quartz)

        request_destroy_bgobj_actor(hact_quartz)

        set_flag(502)
        this.SetSelfFlag()

        for(local i = 0; i < aHact.len(); ++i) {
            idle_actor(aHact[i])
            if(aHact[i] != 0 && alive[i] == false) {
                set_actor_visible(aHact[i], true)
            }
        }

        end_petit()

        PadOnWait(0)
    }
}
