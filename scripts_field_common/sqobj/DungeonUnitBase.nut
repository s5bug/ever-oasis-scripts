// TODO match line infos

class DungeonUnitBase {
    scene_ = null

    constructor(scene) {
        print("DungeonUnitBase::constructor")

        this.scene_ = scene
    }

    function CreateBgobjActorByGroupID(area_id, group_id) {
        this.scene_.bgobj_creator_.CreateBgobjActorByGroupID(area_id, group_id)
    }

    function CreateDoorActorByAreaID(area_id) {
        this.scene_.bgobj_creator_.CreateDoorActorByAreaID(area_id)
    }

    function CreateBgobjActorByAreaID(area_id) {
        this.scene_.bgobj_creator_.CreateBgobjActorByAreaID(area_id)
    }

    function Initialize() {
        print("DungeonUnitBase::initialize")
    }

    function Finalize() {
        print("DungeonUnitBase::finalize")
    }

    function OnPhantomEnterEvent(lytid, hact) {
        print("DungeonUnitBase::onEnterPhantom [phm_lytid:" + lytid +
            " act:" + hact + "]")
    }

    function OnPhantomLeaveEvent(lytid, hact) {
        print("DungeonUnitBase::onLeavePhantom [phm_lytid:" + lytid +
            " act:" + hact + "]")
    }

    function OnSwitchChanged(switch_id) {
        print("DungeonUnitBase::OnSwitchChanged")
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        print("DungeonUnitBase::OnPlayerSkill")
        return true;
    }

    function GetLoadResources() {
        print("DungeonUnitBase::GetLoadResources")
        return null;
    }

    function InitializeFlags() {
        print("DungeonUnitBase::InitializeFlags")
    }

    function InitializeEnemyResources() {
        print("DungeonUnitBase::InitializeEnemyResources")
    }

    function PopAreaManager(area_id) {
        print("DungeonUnitBase::PopAreaManager")
        return -1;
    }

    function PopEventChecker(area_id, group_id) {
        print("DungeonUnitBase::PopEventChecker")
    }

    function PopObjectWhenDoorOpened(area_id) {
        print("DungeonUnitBase::PopObjectWhenDoorOpened")
    }

    function SetDungeonDoor(area_id) {
        print("DungeonUnitBase::SetDungeonDoor")
    }

    function PopAreaObject(area_id) {
        print("DungeonUnitBase::PopAreaObject")
    }

    function GimmickPositionData() {
        print("DungeonUnitBase::GimmickPositionData")
        return null;
    }

    function ChengeRoomEventDuringFade(area_id, door_direction) {
        print("DungeonUnitBase::ChengeRoomEventDuringFade")
    }

    function ChengeRoomEvent(area_id, door_direction) {
        print("DungeonUnitBase::ChengeRoomEvent")
    }

    function DestroyEventChecker(hact, member_num, group_id) {
        print("DungeonUnitBase::DestroyEventChecker")
    }

    function BGObjectDeadChecker(hact) {
        print("DungeonUnitBase::BGObjectDeadChecker")
    }

    function LifeZeroEventChecker(hact, member_num, group_id) {
        print("DungeonUnitBase::LifeZeroEventChecker")
    }

    function LifeZeroEventFirstChecker(hact, member_num, group_id) {
        print("DungeonUnitBase::LifeZeroEventFirstChecker [act:" + hact + "]")

        if(!test_flag(1972) && check_mission_completed(9)) {
            GazeCameraForHact(hact, false, 30, 0.0)
            ForceStartOptionalQuestEvent_SetEventMode(2, false)
            set_flag(1972)
        }
    }

    function OnBossDyingEvent(hact, state) {
        print("DungeonUnitBase::onBossDyingEvent: hact=[ " + hact +
          " ], state=[ " + state + " ]")
    }

    function InitializeNpcResources() {
        print("DungeonUnitBase::InitializeNpcResources")
    }

    function OnPostLoadEvent() {
        print("DungeonUnitBase::OnPostLoadEvent")
    }

    function OnPostLoadEventChecker() {
        print("DungeonUnitBase::OnPostLoadEventChecker")
    }

    function SetPathForObject(path_id) {
        print("DungeonUnitBase::SetPathForObject")
    }

    function IsRegisterBossSymbol() {
        return false;
    }

    function AfterPlayerActionEvent(switch_id, layout_id) {
        local area_id = GetAreaId()
    }

    function CallDoorProcessBySeedBall(door_direction, lr_mode) {
        const neg9 = -9

        local target_scene = GetTargetScene()
        local nextRoom = GetAreaId()
        local door_id = door_direction
        local door_hact = GetCurrentDoorHact(door_id)
        local door_flag = GetCurrentDoorFlag(door_id)

        PadOffWait(0)

        PlayerMakesParty()
        SetLastRoomToEnterWithParty()

        local pl0_appear_param = [0.0, 0.0, 0.0, 0.0]
        local pl1_appear_param = [0.0, 0.0, 0.0, 0.0]
        local pl2_appear_param = [0.0, 0.0, 0.0, 0.0]

        local hplayer = get_party_order(0)
        local hparty1 = get_party_order(1)
        local hparty2 = get_party_order(2)

        SC_GetDoorApperPosition(pl0_appear_param, pl1_appear_param, pl2_appear_param, door_hact)

        if(hparty1 != 0) {
            set_actor_position_angle_y(
                hparty1,
                pl1_appear_param[0], pl1_appear_param[1], pl1_appear_param[2],
                pl1_appear_param[3]
            )
            fadeout_actor_alpha(hparty1, 1)
        }

        if(hparty2 != 0) {
            set_actor_position_angle_y(
                hparty2,
                pl2_appear_param[0], pl2_appear_param[1], pl2_appear_param[2],
                pl2_appear_param[3]
            )
            fadeout_actor_alpha(hparty2, 1)
        }

        set_camera_target(door_hact)

        print("CallDoorProcessBySeedBall : パンカメラ開始")

        wait(neg9)

        print("CallDoorProcessBySeedBall : パンカメラ終了後待ち開始")

        wait(15)

        print("CallDoorProcessBySeedBall : 待ち終了")

        reset_camera_target()
        init_petit()
        
        local camera_param = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        if(SC_CalcCameraApperPositionLR(camera_param, door_hact, lr_mode) == true) {
            set_petit_src_param(camera_param)
            set_petit_dst_param(camera_param)
            begin_petit(1)
            ui_push_env(0)
            ui_map_hide(true)

            const neg8 = -8
            wait(neg8)
        }

        if(door_flag > 0 && !test_flag(door_flag)) {
            lock_door(door_hact, 0, false, true)
            set_flag(door_flag)
            play_se(0x100023B)
            wait(40)
        }

        change_door(door_hact, 1, true, true)

        wait(25)

        local pl0_target_pos = [0.0, 0.0, 0.0]
        local pl1_target_pos = [0.0, 0.0, 0.0]
        local pl2_target_pos = [0.0, 0.0, 0.0]

        if(SC_GetDoorMovementEndPosition(pl0_target_pos, pl1_target_pos, pl2_target_pos, door_hact) == true) {
            if(hparty1 != 0) {
                set_actor_position_angle_y(
                    hparty1,
                    pl1_appear_param[0], pl1_appear_param[1], pl1_appear_param[2],
                    pl1_appear_param[3]
                )
                fadeout_actor_alpha(hparty1, 1)
                move_actor(hparty1, 1, pl1_target_pos, 30 * 2)
                fadein_actor_alpha(hparty1, 8)
            }

            if(hparty2 != 0) {
                set_actor_position_angle_y(
                    hparty2,
                    pl2_appear_param[0], pl2_appear_param[1], pl2_appear_param[2],
                    pl2_appear_param[3]
                )
                fadeout_actor_alpha(hparty2, 1)
                move_actor(hparty2, 1, pl2_target_pos, 30 * 2)
                fadein_actor_alpha(hparty2, 8)
            }
        }

        wait(25)

        change_door(door_hact, 0, true, true)
        
        wait(30)

        end_petit()
        ui_pop_env()
        ui_map_hide(false)
        set_camera_target(door_hact, 0.0, true)

        wait(neg9)

        reset_camera_target()
        SetLastRoomToEnterWithParty()
        target_scene.ChengeRoomEvent(nextRoom, door_id)

        PadOnWait(0)
    }

    function __GetAntlionSuckedAnim(tribe_type) {
        if(tribe_type == 0) {
            return 1762;
        } else if(tribe_type == 1) {
            return 1762;
        } else if(tribe_type == 2) {
            return 1762;
        } else if(tribe_type == 3) {
            return 1762;
        }
    }

    function __GetAntlionOutAnim(tribe_type) {
        if(tribe_type == 0) {
            return 1765;
        } else if(tribe_type == 1) {
            return 1765;
        } else if(tribe_type == 2) {
            return 1765;
        } else if(tribe_type == 3) {
            return 1765;
        }
    }

    function ChangeRoomForAntlion(hact, aPos_player, aPos_Antlion, nextRoom, keyPhantomId, prev_area_id = -1) {
        const neg7 = -7
        const neg8 = -8
        
        reserve_scene_change()
        
        PadOffWait(0)

        local hact00 = get_party_order(0)
        local hact01 = get_party_order(1)
        local hact02 = get_party_order(2)

        local tribeType00 = get_charadb(hact00, 54)
        local tribeType01 = -1
        local tribeType02 = -1

        if(hact01 != 0) {
            tribeType01 = get_charadb(hact01, 54)
        }

        if(hact02 != 0) {
            tribeType02 = get_charadb(hact02, 54)
        }

        local dummy_act = create_temp_actor(4059, aPos_Antlion[0], aPos_Antlion[1], aPos_Antlion[2], aPos_Antlion[3], true)

        start_actor_motion(hact00, this.__GetAntlionSuckedAnim(tribeType00))

        if(hact01 != 0) {
            local distsq = get_acotr_dist_sq(hact00, hact01)

            if(distsq < 10.0 * 10.0) {
                start_actor_motion(hact01, this.__GetAntlionSuckedAnim(tribeType01))
            }
        }

        if(hact02 != 0) {
            local distsq = get_acotr_dist_sq(hact00, hact02)

            if(distsq < 10.0 * 10.0) {
                start_actor_motion(hact02, this.__GetAntlionSuckedAnim(tribeType02))
            }
        }

        wait(15)

        set_flag(886)
        fadeout_sync(0, 0, 1.0)
        
        ChangeRoomForDungeonMain(nextRoom, keyPhantomId, 1, null, 0, prev_area_id)

        revive(0, false)
        set_actor_visible(hact00, false)
        set_actor_shadow_visible(hact00, false)

        if(hact01 != 0) {
            set_actor_visible(hact01, false)
            set_actor_shadow_visible(hact01, false)
        }

        if(hact02 != 0) {
            set_actor_visible(hact02, false)
            set_actor_shadow_visible(hact02, false)
        }

        wait(1)

        set_actor_position(hact00, aPos_player[0], aPos_player[1], aPos_player[2], 0)
        set_actor_angleY(hact00, aPos_player[3])

        wait(1)

        reset_party_position()

        wait(10)

        print("aPos_player:" + aPos_player[0] +
            "," + aPos_player[1] +
            "," + aPos_player[2])
        
        reset_flag(886)
        clear_scene_change()

        local reset_param = get_reset_param_of_behind_camera()
        local aCam = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

        if(aPos_player[3] == 0.0) {
            print("ChangeRoomForAntlion  aPos_player[3] == 0.0")

            aCam = [
                aPos_player[0] + -35.803,
                aPos_player[1] + 25.538,
                aPos_player[2] + -95.784,
                aPos_player[0] + -35.261,
                aPos_player[1] + 25.16,
                aPos_player[2] + -95.034
            ]
        } else if(aPos_player[3] <= 45.0) {
            print("ChangeRoomForAntlion  aPos_player[3] == 45.0")

            aCam = [
                aPos_player[0] + -103.253,
                aPos_player[1] + 17.854,
                aPos_player[2] + -37.511,
                aPos_player[0] + -102.285,
                aPos_player[1] + 17.603,
                aPos_player[2] + -37.528
            ]
        } else if(aPos_player[3] <= 90.0) {
            print("ChangeRoomForAntlion  aPos_player[3] == 90.0")

            aCam = [
                aPos_player[0] + -95.784,
                aPos_player[1] + 25.538,
                aPos_player[2] + 35.803,
                aPos_player[0] + -95.034,
                aPos_player[1] + 25.16,
                aPos_player[2] + 35.261
            ]
        } else if(aPos_player[3] <= 180.0) {
            print("ChangeRoomForAntlion  aPos_player[3] == 180.0")

            aCam = [
                aPos_player[0] + 35.803,
                aPos_player[1] + 25.538,
                aPos_player[2] + 95.784,
                aPos_player[0] + 35.261,
                aPos_player[1] + 25.16,
                aPos_player[2] + 95.034
            ]
        } else if(aPos_player[3] <= 225.0) {
            print("ChangeRoomForAntlion  aPos_player[3] == 225.0")

            aCam = [
                aPos_player[0] + 103.253,
                aPos_player[1] + 17.854,
                aPos_player[2] + 37.511,
                aPos_player[0] + 102.285,
                aPos_player[1] + 17.603,
                aPos_player[2] + 37.528
            ]
        } else if(aPos_player[3] <= 270.0) {
            print("ChangeRoomForAntlion  aPos_player[3] == 270.0")

            aCam = [
                aPos_player[0] + 95.784,
                aPos_player[1] + 25.538,
                aPos_player[2] + -35.803,
                aPos_player[0] + 95.034,
                aPos_player[1] + 25.16,
                aPos_player[2] + -35.261
            ]
        } else {
            print("ChangeRoomForAntlion  aPos_player[3] == else")

            aCam = [
                aPos_player[0] + -35.803,
                aPos_player[1] + 25.538,
                aPos_player[2] + -95.784,
                aPos_player[0] + -35.261,
                aPos_player[1] + 25.16,
                aPos_player[2] + -95.034
            ]
        }

        print("ChangeRoomForAntlion  aCam[0] = " + aCam[0])
        print("ChangeRoomForAntlion  aCam[1] = " + aCam[1])
        print("ChangeRoomForAntlion  aCam[2] = " + aCam[2])
        print("ChangeRoomForAntlion  aCam[3] = " + aCam[3])
        print("ChangeRoomForAntlion  aCam[4] = " + aCam[4])
        print("ChangeRoomForAntlion  aCam[5] = " + aCam[5])

        init_petit()
        set_petit_src_param(aCam[0], aCam[1], aCam[2], aCam[3], aCam[4], aCam[5], 0.0, __GetFovy())
        set_petit_dst_param(aCam[0], aCam[1], aCam[2], aCam[3], aCam[4], aCam[5], 0.0, __GetFovy())
        begin_petit(1)

        wait(neg8)

        fadein(0, 0, 1.0)
        wait(10)

        start_actor_motion(dummy_act, 422)
        wait(5)

        print("ChangeRoomForAntlion  hact00 = " + hact00)

        local target_pos = get_actor_position(hact00)
        local angle_y = get_actor_angle_y(hact00)

        request_parabola_move_action(hact00, aPos_Antlion, target_pos, 40.0, angle_y, 1.5)
        wait(1)

        set_actor_visible(hact00, true)
        set_actor_shadow_visible(hact00, false)

        wait(4)

        if(hact01 != 0) {
            print("ChangeRoomForAntlion  hact01 = " + hact01)
            
            target_pos = get_actor_position(hact01)
            angle_y = get_actor_angle_y(hact01)

            request_parabola_move_action(hact01, aPos_Antlion, target_pos, 40.0, angle_y, 1.5)
            wait(1)

            set_actor_visible(hact01, true)
            set_actor_shadow_visible(hact01, false)

            wait(4)
        }

        if(hact02 != 0) {
            print("ChangeRoomForAntlion  hact02 = " + hact02)
            
            target_pos = get_actor_position(hact02)
            angle_y = get_actor_angle_y(hact02)

            request_parabola_move_action(hact02, aPos_Antlion, target_pos, 40.0, angle_y, 1.5)
            wait(1)

            set_actor_visible(hact02, true)
            set_actor_shadow_visible(hact02, false)

            wait(4)
        }

        wait(neg7)

        set_petit_dst_param(reset_param)
        begin_petit(50)

        wait(15)

        set_actor_shadow_visible(hact00, true)

        if(hact01 != 0) {
            wait(5)
            set_actor_shadow_visible(hact01, true)
        }

        if(hact02 != 0) {
            wait(5)
            set_actor_shadow_visible(hact02, true)
        }

        wait(neg8)

        end_petit()

        wait_for_true2(is_action_finished, hact00, 126)

        destroy_actor(dummy_act)

        local end_pos = get_actor_position(hact00)
        local end_angle_y = get_actor_angle_y(hact00)

        update_player_home_pos_angle_y(end_pos[0], end_pos[1], end_pos[2], end_angle_y)

        PadOnWait(1)
    }

    function ActivateWarpGateForQuartzGetEvent(treasure_box_id) {
        set_demo_event(true)

        local target_pos = get_actor_position(treasure_box_id)
        local target_rot = get_actor_angle_y(treasure_box_id)

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

        local POS_OFFSET_MAIN = [0.0, 0.0, 14.0, 0.0]
        local POS_OFFSET_SUB1 = [13.0, 0.0, 12.0, -40.0]
        local POS_OFFSET_SUB2 = [-12.0, 0.0, 12.0, 40.0]

        local WARP_GATE_CAM = [
            9.0, 25.5, -19.8,
            8.8, 25.1, -18.8,
            50.0
        ]

        local aHact = [
            get_party_index(0),
            get_party_index(1),
            get_party_index(2)
        ]
        local alive = [false, false, false]

        for(local i = 0; i < aHact.len(); ++i) {
            if(aHact[i] == 0) continue;

            alive[i] = is_player_alive(aHact[i])
        }

        local POS_MAIN = [
            target_pos[0] + (dir_x * POS_OFFSET_MAIN[2]) + (dir_z * POS_OFFSET_MAIN[0]),
            target_pos[1] + POS_OFFSET_MAIN[1],
            target_pos[2] + (dir_z * POS_OFFSET_MAIN[2]) + (-dir_x * POS_OFFSET_MAIN[0]),
            Clamp0To2PI(target_rot + POS_OFFSET_MAIN[3])
        ]
        local POS_SUB1 = [
            target_pos[0] + (dir_x * POS_OFFSET_SUB1[2]) + (dir_z * POS_OFFSET_SUB1[0]),
            target_pos[1] + POS_OFFSET_SUB1[1],
            target_pos[2] + (dir_z * POS_OFFSET_SUB1[2]) + (-dir_x * POS_OFFSET_SUB1[0]),
            Clamp0To2PI(target_rot + POS_OFFSET_SUB1[3])
        ]
        local POS_SUB2 = [
            target_pos[0] + (dir_x * POS_OFFSET_SUB2[2]) + (dir_z * POS_OFFSET_SUB2[0]),
            target_pos[1] + POS_OFFSET_SUB2[1],
            target_pos[2] + (dir_z * POS_OFFSET_SUB2[2]) + (-dir_x * POS_OFFSET_SUB2[0]),
            Clamp0To2PI(target_rot + POS_OFFSET_SUB2[3])
        ]
        
        if(aHact[0] != 0 && alive[0] == true) {
            set_actor_position_angle_y(aHact[0], POS_MAIN[0], POS_MAIN[1], POS_MAIN[2], POS_MAIN[3])
        }
        if(aHact[1] != 0 && alive[1] == true) {
            set_actor_position_angle_y(aHact[1], POS_SUB1[0], POS_SUB1[1], POS_SUB1[2], POS_SUB1[3])
        }
        if(aHact[2] != 0 && alive[2] == true) {
            set_actor_position_angle_y(aHact[2], POS_SUB2[0], POS_SUB2[1], POS_SUB2[2], POS_SUB2[3])
        }

        wait(1)

        local POS_CAM = [
            target_pos[0] + (dir_x * WARP_GATE_CAM[2]) + (dir_z * WARP_GATE_CAM[0]),
            target_pos[1] + WARP_GATE_CAM[1],
            target_pos[2] + (dir_z * WARP_GATE_CAM[2]) + (-dir_x * WARP_GATE_CAM[0]),
            target_pos[0] + (dir_x * WARP_GATE_CAM[5]) + (dir_z * WARP_GATE_CAM[3]),
            target_pos[1] + WARP_GATE_CAM[4],
            target_pos[2] + (dir_z * WARP_GATE_CAM[5]) + (-dir_x * WARP_GATE_CAM[3]),
            WARP_GATE_CAM[6]
        ]

        init_petit()
        set_petit_dst_param(
            POS_CAM[0], POS_CAM[1], POS_CAM[2],
            POS_CAM[3], POS_CAM[4], POS_CAM[5],
            0.0, POS_CAM[6]
        )
        begin_petit(0)

        const neg8 = -8
        wait(neg8)

        fadein_sync(1, 1, 1.0)

        const neg7 = -7
        wait(neg7)

        wait(30)

        local warp_gate = FindBgobjActorByActType(25)
        if(warp_gate && warp_gate.hself_) {
            warp_gate.Activate()
        }

        wait(30)

        set_petit_slide_dst_to_src()
        ResetToBehindCamera(30)
        
        set_demo_event(false)
    }

    function PostLoadAfterSetPlayerPos(isPostLoad) {
        // empty
    }
}
