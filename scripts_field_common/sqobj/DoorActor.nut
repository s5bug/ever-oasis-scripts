// TODO match line infos

class DoorActor extends BgobjActorBase {
    door_action_ = null
    door_open_action_ = null
    skill_action_ = null
    eff_id_ = 0
    door_id_ = -1
    key_bgobj_id_ = 0
    hiero_room_type = 0
    __camera_archive_ = null
    __camera_name_ = null
    __p0_pos_angle_ = null
    __p1_pos_angle_ = null
    __p2_pos_angle_ = null

    function CreateAndInit() {
        local pos = this.GetPos()
        local angle = this.GetAngle()
        local door_lock_type = this.GetDoorLockType()
        local door_state = 1
        local flag = this.GetFlag()

        this.door_action_ = this.CallDoorProcessBranch
        this.door_open_action_ = this.__DoorOpenAction_normal

        if(this.bgobj_id_ == 4211) {
            this.AfterCreateAction_ = this.__AfterCreateAction
        }

        if(door_lock_type == 2) {
            this.key_bgobj_id_ = 4089
            this.door_open_action_ = this.__DoorOpenAction_key
        }
        if(door_lock_type == 4) {
            this.key_bgobj_id_ = 4090
            this.door_open_action_ = this.__DoorOpenAction_key
        }
        if(door_lock_type == 3) {
            this.key_bgobj_id_ = 4088
            this.door_open_action_ = this.__DoorOpenAction_key
        }
        if(door_lock_type == 5) {
            this.key_bgobj_id_ = 4107
            this.door_open_action_ = this.__DoorOpenAction_boss
        }

        if(flag != 0 && !test_flag(flag)) {
            door_state = 2
        } else if(door_lock_type == 5) {
            if(this.bgobj_id_ == 4643) {
                this.door_open_action_ = this.__DoorOpenAction_AnkhBoss_second_time
            } else {
                this.door_open_action_ = this.__DoorOpenAction_boss_second_time
            }
        } else {
            this.door_open_action_ = this.__DoorOpenAction_normal
        }

        if(this.bgobj_id_ == 4579) {
            this.door_open_action_ = this.__DoorOpenAction_lastboss
        }
        if(this.bgobj_id_ == 4488) {
            this.door_open_action_ = this.__DoorOpenAction_HieroBoss
        }

        local aDoorOfs = this.__GetDoorOffsetXY(pos[0], pos[2])

        this.door_id_ = this.__GetDoorDirection(aDoorOfs, pos[0], pos[2], angle)

        local door_room_id = this.GetRoomId()

        this.SetDoorState(door_state)
        this.CreateActor()

        if(this.hself_ <= 0) return;

        if(this.act_type_ == 500 || this.act_type_ == 508 || this.act_type_ == 519) {
            if(this.bgobj_id_ != 4207 &&
                this.bgobj_id_ != 4209 &&
                this.bgobj_id_ != 4211 &&
                this.bgobj_id_ != 4578) {
                local gimmick_lock_flag = this.GetFlag(1)

                if(gimmick_lock_flag > 0 && test_flag(gimmick_lock_flag) == false) {
                    this.Deactivate()
                }
            }
        }

        if(this.bgobj_id_ == 4578) {
            start_actor_motion(this.hself_, 619)
        }

        SetCurrentDoorHact(this.door_id_, this.hself_)

        if(this.act_type_ == 502) {
            this.__SetBossDoorId(this.door_id_)
        }

        local phantom = this.GetPhantom()

        SetCurrentDoorFlag(this.door_id_, flag)
        SetCurrentDoorType(this.door_id_, this.act_type_)
        SetCurrentDoorData(this.door_id_, phantom)
        SetCurrentDoorRoomId(this.door_id_, door_room_id)
    }

    function __AfterCreateAction() {
        if(this.hself_ == 0) return;

        after_initialize_hiero_door(this.hself_, CalcNextRoomId(this.door_id_))
    }

    function Activate() {
        set_enable_bgobj_responder(this.hself_, true)
    }

    function Deactivate() {
        set_enable_bgobj_responder(this.hself_, false)
    }

    function InitializeBossDoorAfterCreate(archive_location, archive_name, camera_name, p0_pos_angle, p1_pos_angle, p2_pos_angle) {
        this.__camera_archive_ = find_archive(archive_location, archive_name)
        assert(this.__camera_archive_)
        this.__camera_name_ = camera_name

        local pos = get_actor_position(this.hself_)
        local target_rot = Clamp0To2PI(get_actor_angle_y(this.hself_))
        local dir_x = 0.0
        local dir_z = 0.0

        if(target_rot <= 0.0) {
            dir_x = 0.0
            dir_z = 1.0
        } else if(target_rot <= 90.0) {
            dir_x = -1.0
            dir_z = 0.0
        } else if(target_rot <= 180.0) {
            dir_x = 0.0
            dir_z = -1.0
        } else if(target_rot <= 270.0) {
            dir_x = 1.0
            dir_z = 0.0
        } else {
            dir_x = 0.0
            dir_z = 1.0
        }

        this.__p0_pos_angle_ = this.__CalcPlayerPos(pos, target_rot, dir_x, dir_z, p0_pos_angle)
        this.__p1_pos_angle_ = this.__CalcPlayerPos(pos, target_rot, dir_x, dir_z, p1_pos_angle)
        this.__p2_pos_angle_ = this.__CalcPlayerPos(pos, target_rot, dir_x, dir_z, p2_pos_angle)
    }

    function __CalcPlayerPos(pos, target_rot, dir_x, dir_z, p_pos_angle) {
        local pos = [
            (pos[0] + (dir_z * p_pos_angle[0])) + (-dir_x * p_pos_angle[2]),
            pos[1] + p_pos_angle[1],
            (pos[2] + (dir_z * p_pos_angle[2])) + (dir_x * p_pos_angle[0]),
            Clamp0To2PI(target_rot + p_pos_angle[3])
        ]

        print(pos)

        return pos;
    }

    function OnPlayerDoor(hplayer, htarget) {
        if(this.door_action_) {
            this.door_action_(hplayer, 0)
        }
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        if(this.skill_action_) {
            this.skill_action_(hplayer, result)
        }
    }

    function CallDoorProcessBranch(hplayer, responder_hact) {
        reserve_scene_change()

        PadOffWait(0)

        local prev_area_id = GetAreaId()
        local target_scene = GetTargetScene()
        local next_room_id = CalcNextRoomId(this.door_id_)
        local next_area_id = MoveToNextAreaId(this.door_id_)

        UpDateAreaOffset(next_area_id)

        if(next_area_id <= 0) {
            assert(0)
            return false;
        }

        local this_door_pos = get_actor_position(this.hself_)
        local this_door_angle = get_actor_angle_y(this.hself_) + 180.0

        if(this.bgobj_id_ == 4211) {
            open_hiero_door_process(this.layout_id_, prev_area_id, next_area_id)
        }

        set_flag(886)

        local prev_boss_area_type = get_boss_area_type(prev_area_id)
        local isBossArea = false
        local zone_id = get_zone_id()

        if(zone_id == 24) {
            isBossArea = ChangeEnemyResource_FD05(next_area_id)
        } else {
            isBossArea = ChangeEnemyResource(next_area_id, prev_boss_area_type)
        }

        PopAreaDoorCommon(target_scene, next_area_id)

        wait(1)

        local next_door_hact = this.__GetNextDoorHActor(this.hself_)

        if(next_door_hact == -1) {
            print("ERROR:次部屋のドアが見つかりません")
        }

        local next_direction = GetDoorIndex(next_door_hact)
        local next_door_flag = GetCurrentDoorFlag(next_direction)
        local shutter_door_direction = -1

        if(next_door_flag > 0 && !test_flag(next_door_flag)) {
            shutter_door_direction = next_direction
            lock_door(next_door_hact, 0, false, false)
        }

        local isLockout = 4209 == get_bgobj_id_by_handle(next_door_hact)
        local oldRoomPhantomId = GetOldDoorData(this.door_id_)

        set_enable_room(-1)

        if(__GetEnterRandomDungeon() && oldRoomPhantomId >= 0) {
            load_next_room(oldRoomPhantomId)
        }

        if(this.door_open_action_) {
            this.door_open_action_(next_door_hact, responder_hact)
        }

        init_petit()

        local hplayer = get_party_order(0)
        local door_pos = get_actor_position(next_door_hact)

        if(this.bgobj_id_ == 4488) {
            local add_pos = vector_rotate_y([0.0, 0.0, 85.0], this_door_angle)
            door_pos = [
                this_door_pos[0] + add_pos[0],
                this_door_pos[1] + add_pos[1],
                this_door_pos[2] + add_pos[2]
            ]
        }

        move_actor(hplayer, 1, door_pos, 30 * 2)

        func_wait(is_archive_loaded)

        if(isBossArea) {
            CallPopEnemy()
        }

        recovery_confusion_bind()

        local pl0_appear_param = [0.0, 0.0, 0.0, 0.0]
        local pl1_appear_param = [0.0, 0.0, 0.0, 0.0]
        local pl2_appear_param = [0.0, 0.0, 0.0, 0.0]
        local isGetDoorApperPos = SC_GetDoorApperPosition(pl0_appear_param, pl1_appear_param, pl2_appear_param, next_door_hact)

        local pl0_target_pos = [0.0, 0.0, 0.0]
        local pl1_target_pos = [0.0, 0.0, 0.0]
        local pl2_target_pos = [0.0, 0.0, 0.0]
        local isGetDoorMoveEndPos = SC_GetDoorMovementEndPosition(pl0_target_pos, pl1_target_pos, pl2_target_pos, next_door_hact)

        wait(10)
        func_wait(is_room_loaded)

        idle_actor(hplayer)
        fadeout_actor_alpha(hplayer, 1)

        if(!is_hieroglyph_dungeon()) {
            if(__GetEnterRandomDungeon() && oldRoomPhantomId >= 0) {
                set_nextroom_sceneenv(oldRoomPhantomId)
            }
        }

        if(prev_boss_area_type == 1) {
            change_hiero_goal_env()
        } else {
            change_hiero_env(next_area_id, get_boss_area_type(next_area_id))
        }

        set_attack_contact_in_demo(true)
        revive(0, false)
        target_scene.ChengeRoomEventDuringFade(prev_area_id, next_direction)
        target_scene.PopObjectWhenDoorOpened(next_area_id)
        InitializeBgobjAfterCreate(next_area_id)
        SetRouteIdToPartyAI_InArea(next_area_id)
        reset_flag(886)
        clear_scene_change()

        if(isGetDoorApperPos) {
            set_actor_position_angle_y(hplayer, pl0_appear_param[0], pl0_appear_param[1], pl0_appear_param[2], pl0_appear_param[3])
        } else {
            print("ERROR: プレイヤーの出現開始位置が求まりません")
        }

        local camera_param = [
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0,
            0.0, 0.0
        ]

        if(shutter_door_direction >= 0 && !isLockout) {
            local door_lr_mode = 3

            if(test_flag(357)) {
                reset_flag(357)
                door_lr_mode = 2
            }

            if(SC_CalcCameraApperPositionLR(camera_param, next_door_hact, door_lr_mode) == false) {
                print("ERROR: カメラの出現位置が求まりません")
            }
        } else if(SetCalcCameraApperPosition(camera_param, next_door_hact, hplayer) == false) {
            print("ERROR: カメラの出現位置が求まりません")
        }

        shift_current_room_id(next_room_id)
        set_petit_src_param(camera_param)
        set_petit_dst_param(camera_param)
        begin_petit(0)

        const neg8 = -8
        wait(neg8)
        wait(1)

        target_scene.InitializeMap(false)
        PlayNextRoomBgm(next_area_id, prev_area_id)

        local hparty1 = get_party_order(1)
        local hparty2 = get_party_order(2)

        if(isGetDoorMoveEndPos) {
            fadein_actor_alpha(hplayer, 8)
            move_actor(hplayer, 1, pl0_target_pos, 30 * 2)
            update_player_home_pos_angle_y(pl0_target_pos[0], pl0_target_pos[1], pl0_target_pos[2], pl0_appear_param[3])

            wait(8)

            if(!isPlayerAlone()) {
                if(hparty1 > 0) {
                    set_actor_position_angle_y(hparty1, pl1_appear_param[0], pl1_appear_param[1], pl1_appear_param[2], pl1_appear_param[3])
                    fadeout_actor_alpha(hparty1, 1)
                    move_actor(hparty1, 1, pl1_target_pos, 30 * 2)
                    fadein_actor_alpha(hparty1, 8)
                }
                if(hparty2 > 0) {
                    set_actor_position_angle_y(hparty2, pl2_appear_param[0], pl2_appear_param[1], pl2_appear_param[2], pl2_appear_param[3])
                    fadeout_actor_alpha(hparty2, 1)
                    move_actor(hparty2, 1, pl2_target_pos, 30 * 2)
                    fadein_actor_alpha(hparty2, 8)
                }
            }
        } else {
            print("ERROR: プレイヤーの移動終了位置が求まりません")
        }

        if(hparty2 > 0) {
            wait_for_false1(is_actor_moving, hparty2)
        } else if(hparty1 > 0) {
            wait_for_false1(is_actor_moving, hparty1)
        } else {
            wait_for_false1(is_actor_moving, hplayer)
        }

        if(this.door_open_action_ == this.__DoorOpenAction_boss ||
            this.door_open_action_ == this.__DoorOpenAction_boss_second_time ||
            this.door_open_action_ == this.__DoorOpenAction_AnkhBoss_second_time) {
            set_actor_collision(next_door_hact, true)
        } else {
            motion_wait(next_door_hact)
            change_door(next_door_hact, 0, true, true)
        }

        if(shutter_door_direction < 0 || isLockout) {
            wait_for_false1(get_state_switch_actor, next_door_hact)
            wait(1)

            set_petit_slide_dst_to_src()
            camera_param = get_reset_param_of_behind_camera()

            set_petit_dst_param(camera_param)
            begin_petit(30)

            wait(neg8)

            end_petit()

            if(isLockout) {
                wait(1)

                motion_wait(next_door_hact)
                lock_door(next_door_hact, 1, false, true)
            }
        } else {
            local next_door_id = get_bgobj_id_by_handle(next_door_hact)

            if(next_door_id != 4209 && next_door_id != 4489) {
                ShutDoorForRoomChangeEvent(shutter_door_direction)
            } else {
                ShutDoorForRoomChangeEventHieroCloseDoor(shutter_door_direction)
            }
        }

        wait_for_false1(is_actor_moving, hplayer)

        idle_actor(hplayer)

        wait(1)

        if(shutter_door_direction >= 0 && !isLockout) {
            set_petit_slide_dst_to_src()
            
            local reset_param = get_reset_param_of_behind_camera()

            set_petit_dst_param(reset_param)
            begin_petit(30)

            wait(neg8)

            end_petit()
        }

        if(!isPlayerAlone()) {
            SetLastRoomToEnterWithParty()
        } else {
            ManageTheStateOfTheParty()
        }

        target_scene.ChengeRoomEvent(next_area_id, GetDoorIndex(next_door_hact))
        set_enable_room(next_room_id)
        set_attack_contact_in_demo(false)

        PadOnWait(0)
    }

    function __GetDoorDirection(aDoorOfs, posX, posZ, angle) {
        local door_id = null

        if(angle < 0) {
            angle = 360 + angle
        }

        if(angle == 0) {
            if(aDoorOfs[1] == 0) {
                door_id = 0
            } else {
                door_id = 4
            }
        } else if(angle <= 90.0) {
            if(aDoorOfs[0] == 0) {
                door_id = 3
            } else {
                door_id = 7
            }
        } else if(angle <= 180.0) {
            if(aDoorOfs[1] == 0 && aDoorOfs[0] == 0) {
                door_id = 2
            } else if(aDoorOfs[1] == 0 && aDoorOfs[0] == 1) {
                door_id = 6
            } else if(aDoorOfs[1] == 1 && aDoorOfs[0] == 0) {
                door_id = 9
            } else {
                door_id = 11
            }
        } else {
            if(aDoorOfs[1] == 0 && aDoorOfs[0] == 0) {
                door_id = 1
            } else if(aDoorOfs[1] == 1 && aDoorOfs[0] == 0) {
                door_id = 5
            } else if(aDoorOfs[1] == 0 && aDoorOfs[0] == 1) {
                door_id = 8
            } else {
                door_id = 10
            }
        }

        return door_id;
    }

    function __GetDoorOffsetXY(posX, posZ) {
        local area_id = GetAreaId()
        local local_room_id = GetRoomNumberForProgram(area_id)
        local aDoorOfs = [0, 0]
        local x = (local_room_id % 8) * 300
        local z = (local_room_id / 8) * 300

        if((posX - x) > 300.0) {
            aDoorOfs[1] = 1
        }

        if((posZ - z) > 300.0) {
            aDoorOfs[0] = 1
        }

        return aDoorOfs;
    }

    function __DoorOpenAction_normal(next_door_hact, responder_hact) {
        wait(1)

        change_door(next_door_hact, 1, true, true)
        change_door(this.hself_, 1, true, true)

        wait(20)
    }

    function __DoorOpenAction_boss_second_time(next_door_hact, responder_hact) {
        change_door(this.hself_, 1, true, true)

        wait(2)
        motion_wait_with_id(this.hself_, 108)

        set_actor_collision(next_door_hact, false)
    }

    function __DoorOpenAction_AnkhBoss_second_time(next_door_hact, responder_hact) {
        change_door(this.hself_, 1, true, true)

        wait(2)
        motion_wait_with_id(this.hself_, 771)

        set_actor_collision(next_door_hact, false)
    }

    function __CreateKeyObj() {
        local key_hact = 0

        if(this.key_bgobj_id_ != 0) {
            local pos = get_actor_position(this.hself_)
            local angle = get_actor_angle_y(this.hself_)

            key_hact = create_temp_actor_in_bgobj_group(this.group_id_, this.key_bgobj_id_, pos[0], pos[1], pos[2], angle)
        } else {
            print("ERROR:DoorActor key bgobj_id is invalid")
        }

        return key_hact;
    }

    function __DoorOpenAction_boss(next_door_hact, responder_hact) {
        unregister_player_responder(responder_hact, 4)
        this.__BeginBossDoorCameraEvent()

        local key_hact = this.__CreateKeyObj()

        start_actor_motion(key_hact, 180)
        lock_door(this.hself_, 0, false, true)
        this.SetSelfFlag()
        play_se(0x1000236)

        motion_wait(key_hact)

        if(this.__EndBossDoorCameraEvent() == false) {
            motion_wait_with_id(this.hself_, 172)
        }

        set_actor_collision(next_door_hact, false)
    }

    function __DoorOpenAction_lastboss(next_door_hact, responder_hact) {
        this.__BeginBossDoorCameraEvent()
        change_door(this.hself_, 1, true, true)
        this.__EndBossDoorCameraEvent()
        change_door(next_door_hact, 1, true, true)
    }

    function __DoorOpenAction_HieroBoss(next_door_hact, responder_hact) {
        change_door(this.hself_, 1, true, true)

        wait(116 + 10 + 15)

        change_door(next_door_hact, 1, true, true)
    }

    function __BeginBossDoorCameraEvent() {
        if(!this.__camera_archive_) return;

        fadeout_sync(0, 0, 0.25)
        
        const neg7 = -7
        wait(neg7)

        local hparty0 = get_party_order(0)
        local hparty1 = get_party_order(1)
        local hparty2 = get_party_order(2)

        set_actor_position_angle_y(hparty0, this.__p0_pos_angle_[0], this.__p0_pos_angle_[1], this.__p0_pos_angle_[2], this.__p0_pos_angle_[3])
        idle_actor(hparty0, 0)

        if(hparty1 != 0) {
            set_actor_position_angle_y(hparty1, this.__p1_pos_angle_[0], this.__p1_pos_angle_[1], this.__p1_pos_angle_[2], this.__p1_pos_angle_[3])
            idle_actor(hparty1, 0)
        }

        if(hparty2 != 0) {
            set_actor_position_angle_y(hparty2, this.__p2_pos_angle_[0], this.__p2_pos_angle_[1], this.__p2_pos_angle_[2], this.__p2_pos_angle_[3])
            idle_actor(hparty2, 0)
        }

        local door_pos = get_actor_position(this.hself_)
        local door_angle = get_actor_angle_y(this.hself_)

        wait(15)

        begin_demo_camera(this.__camera_archive_, this.__camera_name_, [door_pos[0], door_pos[1], door_pos[2], door_angle])
        fadein_sync(3, 0, 0.25)
    }

    function __EndBossDoorCameraEvent() {
        if(!this.__camera_archive_) return false;

        func_wait(is_demo_camera_finished)

        end_demo_camera()

        return true;
    }

    function __DoorOpenAction_key(next_door_hact, responder_hact) {
        unregister_player_responder(responder_hact, 4)
        set_camera_target(responder_hact, 12.0)

        local key_hact = this.__CreateKeyObj()

        start_actor_motion(key_hact, 650)
        lock_door(this.hself_, 0, false, true)
        this.SetSelfFlag()

        wait_for_true2(is_door_actor_state, this.hself_, 2)

        change_door(this.hself_, 1, true, true)

        wait(15)

        reset_camera_target()
        change_door(next_door_hact, 1, true, true)
    }

    function __GetNextDoorHActor(door_hactor) {
        local door_dir = this.__GetNextDoorDirection(door_hactor)

        if(door_dir == -1) {
            return -1;
        }

        local next_hact = GetCurrentDoorHact(door_dir)
        return next_hact;
    }

    function __GetRoomPhantomID(door_hactor) {
        local door_dir = GetOldDoorIndex(door_hactor)

        if(door_dir == -1) {
            return -1;
        }

        local phantom_id = GetOldDoorData(door_dir)
        return phantom_id;
    }

    function __GetNextDoorDirection(enter_door_hact) {
        local enterDoorIndex = GetOldDoorIndex(enter_door_hact)
        local enterDoorRoomId = GetOldDoorRoomId(enterDoorIndex)
        local room_id_ofs = [-8, 1, 8, -1]
        local exitDoorRoomId = enterDoorRoomId + room_id_ofs[DoorDirectionToDirectionIdx(enterDoorIndex)]
        local exitDoorIndex = GetDoorIndexFromRoomId(exitDoorRoomId, enterDoorIndex)

        return exitDoorIndex;
    }

    function ShutDoorForRoomChangeEvent(door_id) {
        local door_hact = GetCurrentDoorHact(door_id)
        local door_flag = GetCurrentDoorFlag(door_id)

        if(door_hact == 0) return false;

        wait(1)
        motion_wait(door_hact)

        lock_door(door_hact, 1, false, true)
        play_se(0x100023B)

        wait(15)

        return true;
    }

    function ShutDoorForRoomChangeEventHieroCloseDoor(door_id) {
        local door_hact = GetCurrentDoorHact(door_id)
        local door_flag = GetCurrentDoorFlag(door_id)

        if(door_hact == 0) return false;

        wait(1)
        motion_wait(door_hact)

        lock_door(door_hact, 1, false, true)

        wait(15)
        
        return true;
    }

    function SetCalcCameraApperPosition(outparam, door_hactor, hplayer) {
        if(door_hactor == 0) return false;

        local door_dir = GetDoorIndex(door_hactor)

        if(door_dir == -1) return false;

        local appear_pos = get_actor_position(door_hactor)
        local rot_y = get_actor_angle_y(door_hactor)
        local add_vec_1 = vector_rotate_y([0.0, 20.293, -28.243], rot_y)
        local add_vec_2 = vector_rotate_y([0.0, 11.471, -4.019], rot_y)

        outparam[0] = appear_pos[0] + add_vec_1[0]
        outparam[1] = appear_pos[1] + add_vec_1[1]
        outparam[2] = appear_pos[2] + add_vec_1[2]
        outparam[3] = appear_pos[0] + add_vec_2[0]
        outparam[4] = appear_pos[1] + add_vec_2[1]
        outparam[5] = appear_pos[2] + add_vec_2[2]
        outparam[6] = 0.0
        outparam[7] = 50.0

        return true;
    }

    function GetDoorIndexFromRoomId(room_id, enterDoorIndex) {
        for(local i = 0; i < 12; i++) {
            if(room_id == GetCurrentDoorRoomId(i) && this.isCheckDoorDirection(enterDoorIndex, i)) {
                return i;
            }
        }
        return -1;
    }

    function isCheckDoorDirection(enterDoorIndex, exitDoorIndex) {
        local enter = this.DoorDirectionToDirectionIdx(enterDoorIndex)
        local exit = this.DoorDirectionToDirectionIdx(exitDoorIndex)

        switch(enter) {
            case 0: return exit == 2;
            case 1: return exit == 3;
            case 2: return exit == 0;
            case 3: return exit == 1;
        }

        return false;
    }

    function DoorDirectionToDirectionIdx(door_direction) {
        local dir = [
            0, 1, 2, 3,
            0, 1, 2, 3,
            1, 2, 1, 2
        ]

        return dir[door_direction]
    }
}
