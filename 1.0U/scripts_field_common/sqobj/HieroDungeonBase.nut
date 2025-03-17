// TODO match line infos

class HieroDungeonBase extends DungeonUnitBase {
    PTERANO_SW_CTRL_FLAG = false
    PTERANO_YUKA_DWN_CTRL_FLAG = false

    function PopProcessHieroglyphDungeon(area_id, check_id) {
        if(area_id == check_id) {
            setup_hieroglyph_room(area_id)
            PopProcess(area_id)
        }
    }

    function PopProcessNoEnemyPopHieroglyphDungeon(area_id, check_id) {
        if(area_id == check_id) {
            setup_hieroglyph_room(area_id)
            PopProcessNoEnemyPop(area_id)
        }
    }

    function IsHieroRoomTypeEnemy(area_id) {
        if(get_room_type_by_area_id(area_id) == 0) return true;
        return false;
    }

    function IsHieroRoomTypeRecovery(area_id) {
        if(get_room_type_by_area_id(area_id) == 1) return true;
        return false;
    }

    function IsHieroRoomTypeMaterial(area_id) {
        if(get_room_type_by_area_id(area_id) == 2) return true;
        return false;
    }

    function IsHieroRoomTypeTrap(area_id) {
        if(get_room_type_by_area_id(area_id) == 3) return true;
        return false;
    }

    function IsHieroRoomTypeUnknow(area_id) {
        local result = get_room_type_by_area_id(area_id)
        if(result >= 4) return true;
        return false;
    }

    function CallPopGroupHieroSandHill(area_id, group_id, layout_id) {
        local sand_hill = FindBgobjActorByLayoutId(layout_id)
        local is_pop_group = 1
        
        if(sand_hill != 0) {
            if(is_hiero_sand_hill(sand_hill.hself_)) {
                if(get_hiero_sand_hill_type(sand_hill.hself_) != 1) {
                    is_pop_group = 0
                }
            }
        }

        if(is_pop_group) {
            CallPopGroup(area_id, group_id)
        }
    }

    function TutorialSymbolDoor() {
        if(!test_flag(3888)) {
            ui_sync(5, [83172, 83173])
            set_flag(3888)
        }
    }

    function TutorialSymbolSwitch() {
        if(!test_flag(3889)) {
            ui_sync(5, [83174, 83175])
            set_flag(3889)
        }
    }

    function TutorialBoostOrb() {
        if(!test_flag(3890)) {
            ui_sync(5, [83176, 83177])
            set_flag(3890)
        }
    }

    function TutorialMaterialRoom(area_id) {
        if(!test_flag(4015)) {
            if(get_room_type_by_area_id(area_id) == 2) {
                ui_sync(5, [83226, 83227])
                set_flag(4015)
            }
        }
    }

    function ActivateMediumBossPortal(bgobj_id) {
        PadOffWait(0)

        ActivateBgobj(bgobj_id)

        wait(60)

        PadOnWait(0)
    }

    function SetHieroBossGroup(group_id) {
        local hiero_boss_type = get_hiero_boss_type()

        if(hiero_boss_type == 0 || hiero_boss_type == 3) {
            if(!is_hiero_boss_morbor()) {
                SetGroup(group_id)
                return group_id;
            }
        }

        return -1;
    }

    function CreateHieroGoalBgobjActorByGroupID(area_id, treasure_group_id, altar_group_id) {
        CreateBgobjActorByGroupID(area_id, treasure_group_id)
    }

    function CallPopHieroBossGroup(area_id, group_id) {
        local hiero_boss_type = get_hiero_boss_type()
        local hiero_id = get_current_hiero_id()

        if(hiero_boss_type == 1 || hiero_boss_type == 2 || is_hiero_boss_morbor()) {
            set_demo_event_sync()
            PadOffWait(0)
            set_enemy_sleep(true)

            if(hiero_boss_type == 1 && !is_hiero_boss_morbor()) {
                hiero_shuffle_enemy_create_pos(group_id, 0, 2)
            }

            init_petit()

            switch(hiero_id) {
                case 0:
                    this.__BigBossPopCameraEventHiero1(group_id)
                    break;
                case 1:
                    this.__BigBossPopCameraEventHiero2(group_id)
                    break;
                case 2:
                    this.__BigBossPopCameraEventHiero3(group_id)
                    break;
            }

            CallPopGroup(area_id, group_id)

            if(hiero_id == 0) {
                local hact_player = get_party_order(0)

                set_actor_position_angle_y(hact_player, 1200.0, 1.0, 213.0, 270)
                
                wait(30)

                reset_party_position()
            } else {
                wait(30)
            }

            set_enemy_sleep(false)

            found_player_by_enemygroup(group_id)

            wait(30)

            end_petit()
            set_demo_event(false)

            PadOnWait(0)
            return;
        }

        local event_index = 6

        this.scene_.demo_obj.StartDemo(event_index, [0, group_id, -1])

        if(hiero_id == 0 || hiero_id == 2) {
            set_flag(1023)
            update_room_scene_env()
        }

        set_hiero_boss_battle(true)
    }

    function __BigBossPopCameraEventHiero1(group_id) {
        set_petit_dst_param(
            1140.467, 4.889, 212.514,
            1139.474, 5.008, 212.513,
            -0.0, 50.0
        )
        begin_petit(0)
        set_petit_slide_dst_to_src()
        set_petit_dst_param(
            1115.385, 8.274, 212.477,
            1114.392, 8.392, 212.475,
            -0.0, 50.0
        )
        begin_petit(60)

        wait(60)
        wait(30)
    }

    function __BigBossPopCameraEventHiero2(group_id) {
        set_petit_dst_param(
            1873.607, 28.001, 792.671,
            1873.616, 27.914, 791.674,
            -0.0, 50.0
        )
        begin_petit(0)
        set_petit_slide_dst_to_src()
        set_petit_dst_param(
            1874.062, 23.778, 743.777,
            1874.072, 23.692, 742.781,
            -0.0, 50.0
        )
        begin_petit(60)

        wait(60)
        wait(30)
    }

    function __BigBossPopCameraEventHiero3(group_id) {
        hiero_offset_enemy_create_pos(group_id, [0.0, 0.0, -45.0])
        set_petit_dst_param(
            585.0, -722.275, 618.344,
            585.0, -722.344, 617.347,
            0.0, 50.0
        )
        begin_petit(0)
        set_petit_slide_dst_to_src()
        set_petit_dst_param(
            585.0, -730.587, 595.159,
            585.0, -730.664, 594.162,
            0.0, 50.0
        )
        begin_petit(60)

        wait(60)
        wait(30)
    }

    function StartRayMotion(rayout_id) {
        local ray_hact = FindBgobjHandleByLayoutId(rayout_id)

        start_actor_motion(ray_hact, 545)
    }

    function PopProcessPteranoFrog(area_id, group_id, flag) {
        local hiero_boss_type = get_hiero_boss_type()
        local is_pteranofrog = true
        local cameraEvent = CameraEventControl(null)
        local original_offset_x = -600.0
        local original_offset_z = -300.0
        local frog_mine_02 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle1LayoutId1())
        local frog_mine_03 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle1LayoutId2())
        local player = get_party_index(0)
        local p01_hact = get_party_index(1)
        local p02_hact = get_party_index(2)

        if(hiero_boss_type == 1 || hiero_boss_type == 2 || is_hiero_boss_morbor()) {
            is_pteranofrog = false
        }

        if(!is_pteranofrog) {
            destroy_actor(frog_mine_02)
            destroy_actor(frog_mine_03)
        } else {
            mine_set_visible(frog_mine_02, false)
            mine_set_visible(frog_mine_03, false)
        }

        local dummy_hact = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdK())
        local dummy_hact2 = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdI())

        PadOffWait(0)

        fadeout_sync(0, 0, 0.25)

        local pos_angle_table = [
            [1185.0 + original_offset_x, -48.0, 918.0 + original_offset_z, 180.0],
            [1193.0 + original_offset_x, -48.0, 926.0 + original_offset_z, 180.0],
            [1177.0 + original_offset_x, -48.0, 926.0 + original_offset_z, 180.0]
        ]
        local party_ = [
            get_party_index(0),
            get_party_index(1),
            get_party_index(2)
        ]

        for(local i = 0; i < 3; ++i) {
            if(!exists_actor(party_[i])) {
                // empty
            } else {
                local pos_angle = pos_angle_table[i]
                set_actor_position_angle_y(
                    party_[i],
                    pos_angle[0], pos_angle[1], pos_angle[2],
                    pos_angle[3]
                )
            }
        }

        cameraEvent.SetFade(false, false)
        cameraEvent.SetFrame(1, 1)
        cameraEvent.Begin(
            [1150.892 + original_offset_x, -0.373, 872.839 + original_offset_z],
            [1151.348 + original_offset_x, -1.09, 873.366 + original_offset_z]
        )

        wait(20)

        load_sound_group(0x6000017)
        
        wait_for_true1(sound_group_is_loaded, 0x6000017)

        play_se(0x1000185)
        set_ambient_se_volume(1.0)

        fadein_sync(3, 0, 0.25)

        play_se3D_handle(0x10002B0, dummy_hact)
        QuakeStart(0)

        wait(20)

        QuakeEnd()

        if(!is_pteranofrog) {
            request_gear_height(dummy_hact, 1, -7000, -25, 0)
            request_gear_height(dummy_hact2, 0, -7000, -25, 0)
        } else {
            request_gear_height(dummy_hact, 1, -6000, -25, 0)
            request_gear_height(dummy_hact2, 0, -6000, -25, 0)
        }

        cameraEvent.SetFade(false, false)
        cameraEvent.SetFrame(70, 1)
        cameraEvent.Begin(
            [1149.742 + original_offset_x, 23.694, 860.119 + original_offset_z],
            [1149.956 + original_offset_x, 22.749, 860.367 + original_offset_z]
        )

        wait(20)

        stop_se_by_id(0x10002B0)
        play_se3D_handle(0x10002B1, dummy_hact)

        if(!is_pteranofrog) {
            cameraEvent.End()

            wait(35 + 130 + 20)
        } else {
            cameraEvent.SetFade(false, false)
            cameraEvent.SetFrame(1, 1)
            cameraEvent.Begin(
                [1126.859 + original_offset_x, -617.187, 1123.765 + original_offset_z],
                [1127.061 + original_offset_x, -616.584, 1122.993 + original_offset_z]
            )

            wait(20)

            cameraEvent.SetFrame(130, 1)
            cameraEvent.Begin(
                [1126.859 + original_offset_x, -617.187, 1123.765 + original_offset_z],
                [1127.11 + original_offset_x, -617.055, 1122.806 + original_offset_z]
            )
        }

        stop_se_by_id(0x10002B1)
        play_se3D_handle(0x10002B2, dummy_hact)

        QuakeStart(1)

        wait(30)

        QuakeEnd()

        if(!is_pteranofrog) {
            local dummy_hact = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdK())
            local dummy_hact2 = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdI())

            play_gear_axis_anim(dummy_hact2, 0)
            change_gear_collision_model(dummy_hact, 0)
            change_gear_collision_model(dummy_hact2, 0)

            local impact_sw_hact_1 = FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId1())
            local impact_sw_hact_2 = FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId2())

            destroy_actor(impact_sw_hact_1)
            destroy_actor(impact_sw_hact_2)
        } else {
            start_actor_motion(player, 1702)

            wait(8)

            start_actor_motion(p01_hact, 1702)

            wait(15)

            start_actor_motion(p02_hact, 1702)
            fadeout_sync(0, 0, 0.25)
            request_gear_rotate2(dummy_hact, 120, 120, 0, 240)

            wait(1)

            set_actor_angleY(player, 225)

            cameraEvent.SetFade(false, false)
            cameraEvent.SetFrame(1, 1)
            cameraEvent.Begin(
                [1173.608 + original_offset_x, -629.434, 908.651 + original_offset_z],
                // `original_offset_z` used for X?
                [1174.08 + original_offset_z, -630.013, 909.316 + original_offset_z]
            )

            fadein_sync(3, 0, 0.25)

            cameraEvent.SetFrame(70, 1)
            cameraEvent.Begin(
                [1161.246 + original_offset_x, -614.243, 891.213 + original_offset_z],
                [1161.717 + original_offset_x, -614.822, 891.878 + original_offset_z]
            )

            local cam_target = FindBgobjActorByLayoutId(this.GetAppearDemoDummyObjLayoutId())

            begin_actor_look_target(player, cam_target.hself_)

            wait(15)

            start_actor_motion(player, 325)

            wait(15)

            mine_set_visible(frog_mine_02, true)
            mine_set_visible(frog_mine_03, true)
        }

        if(!test_flag(flag)) {
            set_flag(flag)
            this.CallPopHieroBossGroup(area_id, group_id)
        
            if(is_pteranofrog) {
                end_actor_look_target(get_player())
                cameraEvent.End()
            }
        }

        PadOnWait(0)
    }

    function CheckSwitchPteranoFrogProcess(switch_id) {
        if(CheckSwitchByLayoutId(switch_id, this.GetImpactSwitchLayoutId1()) ||
            CheckSwitchByLayoutId(switch_id, this.GetImpactSwitchLayoutId2())) {
            local impact_sw_hact_1 = FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId1())
            local impact_sw_hact_2 = FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId2())

            if(this.PTERANO_SW_CTRL_FLAG == false) {
                this.PTERANO_SW_CTRL_FLAG = true
                local yuka_gear_hact = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdK())

                request_gear_rotate(yuka_gear_hact, -90, -3, 0)

                wait(30)

                QuakeStart(0)

                wait(10)

                QuakeEnd()
            } else {
                this.PTERANO_SW_CTRL_FLAG = false
            }
        }
    }

    function CheckSwitchPteranoFrogProcessNew(switch_id, area_id, flag) {
        if(CheckSwitchByLayoutId(switch_id, this.GetImpactSwitchLayoutId1()) ||
            CheckSwitchByLayoutId(switch_id, this.GetImpactSwitchLayoutId2())) {
            local impact_sw_hact_1 = FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId1())
            local impact_sw_hact_2 = FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId2())
            local switch_1_state = get_state_switch_actor(impact_sw_hact_1)
            local switch_2_state = get_state_switch_actor(impact_sw_hact_2)

            if(switch_1_state == true || switch_2_state == true) {
                if(this.PTERANO_SW_CTRL_FLAG == false) {
                    this.PTERANO_SW_CTRL_FLAG = true

                    if(this.PTERANO_YUKA_DWN_CTRL_FLAG == false) {
                        stop_timer_se()
                        EventStart(0)
                    }

                    change_bgobj_collision_transparent(impact_sw_hact_1)
                    change_bgobj_collision_transparent(impact_sw_hact_2)

                    local yuka_gear_hact = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdK())

                    request_gear_rotate(yuka_gear_hact, -90, -3, 0)

                    wait(30)

                    QuakeStart(0)

                    wait(10)

                    QuakeEnd()

                    if(this.PTERANO_YUKA_DWN_CTRL_FLAG == false) {
                        this.PTERANO_YUKA_DWN_CTRL_FLAG = true
                        this.PopProcessPteranoFrog(area_id, this.GetPteranoFrogGroupId(), flag)
                        EventEnd()
                    }
                }
            }

            if(switch_1_state == false && switch_2_state == false) {
                reset_bgobj_collision_transparent(impact_sw_hact_1)
                reset_bgobj_collision_transparent(impact_sw_hact_2)
                this.PTERANO_SW_CTRL_FLAG = false
            }
        }
    }

    function PopAreaObjectPteranoFrogProcess(area_id, mine_group_id, gear_group_id, flag) {
        CreateBgobjActorByGroupID(area_id, gear_group_id)
        if(test_flag(flag) == false) {
            CreateBgobjActorByGroupID(area_id, mine_group_id)
            
            local dummy_hact2 = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdI())
            local impact_sw_hact_1 = FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId1())
            local impact_sw_hact_2 = FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId2())
            local dummy_hact_out = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdK())

            switch_actor_gear_attach(dummy_hact2, impact_sw_hact_1, 1)
            switch_actor_gear_attach(dummy_hact2, impact_sw_hact_2, 0)
            change_gear_collision_model(dummy_hact_out, 2)
        } else {
            local dummy_hact_in = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdI())
            local dummy_hact_out = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdK())
            local gear_end = FindBgobjHandleByLayoutId(this.GetGearEndLayoutId())

            request_gear_height(dummy_hact_in, 0, 5, 5, -7000)
            request_gear_height(dummy_hact_out, 0, 5, 5, -7000)
            change_gear_collision_model(dummy_hact_in, 0)
            change_gear_collision_model(dummy_hact_out, 0)
            play_gear_axis_anim(dummy_hact_in, 1)
            request_gear_rotate3(gear_end, 120, 120, 0, 0)
        }
    }

    function GenericEvent(parameters) {
        switch(parameters[0]) {
            case 0x10000000:
                this.OnPteranoFrogPhaseShift()
                break;
            case 0x10000001:
                this.OnPteranoFrogFirstTornado()
                break;
            case 0x10010000:
                this.OnDownChaosKelpRedTentacle(parameters[1], parameters[2])
                break;
            case 0x10010001:
                this.OnReviveChaosKelpRedTentacle(parameters[1], parameters[2], parameters[3])
                break;
            default: break;
        }
    }

    function OnPteranoFrogPhaseShift() {
        print("HieroDungeonBase::OnPteranoFrogPhaseShift")

        local h_frog = get_enemygroup_member(this.GetPteranoFrogGroupId(), 0)
        local h_mines = [
            FindBgobjHandleByLayoutId(this.GetFrogMineBattle1LayoutId1()),
            FindBgobjHandleByLayoutId(this.GetFrogMineBattle1LayoutId2())
        ]
        local h_wheel = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdK())
        local h_wheel2 = FindBgobjHandleByLayoutId(this.GetMoveGearFloorLayoutIdI())
        local h_impact_switches = [
            FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId1()),
            FindBgobjHandleByLayoutId(this.GetImpactSwitchLayoutId2())
        ]

        load_module_sync("EvBossPop")

        local obj = DemoBossPopSet()
        obj.StartDemo([3, h_frog, h_mines, h_wheel, h_wheel2, h_impact_switches])
    }

    function OnPteranoFrogFirstTornado() {
        print("HieroDungeonBase::OnPteranoFrogFirstTornado")
    }

    function OnDownChaosKelpRedTentacle(h_kelp_body, down_count) {
        print("HieroDungeonBase::OnDownChaosKelpRedTentacle")

        if(down_count == 1) {
            load_module_sync("EvBossPop")
            
            local obj = DemoBossPopSet()
            obj.StartDemo([4, 0, h_kelp_body])
        } else {
            wait(30 * 2)

            depop_all_chaos_kelp_fences()
        }

        send_signal_to_chaos_kelp(h_kelp_body, 4, 0)
    }

    function OnReviveChaosKelpRedTentacle(h_kelp_body, phase, phase_changed) {
        print("HieroDungeonBase::OnReviveChaosKelpRedTentacle")

        pop_chaos_kelp_fences_by_phase(h_kelp_body, phase)
    }

    function GetPteranoFrogGroupId() {
        return 0;
    }

    function GetMoveGearFloorLayoutIdK() {
        return 0;
    }

    function GetMoveGearFloorLayoutIdI() {
        return 0;
    }

    function GetFrogMineBattle1LayoutId1() {
        return 0;
    }

    function GetFrogMineBattle1LayoutId2() {
        return 0;
    }

    function GetImpactSwitchLayoutId1() {
        return 0;
    }

    function GetImpactSwitchLayoutId2() {
        return 0;
    }

    function GetFrogMineBattle2LayoutId1() {
        return 0;
    }

    function GetFrogMineBattle2LayoutId2() {
        return 0;
    }

    function GetFrogMineBattle2LayoutId3() {
        return 0;
    }

    function GetFrogMineBattle2LayoutId4() {
        return 0;
    }

    function GetGearEndLayoutId() {
        return 0;
    }

    function GetAppearDemoDummyObjLayoutId() {
        return 0;
    }

    function GetSecretDoorLayoutId() {
        return 0;
    }

    function PlaySandFallSE(tag_1, tag_2) {
        if(tag_1 != -1) {
            local pos = get_tag_point(tag_1)
            play_se3D(0x10002DB, pos[0], pos[1], pos[2])
        }
        if(tag_2 != -1) {
            local pos = get_tag_point(tag_2)
            play_se3D(0x10002DC, pos[0], pos[1], pos[2])
        }
    }

    function StopSandFallSE() {
        stop_se_by_id(0x10002DB)
        stop_se_by_id(0x10002DC)
    }

    function InitializeEnemyResources() {
        // empty
    }

    function IsRegisterBossSymbol() {
        if(!test_flag(3891)) {
            set_flag(3891)
            return true;
        }
        return false;
    }

    function OnBossDyingEvent(hact, state) {
        print("onBossDyingEvent: hact=[ " + hact +
            " ], state=[ " + state + " ]")
        
        local hiero_id = get_current_hiero_id()
        local event_index = 7

        if(hiero_id == 2) {
            local frog_mine_01 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle2LayoutId1())
            local frog_mine_02 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle2LayoutId2())
            local frog_mine_03 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle2LayoutId3())
            local frog_mine_04 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle2LayoutId4())

            destroy_actor(frog_mine_01)
            destroy_actor(frog_mine_02)
            destroy_actor(frog_mine_03)
            destroy_actor(frog_mine_04)
        }

        this.scene_.demo_obj.StartDemo(event_index, [1, hact, state])

        if(hiero_id == 0 || hiero_id == 2) {
            reset_flag(1023)
            update_room_scene_env()
        }

        set_hiero_boss_battle(false)

        if(hiero_id == 2) {
            PadOffWait(0)
            this.DestroyHiero3BossEvent()
            PadOnWait(0)
        }
    }

    function DestroyEventNotPteranoFrog() {
        print("_/_/_/_/_/_/ DestroyEventNotPteranoFrog _/_/_/_/_/_/")

        local hiero_id = get_current_hiero_id()
        local hiero_boss_type = get_hiero_boss_type()

        if(hiero_id != 2) return;
        if(hiero_boss_type != 1 && hiero_boss_type != 2 && !is_hiero_boss_morbor()) return;

        local frog_mine_01 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle2LayoutId1())
        local frog_mine_02 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle2LayoutId2())
        local frog_mine_03 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle2LayoutId3())
        local frog_mine_04 = FindBgobjHandleByLayoutId(this.GetFrogMineBattle2LayoutId4())

        destroy_actor(frog_mine_01)
        destroy_actor(frog_mine_02)
        destroy_actor(frog_mine_03)
        destroy_actor(frog_mine_04)

        PadOffWait(0)
        this.DestroyHiero3BossEvent()
        PadOnWait(0)
    }

    function DestroyHiero3BossEvent() {
        local gear_end = FindBgobjHandleByLayoutId(this.GetGearEndLayoutId())
        local hide_door_hact = FindBgobjHandleByLayoutId(this.GetSecretDoorLayoutId())

        local cameraEvent = CameraEventControl(null)

        GazeCameraForHact(gear_end, false, 20, 20.0)
        request_gear_rotate2(gear_end, 120, 2, 0, 0)

        cameraEvent.SetFade(false, false)
        cameraEvent.SetFrame(1, 1)
        cameraEvent.Begin(
            [1350.55 - 600.0, -672.473, 928.931 - 300.0],
            [1350.49 - 600.0, -672.896, 928.027 - 300.0]
        )

        wait(50)

        QuakeStart(1)
        wait(55)
        QuakeEnd()

        change_state_switch_actor(hide_door_hact, 1, false)

        QuakeStart(1)
        wait(30)
        QuakeEnd()

        cameraEvent.SetFade(false, false)
        cameraEvent.SetFrame(1, 1)
        cameraEvent.Begin(
            [1346.948 - 600.0, -723.613, 750.654 - 300.0],
            [1346.796 - 600.0, -723.782, 749.681 - 300.0]
        )

        wait(20)
        wait(10)

        QuakeStart(0)
        wait(60)
        QuakeEnd()

        wait(40)

        cameraEvent.End()
        set_flag(5145)
        change_dungeon_map_room_pattern(9, -2)
    }
}
