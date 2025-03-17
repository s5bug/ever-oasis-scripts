// TODO match line infos

function EventOfReturningFromTownGate() {
    if(!__GetGateEventFlag()) return false;

    local player = get_party_order(0)
    local p01_hact = get_party_order(1)
    local p02_hact = get_party_order(2)

    set_actor_visible(player, false)
    if(p01_hact != 0) {
        set_actor_visible(p01_hact, false)
    }
    if(p02_hact != 0) {
        set_actor_visible(p02_hact, false)
    }

    wait(1)

    local end_pos = get_actor_position(player)
    local end_angle_y = get_actor_angle_y(player)
    update_player_home_pos_angle_y(end_pos[0], end_pos[1], end_pos[2], end_angle_y)

    init_petit()
    ResetToBehindCamera(1)

    wait(4)

    fadein(0, 0, 1.0, 0, 1)

    start_actor_motion(player, 1785)
    local se_pos = get_actor_position(player)
    play_se3D(0x1000087, se_pos[0], se_pos[1], se_pos[2])
    wait(1)
    set_actor_visible(player, true)
    wait(15)

    if(p01_hact != 0) {
        start_actor_motion(p01_hact, 1785)
        se_pos = get_actor_position(p01_hact)
        play_se3D(0x1000087, se_pos[0], se_pos[1], se_pos[2])
        wait(1)
        set_actor_visible(p01_hact, true)
        wait(14)
    }

    if(p02_hact != 0) {
        start_actor_motion(p02_hact, 1785)
        se_pos = get_actor_position(p02_hact)
        play_se3D(0x1000087, se_pos[0], se_pos[1], se_pos[2])
        wait(1)
        set_actor_visible(p02_hact, true)
        wait(14)
    }

    wait(90)

    const neg7 = -7
    wait(neg7)

    return true;
}

function InitializeFieldData() {
    InitializeVariable()
    __SetEnterField()
}

function PostLoadFieldData() {
    if(isJumpToEntranceByPortal()) {
        print("!!!!! PORTAL JUMP !!!!!")

        local hact = get_player()
        local pos_angle = [4]
        pos_angle = get_portal_warp_pos_angle()

        set_actor_position_angle_y(hact, pos_angle[0], pos_angle[1], pos_angle[2], pos_angle[3])

        wait(1)

        reset_party_position()
        __SetGateEventFlag()
        ClearPortalFlag()
    } else if(is_from_save_data()) {
        print("PostLoadFieldData from save data")
        __SetGateEventFlag()
    }
}

function AquaGateReturnProcess() {
    if(__GetEnterField()) {
        if(__isCheckedLastScene()) {
            reset_flag(874)
            __MoveToDestination()
            __DestoryContactBgobjWhenReturnGate()
        }
    }
}

function __InitializeDungeonCore(scene, is_now_create) {
    if(is_now_create) {
        __ModeChangeStartUiInitialize()
    }

    local start_room_id = dungeon_setup_parameter()
    SetCurrentRoomIdAndAreaId(start_room_id)

    scene.SetDungeonSlot(get_dungeon_slot())
    __SetEnterRandomDungeon()
    __SetTargetScene(scene)
}

function InitializeDungeon(scene) {
    local is_now_create = create_dungeon()

    __InitializeDungeonCore(scene, is_now_create)
}

function InitializeHieroDungeon(scene, start_key, end_key) {
    local is_now_create = create_hiero_dungeon(start_key, end_key)

    __InitializeDungeonCore(scene, is_now_create)
}

function PostLoadDungeonData() {
    set_party_gravity_scale(0.0)
    
    local target_scene = GetTargetScene()

    set_enemy_sleep(true)

    if(IsUIInitializeState()) {
        target_scene.InitializeFlags()
    }

    register_dungeon_exit_symbol()
    InitializeElements(target_scene)
    set_flag(868)

    local area_id = GetAreaId()

    print("PostLoadDungeonData: area_id = " + area_id)

    UpDateAreaOffset(area_id)
    
    print("PostLoadDungeonData: 01")

    PopAreaDoorCommon(target_scene, area_id)
    target_scene.PopObjectWhenDoorOpened(area_id)
    InitializeBgobjAfterCreate(area_id)
    SetRouteIdToPartyAI_InArea(area_id)

    print("PostLoadDungeonData: 02")

    if(test_flag(3920)) {
        local tag_point_id = get_var(156)
        local tag_point = get_tag_point(tag_point_id)
        local hact_player = get_party_order(0)

        if(tag_point != null) {
            set_actor_position_angle_y(hact_player, tag_point[0], tag_point[1], tag_point[2], tag_point[3])
        } else if(tag_point_id == 0) {
            local pos_x = get_var(75)
            local pos_y = get_var(76)
            local pos_z = get_var(77)
            local ang_y = get_var(78)
            set_actor_position_angle_y(hact_player, pos_x, pos_y, pos_z, ang_y)

            set_var(75, 0)
            set_var(76, 0)
            set_var(77, 0)
            set_var(78, 0)
        } else {
            assert(0)
        }

        wait(1)

        reset_party_position()
        reset_flag(3920)
        init_petit()
        ResetToBehindCamera(1)
    } else if(__isCheckedLastScene()) {
        print("PostLoadDungeonData from entrance gate")

        reset_flag(874)
        __MoveToDestination()
        __DestoryContactBgobjWhenReturnGate()

        wait(1)
    } else if(isJumpToEntranceByPortal()) {
        print("PostLoadDungeonData from portal")

        local hact = get_player()
        local pos_angle = [4]
        pos_angle = get_portal_warp_pos_angle()

        set_actor_position_angle_y(hact, pos_angle[0], pos_angle[1], pos_angle[2], pos_angle[3])
        idle_actor(hact)

        wait(1)

        reset_party_position()
        __SetGateEventFlag()
        ClearPortalFlag()
    } else if(is_from_save_data()) {
        print("PostLoadDungeonData from save data")
        __SetGateEventFlag()
    } else if(test_flag(358)) {
        __SetGateEventFlag()
        reset_flag(358)
    } else if(test_flag(1002)) {
        reset_flag(1002)
    } else {
        print("PostLoadDungeonData from door or scene selector")

        local hact = get_player()
        local aPos = get_dungeon_start_pos()
        local degree = get_dungeon_start_degree()

        set_actor_position_angle_y(hact, aPos[0], aPos[1], aPos[2], degree)

        wait(1)

        reset_party_position()
    }

    set_party_gravity_scale(1.0)
    target_scene.InitializeMap(true)

    print("PostLoadDungeonData: 03")
    print("PostLoadDungeonData: 04")

    target_scene.InitializeEvent()

    print("PostLoadDungeonData: 05")

    SetLastRoomToEnterWithParty()
    set_enemy_sleep(false)
    start_hiero_item_get_count()

    print("PostLoadDungeonData: 06")

    print("PostLoadDungeonData: test_flag( FLAG_SQID.ENTER_FROM_TOWN ) = " + test_flag(874))
    print("PostLoadDungeonData: get_var( VAR_SQID.GATE_LAST_SCENE ) = " + get_var(99))
    print("PostLoadDungeonData: __GetEnterRandomDungeon() = " + __GetEnterRandomDungeon())
    print("PostLoadDungeonData: get_var( VAR_SQID.GATE_LAST_SLOTID ) = " + get_var(98))
}

function FD01_EventChecker() {
    local area_id = GetCurrentRoomId()
    local arg = false

    if(SpiritMissionStateChecker(39, 2)) {
        SetMissionFlag(1, true)
    }
    if(SpiritMissionStateChecker(102, 1)) {
        set_flag(1558)
        set_flag(1617)
    }

    if(GetFieldChaosStatus()) {
        set_flag(1555)
        set_flag(1627)
        set_flag(1671)
        set_flag(1742)
        set_flag(1745)
    } else {
        reset_flag(1555)
        reset_flag(1627)
        reset_flag(1671)
        reset_flag(1742)
    }

    local prev_scene = get_prev_scene()

    if(prev_scene == 0) {
        SetMissionFlag(1, true)
        set_flag(1555)
        set_flag(1627)
        set_flag(1671)
        set_flag(1742)
        set_flag(1745)

        if(area_id == 2) {
            set_flag(1560)
        }
    }

    set_flag(1601)
    
    if(test_flag(1604)) {
        set_enable_quicksand(false)
        if(area_id == 18) {
            reset_flag(1000)
        } else {
            set_flag(1000)
        }
    }

    if(true) {
        if(area_id == 19 || area_id == 20 || area_id == 26 || area_id == 27 || area_id == 28 || area_id == 29) {
            set_flag(1766)
            set_flag(1763)
            set_flag(1764)
        } else {
            reset_flag(1766)
            reset_flag(1763)
            reset_flag(1764)
        }
    }

    if(test_flag(1560)) {
        change_dungeon_map_room_pattern(3, 13)
    }
}

function FD01_Sand_Depth_Checker() {
    local current_area_id = GetAreaId()

    print("FD01_Sand_Depth_Checker : current_area_id = " + current_area_id)

    if(current_area_id == 5) {
        if(test_flag(1000)) {
            reset_flag(1000)
        }
    } else if(current_area_id == 11 || current_area_id == 12) {
        if(test_flag(1604)) {
            set_enable_quicksand(false)
            set_flag(1000)
        }
    }
}

function FD01_SilentMode_Checker() {
    local current_area_id = GetAreaId()

    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    print("FD01_SilentMode_Checker : current_area_id = " + current_area_id)
    
    if(!test_flag(1613)) {
        if(current_area_id == 11) {
            SilentModeEnd()
        } else if(current_area_id == 18) {
            SilentModeStart()
        }
    }
}
