// TODO match line infos

const neg1 = -1

class DungeonSceneBase extends SceneBase {
    OFS_X = 600.0
    OFS_Z = -240.0
    demo_obj = null
    dunits_ctrl = DungeonUnitControl()
    dslot_num = 1
    __current_archive_group = neg1

    function CurrentArchiveGroupIs(archive_group_id) {
        return this.__current_archive_group == archive_group_id;
    }

    function InitializeDungeonCore() {
        // empty
    }

    function Initialize() {
        InitializeVariable()
        this.InitializeDungeonCore()
    }

    function OnPostLoad() {
        print("onPostLoad")

        PadOffWait(0)

        local event_name = get_dungeon_event_name()
        if(event_name) {
            print("Event name :")
            print(event_name)
            load_module_sync(event_name)
            this.demo_obj = DemoEventSet()
        }

        print("onPostLoad : 01")

        this.dunits_ctrl.Init(this)

        print("onPostLoad : 02")

        local unit = get_dungeon_unit_index_by_room(GetCurrentRoomId())
        print("OnPostLoad : unit = " + unit)
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].OnPostLoadEventChecker()
        }

        local bgm_id = get_dungeon_bgm_id()

        if(!PlayNextRoomBgm(GetAreaId()) && bgm_id != -1) {
            start_bgm(bgm_id)
        }

        PostLoadDungeonData()

        PadOnWait(0)
    }

    function InitializeFlags() {
        for(local i = 0; i < 4; i++) {
            local unit = get_dungeon_unit_name(i)
            if(unit != null) {
                this.dunits_ctrl.units_[i].InitializeFlags()
            }
        }
    }

    function InitializeLoadResources() {
        local aResources = null
        
        for(local i = 0; i < 4; i++) {
            local unit = get_dungeon_unit_name(i)
            if(unit != null) {
                aResources = this.dunits_ctrl.units_[i].GetLoadResources()
                if(aResources != null) {
                    LoadResources(aResources)
                }
            }
        }
    }

    function InitializeEvent() {
        const neg7 = -7
        const neg8 = -8

        // it's actually called this, I name unknown locals `unkXX`
        local unknown = -1
        local scene_id = get_scene_id()

        if(EventOfReturningFromTownGate()) {
            // empty
        } else if(get_prev_scene() == 0) {
            set_demo_event(true)
            init_petit()
            begin_petit(0)
            end_petit()
            fadein_sync()
            set_demo_event(false)
        } else if(scene_id == 390 || scene_id == 391 || scene_id == 392 ||
                scene_id == 393 || scene_id == 394 || scene_id == 396 || is_hieroglyph_dungeon()) {
            local hplayer = get_party_order(0)
            
            AiSleepForSwitch(hplayer)
            fadein(0, 0, 1.0)
            
            local room_num = GetAreaId()

            print("InitializeEvent : room_num = " + room_num)

            local unit = get_dungeon_unit_index_by_room(GetCurrentRoomId())
            if(unit != -1) {
                this.dunits_ctrl.units_[unit].ChengeRoomEvent(room_num, 2)
            }

            wait(neg7)

            AiWakeUpForSwitch(hplayer)
        } else if(has_dungeon_start_event() || get_prev_scene() == 313) {
            local door_hact = GetCurrentDoorHact(2)
            if(door_hact == 0) door_hact = GetCurrentDoorHact(6)
            if(door_hact == 0) door_hact = GetCurrentDoorHact(9)
            if(door_hact == 0) door_hact = GetCurrentDoorHact(11)
            
            local hplayer = get_party_order(0)

            AiSleepForSwitch(hplayer)

            local pl0_appear_param = [0.0, 0.0, 0.0, 0.0]
            local pl1_appear_param = [0.0, 0.0, 0.0, 0.0]
            local pl2_appear_param = [0.0, 0.0, 0.0, 0.0]

            local hparty1 = get_party_order(1)
            local hparty2 = get_party_order(2)

            if(SC_GetDoorApperPosition(pl0_appear_param, pl1_appear_param, pl2_appear_param, door_hact) == true) {
                set_actor_position_angle_y(
                    hplayer,
                    pl0_appear_param[0], pl0_appear_param[1], pl0_appear_param[2],
                    pl0_appear_param[3]
                )
                set_actor_position_angle_y(
                    hparty1,
                    pl1_appear_param[0], pl1_appear_param[1], pl1_appear_param[2],
                    pl1_appear_param[3]
                )
                fadeout_actor_alpha(hplayer, 1)
                set_actor_position_angle_y(
                    hparty2,
                    pl2_appear_param[0], pl2_appear_param[1], pl2_appear_param[2],
                    pl2_appear_param[3]
                )
                fadeout_actor_alpha(hparty2, 1)
            } else {
                print("ERROR: プレイヤーの出現開始位置が求まりません")
            }

            local camera_param = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

            if(SC_CalcCameraApperPosition(camera_param, door_hact) == true) {
                init_petit()
                set_petit_src_param(camera_param)
                set_petit_dst_param(camera_param)
                begin_petit(1)

                wait(neg8)
            } else {
                print("ERROR: カメラの出現位置が求まりません")
            }

            change_switch(door_hact, 1, true)
            fadein_sync(0, 0, 1.0)

            wait(15)

            local pl0_target_pos = [0.0, 0.0, 0.0]
            local pl1_target_pos = [0.0, 0.0, 0.0]
            local pl2_target_pos = [0.0, 0.0, 0.0]

            if(SC_GetDoorMovementEndPosition(pl0_target_pos, pl1_target_pos, pl2_target_pos, door_hact) == true) {
                fadein_actor_alpha(hplayer, 8)
                move_actor(hplayer, 1, pl0_target_pos, 30 * 2)

                wait(8)

                move_actor(hparty1, 1, pl1_target_pos, 30 * 2)
                fadein_actor_alpha(hparty1, 8)
                
                move_actor(hparty2, 1, pl2_target_pos, 30 * 2)
                fadein_actor_alpha(hparty2, 8)

                wait_for_false1(is_actor_moving, hplayer)
                
                idle_actor(hplayer)

                wait(1)
            } else {
                print("ERROR: プレイヤーの移動終了位置が求まりません")
            }

            motion_wait(door_hact)
            change_switch(door_hact, 0, true)
            wait(1)
            motion_wait(door_hact)

            set_petit_slide_dst_to_src()
            
            local reset_param = get_reset_param_of_behind_camera()

            set_petit_dst_param(reset_param)
            begin_petit(30)
            
            local room_num = GetAreaId()

            print("InitializeEvent : room_num = " + room_num)

            local unit = get_dungeon_unit_index_by_room(GetCurrentRoomId())
            if(unit != -1) {
                this.dunits_ctrl.units_[unit].ChengeRoomEvent(room_num, 2)
            }

            wait(neg8)

            end_petit()
            AiWakeUpForSwitch(hplayer)
        } else if(0 == this.mission_demo_flag) {
            RunIntoSceneDemo()
        }

        local area_id = GetAreaId()
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))

        print("OnPostLoadEvent : unit = " + unit)

        if(unit != -1) {
            this.dunits_ctrl.units_[unit].OnPostLoadEvent()
        }
    }

    function OnPhantomEnterEvent(lytid, hact) {
        local area_id = GetAreaId()
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))

        print("OnPhantomEnterEvent : unit = " + unit +
            "  lytid = " + lytid)
        
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].OnPhantomEnterEvent(lytid, hact)
        }

        change_dungeon_map_room_pattern_by_phantom_id(lytid)
    }

    function OnPhantomLeaveEvent(lytid, hact) {
        local area_id = GetAreaId()
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))

        print("OnPhantomLeaveEvent : unit = " + unit +
            "  lytid = " + lytid)
        
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].OnPhantomLeaveEvent(lytid, hact)
        }
    }

    function OnSwitchChanged(switch_id) {
        local area_id = GetAreaId()
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].OnSwitchChanged(switch_id)

            local bgobj = FindBgobjActorByHandle(switch_id)
            if(bgobj) {
                if(!is_same_unit_id_bgobj(bgobj.hself_, unit)) return;

                bgobj.OnSwitchChanged(get_state_switch_actor(bgobj.hself_))
                if(get_state_switch_actor(bgobj.hself_)) {
                    bgobj.SetRouteIdToPartyAI()
                } else if(bgobj.GetRouteId() > 0) {
                    reset_route_id_to_party_ai()
                }
            }
        }
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        local area_id = GetAreaId()
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        local enable_bgobj = true

        if(unit != -1) {
            enable_bgobj = this.dunits_ctrl.units_[unit].OnPlayerSkill(hplayer, htarget, result)
        }

        if(!enable_bgobj) return;

        print("Scene::onPlayerSkill_begin:" + hplayer +
            "," + htarget +
            "," + result)
        
        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_list in group_table) {
                foreach(bgobj in bgobj_list) {
                    if(bgobj.hself_ == htarget) {
                        bgobj.OnPlayerSkill(hplayer, htarget, result)
                        return;
                    }
                }
            }
        }
    }

    function __RegisterEnemyAndBgobj() {
        print("[!][!][!]<<< SET : EnemyArchive >>>[!][!][!]")

        register_enemygroup_for_dungeon()

        print("[!][!][!]<<< SET : OBJArchive >>>[!][!][!]")

        register_bgobjgroup_for_dungeon(true)

        func_wait(is_archive_loaded)
    }

    function __LoadEnemyResourceArchive() {
        local prev_boss_area_type = 0
        local zone_id = get_zone_id()

        if(zone_id == 24) {
            ChangeEnemyResource_FD05(GetAreaId())
        } else {
            ChangeEnemyResource(GetAreaId(), prev_boss_area_type)
        }

        func_wait(is_archive_loaded)
    }

    function LoadResourceArchive(archive_group_id) {
        load_archive_group_member(archive_group_id)
        this.__current_archive_group = archive_group_id
    }

    function InitializeEnemyGroup() {
        this.__RegisterEnemyAndBgobj()
        create_enemy_archive_group_for_dungeon()
        this.__LoadEnemyResourceArchive()
        register_quest_target_npc_for_dungeon()

        for(local i = 0; i < 4; i++) {
            local unit = get_dungeon_unit_name(i)
            if(unit != null) {
                this.dunits_ctrl.units_[i].InitializeEnemyResources()
                if(this.dunits_ctrl.units_[i].IsRegisterBossSymbol()) {
                    register_boss_symbol()
                }
            }
        }
    }

    function PopAreaManager(area_id) {
        local group_id = -1
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))

        if(unit != -1) {
            group_id = this.dunits_ctrl.units_[unit].PopAreaManager(area_id)
        }

        return group_id;
    }

    function PopObjectWhenDoorOpened(area_id) {
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].PopObjectWhenDoorOpened(area_id)
        }
    }

    function ChengeRoomEventDuringFade(area_id, door_direction) {
        print("ChengeRoomEventDuringFade : area_id = " + area_id)
        print("ChengeRoomEventDuringFade : door_direction = " + door_direction)

        reset_route_id_to_party_ai()

        local scene = GetCurrentSceneObj()
        if(scene != null) {
            for(local i = 0; i < scene.chara_list_.len(); ++i) {
                if(is_encounter_npc(scene.chara_list_[i].hself)) {
                    scene.chara_list_.remove(i)
                    --i
                }
            }
        }

        destroy_encounter_npc_all()

        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].ChengeRoomEventDuringFade(area_id, door_direction)
        }
    }

    function ChengeRoomEvent(area_id, door_direction) {
        print("ChengeRoomEvent : area_id = " + area_id)
        print("ChengeRoomEvent : door_direction = " + door_direction)

        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].ChengeRoomEvent(area_id, door_direction)
        }
    }

    function SetDungeonDoor(area_id) {
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        local p_room_id = GetRoomNumberForProgram(area_id)

        print("<<< SetDungeonDoor : area_id = " + area_id + " >>>")
        print("<<< SetDungeonDoor : p_room_id = " + p_room_id + " >>>")
        print("<<< SetDungeonDoor : 今回ＰＯＰするドアは unit = " + unit + " です >>>")

        if(unit != -1) {
            this.dunits_ctrl.units_[unit].SetDungeonDoor(area_id)
        }
    }
    
    function PopAreaObject(area_id) {
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].PopAreaObject(area_id)
        }
    }

    function GimmickPositionData() {
        local area_id = GetAreaId()
        local aPos = [0.0, 0.0, 0.0, 0.0]
        local aA = null
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))

        if(unit != -1) {
            aA = this.dunits_ctrl.units_[unit].GimmickPositionData()
        }

        if(aA != null) {
            aPos = aA
        }

        return aPos;
    }

    function PopEventChecker(area_id, group_id) {
        print("[ !!!!!!!! PopEventChecker :     group_id = " + group_id + " !!!!!!!! ]")
        
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].PopEventChecker(area_id, group_id)
        }
    }

    function DestroyEventChecker(hact, member_num, group_id) {
        print("[ !!!!!!!! DestroyEventChecker : member_num = " + member_num +
            "    group_id = " + group_id + " !!!!!!!! ]")
        
        local area_id = GetAreaId()
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))

        if(unit != -1) {
            this.dunits_ctrl.units_[unit].DestroyEventChecker(hact, member_num, group_id)
        }
    }

    function BGObjectDeadChecker(hact) {
        print("[ !!!!!!!! BGObjectDeadChecker !!!!!!!! ]")

        local area_id = GetAreaId()
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].BGObjectDeadChecker(hact)
        }
    }

    function LifeZeroEventChecker(hact, member_num, group_id) {
        print("DangeonSceneBase::LifeZeroEventChecker [act:" + hact + "]")

        local area_id = GetAreaId()
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))

        if(unit != -1) {
            this.dunits_ctrl.units_[unit].LifeZeroEventChecker(hact, member_num, group_id)
        }
    }

    function OnPlayerDoor(hplayer, htarget) {
        print("onPlayerDoor:" + hplayer + "," + htarget)

        foreach(group_table in bgobj_table_) {
            foreach(bgobj_list in group_table) {
                foreach(bgobj in bgobj_list) {
                    if(bgobj.hself_ == htarget) {
                        bgobj.OnPlayerDoor(hplayer, htarget)
                        return;
                    }
                }
            }
        }
    }
    
    function OnActorDeadEvent(hact, group_id, rest_group_member_num) {
        print("onActorDead:DungeonSceneBase [act:" + hact +
            " group_id:" + group_id +
            " rest_group_member_num:" + rest_group_member_num + "]")
        
        local bgobj = SceneBase.OnActorDeadEvent(hact, group_id, rest_group_member_num)

        if(bgobj && bgobj.hself_ == hact) {
            bgobj.SetRouteIdToPartyAI()
            bgobj.hself_ = 0
        }
    }

    function OnBossDyingEvent(hact, state) {
        local area_id = GetAreaId()

        print("DungeonSceneBase::onBossDyingEvent: hact=[ " + hact +
            " ], state=[ " + state +
            " ], [ " + area_id + " ]")
        
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].OnBossDyingEvent(hact, state)
        }
    }

    function OnDateTimePeriod(period_index) {
        print("onDateTimePeriod: " + "ピリオド: " + period_index)
        onDateTimePeriodCommon(period_index)
    }

    function GenericEvent(parameters) {
        local area_id = GetAreaId()

        print("GenericEvent : ")

        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].GenericEvent(parameters)
        }
    }

    function Finalize() {
        FinalizePartyControll()
        foreach(unit in this.dunits_ctrl.units_) {
            unit.Finalize()
        }

        set_enable_quicksand(true)
        reset_flag(1000)
    }

    function onTick(timer_id) {
        // empty
    }

    function OnPlayerTalked(hplayer, htarget) {
        print("DungeonMain::onPlayerTalked:" + hplayer + "," + htarget)

        foreach(actor in this.chara_list_) {
            if(actor.hself == htarget) {
                set_actor_bit(hplayer, 14)
                set_actor_bit(htarget, 14)
                actor.OnPlayerTalked(hplayer, htarget)
                reset_actor_bit(hplayer, 14)
                reset_actor_bit(htarget, 14)
                return;
            }
        }
    }

    function OnPlayerShopping(hplayer, htarget) {
        print("onPlayerShopping:" + hplayer + "," + htarget)
    }

    function OnPlayerCarry(hplayer, htarget) {
        print("onPlayerCarry:" + hplayer + "," + htarget)
    }

    function SetDungeonSlot(slot_id) {
        this.dslot_num
        // no-op
    }

    function AfterPlayerActionEvent(switch_id, layout_id) {
        local area_id = GetAreaId()
        local unit = get_dungeon_unit_index_by_room(GetRoomNumberForProgram(area_id))

        if(unit != -1) {
            this.dunits_ctrl.units_[unit].AfterPlayerActionEvent(switch_id, layout_id)
        }
    }

    function InitializeNpcResources() {
        for(local i = 0; i < 4; i++) {
            local unit = get_dungeon_unit_name(i)
            if(unit != null) {
                this.dunits_ctrl.units_[i].InitializeNpcResources()
            }
        }
    }

    function OnBattleEvent(begin) {
        if(begin == 1) {
            if(check_mission_completed(9)) {
                // empty
            }
        }
    }

    function OnHitHappower(hplayer, htarget) {
        OnHitWindowMasic(hplayer, htarget)
    }

    function InitializeMap(isPostLoad) {
        local hact = get_player()
        local phantoms = get_phantom_in_contact(get_actor_position(hact))

        if(phantoms != null) {
            foreach(phantom_id in phantoms) {
                if(900 <= phantom_id && phantom_id <= 949) {
                    change_dungeon_map_room_pattern_by_phantom_id(phantom_id)
                }
            }
        }

        local unit = get_dungeon_unit_index_by_room(GetCurrentRoomId())
        if(unit != -1) {
            this.dunits_ctrl.units_[unit].PostLoadAfterSetPlayerPos(isPostLoad)
        }
    }
}
