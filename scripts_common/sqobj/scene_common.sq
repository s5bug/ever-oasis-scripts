// TODO match line infos

class SceneCommon {
    keep_area_id_ = 0
    current_area_id_ = -1
    current_room_id_ = -1
    isBattleRoyalBegins_ = false
    aDungeonAct_hact_ = null
    aCurrentDoor_hact_ = null
    aCurrentDoor_flag_ = null
    aCurrentDoor_type_ = null
    aCurrentDoor_data_ = null
    aCurrentDoor_rmid_ = null
    aOldDoor_hact_ = null
    aOldDoor_flag_ = null
    aOldDoor_type_ = null
    aOldDoor_data_ = null
    aOldDoor_rmid_ = null
    isRandomDungeon_ = false
    isField_ = false
    boss_door_id_ = -1
    ui_initialize_ = 0
    isGateEvent_ = false
    current_scene_ = null
    area_ofs_x_ = 0
    area_ofs_z_ = 0
    aMission_ = null
    last_pop_group_ = -1
    fovy_ = 50.0
    aPop_group_ = null
    aPop_area_ = null
    aSceneData_ = null

    constructor() {
        keep_area_id_ = 0
        current_area_id_ = -1
        current_room_id_ = -1
        isBattleRoyalBegins_ = false
        aDungeonAct_hact_ = {}
        aCurrentDoor_hact_ = array(12, 0)
        aCurrentDoor_flag_ = array(12, 0)
        aCurrentDoor_type_ = array(12, 0)
        aCurrentDoor_data_ = array(12, 0)
        aCurrentDoor_rmid_ = array(12, 0)
        aOldDoor_hact_ = array(12, 0)
        aOldDoor_flag_ = array(12, 0)
        aOldDoor_type_ = array(12, 0)
        aOldDoor_data_ = array(12, 0)
        aOldDoor_rmid_ = array(12, 0)
        isRandomDungeon_ = false
        isField_ = false
        boss_door_id_ = -1
        ui_initialize_ = 0
        isGateEvent_ = false
        current_scene_ = null
        area_ofs_x_ = 0
        area_ofs_z_ = 0
        aMission_ = array(6 + 1, false)
        last_pop_group_ = -1
        fovy_ = 50.0
        aPop_group_ = []
        aPop_area_ = []
        aSceneData_ = []
    }

    function Destroy() {
        keep_area_id_ = 0
        current_area_id_ = -1
        current_room_id_ = -1
        isBattleRoyalBegins_ = false
        aDungeonAct_hact_ = null
        aCurrentDoor_hact_ = null
        aCurrentDoor_flag_ = null
        aCurrentDoor_type_ = null
        aCurrentDoor_data_ = null
        aCurrentDoor_rmid_ = null
        aOldDoor_hact_ = null
        aOldDoor_flag_ = null
        aOldDoor_type_ = null
        aOldDoor_data_ = null
        aOldDoor_rmid_ = null
        isRandomDungeon_ = false
        isField_ = false
        boss_door_id_ = -1
        ui_initialize_ = 0
        isGateEvent_ = false
        current_scene_ = null
        area_ofs_x_ = 0
        area_ofs_z_ = 0
        aMission_ = null
        last_pop_group_ = -1
        fovy_ = 50.0
        aPop_group_ = null
        aPop_area_ = null
        aSceneData_ = null
    }
}

g_scene_common <- null

function init_scene_common() {
    g_scene_common = SceneCommon()
}

function destory_scene_common() {
    g_scene_common.Destroy()
    g_scene_common = null
}

function __GetFovy() {
    return g_scene_common.fovy_;
}

function __SetFovy(value) {
    g_scene_common.fovy_ = value
}

function __ResetFovy() {
    g_scene_common.fovy_ = 50.0
}

function __GetLastGroup() {
    return g_scene_common.last_pop_group_
}

function __SetLastGroup(group_id) {
    g_scene_common.last_pop_group_ = group_id
}

function __SetTargetScene(scene_instance) {
    g_scene_common.current_scene_ = scene_instance
}

function GetTargetScene() {
    return g_scene_common.current_scene_
}

function __SetGateEventFlag() {
    g_scene_common.isGateEvent_ = true
}

function __GetGateEventFlag() {
    return g_scene_common.isGateEvent_
}

function __ModeChangeStartUiInitialize() {
    g_scene_common.ui_initialize_ = 2
}

function __FinishedUiInitialize() {
    g_scene_common.ui_initialize_ = 0
}

function __GetStateOfUiInitialize() {
    return g_scene_common.ui_initialize_
}

function IsUIInitializeState() {
    return g_scene_common.ui_initialize_ == 2
}

function __SetBossDoorId(door_id) {
    g_scene_common.boss_door_id_ = door_id
}

function GetBossDoorId() {
    return g_scene_common.boss_door_id_
}

function __SetEnterRandomDungeon() {
    g_scene_common.isRandomDungeon_ = true
}

function __GetEnterRandomDungeon() {
    return g_scene_common.isRandomDungeon_
}

function __SetEnterField() {
    g_scene_common.isField_ = true
}

function __GetEnterField() {
    return g_scene_common.isField_
}

function GetCurrentDoorHact(door_direction) {
    return g_scene_common.aCurrentDoor_hact_[door_direction]
}

function SetCurrentDoorHact(door_direction, hact) {
    g_scene_common.aCurrentDoor_hact_[door_direction] = hact
}

function GetCurrentDoorFlag(door_direction) {
    return g_scene_common.aCurrentDoor_flag_[door_direction]
}

function SetCurrentDoorFlag(door_direction, flag) {
    g_scene_common.aCurrentDoor_flag_[door_direction] = flag
}

function GetCurrentDoorType(door_direction) {
    return g_scene_common.aCurrentDoor_type_[door_direction]
}

function SetCurrentDoorType(door_direction, type) {
    g_scene_common.aCurrentDoor_type_[door_direction] = type
}

function GetCurrentDoorData(door_direction) {
    return g_scene_common.aCurrentDoor_data_[door_direction]
}

function SetCurrentDoorData(door_direction, data) {
    g_scene_common.aCurrentDoor_data_[door_direction] = data
}

function GetCurrentDoorRoomId(door_direction) {
    return g_scene_common.aCurrentDoor_rmid_[door_direction]
}

function SetCurrentDoorRoomId(door_direction, data) {
    g_scene_common.aCurrentDoor_rmid_[door_direction] = data
}

function GetOldDoorHact(door_direction) {
    return g_scene_common.aOldDoor_hact_[door_direction]
}

function SetOldDoorHact(door_direction, hact) {
    g_scene_common.aOldDoor_hact_[door_direction] = hact
}

function GetOldDoorFlag(door_direction) {
    return g_scene_common.aOldDoor_flag_[door_direction]
}

function SetOldDoorFlag(door_direction, flag) {
    g_scene_common.aOldDoor_flag_[door_direction] = flag
}

function GetOldDoorType(door_direction) {
    return g_scene_common.aOldDoor_type_[door_direction]
}

function SetOldDoorType(door_direction, type) {
    g_scene_common.aOldDoor_type_[door_direction] = type
}

function GetOldDoorData(door_direction) {
    return g_scene_common.aOldDoor_data_[door_direction]
}

function SetOldDoorData(door_direction, data) {
    g_scene_common.aOldDoor_data_[door_direction] = data
}

function GetOldDoorRoomId(door_direction) {
    return g_scene_common.aOldDoor_rmid_[door_direction]
}

function SetOldDoorRoomId(door_direction, data) {
    g_scene_common.aOldDoor_rmid_[door_direction] = data
}

function GetKeepAreaId() {
    return g_scene_common.keep_area_id_
}

function SetKeepAreaId(area_id) {
    g_scene_common.keep_area_id_ = area_id
}

function GetAreaId() {
    return g_scene_common.current_area_id_
}

function __SetAreaId(area_id) {
    g_scene_common.current_area_id_ = area_id
}

function GetCurrentRoomId() {
    return g_scene_common.current_room_id_
}

function SetCurrentRoomIdAndAreaId(room_id) {
    print("SetCurrentRoomIdAndAreaId: room_id = " + room_id)
    print("SetCurrentRoomIdAndAreaId: Wait Dungeon Load ... ")

    if(is_active_dungeon_exist() == false) {
        func_wait(is_active_dungeon_exist)
    }

    local origin_room_id = get_origin_room_id(room_id)

    print("SetCurrentRoomIdAndAreaId: origin_room_id = " + origin_room_id)

    g_scene_common.current_room_id_ = origin_room_id

    local unit_id = get_dungeon_unit_index_by_room(GetCurrentRoomId())
    if(unit_id != -1) {
        set_unit_id_to_group_manager(unit_id)
    }
    
    local next_area_id = get_area_id_by_room_id(origin_room_id)
    __SetAreaId(next_area_id)
}

function SetCurrentRoomIdByAreaId(area_id) {
    print("SetCurrentRoomIdByAreaId: area_id = " + area_id)

    __SetAreaId(area_id)

    local room_id = GetRoomNumberForProgram(area_id)
    local origin_room_id = get_origin_room_id(room_id)
    print("SetCurrentRoomIdByAreaId: room_id = " + room_id)
    print("SetCurrentRoomIdByAreaId: origin_room_id = " + origin_room_id)

    g_scene_common.current_room_id_ = origin_room_id

    local unit_id = get_dungeon_unit_index_by_room(GetCurrentRoomId())

    if(unit_id != -1) {
        set_unit_id_to_group_manager(unit_id)
    }
}

function SetBattleRoyalBegins(flag) {
    print("SetBattleRoyalBegins:" + flag)

    g_scene_common.isBattleRoyalBegins_ = flag
}

function isBattleRoyalBegins() {
    return g_scene_common.isBattleRoyalBegins_;
}

function GetDungeonHact(area_id, act_index) {
    if(area_id < 0 || act_index < 0) {
        return 0
    }

    return g_scene_common.aDungeonAct_hact_[area_id][act_index];
}

function SetDungeonHact(area_id, act_index, hact) {
    if(!(area_id in g_scene_common.aDungeonAct_hact_)) {
        g_scene_common.aDungeonAct_hact_[area_id] <- {}
    }

    if(!(act_index in g_scene_common.aDungeonAct_hact_[area_id])) {
        g_scene_common.aDungeonAct_hact_[area_id][act_index] <- hact
    } else {
        g_scene_common.aDungeonAct_hact_[area_id][act_index] = hact
    }
}

function GAO_X() {
    return g_scene_common.area_ofs_x_;
}

function GAO_Z() {
    return g_scene_common.area_ofs_z_;
}

function __SetAreaOffset_X(ofsX) {
    g_scene_common.area_ofs_x_ = ofsX
}

function __SetAreaOffset_Z(ofsZ) {
    g_scene_common.area_ofs_z_ = ofsZ
}

function SetMissionFlag(mission_id, isFlag) {
    g_scene_common.aMission_[mission_id] = isFlag
}

function GetMissionFlag(mission_id) {
    return g_scene_common.aMission_[mission_id];
}

function UpDateAreaOffset(area_id) {
    local position = GetAreaCenterPos(area_id)

    print("■■■■■■■■■ UpDateAreaOffset : GAO ( GetAreaOffset ) ■■■■■■■■■" + position[0])
    print("UpDateAreaOffset : position_X = " + position[0])
    print("UpDateAreaOffset : position_Z = " + position[2])

    __SetAreaOffset_X(position[0])
    __SetAreaOffset_Z(position[2])
}

function InitializeElements(scene_instance) {
    local target_scene = scene_instance

    __SetTargetScene(target_scene)

    if(!__GetEnterRandomDungeon() && !__GetEnterField()) {
        InitializeVariable()
    } else {
        set_flag(98)
        target_scene.InitializeLoadResources()
        InitializeCreateSwitch()
        InitializeMakeParty()
        target_scene.InitializeEnemyGroup()
        setup_enemygroup_for_quest()
    }

    target_scene.InitializeNpcResources()
    set_flag(813)
    __FinishedUiInitialize()
    reset_date_notification(1, 0)
    set_date_notification(1)
}

function LoadResources(aResources) {
    for(local i = 0; i < aResources.len() - 1; i = i + 2) {
        load_actor_archive(aResources[i], aResources[i + 1])
    }
    func_wait(is_archive_loaded)
}

function InitializeVariable() {
    
}

function __isCheckedLastScene() {
    print("__isCheckedLastScene: test_flag( FLAG_SQID.ENTER_FROM_TOWN ) = " + test_flag(874))
    print("__isCheckedLastScene: get_var( VAR_SQID.GATE_LAST_SCENE ) = " + get_var(99))
    print("__isCheckedLastScene: __GetEnterRandomDungeon() = " + __GetEnterRandomDungeon())
    print("__isCheckedLastScene: get_var( VAR_SQID.GATE_LAST_SLOTID ) = " + get_var(98))

    local from_town_gate = is_from_town_gate()
    if(from_town_gate) {
        __SetGateEventFlag()
    }
    return from_town_gate;
}

function __DestoryContactBgobjWhenReturnGate() {
    local hplayer = get_party_order(0)
    local h_p01 = get_party_order(1)
    local h_p02 = get_party_order(2)

    wait(1)

    destory_bgobj_when_return_gate(get_actor_position(hplayer))
    
    if(h_p01 != 0) {
        destory_bgobj_when_return_gate(get_actor_position(h_p01))
    }
    if(h_p02 != 0) {
        destory_bgobj_when_return_gate(get_actor_position(h_p02))
    }

    wait(1)
}

function __MoveToDestination() {
    local hplayer = get_party_order(0)
    local p01_hact = get_party_order(1)
    local p02_hact = get_party_order(2)

    local aPos = array(12, 0.0)

    print("__MoveToDestination: get_var( VAR_SQID.GATE_LAST_ROOM ) =  " + get_var(97))
    print("__MoveToDestination: get_var( VAR_SQID.GATE_LAST_SLOTID ) =  " + get_var(98))
    print("__MoveToDestination: get_var( VAR_SQID.GATE_LAST_SCENE ) =  " + get_var(99))
    print("__MoveToDestination: test_flag( FLAG_SQID.ENTER_FROM_FIELDS ) =  " + test_flag(873))
    print("__MoveToDestination: test_flag( FLAG_SQID.ENTER_FROM_TOWN ) =  " + test_flag(874))
    print("__MoveToDestination: test_flag( FLAG_SQID.OPENED_GATE ) =  " + test_flag(875))

    for(local i = 0; i < 4; i++) {
        aPos[i] = get_var(85 + i)
        print("__MoveToDestination: aPos[i] =  " + aPos[i])
    }

    wait(1)

    set_actor_position_angle_y(hplayer, aPos[0], aPos[1], aPos[2], aPos[3])

    if(p01_hact != 0) {
        local pos_angle = get_return_pos_of_aqua_gate(p01_hact)
        set_actor_position_angle_y(p01_hact, pos_angle[0], pos_angle[1], pos_angle[2], pos_angle[3], 1)
    }

    if(p02_hact != 0) {
        local pos_angle = get_return_pos_of_aqua_gate(p02_hact)
        set_actor_position_angle_y(p02_hact, pos_angle[0], pos_angle[1], pos_angle[2], pos_angle[3], 1)
    }
}

function ResetFieldFlagVarWhenCleared() {
    reset_flag(501)
    reset_flag(502)
    reset_flag(873)
    reset_flag(874)
}

function GetAreaCenterPos(area_id) {
    print("<<< GetAreaCenterPos : area_id = " + area_id + " >>>")

    if(area_id <= -1) {
        area_id = GetAreaId()
        print("<<< GetAreaCenterPos : GetAreaId() >> area_id = " + area_id + " >>>")
        if(area_id <= 0) {
            print("<<< GetAreaCenterPos : 正しい area_id が求まりません >>>")
        }
    }

    local room_id = GetRoomNumberForProgram(area_id)
    local aPos = null

    aPos = get_dungeon_parts_position(room_id)
    return aPos;
}

function PopProcess(area_id) {
    PopProcessMain(area_id, 0)
}

function PopProcessNoEnemyPop(area_id) {
    PopProcessMain(area_id, -1)
}

function PopProcessEnemyOnly(area_id) {
    PopProcessMain(area_id, -2)
}

function PopProcessEnemyOnlyWithFlag(area_id, flag) {
    if(test_flag(flag)) {
        return;
    }
    
    set_flag(flag)
    PopProcessMain(area_id, -2)
}

function PopProcessMain(area_id, type) {
    print("[ !!!!!  PopProcessMain : type = " + type + "  !!!!! ]")

    local target_scene = GetTargetScene()
    local aGroup_id = null
    if(type == -2) {
        print("[ !!!!!  PopProcessMain : 01  !!!!! ]")
        aGroup_id = DepopAreaManager(area_id)
        if(aGroup_id[0] != -1 && CheckPopedEnemyOfArea(area_id) == -1) {
            CallPopGroup(area_id, aGroup_id)
        }
    } else if(GetKeepAreaId() != area_id) {
        print("[ !!!!!  PopProcessMain : 02  !!!!! ]")
        __SetAreaId(area_id)
        PopAreaObjectCommon(area_id)
        if(type != -3) {
            aGroup_id = DepopAreaManager(area_id)
            if(aGroup_id[0] != -1 && type > -1 && CheckPopedEnemyOfArea(area_id) == -1) {
                CallPopGroup(area_id, aGroup_id)
            }
        }
        SetKeepAreaId(area_id)
    } else {
        print("[ !!!!!  Already entered same area  !!!!! ]")
    }
}

function PopAreaObjectCommon(area_id) {
    local target_scene = GetTargetScene()

    print("[ !!!!!  PopAreaObjectCommon   keep_area_id_ = " + GetKeepAreaId() + " !!!!! ]")
    print("[ !!!!!  PopAreaObjectCommon   area_id = " + area_id + " !!!!! ]")

    local prev_area_id = GetKeepAreaId()
    if(prev_area_id == -1) {
        return;
    }

    AreaActorDelete(prev_area_id)
    DestroyAllBgobjActors(prev_area_id)
    target_scene.PopAreaObject(area_id)
}

function PopProcessInDungeon(area_id) {
    __SetAreaId(area_id)
    PopAreaObjectCommon(area_id)
    depop_enemy_outside_area(area_id)
    pop_enemy_inside_area(area_id)
    SetKeepAreaId(area_id)
}

function AreaActorDelete(area_id) {
    if(!(area_id in g_scene_common.aDungeonAct_hact_)) {
        return;
    }

    foreach(hact in g_scene_common.aDungeonAct_hact_[area_id]) {
        if(hact > 0) {
            destroy_actor(hact)
        }
    }
}

function SwitchChangedProccess(switch_id) {
    local isCheck = false
    if(!isSwitchOn(switch_id)) {
        isCheck = true
    }
    return isCheck;
}

function GetPopGroup(area_id) {
    local target_scene = GetTargetScene()
    local group_id = -1

    print("[ !!!!!!!! GetPopGroup : area_id = " + area_id + " !!!!!!!! ]")

    group_id = target_scene.PopAreaManager(area_id)

    if(group_id == null) {
        group_id = [-1]
    } else if(type(group_id) == "array" && group_id.len() <= 0) {
        group_id = [-1]
    }

    local aGroup_id = ConvertIntoArray(group_id)
    return aGroup_id;
}

function DepopAreaManager(area_id) {
    local aGroup_id = GetPopGroup(area_id)

    print("[ !!!!!!!! DepopAreaManager   aGroup_id = " + aGroup_id + " !!!!!!!! ]")

    if(get_scene_type() == 5) {
        DestroyEnemyGroupBeingOutsideTheArea(area_id)
    } else if(aGroup_id[0] != -1 && CheckPopedEnemyGroup()) {
        DestroyEnemyGroupBeingOutsideTheArea(area_id)
    }
    return aGroup_id;
}

function DestroyAreaManager(area_id) {
    local aGroup_id = GetPopGroup(area_id)

    print("[ !!!!!!!! DestroyAreaManager   aGroup_id = " + aGroup_id + " !!!!!!!! ]")

    if(get_scene_type() == 5) {
        DestroyEnemyGroupBeingOutsideTheAreaForce(area_id)
    } else if(aGroup_id[0] != -1 && CheckPopedEnemyGroup()) {
        DestroyEnemyGroupBeingOutsideTheAreaForce(area_id)
    }
    return aGroup_id;
}

function CreateEnemyGroupWithArray(area_id, aGroup_id) {
    local isCheck = false

    for(local i = 0; i < aGroup_id.len(); i++) {
        print("[ !!!!!!!! CreateEnemyGroupWithArray   aGroup_id[i] = " + aGroup_id[i] + " !!!!!!!! ]")

        if(aGroup_id[i] > 0 && __GetAreaOfPopedEnemy(aGroup_id[i]) == -1) {
            __SetLastGroup(aGroup_id[i])
            g_scene_common.aPop_group_.append(aGroup_id[i])
            g_scene_common.aPop_area_.append(area_id)
            create_actor_from_enemygroup(aGroup_id[i])

            isCheck = true
        }
    }

    return isCheck;
}

function DestroyEnemyGroupBeingOutsideTheArea(area_id) {
    local count = 0

    depop_enemy_outside_area(area_id)
    for(local i = 0; i < g_scene_common.aPop_group_.len(); i++) {
        if(area_id != g_scene_common.aPop_area_[i] && g_scene_common.aPop_group_[i] != 0) {
            g_scene_common.aPop_group_.remove(i)
            g_scene_common.aPop_area_.remove(i)
            i = i - 1

            count++
        }
    }

    return count;
}

function DestroyEnemyGroupBeingOutsideTheAreaForce(area_id) {
    print("[!!!!!!!!!!!!!!!!!!!!!!!!!! DestroyEnemyGroupBeingOutsideTheAreaForce !!!!!!!!!!!!!!!!!!!!!!!!!!]")

    local count = 0

    destroy_enemy_outside_area(area_id)
    for(local i = 0; i < g_scene_common.aPop_group_.len(); i++) {
        if(area_id != g_scene_common.aPop_area_[i] && g_scene_common.aPop_group_[i] != 0) {
            g_scene_common.aPop_group_.remove(i)
            g_scene_common.aPop_area_.remove(i)
            i = i - 1

            count++
        }
    }

    return count;
}

function CheckPopedEnemyGroup() {
    local count = 0

    for(local i = 0; i < g_scene_common.aPop_group_.len(); i++) {
        if(g_scene_common.aPop_group_[i] != 0) {
            count++
        }
    }

    return count;
}

function __GetAreaOfPopedEnemy(group_id) {
    for(local i = 0; i < g_scene_common.aPop_group_.len(); i++) {
        if(group_id == g_scene_common.aPop_group_[i]) {
            return g_scene_common.aPop_area_[i];
        }
    }
    return -1;
}

function CheckPopedEnemyOfArea(area_id) {
    for(local i = 0; i < g_scene_common.aPop_group_.len(); i++) {
        if(area_id == g_scene_common.aPop_area_[i]) {
            return g_scene_common.aPop_group_[i];
        }
    }
    return -1;
}

function CheckLivingEnemyOfArea(area_id) {
    for(local i = 0; i < g_scene_common.aPop_group_.len(); i++) {
        if(area_id == g_scene_common.aPop_area_[i] &&
            get_rest_enemy_num_in_group(g_scene_common.aPop_group_[i]) != 0) {
            return g_scene_common.aPop_group_[i];
        }
    }
    return -1;
}

function SetGroup(group_id) {
    local check_id = ConvertIntoArray(group_id)
    local check_group = 0

    for(local i = 0; i < check_id.len(); i++) {
        check_enemy_respawn(check_id[i])
        if(get_rest_enemy_num_in_group(check_id[i]) != 0) {
            check_group++
        }
    }

    if(check_group > 0) {
        return true;
    }

    return false;
}

function ConvertIntoArray(arg) {
    local arg_type = type(arg)
    local aArray = null

    if(arg_type == "array") {
        if(arg.len() == 0) {
            print("ERROR:ConvertIntoArray 空の配列を返しています。")
        }
        aArray = arg
    } else {
        aArray = [arg]
    }

    return aArray;
}

function NextPopGroupChecker(hact, group_id, rest_group_member_num) {
    print("[ !!!!!!!! NextPopGroupChecker    hact =" + hact +
        " group_id = " + group_id +
        " rest_group_member_num = " + rest_group_member_num)
    
    local part = get_actor_part(hact)
    if(part == 4) {
        if(group_id == -1) {
            print("\n!!!! 敵グループのIDが不正です。開発用シーン以外ではバグとしてご報告下さい。 !!!!\n")
        }
    }

    return NextPopGroupCheckerCore(hact, group_id, rest_group_member_num);
}

function NextPopGroupCheckerFromEnemyGenerator(hact) {
    print("[ !!!!!!!! NextPopGroupCheckerFromEnemyGenerator    hact =" + hact)

    local group_id = get_enemygroup_by_generator(hact)
    local rest_group_member_num = get_rest_enemy_num_in_group(group_id)

    return NextPopGroupCheckerCore(hact, group_id, rest_group_member_num);
}

function NextPopGroupCheckerFromEnemyGeneratorCallLifeZero(hact) {
    print("[ !!!!!!!! NextPopGroupCheckerFromEnemyGeneratorCallLifeZero    hact =" + hact)

    local group_id = get_enemygroup_by_generator(hact)
    local rest_group_member_num = get_rest_enemy_num_in_group(group_id)

    print("[ !!!!!!!! NextPopGroupCheckerCore    hact =" + hact +
        "group_id = " + group_id +
        " rest_group_member_num = " + rest_group_member_num)
    
    local target_scene = GetTargetScene()

    if(group_id != -1) {
        local area_id = __GetAreaOfPopedEnemy(group_id)
        local living_group = CheckLivingEnemyOfArea(area_id)

        print("[ !!!!!!!! NextPopGroupCheckerCore    area_id =" + area_id +
            "  living_group = " + living_group +
            "  group_id = " + group_id +
            " rest_group_member_num = " + rest_group_member_num)
        
        target_scene.LifeZeroEventChecker(hact, rest_group_member_num, group_id)
        target_scene.DestroyEventChecker(hact, rest_group_member_num, group_id)

        if(living_group == -1 && area_id != -1) {   
            local aNext_group_id = GetPopGroup(area_id)

            print("[ !!!!!!!! Destroy !!!!!!!! ]   group_id = " + group_id)
            print("[ !!!!!!!! aNext_group_id[0] = " + aNext_group_id[0] + " !!!!!!!! ]")

            if(aNext_group_id[0] != -1) {
                CallPopGroup(area_id, aNext_group_id)
            }

            return true;
        } else {
            print("[ !!!!!!!! Not Yet !!!!!!!!  living_group = " + living_group + " ]" +
                " group_id = " + group_id)
        }
    } else {
        if(target_scene != null) {
            print("[ !!!!!!!! Not ENEMY !!!!!!!!   " + group_id + " ]")

            target_scene.BGObjectDeadChecker(hact)
        }
    }
    return false;
}

function NextPopGroupCheckerCore(hact, group_id, rest_group_member_num) {
    print("[ !!!!!!!! NextPopGroupCheckerCore    hact =" + hact +
        "group_id = " + group_id +
        " rest_group_member_num = " + rest_group_member_num)
    
    local target_scene = GetTargetScene()

    if(group_id != -1) {
        local area_id = __GetAreaOfPopedEnemy(group_id)
        local living_group = CheckLivingEnemyOfArea(area_id)

        print("[ !!!!!!!! NextPopGroupCheckerCore    area_id =" + area_id +
            "  living_group = " + living_group +
            "  group_id = " + group_id +
            " rest_group_member_num = " + rest_group_member_num)
        
        target_scene.DestroyEventChecker(hact, rest_group_member_num, group_id)

        if(living_group == -1 && area_id != -1) {   
            local aNext_group_id = GetPopGroup(area_id)

            print("[ !!!!!!!! Destroy !!!!!!!! ]   group_id = " + group_id)
            print("[ !!!!!!!! aNext_group_id[0] = " + aNext_group_id[0] + " !!!!!!!! ]")

            if(aNext_group_id[0] != -1) {
                CallPopGroup(area_id, aNext_group_id)
            }

            return true;
        } else {
            print("[ !!!!!!!! Not Yet !!!!!!!!  living_group = " + living_group + " ]" +
                " group_id = " + group_id)
        }
    } else {
        if(target_scene != null) {
            print("[ !!!!!!!! Not ENEMY !!!!!!!!   " + group_id + " ]")

            target_scene.BGObjectDeadChecker(hact)
        }
    }
    return false;
}

function CallPopGroup(area_id, aGroup_id) {
    local aCheck_arg = ConvertIntoArray(aGroup_id)
    local target_scene = GetTargetScene()

    if(CreateEnemyGroupWithArray(area_id, aCheck_arg)) {
        print("[ !!!!!!!! CallPopGroup !!!!!!!!   Succeed create enemy! ]")
    } else {
        print("[ !!!!!!!! CallPopGroup !!!!!!!!   Fail create enemy! ]")
    }

    target_scene.PopEventChecker(area_id, aCheck_arg)
}

function CallPopGroupWithFlag(aGroup_id, flag) {
    if(test_flag(flag)) {
        return;
    }

    set_flag(flag)

    CallPopGroup(GetAreaId(), aGroup_id)
}

function AllowPopGroup(aGroup_id) {
    local group_id_array = ConvertIntoArray(aGroup_id)

    for(local i = 0; i < group_id_array.len(); i++) {
        allow_pop_to_enemy_group(group_id_array[i])
    }
}

function PadOffWait(frame) {
    SuspendTime()
    set_demo_event_sync()

    print("PadOffWait : Done")

    if(frame > 0) {
        wait(frame)
    }
}

function PadOnWait(frame) {
    if(frame > 0) {
        wait(frame)
    }
    ManageTheStateOfThePartyForEvent()

    print("PadOnWait : Done")

    ResumeTime()
    set_demo_event(false)
}

function ShutInBattleStart() {
    ShutInBattleStartMain(0)
}

function ShutInBattleStartField() {
    ShutInBattleStartMain(1)
}

function ShutInBattleStartBoss() {
    ShutInBattleStartMain(2)
}

function ShutInBattleStartFieldBoss() {
    ShutInBattleStartMain(3)
}

function ShutInBattleStartForLastDungeon() {
    ShutInBattleStartMain(3)
}

function ShutInBattleStartMain(type) {
    print("scene_common::ShutInBattleStartMain [type:" + type + "]")

    if(type == 0 || type == 2) {
        set_flag(1023)
        update_room_scene_env()
    }

    set_chaos_lock_gate(true)

    if(type != 2 && type != 3) {
        if(is_playing_battlebgm()) {
            pop_bgm(0)
        }
        push_bgm(0x100001E)
    }
}

function ShutInBattleEnd() {
    ShutInBattleEndMain(0)
}

function ShutInBattleEndField() {
    ShutInBattleEndMain(1)
}

function ShutInBattleEndBoss() {
    ShutInBattleEndMain(2)
}

function ShutInBattleEndFieldBoss() {
    ShutInBattleEndMain(3)
}

function ShutInBattleEndForLastDungeon() {
    ShutInBattleEndMain(4)
}

function ShutInBattleEndMain(type) {
    print("scene_common::ShutInBattleEndMain [type:" + type + "]")

    if(type == 0 || type == 2 || type == 4) {
        reset_flag(1023)
        update_room_scene_env()
    }

    if(type != 4) {
        set_chaos_lock_gate(false)
    }

    if(type != 2 && type != 3) {
        pop_bgm(0x1E)
    }
}

function ShutInBattleStartTriChaos() {
    if(is_playing_battlebgm()) {
        pop_bgm(0)
    }

    push_bgm(0x1000034)
}

function ShutInBattleEndTriChaos() {
    pop_bgm(0x1E)
}

function SilentModeStart() {
    set_bgm_volume(0.2, 45)
}

function SilentModeEnd() {
    set_bgm_volume(1.0, 45)
}

function EventStart(mode) {
    switch(mode) {
        case 0:
            PadOffWait(0)
            ui_push_env(0)
            black_mask_d_start()
            ui_map_hide(true)
            break;
        case 3:
            ui_push_env(0)
            black_mask_d_start()
            ui_map_hide(true)
            break;
        case 1:
            break;
        default:
            ui_push_env(2)
            ui_map_hide(true)
            break;
    }
}

function EventEnd() {
    ui_pop_env()
    black_mask_d_end()
    ui_map_hide(false)
    PadOnWait(0)
}

function EventContinue() {
    black_mask_d_end()
    ui_map_hide(false)
}

function ChangeSceneForTag(scene, tag_point_id) {
    fadeout_sync(0, 0, 1.0)
    request_jump_scene_tag(scene, tag_point_id, 0)
}

function SetPlayerPosition(x, y, z, rotY) {
    local hplayer = get_player()

    set_actor_position_with_hitbgobj(hplayer, x, y, z, 0)
    set_actor_angleY(hplayer, rotY)

    wait(1)

    reset_party_position()
}

function FinalizePartyControll() {

}

function CheckSwitchObj(sw_hact) {
    local result = get_switch_state(sw_hact, 0)
    return result;
}

function isJumpToEntrance() {
    return test_flag(873);
}

function isJumpToEntranceByPortal() {
    return test_flag(2025);
}

function ClearGateFlagProcess() {
    if(test_flag(873)) {
        reset_flag(873)
    }

    if(test_flag(502)) {
        ResetFieldFlagVarWhenCleared()
    }
}

function ClearPortalFlag() {
    reset_flag(2025)
}

function GateWarp() {
    set_flag(874)
    reset_flag(875)

    local hact = get_party_order(0)

    start_actor_motion(hact, 1787)
    wait(15)
    play_se(0x1000085)
    clear_fade_info()
    fadeout(0, 0, 2.0, 0, 1)
    const neg7 = -7
    wait(neg7)
    request_jump_scene(get_var(99), 0.0, 0.0, 0.0, 0.0, 0)
}

function PortalProsess(db_key, is_from_town) {
    local result = [2]

    ui_push_env(2)
    ui_activate(51, [db_key])
    ui_wait(51)
    ui_pop_env()

    result = get_ui_results(51)

    end_portal_pause()
    if(result[0] == 1) {
        if(is_from_town == true) {
            start_actor_motion(get_party_order(0), 1787)
        } else {
            local party_count = get_party_count()
            for(local i = 0; i < party_count; ++i) {
                local hact = get_party_order(i)
                start_actor_motion(hact, 1787)
            }
        }
        wait(15)
        portal_warp(result[1])
        return true;
    } else if(result[0] == 2) {
        GateWarp()
        return true;
    }
    return false;
}

function CreateRoomObj(area_id, posX, posY, posZ, angle, scale, act_index, act_type, obj_id, opt) {
    CreateRoomObjMain(area_id, posX, posY, posZ, angle, scale, act_index, act_type, obj_id, opt, true)
}

function CreateRoomObjNoCollision(area_id, posX, posY, posZ, angle, scale, act_index, act_type, obj_id, opt) {
    CreateRoomObjMain(area_id, posX, posY, posZ, angle, scale, act_index, act_type, obj_id, opt, false)
}

function CreateRoomObjMain(area_id, posX, posY, posZ, angle, scale, act_index, act_type, obj_id, opt, isCollision) {
    if(__GetStateOfUiInitialize() != 0) {
        return false;
    }

    local dbkey = get_dbkey_by_charaId(obj_id)
    local hact = 0
    if(dbkey == -1) {
        hact = create_temp_actor(obj_id, posX, posY, posZ, angle, isCollision, opt)
    } else {
        hact = create_actor(dbkey, 1, posX, posY, posZ, angle, isCollision)
    }

    set_actor_scale(hact, scale, scale, scale)

    print("<<< CreateRoomObjMain   hact = " + hact + " >>>")

    SetDungeonHact(area_id, act_index, hact)
    return true;
}

function ChangeRoomForDungeonMain(next_area_id, prev_phantom_id, type, camera_event = null, camera_event_mode = 0, prev_area_id = -1) {
    if(next_area_id <= 0) {
        warning("ERROR:ChangeRoomForDungeonMain 次の部屋番号が0以下です")
        return;
    }

    local isChangeRoom = __GetEnterRandomDungeon() && prev_phantom_id >= 0
    if(isChangeRoom == false) {
        print("ERROR:ChangeRoomForDungeonMain ダンジョンではないか、前の部屋のファントムIDが不正です")
        return;
    }

    local target_scene = GetTargetScene()

    UpDateAreaOffset(next_area_id)
    set_enable_room(-2)
    SetCurrentRoomIdByAreaId(next_area_id)
    PopAreaDoorCommon(target_scene, next_area_id)

    if(camera_event != null) {
        if(camera_event.camera_fade_enable_[camera_event_mode]) {
            camera_event.FadeOut(camera_event_mode)
        }
    }

    set_nextroom_sceneenv(prev_phantom_id)

    local next_room_id = load_next_room(prev_phantom_id)

    func_wait(is_room_loaded)

    local next_direction = -1
    if(prev_area_id > 0) {
        target_scene.ChengeRoomEventDuringFade(prev_area_id, next_direction)
    }

    target_scene.PopObjectWhenDoorOpened(next_area_id)
    if(camera_event != null) {
        if(camera_event_mode == 0) {
            camera_event.DoBeginEventAction()
        } else {
            camera_event.DoEndEventAction()
        }
    }

    shift_current_room_id(next_room_id)
    InitializeBgobjAfterCreate(next_area_id)
    SetRouteIdToPartyAI_InArea(next_area_id)
    if(type == 0) {
        ManageTheStateOfTheParty()
    }

    target_scene.ChengeRoomEvent(next_area_id, -1)
    set_enable_room(next_room_id)
}

function ChangeRoomForEventJump(next_area_id) {
    if(next_area_id <= 0) {
        warning("ERROR:ChangeRoomForEventJump 次の部屋番号が0以下です")
        return;
    }

    local pos = get_room_switch_phantom_pos_by_area_id(next_area_id)
    if(pos == null) {
        warning("ERROR:ChangeRoomForEventJump 行き先座標が取得できませんでした")
        return;
    }

    PadOffWait(0)
    fadeout_sync(0, 0, 0.25)
    init_petit()

    local target_scene = GetTargetScene()

    local prev_boss_area_type = get_boss_area_type(GetAreaId())
    local zone_id = get_zone_id()
    if(zone_id == 24) {
        ChangeEnemyResource_FD05(next_area_id)
    } else {
        ChangeEnemyResource(next_area_id, prev_boss_area_type)
    }

    UpDateAreaOffset(next_area_id)
    wait(1)
    SetCurrentRoomIdByAreaId(next_area_id)
    PopAreaDoorCommon(target_scene, next_area_id)
    set_nextroom_sceneenv_by_area_id(next_area_id)
    load_next_room_by_area_id(next_area_id)
    func_wait(is_room_loaded)
    func_wait(is_archive_loaded)
    target_scene.PopObjectWhenDoorOpened(next_area_id)
    InitializeBgobjAfterCreate(next_area_id)
    SetRouteIdToPartyAI_InArea(next_area_id)

    local hact_player = get_party_order(0)

    set_actor_position_angle_y(hact_player, pos[0], pos[1], pos[2], 180)
    wait(1)
    reset_party_position()
    shift_current_room_id(GetCurrentRoomId())
    ResetToBehindCamera(0)
    fadein(0, 0, 0.25)
    PadOnWait(0)
}

function ChangeEnemyResource(next_area_id, prev_boss_area_type) {
    local isBossArea = false
    if(prev_boss_area_type == 1) {
        return isBossArea
    }

    local target_scene = GetTargetScene()
    local boss_area_type = get_boss_area_type(next_area_id)

    if(boss_area_type == 1 && !target_scene.CurrentArchiveGroupIs(3)) {
        DestroyEnemyGroupBeingOutsideTheAreaForce(next_area_id)
        wait(1)

        isBossArea = true

        destroy_archive_group_member(0)
        target_scene.LoadResourceArchive(3)
    } else if(boss_area_type == 2 && !target_scene.CurrentArchiveGroupIs(4)) {
        DestroyEnemyGroupBeingOutsideTheAreaForce(next_area_id)
        wait(1)

        destroy_archive_group_member(0)
        target_scene.LoadResourceArchive(4)
    } else if(!target_scene.CurrentArchiveGroupIs(0)) {
        DestroyEnemyGroupBeingOutsideTheAreaForce(next_area_id)
        wait(1)

        target_scene.LoadResourceArchive(0)
    }

    return isBossArea;
}

function ChangeEnemyResource_FD05(next_area_id) {
    local target_scene = GetTargetScene()
    local require_archive_group = 0

    switch(next_area_id) {
        case 7:
            if(!test_flag(567)) {
                require_archive_group = 2
            }
            break;
        case 10:
            if(!test_flag(568)) {
                require_archive_group = 4
            }
            break;
        case 14:
            if(!test_flag(569)) {
                require_archive_group = 3
            }
            break;
        default:
            require_archive_group = 0
            break;
    }

    if(!target_scene.CurrentArchiveGroupIs(require_archive_group)) {
        DestroyEnemyGroupBeingOutsideTheAreaForce(next_area_id)
        wait(1)

        destroy_archive_group_member(0)
        target_scene.LoadResourceArchive(require_archive_group)
    }

    return false;
}

function ManageTheStateOfTheParty() {
    if(GetAreaId() == get_var(80)) {
        print("ManageTheStateOfTheParty PlayerMakesParty")
        PlayerMakesParty()
        return true;
    } else if(!isPlayerAlone()) {
        print("ManageTheStateOfTheParty PlayerActsAlone")
        PlayerActsAlone()
    }
    return false;
}

function ManageTheStateOfThePartyForEvent() {
    if(isPlayerAlone()) {
        print("ManageTheStateOfThePartyForEvent PlayerActsAlone")
        PlayerActsAlone()
    }
}

function SetLastRoomToEnterWithParty() {
    if(!isPlayerAlone()) {
        set_var(80, GetAreaId())
    }
}

function AiSleepForSwitch(hact) {
    AiSleepToCompare(hact, true, true, true)
}

function AiWakeUpForSwitch(hact) {
    AiSleepToCompare(hact, false, true, true)
}

function PlayerActsAlone() {
    print("PlayerActsAlone set_falg")
    set_flag(812)
    AiSleepToCompare(get_player(), true, true, false)

    local p01_hact = get_party_order(1)
    local p02_hact = get_party_order(2)
    local aPos = null

    if(p01_hact != 0) {
        aPos = get_actor_position(p01_hact)
        set_actor_position(p01_hact, aPos[0], aPos[1], aPos[2], 0)
    }

    if(p02_hact != 0) {
        aPos = get_actor_position(p02_hact)
        set_actor_position(p02_hact, aPos[0], aPos[1], aPos[2], 0)
    }
}

function PlayerActsAloneSameRoom() {
    AiSleepToCompare(get_player(), true, false, true)
}

function PlayerMakesParty() {
    print("PlayerMakesParty reset_flag")
    reset_flag(812)

    AiSleepToCompare(get_player(), false, true, true)
}

function isPlayerAlone() {
    return test_flag(812)
}

function AiSleepToCompare(hact, flag, mode, isColision) {
    print("<<< AiSleepToCompare : ( hact = " + hact + " ) >>>")
    print("<<< AiSleepToCompare : ( isColision = " + isColision + " ) >>>")

    local change_flag = false
    if(!flag) {
        change_flag = true
    } else if(mode != true) {
        change_flag = true
    }
    
    set_player_sleep(1, flag, isColision)
    set_player_sleep(2, flag, isColision)
    set_player_change(get_party_order(1), change_flag)
    set_player_change(get_party_order(2), change_flag)
}

function SC_GetDoorApperPosition(party0, party1, party2, door_hactor) {
    if(door_hactor == 0) {
        return false;
    }

    const neg25f = -25.0
    local base_pos = get_actor_position(door_hactor)
    local rot_y = get_actor_angle_y(door_hactor)

    local offset = vector_rotate_y([0.0, 0.0, neg25f], rot_y)
    party0[0] = base_pos[0] + offset[0]
    party0[1] = base_pos[1] + offset[1]
    party0[2] = base_pos[2] + offset[2]
    party0[3] = rot_y

    offset = vector_rotate_y([-8.0, 0.0, neg25f], rot_y)
    party1[0] = base_pos[0] + offset[0]
    party1[1] = base_pos[1] + offset[1]
    party1[2] = base_pos[2] + offset[2]
    party1[3] = rot_y

    offset = vector_rotate_y([8.0, 0.0, neg25f], rot_y)
    party2[0] = base_pos[0] + offset[0]
    party2[1] = base_pos[1] + offset[1]
    party2[2] = base_pos[2] + offset[2]
    party2[3] = rot_y

    return true;
}

function SC_GetDoorMovementEndPosition(party0, party1, party2, door_hactor) {
    if(door_hactor == 0) {
        return false;
    }

    local base_pos = get_actor_position(door_hactor)
    local rot_y = get_actor_angle_y(door_hactor)

    local offset = vector_rotate_y([0.0, 0.0, 21.0], rot_y)
    party0[0] = base_pos[0] + offset[0]
    party0[1] = base_pos[1] + offset[1]
    party0[2] = base_pos[2] + offset[2]

    offset = vector_rotate_y([-8.0, 0.0, 21.0 - 8.0], rot_y)
    party1[0] = base_pos[0] + offset[0]
    party1[1] = base_pos[1] + offset[1]
    party1[2] = base_pos[2] + offset[2]

    offset = vector_rotate_y([8.0, 0.0, 21.0 - 8.0], rot_y)
    party2[0] = base_pos[0] + offset[0]
    party2[1] = base_pos[1] + offset[1]
    party2[2] = base_pos[2] + offset[2]

    return true;
}

function SC_CalcCameraApperPosition(outparam, door_hactor) {
    return SC_CalcCameraApperPositionMain(outparam, door_hactor, 2);
}

function SC_CalcCameraApperPositionLR(outparam, door_hactor, lr_mode) {
    return SC_CalcCameraApperPositionMain(outparam, door_hactor, lr_mode);
}

function SC_CalcCameraApperPositionMain(outparam, door_hactor, lr_mode) {
    if(door_hactor == 0) {
        return false;
    }

    local appear_pos = get_actor_position(door_hactor)
    local rot_y = get_actor_angle_y(door_hactor)
    local signX = 1.0

    if(lr_mode == 3) {
        signX = -1.0
    }

    local offset_1 = vector_rotate_y([17.92 * signX, 15.508, 22.787], rot_y)
    local offset_2 = vector_rotate_y([17.252 * signX, 15.417, 22.048], rot_y)

    outparam[0] = appear_pos[0] + offset_1[0]
    outparam[1] = appear_pos[1] + offset_1[1]
    outparam[2] = appear_pos[2] + offset_1[2]

    outparam[3] = appear_pos[0] + offset_2[0]
    outparam[4] = appear_pos[1] + offset_2[1]
    outparam[5] = appear_pos[2] + offset_2[2]

    outparam[6] = 0.0
    outparam[7] = 50.0

    return true;
}

function GetRoomNumberForProgram(area_id) {
    print("GetRoomNumberForProgram area_id:" + area_id)

    local room_id = get_room_id_by_area_id(area_id)

    if(room_id < 0 || room_id >= (8 * 8)) {
        print("ERROR:GetRoomNumberForProgram room_id is out range " + room_id)
    }

    return room_id;
}

function MoveToNextAreaId(door_direction) {
    local next_room_id = CalcNextRoomId(door_direction)

    SetCurrentRoomIdAndAreaId(next_room_id)

    print("<<< MoveToNextAreaId : ofs complete -> area_id = " + GetAreaId() + " >>>")

    return GetAreaId();
}

function CalcNextRoomId(door_direction) {
    print("<<< CalcNextRoomId : Reset RoomID -> current_before_area_id = " + GetAreaId() + " >>>")
    print("<<< CalcNextRoomId : door_direction = " + door_direction + " >>>")

    local x = 0
    local z = 0

    if(door_direction == 0) {
        z = -1
    } else if(door_direction == 4) {
        x = 1
        z = -1
    } else if(door_direction == 3) {
        x = -1
    } else if(door_direction == 7) {
        x = -1
        z = 1
    } else if(door_direction == 1) {
        x = 1
    } else if(door_direction == 5) {
        x = 2
    } else if(door_direction == 8) {
        x = 1
        z = 1
    } else if(door_direction == 10) {
        x = 2
        z = 1
    } else if(door_direction == 2) {
        z = 1
    } else if(door_direction == 6) {
        z = 2
    } else if(door_direction == 9) {
        x = 1
        z = 1
    } else if(door_direction == 11) {
        x = 1
        z = 2
    }

    print("<<< CalcNextRoomId : ofsX = " + x +
        "  ofsZ = " + z + "  >>>")

    local current_room_id = GetCurrentRoomId()

    local offset = (z * 8) + x
    local next_room_id = current_room_id + offset

    if(next_room_id < 0 || next_room_id >= (8 * 8)) {
        print("<<<<< ERROR: Next room out of range. >>>>> ")
        next_room_id = 0
    }

    if(!is_enabled_room(next_room_id)) {
        print("<<<<< ERROR: Next room is disable. may be blank >>>>>" + next_room_id)

        return current_room_id;
    }

    return next_room_id;
}

function GetDoorIndex(door_hact) {
    for(local i = 0; i < 12; i++) {
        if(door_hact == GetCurrentDoorHact(i)) {
            return i;
        }
    }
    return -1;
}

function GetOldDoorIndex(door_hact) {
    for(local i = 0; i < 12; i++) {
        if(door_hact == GetOldDoorHact(i)) {
            return i;
        }
    }
    return -1;
}

function PopAreaDoorCommon(target_scene, area_id) {
    if(GetKeepAreaId() == -1) {
        return;
    }

    g_scene_common.aOldDoor_hact_ = g_scene_common.aCurrentDoor_hact_
    g_scene_common.aOldDoor_flag_ = g_scene_common.aCurrentDoor_flag_
    g_scene_common.aOldDoor_type_ = g_scene_common.aCurrentDoor_type_
    g_scene_common.aOldDoor_data_ = g_scene_common.aCurrentDoor_data_
    g_scene_common.aOldDoor_rmid_ = g_scene_common.aCurrentDoor_rmid_

    g_scene_common.aCurrentDoor_hact_ = array(12, 0)
    g_scene_common.aCurrentDoor_flag_ = array(12, 0)
    g_scene_common.aCurrentDoor_type_ = array(12, 0)
    g_scene_common.aCurrentDoor_data_ = array(12, 0)
    g_scene_common.aCurrentDoor_rmid_ = array(12, 0)

    print("<<< PopAreaDoorCommon : 次の部屋のドアをＰＯＰさせます >>>")
    print("<<< PopAreaDoorCommon : area_id = " + area_id + " >>>")

    target_scene.SetDungeonDoor(area_id)
}

function GazeCameraForIndex(act_index, isPad, frame, cam_ofsY) {
    local target_hact = GetDungeonHact(GetAreaId(), act_index)

    GazeCameraForHact(target_hact, isPad, frame, cam_ofsY)
}

function GazeCameraForHact(target_hact, isPad, frame, cam_ofsY) {
    GazeCameraForHactMain(target_hact, isPad, frame, cam_ofsY, false, false, true)
}

function GazeCameraForHactTypeZoom(target_hact, isPad, frame, cam_ofsY) {
    GazeCameraForHactMain(target_hact, isPad, frame, cam_ofsY, false, true, true)
}

function GazeCameraForHactTypeNoLook(target_hact, isPad, frame, cam_ofsY) {
    GazeCameraForHactMain(target_hact, isPad, frame, cam_ofsY, false, true, false)
}

function GazeCameraForHactMain(target_hact, isPad, frame, cam_ofsY, is_target_now, is_zoom, is_look) {
    local p_hact = get_player()

    if(isPad) {
        PadOffWait(0)
    }

    if(is_look) {
        begin_actor_look_target(p_hact, target_hact)
    }

    set_camera_target(target_hact, cam_ofsY, is_target_now, is_zoom)

    if(frame < 0) {
        const neg9 = -9
        wait(neg9)
    } else {
        wait(frame)
    }

    reset_camera_target()

    if(is_look) {
        end_actor_look_target(p_hact)
    }

    if(isPad) {
        PadOnWait(0)
    }
}

function CallPopEnemy() {
    local area_id = GetAreaId()
    local aGroup_id = DepopAreaManager(area_id)
    CallPopGroup(area_id, aGroup_id)
}

function CallPopEnemyAndDestroyOhterAreaEnemy() {
    local area_id = GetAreaId()
    local aGroup_id = DestroyAreaManager(area_id)
    CallPopGroup(area_id, aGroup_id)
}

function ShutDoor2(door_id, ev_type) {
    local door_hact = GetCurrentDoorHact(door_id)
    local door_flag = GetCurrentDoorFlag(door_id)
    __ShutDoor_internal(door_hact, door_flag, ev_type)
}

function __ShutDoor_internal(door_hact, door_flag, is_show) {
    if(door_hact == 0) return;
    if(door_flag > 0 && !test_flag(door_flag)) return;

    reset_flag(door_flag)

    if(is_show != 0) {  
        set_camera_target(door_hact)
        const neg9 = -9
        wait(neg9)
        reset_camera_target()
    }

    lock_door(door_hact, 1, false, true)
    play_se(0x100023B)
    wait(15)
}

function UnlockedDoor(door_id) {
    if(door_id < 0) return;

    local door_hact = GetCurrentDoorHact(door_id)
    local door_flag = GetCurrentDoorFlag(door_id)
    UnlockedDoorForHact(door_hact, door_flag)
}

function UnlockedDoorForHact(door_hact, door_flag) {
    if(door_hact == 0) {
        print("1________________")
        return;
    }

    if(door_flag > 0 && test_flag(door_flag)) {
        print("2________________")
        return;
    }

    if(door_flag > 0) {
        print("3________________")
        set_flag(door_flag)
    }

    print("4________________")
    lock_door(door_hact, 0, false, true)
}

function QuakeStart(mode) {
    if(mode == 2) {
        start_camera_shake(0.0, 0.0, 0.0, 0.0, 2.8, 0.067, 0.0, 0.34)
    } else if(mode == 1) {
        start_camera_shake(0.0, 0.0, 0.0, 0.0, 0.75, 0.067, 0.03, 0.0)
    } else {
        start_camera_shake(0.0, 0.0, 0.0, 0.0, 0.25, 0.067, 0.0, 0.0)
    }

    if(true) {
        play_se(0x10000EE)
    }
}

function QuakeEnd() {
    stop_camera_shake()
    stop_se_by_id(0x10000EE)
}

function InitializeCreateSwitch() {
    create_switch(1, 0, [0, 0, 0, 1])
    create_switch(2, 0, [0, 0, 0, 1])
    create_switch(3, 0, [0, 0, 0, 1])
    create_switch(4, 0, [0, 0, 0, 1])
    create_switch(5, 0, [0, 0, 0, 1])
    create_switch(6, 0, [0, 0, 0, 1])
    create_switch(7, 0, [0, 0, 0, 1])
    create_switch(10, 0, [0, 0, 0, 1])
    create_switch(8, 0, [0, 0, 0, 1])
    create_switch(9, 0, [0, 0, 0, 1])
    create_switch(11, 0, [0, 0, 0, 1])
    create_switch(12, 0, [0, 0, 0, 1])
}

function SendDoorOpened() {
    print("SendDoorOpened : toggle_switch(REACTION.DOOR)")
    toggle_switch(1)
}

function SendDoorOpened2() {
    print("SendDoorOpened2 : toggle_switch(REACTION.DOOR2)")
    toggle_switch(2)
}

function SendDoorOpened3() {
    print("SendDoorOpened3 : toggle_switch(REACTION.DOOR3)")
    toggle_switch(3)
}

function SendTreasureAppear() {
    print("SendTreasureAppear : toggle_switch(REACTION.TREASURE)")
    toggle_switch(4)
}

function SendEventStart() {
    print("SendEventStart : toggle_switch(REACTION.EVENT)")
    toggle_switch(5)
}

function SendEventStart2() {
    print("SendEventStart2 : toggle_switch(REACTION.EVENT2)")
    toggle_switch(6)
}

function SendEventStart3() {
    print("SendEventStart3 : toggle_switch(REACTION.EVENT3)")
    toggle_switch(7)
}

function SendItemGet() {
    print("SendItemGet : toggle_switch(REACTION.ITEM_GET)")
    toggle_switch(10)
}

function SendCollectingObjEnd() {
    print("SendCollectingObjEnd : toggle_switch(REACTION.COLLECTING_OBJ_END)")
    toggle_switch(8)
}

function SendHieroAltarEventEnd() {
    print("SendHieroAltarEventEnd : toggle_switch(REACTION.HIERO_ALTAR_EVENT_END)")
    toggle_switch(9)
}

function SendHieroglyphStoneGet() {
    print("SendHieroglyphStoneGet : toggle_switch(REACTION.HIEROGLYPH_STONE_GET)")
    toggle_switch(11)
}

function SendSkillPanelEnd() {
    print("SendSkillPanelEnd : toggle_switch(REACTION.SKILL_PANEL_END)")
    toggle_switch(12)
}

function isSwitchOn(switch_id) {
    if(get_switch_state(switch_id, 0)) {
        return true;
    }

    return false;
}

function MakePartyMember(party_num) {
    local dbkey = null
    local party_hact = null
    local party_chara_id = null

    if(party_num < 1 || 2 < party_num) {
        print("MakePartyMember: ERROR out of range")
        return;
    }

    party_hact = get_party_index(party_num)
    party_chara_id = get_party_chara_id(party_num)

    print("MakePartyMember: get_party_index(" + party_num + ") = " + party_hact +
        ", chara_id = " + party_chara_id)

    if(party_chara_id <= 0) return;

    if(party_hact == 0) {
        dbkey = get_dbkey_by_charaId(party_chara_id)
        print("MakePartyMember: [dbkey:" + dbkey + "]")
        if(dbkey == -1) {
            party_hact = create_temp_actor(party_chara_id, 0.0, 0.0, 0.0, 0.0, true)
        } else {
            party_hact = create_actor(dbkey, 1, 0.0, 0.0, 0.0, 0.0)
        }
    } else {
        print("MakePartyMember: party_hact set already ")
    }
}

function InitializeMakeParty() {
    print("InitializeMakeParty: test_flag(FLAG_SQID.SET_PARTY_IN_GUILD) = " + test_flag(501))

    if(test_flag(501)) {
        MakePartyMember(1)
        MakePartyMember(2)
        reset_party_position()
        return;
    }

    reset_party_position()
}

function CameraTarget(hact, ofsY, check_member_id) {
    if(get_player() == hact) {
        return false;
    }

    set_camera_target(hact, ofsY)
    return true;
}

function SpiritMissionStateChecker(mission_id, mission_status) {
    if(mission_status == 2) {
        return check_mission_completed(mission_id);
    } else if(mission_status == 1) {
        return check_mission_running(mission_id);
    }
    return false;
}

function RunningSpiritMissionChecker(mission_id_01, mission_id_02) {
    return check_mission_running_range(mission_id_01, mission_id_02);
}

function CompletedSpiritMission(mission_id) {
    force_mission_complete_event(mission_id)
}

function CompletedSpiritMissionNoEvent(mission_id) {
    local m_hact = get_quest_handle(3, mission_id)

    print("<<< CompletedSpiritMissionNoEvent :  mission_id = " + mission_id +
        ", m_hact = " + m_hact + " >>>")
    
    if(m_hact == -1) {
        return false;
    }

    finish_quest(3, m_hact)
    request_auto_run_mission()
    return true;
}

function CreateMissionNpcForBtlFields(area_id, posX, posY, posZ, angle, act_index, char_id, start_flag, end_flag) {
    CreateMissionNpcForBtlFieldsWithMotion(area_id, posX, posY, posZ, angle, act_index, char_id, start_flag, end_flag, -1)
}

function CreateMissionNpcForBtlFieldsWithMotion(area_id, posX, posY, posZ, angle, act_index, char_id, start_flag, end_flag, motion) {
    print("<<< CreateMissionNpcForBtlFields : act_index = " + act_index + " >>>")

    if(!test_flag(start_flag) || test_flag(end_flag)) {
        return false;
    }
    if(char_id < 0) {
        return false;
    }

    print("<<< CreateMissionNpcForBtlFields : char_id = " + char_id + " >>>")

    local act_type = 57
    local is_demo_now = is_demo_event_ready()

    CreateRoomObj(area_id, posX, posY, posZ, angle, 1.0, act_index, act_type, char_id, [])

    local chara_handle = get_hactor_by_chara_id(char_id)

    change_collision_solve_group(chara_handle, 7)

    local hact = GetDungeonHact(area_id, act_index)

    if(hact > 0 && motion != -1) {
        if(is_demo_now) {
            start_actor_motion(hact, motion)
        } else {
            set_demo_event_sync()
            start_actor_motion(hact, motion)
            set_demo_event(false)
        }
    }

    return true;
}

function onDateTimePeriodCommon(period_index) {
    switch(period_index) {
        case 6:
            reset_flag(1808)
            change_fix_hiero_item()
            if(get_var(150) == 2) {
                set_var(150, 3)
            }
            break;
        case 12:
            break;
        case 18:
            break;
    }
}

function ForwardNextMorning() {
    local date_time = get_datetime()
    local hour = date_time[4]
    
    do {
        hour = (hour + 1) % 24

        GetCurrentSceneObj().OnDateTimePeriod(hour)
    } while(hour != 6)

    set_skip_day_end()
    reset_next_morning()
}

function SuspendTimeGlobal() {
    set_flag(2047)
    suspend_time()
}

function ResumeTimeGlobal() {
    reset_flag(2047)
    resume_time()
}

function SuspendTime() {
    suspend_time()
}

function ResumeTime() {
    if(!test_flag(2047)) {
        resume_time()
    }
}

function Clamp0To2PI(angle) {
    if(angle < 0.0) {
        return angle + 360.0;
    } else if(angle >= 360) {
        return angle - 360.0;
    }
    return angle;
}

function GetTimeZone() {
    local timezone = 0

    local date_time = get_datetime()
    local hour = date_time[4]
    if(hour >= 7 && hour < 12) {
        timezone = 1
    } else if(hour >= 12 && hour < 18) {
        timezone = 2
    } else {
        timezone = 3
    }

    return timezone;
}

function FindBgobjActorByActType(act_type, group_id = 0) {
    print("FindBgobjActorByActType__SceneCommon__")

    local scene = GetCurrentSceneObj()

    if(group_id > 0) {
        return scene.bgobj_manager_.FindBgobjActorByActTypeWithGroupId(act_type, group_id);
    }

    return scene.bgobj_manager_.FindBgobjActorByActType(act_type);
}

function FindAllBgobjActorByActType(act_type, group_id = 0) {
    print("FindAllBgobjActorByActType__SceneCommon__")

    local scene = GetCurrentSceneObj()

    if(group_id > 0) {
        return scene.bgobj_manager_.FindAllBgobjActorByActTypeWithGroupId(act_type, group_id);
    }

    return scene.bgobj_manager_.FindAllBgobjActorByActType(act_type);
}

function FindBgobjActorByActTypeInArea(act_type, area_id) {
    print("FindBgobjActorByActTypeInArea__SceneCommon__")

    local scene = GetCurrentSceneObj()

    return scene.bgobj_manager_.FindBgobjActorByActTypeInArea(act_type, area_id);
}

function FindAllBgobjActorByActTypeInArea(act_type, area_id) {
    print("FindAllBgobjActorByActTypeInArea__SceneCommon__")

    local scene = GetCurrentSceneObj()

    return scene.bgobj_manager_.FindAllBgobjActorByActTypeInArea(act_type, area_id);
}

function FindBgobjActorByHandle(hactor, group_id = 0) {
    print("FindBgobjActorByHandle__SceneCommon__")

    local scene = GetCurrentSceneObj()

    if(group_id > 0) {
        return scene.bgobj_manager_.FindBgobjActorByHandleWithGroupId(hactor, group_id);
    }

    return scene.bgobj_manager_.FindBgobjActorByHandle(hactor);
}

function FindBgobjActorByLayoutId(layout_id, group_id = 0) {
    print("FindBgobjActorByLayoutId__SceneCommon__")

    local scene = GetCurrentSceneObj()

    if(group_id > 0) {
        return scene.bgobj_manager_.FindBgobjActorByLayoutIdWithGroupId(layout_id, group_id);
    }

    return scene.bgobj_manager_.FindBgobjActorByLayoutId(layout_id);
}

function FindBgobjActorByBgobjId(bgobj_id) {
    local scene = GetCurrentSceneObj()

    return scene.bgobj_manager_.FindBgobjActorByBgobjId(bgobj_id);
}

function FindAllBgobjActorByBgobjId(bgobj_id) {
    local scene = GetCurrentSceneObj()

    return scene.bgobj_manager_.FindAllBgobjActorByBgobjId(bgobj_id);
}

function FindBgobjHandleByLayoutId(layout_id, group_id = 0) {
    local scene = GetCurrentSceneObj()
    local obj = 0

    if(group_id > 0) {
        obj = scene.bgobj_manager_.FindBgobjActorByLayoutIdWithGroupId(layout_id, group_id)
    } else {
        obj = scene.bgobj_manager_.FindBgobjActorByLayoutId(layout_id)
    }

    if(obj != 0) {
        return obj.hself_;
    }

    print("ERROR:Bgobj LayoutID = " + layout_id + " is not found.")
    return 0;
}

function DestroyAllBgobjActors(area_id) {
    local scene = GetCurrentSceneObj()

    if(area_id > 0) {
        return scene.bgobj_creator_.DestroyAllBgobjActorsInArea(area_id);
    }
}

function ChangeSwitchEvent_Remake(bgobj_list, optSwitch, optGaze, optQuake, setCamTgtFrame, waitSwitchFrame, flag, optRotate = 103) {
    local aHact = []
    local aSw_flag = []

    __GetHactFlagFromBgobjList(bgobj_list, aHact, aSw_flag)

    if(aHact.len() == 0) {
        print("ERROR:ChangeSwitchEvent_Remake 対象スイッチがないため処理を行いません")
        return;
    }

    __ChangeSwitchEventMain(aHact, aSw_flag, optSwitch, optGaze, optQuake, optRotate, setCamTgtFrame, waitSwitchFrame, flag)
}

function ChangeSwitchEventUsingFixCam_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, optRotate = 103) {
    ChangeSwitchEventSetting_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, 60, 30, flag, gazeOfsY, aCam, 0, optRotate)
}

function ChangeSwitchEventUsingMoveCam_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, optRotate = 103) {
    ChangeSwitchEventSetting_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, 0, optRotate)
}

function ChangeSwitchEventTypeChain_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, type, optRotate = 103) {
    if(type == 2) {
        isGaze = 101
    }

    ChangeSwitchEventSetting_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, 60, 30, flag, gazeOfsY, aCam, type, optRotate)
}

function ChangeSwitchEventTypeChainMoveCam_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 103) {
    if(type == 2) {
        isGaze = 101
    }

    ChangeSwitchEventSetting_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate)
}

function ChangeSwitchEventUsingMoveCamType_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 103) {
    ChangeSwitchEventSetting_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate)
}

function ChangeSwitchEventSetting_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 103) {
    local aHact = []
    local aSw_flag = []

    __GetHactFlagFromBgobjList(bgobj_list, aHact, aSw_flag)

    if(aHact.len() == 0) {
        print("WARNING:ChangeSwitchEventSetting_Remake 対象スイッチがありません。カメライベントのみを実行します。")
        
        aHact.append(0)
        aSw_flag.append(0)
    }

    if(type >= 100) {
        if(aCam == null) {
            __UnlockDoorEventMain(aHact, aSw_flag, isGaze, isQuake, optRotate, frame1, frame2, flag)
        } else {
            __UnlockDoorEventMain_withCam(aHact, aSw_flag, isGaze, isQuake, isFade, optRotate, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type)
        }
    } else {
        if(aCam == null) {
            __ChangeSwitchEventMain(aHact, aSw_flag, isSwitchOn, isGaze, isQuake, optRotate, frame1, frame2, flag)
        } else {
            __ChangeSwitchEventMain_withCam(aHact, aSw_flag, isSwitchOn, isGaze, isQuake, isFade, optRotate, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type)
        }
    }
}

function ChangeSwitchEvent_Remake_PadOff(bgobj_list, optSwitch, optGaze, optQuake, setCamTgtFrame, waitSwitchFrame, flag, optRotate = 103) {
    ChangeSwitchEvent_Remake(bgobj_list, optSwitch, optGaze, optQuake, setCamTgtFrame, waitSwitchFrame, flag, optRotate)
    PadOffWait(0)
}

function ChangeSwitchEventUsingFixCam_Remake_PadOff(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, optRotate = 103) {
    ChangeSwitchEventUsingFixCam_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, optRotate)
    PadOffWait(0)
}

function ChangeSwitchEventUsingMoveCam_Remake_PadOff(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, optRotate = 103) {
    ChangeSwitchEventUsingMoveCam_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, optRotate)
    PadOffWait(0)
}

function ChangeSwitchEventTypeChain_Remake_PadOff(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, type, optRotate = 103) {
    ChangeSwitchEventTypeChain_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, type, optRotate)
    PadOffWait(0)
}

function ChangeSwitchEventTypeChainMoveCam_Remake_PadOff(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 103) {
    ChangeSwitchEventTypeChainMoveCam_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate)
    PadOffWait(0)
}

function ChangeSwitchEventSetting_Remake_PadOff(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 103) {
    ChangeSwitchEventSetting_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate)
    PadOffWait(0)
}

function ChangeSwitchEventUsingMoveCamType_Remake_PadOff(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 103) {
    ChangeSwitchEventSetting_Remake(bgobj_list, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate)
    PadOffWait(0)
}

function __GetHactFlagFromBgobjList(bgobj_list, aHact, aSw_flag) {
    if(bgobj_list == null || (type(bgobj_list) != "array" && type(bgobj_list) != "generator")) {
        print("ERROR:__GetHactFlagFromBgobjList bgobj_list にはbgobjActorの配列またはgeneratorを渡してください")
        return;
    }

    if(type(bgobj_list) == "array" && bgobj_list.len() == 0) {
        print("ERROR:__GetHactFlagFromBgobjList bgobj_list 渡された配列が空です")
        return;
    }

    foreach(target_obj in bgobj_list) {
        if(target_obj.hself_ != 0) {
            aHact.append(target_obj.hself_)
            aSw_flag.append(target_obj.GetFlag())
        }

        if(aSw_flag[0] != target_obj.GetFlag()) {
            print("WARNING:ChangeSwitchEvent_Remake 異なるフラグが設定されています")
        }
    }
}

function __ChangeSwitchEventMain(aHact, aSw_flag, optSwitch, optGaze, optQuake, optRotate, setCamTgtFrame, waitSwitchFrame, flag) {
    if(flag > 0 && test_flag(flag)) return;

    PadOffWait(0)

    local isSwitchOn = __IsSwitchOn(optSwitch)

    if(aSw_flag[0] > 0) {
        if(isSwitchOn) {
            set_flag(aSw_flag[0])
        } else {
            reset_flag(aSw_flag[0])
        }
    }

    local isGazeOn = __IsGazeOn(optGaze)

    if(isGazeOn) {
        __ChangeSwitchEvent_targetCam(aHact[0], setCamTgtFrame)
    }

    for(local i = 0; i < aHact.len(); i++) {
        change_state_switch_actor(aHact[i], isSwitchOn, false)
    }

    __ChangeSwitchEventMain_PostProcess(aHact[0], isGazeOn, optQuake, optRotate, waitSwitchFrame, flag)
    PadOnWait(0)
}

function __ChangeSwitchEventMain_PostProcess(hact, isGazeOn, optQuake, optRotate, waitSwitchFrame, flag) {
    local quakeMode = __GetQuakeMode(optQuake)
    local isQuakeOn = __IsQuakeOn(optQuake)
    local isRotateOn = __IsRotateOn(optRotate)

    if(isQuakeOn) {
        QuakeEnd()
        QuakeStart(quakeMode)
    }

    wait(waitSwitchFrame)

    if(isQuakeOn) {
        QuakeEnd()
        stop_se_by_id(0x10000ED)
    }

    if(flag > 0) {
        set_flag(flag)
    }

    if(isRotateOn) {
        SetAngleToDirectionOfTarget(hact)
    }

    if(isGazeOn || isRotateOn) {
        reset_camera_target()
    }
}

function __ChangeSwitchEventMain_withCam(aHact, aSw_flag, optSwitch, optGaze, optQuake, optFade, optRotate, setCamTgtFrame, waitSwitchFrame, frame3, frame4, flag, gazeOfsY, aCam, eventType) {
    if(flag > 0 && test_flag(flag)) return;

    if(aCam == null || (type(aCam) != "array" && aCam.len() < 3)) {
        print("ERROR:__ChangeSwitchEventMain_withCam カメラ座標配列が指定されていません。")
        print("ERROR:__ChangeSwitchEventMain_withCam カットカメラが不要な場合、ChangeSwitchEvent_Remakeを使用してください")
        return;
    }

    local hasPanCam = aCam.len() > 6

    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    print("__ChangeSwitchEventMain_withCam : 001")
    
    local isStartEvent = __IsStartEvent(eventType)
    local isFinishEvent = __IsFinishEvent(eventType)

    print("__ChangeSwitchEventMain_withCam : eventType = " + eventType)
    print("__ChangeSwitchEventMain_withCam : isStartEvent = " + isStartEvent)
    print("__ChangeSwitchEventMain_withCam : isFinishEvent = " + isFinishEvent)

    if(isStartEvent) {
        print("__ChangeSwitchEventMain_withCam : 002")
        PadOffWait(0)
    }

    print("__ChangeSwitchEventMain_withCam : 003")

    local isSwitchOn = __IsSwitchOn(optSwitch)

    if(aSw_flag[0] > 0) {
        if(isSwitchOn) {
            set_flag(aSw_flag[0])
        } else {
            reset_flag(aSw_flag[0])
        }
    }

    local isGazeOn = __IsGazeOn(optGaze)
    local isQuakeOn = __IsQuakeOn(optQuake)
    local isFadeOn = __IsFadeOn(optFade)

    local panCamFrame = frame3
    local waitPanFrame = frame4

    if(panCamFrame < 0) {
        panCamFrame = 15
    }

    if(waitSwitchFrame + waitPanFrame < panCamFrame) {
        waitSwitchFrame = panCamFrame - waitPanFrame
    }

    if(isGazeOn && isStartEvent) {
        __ChangeSwitchEvent_targetCam(aHact[0], setCamTgtFrame)
    }

    local aObjPos = get_actor_position(aHact[0])

    __ChangeSwitchEvent_cutCam(aCam, aObjPos, gazeOfsY, isQuakeOn, isFadeOn, isStartEvent)

    if(hasPanCam) {
        __ChangeSwitchEvent_panCam(aCam, aObjPos, gazeOfsY, panCamFrame, waitPanFrame)
    }

    for(local i = 0; i < aHact.len(); i++) {
        if(aHact[i] != 0) {
            change_state_switch_actor(aHact[i], isSwitchOn, false)
        }
    }

    __ChangeSwitchEventMain_withCam_PostProcess(aHact[0], isGazeOn, optQuake, isFadeOn, optRotate, waitSwitchFrame, flag, hasPanCam, eventType)

    print("__ChangeSwitchEventMain_withCam : 004")

    if(isFinishEvent) {
        print("__ChangeSwitchEventMain_withCam : 005")
        PadOnWait(0)
    }

    print("__ChangeSwitchEventMain_withCam : 006")
}

function __ChangeSwitchEventMain_withCam_PostProcess(hact, isGazeOn, optQuake, isFadeOn, optRotate, waitSwitchFrame, flag, hasPanCam, eventType) {
    local quakeMode = __GetQuakeMode(optQuake)
    local isQuakeOn = __IsQuakeOn(optQuake)
    local isRotateOn = __IsRotateOn(optRotate)
    local isFinishEvent = __IsFinishEvent(eventType)

    if(isQuakeOn) {
        QuakeEnd()
        if(quakeMode != 0) {
            QuakeStart(quakeMode)
        }
    }

    wait(waitSwitchFrame)

    if(isQuakeOn && quakeMode != 0) {
        QuakeEnd()
        stop_se_by_id(0x10000ED)
    }

    if(isFinishEvent) {
        if(flag > 0) {
            set_flag(flag)
        }
    } else return;

    if(isRotateOn) {
        SetAngleToDirectionOfTarget(hact)
    }

    if(isFadeOn) {
        fadeout_sync(0, 0, 0.25)
    }

    ui_pop_env()
    __ResetFovy()
    end_petit()

    wait(3)

    if(isGazeOn) {
        set_camera_target(hact, 0.0, true)
        wait(2)
    }

    if(isFadeOn) {
        fadein_sync(3, 0, 0.25)
    }

    if(isGazeOn || isRotateOn) {
        reset_camera_target()
    }
}

function __ChangeSwitchEvent_cutCam(aCam, aObjPos, gazeOfsY, isQuake, isFade, isStartEvent) {
    if(isStartEvent) {
        if(isFade) {
            fadeout_sync(0, 0, 0.25)
        }

        ui_push_env(0)
        reset_camera_target()
        init_petit()
    }

    if(aCam.len() <= 3) {
        set_petit_src_param(aCam[0], aCam[1], aCam[2],
            aObjPos[0], aObjPos[1] + gazeOfsY, aObjPos[2],
            0.0, __GetFovy())

        set_petit_dst_param(aCam[0], aCam[1], aCam[2],
            aObjPos[0], aObjPos[1] + gazeOfsY, aObjPos[2],
            0.0, __GetFovy())
    } else {
        set_petit_src_param(aCam[0], aCam[1], aCam[2],
            aCam[3], aCam[4], aCam[5],
            0.0, __GetFovy())

        set_petit_dst_param(aCam[0], aCam[1], aCam[2],
            aCam[3], aCam[4], aCam[5],
            0.0, __GetFovy())
    }

    begin_petit(1)

    if(isQuake) {
        QuakeStart(0)
    }

    const neg8 = -8
    wait(neg8)

    if(isFade) {
        fadein_sync(3, 0, 0.25)
    }
}

function __ChangeSwitchEvent_panCam(aCam, aObjPos, gazeOfsY, panCamFrame, waitPanFrame) {
    set_petit_slide_dst_to_src()
    if(aCam.len() <= 9) {
        set_petit_dst_param(
            aCam[6], aCam[7], aCam[8],
            aObjPos[0], aObjPos[1] + gazeOfsY, aObjPos[2],
            0.0, 50.0)
    } else {
        set_petit_dst_param(
            aCam[6], aCam[7], aCam[8],
            aCam[9], aCam[10], aCam[11],
            0.0, 50.0)
    }
    begin_petit(panCamFrame)
    wait(waitPanFrame)
}

function __ChangeSwitchEvent_targetCam(hact, setCamTgtFrame) {
    set_camera_target(hact)
    if(setCamTgtFrame < 0) {
        const neg9 = -9
        wait(neg9)
    } else {
        wait(setCamTgtFrame)
    }
}

function __IsSwitchOn(optSwitch) {
    return optSwitch == 0 ? true : false;
}

function __IsGazeOn(optGaze) {
    return optGaze == 100 ? true : false;
}

function __GetQuakeMode(optQuake) {
    return optQuake == 200 ? 1 : 0;
}

function __IsQuakeOn(optQuake) {
    return optQuake == 200 || optQuake == 201 ? true : false;
}

function __IsRotateOn(optGaze) {
    return optGaze == 102 ? true : false;
}

function __IsFadeOn(optFade) {
    return optFade == 300 ? true : false;
}

function __IsStartEvent(eventType) {
    return eventType != 2 && eventType != 3 && eventType != 102 && eventType != 103;
}

function __IsFinishEvent(eventType) {
    return eventType != 1 && eventType != 2 && eventType != 101 && eventType != 102;
}

function ChangeSwitchObj_Remake(switch_obj, bgobj_list, opt, type) {
    foreach(target_obj in bgobj_list) {
        if(target_obj.hself_ > 0) {
            local result = get_switch_state(switch_obj.hself_, 0)

            print("<<< ChangeSwitchObj_Remake : sw_hact = " + switch_obj.hself_ + " >>>")
            print("<<< ChangeSwitchObj_Remake : opt = " + opt + " >>>")
            print("<<< ChangeSwitchObj_Remake : type = " + type + " >>>")
            print("<<< ChangeSwitchObj_Remake : result = " + result + " >>>")

            if(result == false && type == 1) {
                return;
            } else if(result == true && type == 0) {
                return;
            }

            if(result == false && opt == true) {
                change_state_switch_actor(target_obj.hself_, 0, false)
            } else if(result == true && opt == false) {
                change_state_switch_actor(target_obj.hself_, 0, false)
            } else {
                change_state_switch_actor(target_obj.hself_, 1, false)
            }
        }
    }
}

function __UnlockDoorEventMain(aHact, aSw_flag, optGaze, optQuake, optRotate, setCamTgtFrame, waitSwitchFrame, flag) {
    if(flag > 0 && test_flag(flag)) return;

    PadOffWait(0)

    local isGazeOn = __IsGazeOn(optGaze)

    UnlockChaosTreasureBox()

    if(isGazeOn) {
        __ChangeSwitchEvent_targetCam(aHact[0], setCamTgtFrame)
    }

    for(local i = 0; i < aHact.len(); i++) {
        UnlockedDoorForHact(aHact[i], aSw_flag[i])
    }

    SetBattleRoyalBegins(false)
    __ChangeSwitchEventMain_PostProcess(aHact[0], isGazeOn, optQuake, optRotate, waitSwitchFrame, flag)
    PadOnWait(0)
}

function UnlockedDoorEventUsingFixCam_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, optRotate = 103) {
    UnlockedDoorEventSetting_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, 60, 30, flag, gazeOfsY, aCam, 100, optRotate)
}

function UnlockedDoorEventUsingMoveCam_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, optRotate = 103) {
    UnlockedDoorEventSetting_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, 100, optRotate)
}

function UnlockedDoorEventTypeChain_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, type, optRotate = 103) {
    UnlockedDoorEventSetting_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, 60, 30, flag, gazeOfsY, aCam, type, optRotate)
}

function UnlockedDoorEventTypeChainMoveCam_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 103) {
    if(type == 102) {
        isGaze = 101
    }

    UnlockedDoorEventSetting_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate)
}

function UnlockedDoorEventSetting_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 102) {
    local aDoor_hact = array(aDoor.len(), 0)
    local aDoor_flag = array(aDoor.len(), 0)

    for(local i = 0; i < aDoor.len(); i++) {    
        if(aDoor[i] >= 0) {
            aDoor_hact[i] = GetCurrentDoorHact(aDoor[i])
            aDoor_flag[i] = GetCurrentDoorFlag(aDoor[i])
        } else {
            aDoor_hact[i] == 0
            aDoor_flag[i] == 0
        }
    }

    if(aDoor.len() == 0) {
        print("UnlockedDoorEventSetting_Remake target blank")
        aDoor_hact.append(0)
        aDoor_flag.append(0)
    }

    __UnlockDoorEventMain_withCam(aDoor_hact, aDoor_flag, isGaze, isQuake, isFade, optRotate, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type)
}

function __UnlockDoorEventMain_withCam(aHact, aSw_flag, optGaze, optQuake, optFade, optRotate, setCamTgtFrame, waitSwitchFrame, frame3, frame4, flag, gazeOfsY, aCam, eventType) {
    if(flag > 0 && test_flag(flag)) return;

    if(aCam == null || (type(aCam) != "array" && aCam.len() < 3)) {
        print("ERROR:__UnlockDoorEventMain_withCam カメラ座標配列が指定されていません。処理を飛ばします。")
        return;
    }

    local hasPanCam = aCam.len() > 6
    local isStartEvent = __IsStartEvent(eventType)
    local isFinishEvent = __IsFinishEvent(eventType)

    if(isStartEvent) {
        PadOffWait(0)
    }

    local isGazeOn = __IsGazeOn(optGaze)
    local isQuakeOn = __IsQuakeOn(optQuake)
    local isFadeOn = __IsFadeOn(optFade)

    local isStartEvent = __IsStartEvent(eventType)
    local panCamFrame = frame3
    local waitPanFrame = frame4

    if(panCamFrame < 0) {
        panCamFrame = 15
    }

    if(waitSwitchFrame + waitPanFrame < panCamFrame) {
        waitSwitchFrame = panCamFrame - waitPanFrame
    }

    UnlockChaosTreasureBox()

    if(isGazeOn && isStartEvent) {
        __ChangeSwitchEvent_targetCam(aHact[0], setCamTgtFrame)
    }

    local aObjPos = get_actor_position(aHact[0])

    __ChangeSwitchEvent_cutCam(aCam, aObjPos, gazeOfsY, isQuakeOn, isFadeOn, isStartEvent)

    if(hasPanCam) {
        __ChangeSwitchEvent_panCam(aCam, aObjPos, gazeOfsY, panCamFrame, waitPanFrame)
    }

    for(local i = 0; i < aHact.len(); i++) {
        UnlockedDoorForHact(aHact[i], aSw_flag[i])
    }

    SetBattleRoyalBegins(false)
    __ChangeSwitchEventMain_withCam_PostProcess(aHact[0], isGazeOn, optQuake, isFadeOn, optRotate, waitSwitchFrame, flag, hasPanCam, eventType)

    if(isFinishEvent) {
        PadOnWait(0)
    }
}

function UnlockedDoorEventUsingFixCam_Remake_PadOff(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, optRotate = 103) {
    UnlockedDoorEventUsingFixCam_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, optRotate)
    PadOffWait(0)
}

function UnlockedDoorEventUsingMoveCam_Remake_PadOff(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, optRotate = 103) {
    UnlockedDoorEventUsingMoveCam_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, optRotate)
    PadOffWait(0)
}

function UnlockedDoorEventTypeChain_Remake_PadOff(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, type, optRotate = 103) {
    UnlockedDoorEventTypeChain_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, flag, gazeOfsY, aCam, type, optRotate)
    PadOffWait(0)
}

function UnlockedDoorEventTypeChainMoveCam_Remake_PadOff(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 103) {
    UnlockedDoorEventTypeChainMoveCam_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate)
    PadOffWait(0)
}

function UnlockedDoorEventSetting_Remake_PadOff(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate = 102) {
    UnlockedDoorEventSetting_Remake(aDoor, isSwitchOn, isGaze, isQuake, isFade, frame1, frame2, frame3, frame4, flag, gazeOfsY, aCam, type, optRotate)
    PadOffWait(0)
}

function ShutInPopStart2_Remake(ev_type, main_door, sub_door, key_flag) {
    if(key_flag >= 0 && test_flag(key_flag) == true) return;

    if(isBattleRoyalBegins() == true) {
        print("ERROR:ShutInPopStart2_Remake isBattleRoyalBegins = true")
        assert(0)
    }

    SetBattleRoyalBegins(true)

    ShutInPopStartMain_Remake(ev_type, main_door, sub_door, key_flag, 1, -1)
}

function ShutInPopStart2_GazeBox(ev_type, main_door, sub_door, key_flag) {
    if(test_flag(key_flag) == true) return;

    if(isBattleRoyalBegins() == true) {
        print("ERROR:ShutInPopStart2_GazeBox isBattleRoyalBegins = true")
        assert(0)
        return;
    }

    SetBattleRoyalBegins(true)
    set_flag(key_flag)

    ShutInPopStartMain_Remake(ev_type, main_door, sub_door, key_flag, 1, -1, 1)
}

function PhantomPopStart_Remake(ev_type, main_door, sub_door, key_flag) {
    print("<<< PhantomPopStart_Remake : ( test_flag( key_flag ) = " + test_flag(key_flag) + " ) >>>")
    if(test_flag(key_flag) == true) return;

    set_flag(key_flag)

    ShutInPopStartMain_Remake(ev_type, main_door, sub_door, key_flag, 0, -1)
}

function PhantomPopStartForWeightSwitch_Remake(ev_type, main_door, sub_door, key_flag) {
    print("<<< PhantomPopStartForWeightSwitch_Remake : ( test_flag( key_flag ) = " + test_flag(key_flag) + " ) >>>")
    if(test_flag(key_flag) == true) return;

    set_flag(key_flag)

    ShutInPopStartMain_Remake(ev_type, main_door, sub_door, key_flag, 2, -1)
}

function PhantomPopStartAndSetCamera_Remake(ev_type, main_door, sub_door, key_flag, cam_door) {
    print("<<< PhantomPopStartForWeightSwitch : ( test_flag( key_flag ) = " + test_flag(key_flag) + " ) >>>")
    if(test_flag(key_flag) == true) return;

    set_flag(key_flag)

    ShutInPopStartMain_Remake(ev_type, main_door, sub_door, key_flag, 0, cam_door)
}

function PhantomPopStartAndSetCameraForObj_Remake(ev_type, main_door, sub_door, key_flag, hactor) {
    print("<<< PhantomPopStartForWeightSwitch : ( test_flag( key_flag ) = " + test_flag(key_flag) + " ) >>>")
    if(test_flag(key_flag) == true) return;

    set_flag(key_flag)
    set_camera_target(hactor, 20.0)
    PadOffWait(0)

    const neg9 = -9
    wait(neg9)

    ShutInPopStartMain_Remake(ev_type, main_door, sub_door, key_flag, 0, -1)
    reset_camera_target()
}

function ShutInPopStartMain_Remake(ev_type, main_door, sub_door, key_flag, sequence_type, cam_door, gaze_box = 0) {
    PadOffWait(0)

    local main_door_hact = 0
    if(main_door >= 0) {
        main_door_hact = GetCurrentDoorHact(main_door)
    }

    if(sequence_type == 2) {}

    LockChaosTreasureBox(gaze_box)

    if(gaze_box > 0) {
        print("LockChaosTreasureBox_Wait______________________________")
        wait(40)
    }

    const neg9 = -9

    if(ev_type == 1) {
        ShutDoor2(main_door, 1)
        if(sub_door >= 0) {
            ShutDoor2(sub_door, 1)
        }
    } else {
        if(sub_door >= 0 && ev_type == 0) {
            ShutDoor2(sub_door, 1)
        } else if(sub_door >= 0 && ev_type == 2) {
            ShutDoor2(sub_door, 0)
        }

        if(main_door >= 0) {
            begin_actor_look_target(get_player(), main_door_hact)
            set_camera_target(main_door_hact)

            wait(neg9)

            reset_camera_target()
            end_actor_look_target(get_player())
        } else {
            wait(15)
        }
    }

    if(cam_door > -1) {
        wait(15)

        local cam_door_hact = GetCurrentDoorHact(cam_door)

        begin_actor_look_target(get_player(), cam_door_hact)
        set_camera_target(cam_door_hact)

        wait(neg9)

        end_actor_look_target(get_player())
    }

    CallPopEnemy()

    wait(15)

    if(cam_door > -1) {
        reset_camera_target()
    }

    PadOnWait(0)
}

function ShutInPopEnd2_Remake(ev_type, main_door, sub_door, key_flag) {
    if(key_flag > 0 && test_flag(key_flag)) return;

    local area_id = GetAreaId()

    print("<<< ShutInPopEnd2 : ( area_id = " + area_id + " ) >>>")

    PadOffWait(0)
    UnlockChaosTreasureBox()

    print("<<< ShutInPopEnd2 : 01 >>>")

    if(main_door >= 0) {
        local main_door_hact = GetCurrentDoorHact(main_door)

        begin_actor_look_target(get_player(), main_door_hact)
        set_camera_target(main_door_hact)

        const neg9 = -9
        wait(neg9)
        wait(20)

        reset_camera_target()
        end_actor_look_target(get_player())
    }

    print("<<< ShutInPopEnd2 : 02 >>>")
    print("<<< ShutInPopEnd2 : 03 >>>")
    print("<<< ShutInPopEnd2 : main_door = " + main_door + " >>>")

    UnlockedDoor(main_door)

    print("<<< ShutInPopEnd2 : 04 >>>")

    UnlockedDoor(sub_door)

    print("<<< ShutInPopEnd2 : 05 >>>")

    SetBattleRoyalBegins(false)
    if(key_flag > 0) {
        set_flag(key_flag)
    }
    PadOnWait(0)
}

function ShutInPopEnd2_RemakeOpenAllDoor(key_flag) {
    local area_id = GetAreaId()

    print("<<< ShutInPopEnd2_RemakeOpenAllDoor : ( area_id = " + area_id + " ) >>>")

    UnlockChaosTreasureBox()

    for(local i = 0; i < 12; i++) {
        if(g_scene_common.aCurrentDoor_hact_[i] > 0) {
            if(is_enable_open_door(g_scene_common.aCurrentDoor_hact_[i]) == true) {
                UnlockedDoor(i)
            }
        }
    }

    SetBattleRoyalBegins(false)
    if(key_flag > 0) {
        set_flag(key_flag)
    }
}

function LockChaosTreasureBox(isGaze) {
    local aChaosObj = FindAllBgobjActorByActType(53)

    if(isGaze) {
        foreach(obj in aChaosObj) {
            if(obj.IsEventAppear()) {
                set_camera_target(obj.hself_)
                obj.Activate()

                const neg9 = -9
                wait(neg9)
            }
        }
    } else {
        foreach(obj in aChaosObj) {
            obj.Activate()
        }
    }
}

function LockChaosClosedTreasureBox() {
    local aChaosObj = FindAllBgobjActorByActType(53)
    local aTreasureObj = FindAllBgobjActorByActType(16)

    local box_flag = 0
    local lock_flag = 0

    foreach(box_obj in aTreasureObj) {
        lock_flag = box_obj.GetLockFlag()
        if(lock_flag > 0) {
            box_flag = box_obj.GetFlag()
            if(box_flag > 0 && !test_flag(box_flag)) {
                foreach(chaos_obj in aChaosObj) {
                    if(chaos_obj.GetFlag() == lock_flag) {
                        chaos_obj.Activate()
                        break;
                    }
                }
            }
        }
    }
}

function UnlockChaosTreasureBox(isGaze = true) {
    print("<<< UnlockChaosTreasureBox : start >>>")

    local gen_chaos_obj = FindAllBgobjActorByActType(53)

    print("<<< UnlockChaosTreasureBox : 01 >>>")
    print("<<< UnlockChaosTreasureBox : gen_chaos_obj = " + gen_chaos_obj + " >>>")

    local isSetCamera = false
    local isFindChaos = false

    foreach(obj in gen_chaos_obj) {
        if(isGaze && !isSetCamera && obj.IsEventDisappear()) {
            begin_actor_look_target(get_player(), obj.hself_)
            set_camera_target(obj.hself_)

            const neg9 = -9
            wait(neg9)
            wait(20)

            isSetCamera = true

            end_actor_look_target(get_player())
        }

        obj.Deactivate()
        isFindChaos = true
    }

    if(isGaze && isFindChaos) {
        wait(30)
        reset_camera_target()
    }
}

function ChangeSwitchActorSimple(layout_id, is_on) {
    local h_switch = FindBgobjHandleByLayoutId(layout_id)

    change_state_switch_actor(h_switch, is_on, false)
}

function CreateRichDemoPlayer() {
    local pl_id = 0
    local hplayer = get_player()

    if(hplayer == 0) {
        import_player_to_tempdb()
        local db_key = get_dbkey_by_charaId(pl_id)
        load_actor_archive_sync(1, pl_id)

        const neg1 = -1
        if(db_key != neg1) {
            hplayer = create_actor(db_key, 1, 0.0, 0.0, 0.0, 0.0)
        } else {
            hplayer = create_temp_actor(pl_id, 0.0, 0.0, 0.0, 0.0, true)
        }
    }

    return hplayer;
}

function RoadClosedDemo(phantom_id, message_id = -1, h_speaker = 0) {
    PadOffWait(0)

    local h_player = get_player()

    if(message_id != -1) {
        if(h_speaker != 0 && h_speaker != h_player) {
            if(!is_dead(h_speaker)) {
                turn_actor(h_speaker, 1, h_player, 5)
            }
        }
        msg_sync(message_id, h_speaker)
    }

    local dir = get_leave_phantom_direction(phantom_id, h_player)

    dir[0] *= dir[3] + 10.0
    dir[2] *= dir[3] + 10.0

    move_actor(h_player, 1, dir, 5, 1)

    wait_for_false1(is_actor_moving, h_player)

    PadOnWait(0)
}

function RoadClosedDemoSafe(phantom_id, tagpoint_id, message_id = -1, h_speaker = 0) {
    PadOffWait(0)

    local h_player = get_player()

    if(message_id != -1) {
        if(h_speaker != 0 && h_speaker != h_player) {
            if(!is_dead(h_speaker)) {
                turn_actor(h_speaker, 1, h_player, 5)
            }
        }
        msg_sync(message_id, h_speaker)
    }

    local dist = get_tag_point(tagpoint_id)

    move_actor(h_player, 1, dist, 5, 0)

    wait_for_false1(is_actor_moving, h_player)

    PadOnWait(0)
}

function LeaveSceneByPhantom(phantom_id, fade_color) {
    reserve_scene_change()
    PadOffWait(0)

    local zone_id = get_zone_id()
    local next = get_next_scene_by_phantom(zone_id, phantom_id, get_var(100), 0)

    LeaveSceneByPhantomDemo(phantom_id, get_player(), fade_color)
    request_jump_scene_tag(next[0], next[1], 0)
    SetUseZoneConnectFlag(zone_id, phantom_id)
    PadOnWait(0)
}

function LeaveSceneByPhantomDemo(phantom_id, hact, fade_color) {
    set_railcamera_fixed(true)

    local dir = get_leave_phantom_direction(phantom_id, hact)

    dir[0] *= -50.0
    dir[2] *= -50.0

    fadeout(fade_color, 0, 1.0)

    if(!is_actor_action(hact, 4)) {
        while(is_fade() && !is_motion_finished(hact)) {
            Suspend()
        }
    }

    move_actor(hact, 1, dir, 5, 1)

    const neg7 = -7
    wait(neg7)
}

function RunIntoSceneDemo() {
    local tag_point_id = get_scene_jumped_tagid()

    const neg1 = -1
    if(tag_point_id == neg1) {
        fadein_sync()
        return;
    }

    local dir = get_tag_direction(tag_point_id)

    dir[0] *= 30.0
    dir[2] *= 30.0

    local start_pos = get_tag_point(tag_point_id)

    start_pos[0] -= dir[0]
    start_pos[2] -= dir[2]

    local h_player = get_player()

    set_actor_position_angle_y(h_player, start_pos[0], start_pos[1], start_pos[2], start_pos[3])

    wait(1)

    if(get_camera_type() == 7) {
        reset_party_position()
        reset_behind_camera()
    }

    local h_member1 = get_party_order(1)
    local h_member2 = get_party_order(2)

    fadein(3, 0, 1.0)

    move_actor(h_player, 1, dir, 5, 1)

    wait(3)

    if(h_member1 != 0) {
        move_actor(h_member1, 1, dir, 5, 1)
    }
    if(h_member2 != 0) {
        move_actor(h_member2, 1, dir, 5, 1)
    }

    wait_for_false1(is_actor_moving, h_player)

    const neg7 = -7
    wait(neg7)
}

function SetUseZoneConnectFlag(zone_id, phantom_id) {
    local connect_id = get_zone_connect_id(zone_id, phantom_id)

    if(connect_id != 255) {
        set_flag(939 + connect_id)
    }
}

function ExistAnyConnectSymbol() {
    for(local flag_id = 939; flag_id <= 988; ++flag_id) {
        if(test_flag(flag_id)) return true;
    }
    return false;
}

function ChoiceDisable(msg_id) {
    const int_min = 0x80000000
    return msg_id | int_min;
}

function ActivateBgobj(layout_id) {
    local bgobj_actor = FindBgobjActorByLayoutId(layout_id)

    if(bgobj_actor && bgobj_actor.hself_ > 0) {
        bgobj_actor.Activate()
    }
}

function DeactivateBgobj(layout_id) {
    local bgobj_actor = FindBgobjActorByLayoutId(layout_id)

    if(bgobj_actor && bgobj_actor.hself_ > 0) {
        bgobj_actor.Deactivate()
    }
}

function CheckSwitchByLayoutId(switch_id, layout_id) {
    local bgobj_hact = FindBgobjHandleByLayoutId(layout_id)
    return switch_id == bgobj_hact;
}

function CheckBgObjByLayoutId(handle, layout_id) {
    return CheckSwitchByLayoutId(handle, layout_id);
}

function CheckSwitchByLayoutId_AllOn(switch_id, layout_id_list) {
    if(type(layout_id_list) != "array") {
        print("ERROR:CheckSwitchByLayoutId_AllOn 第2引数は配列で指定してください")
        return false;
    }
    
    if(switch_id == 0) {
        print("ERROR:CheckSwitchByLayoutId_AllOn switch_id = 0")
        return false;
    }

    local bgobj_list = []
    local is_now_on = false

    foreach(layout_id in layout_id_list) {
        local bgobj_actor = FindBgobjActorByLayoutId(layout_id)
        if(bgobj_actor.hself_ == switch_id) {
            is_now_on = true
        } else if(bgobj_actor.GetReaction() == switch_id) {
            is_now_on = true
            continue;
        }

        bgobj_list.append(bgobj_actor)
    }

    if(is_now_on == false) {
        return false;
    }

    foreach(bgobj in bgobj_list) {
        if(get_state_switch_actor(bgobj.hself_) == false) {
            return false;
        }
    }

    foreach(bgobj in bgobj_list) {
        if(bgobj.GetSwitchMode() == 2) {
            fixed_switch_on(bgobj.hself_)
        }
    }

    return true;
}

function InitializeBgobjAfterCreate(area_id) {
    local scene = GetCurrentSceneObj()

    return scene.bgobj_creator_.InitializeAfterCreate(area_id)
}

function SetRouteIdToPartyAI_InArea(area_id) {
    local scene = GetCurrentSceneObj()

    return scene.bgobj_creator_.SetRouteIdToPartyAI_InArea(area_id)
}

function UnlockDoorWithGaze(aDoor) {
    local aDoor_hact = array(aDoor.len(), 0)
    local aDoor_flag = array(aDoor.len(), 0)

    for(local i = 0; i < aDoor.len(); i++) {
        if(0 <= aDoor[i] && aDoor[i] <= 11) {
            aDoor_hact[i] = GetCurrentDoorHact(aDoor[i])
            aDoor_flag[i] = GetCurrentDoorFlag(aDoor[i])
        }
    }

    PadOffWait(0)

    set_camera_target(aDoor_hact[0])

    const neg9 = -9
    wait(neg9)

    for(local i = 0; i < aDoor_hact.len(); i++) {
        UnlockedDoorForHact(aDoor_hact[i], aDoor_flag[i])
    }

    wait(15)

    reset_camera_target()

    PadOnWait(0)
}

function ChangeSceneIntoDungeon(cam_pos, cam_target_pos, bank, view_angle, camera_frame, phantom_id) {
    reserve_scene_change()
    PadOffWait(0)

    for(local i = 0; i < 3; ++i) {
        local hact = get_party_order(i)
        if(hact != 0) {
            local dir = get_leave_phantom_direction(phantom_id, hact)

            dir[0] *= -100.0
            dir[2] *= -100.0

            move_actor(hact, 1, dir, 1, 1)
        }
    }

    init_petit()
    set_petit_dst_param(cam_pos[0], cam_pos[1], cam_pos[2]
        cam_target_pos[0], cam_target_pos[1], cam_target_pos[2],
        bank, view_angle)
    begin_petit(camera_frame)

    wait((camera_frame * 2) / 3)

    fadeout_sync(0, 0, 1.0)

    const neg8 = -8
    wait(neg8)

    local next = get_next_scene_by_phantom(get_zone_id(), phantom_id, get_var(100), 0)
    request_jump_scene_tag(next[0], next[1], 0)
}

function TalkDemo_1_1_Initialize(chara_id_l, chara_id_r, in_out) {
    initialize_talk_event(true)

    local start_pos = null

    switch(in_out) {
        case 0:
        case 1:
            start_pos = [7, 8]
            break;
        case 2:
            start_pos = [3, 4]
            break;
    }

    local h_talk_acts = [
        create_talk_event_actor_index(get_dbkey_by_charaId(chara_id_l), 1, start_pos[0], 0.0),
        create_talk_event_actor_index(get_dbkey_by_charaId(chara_id_r), 1, start_pos[1], 0.0)
    ]

    set_talk_event_actor_angle_index(h_talk_acts[0], 1)
    set_talk_event_actor_angle_index(h_talk_acts[1], 0)

    if(in_out == 0) {
        talk_actor_slide_move(h_talk_acts[0], 3)
        talk_actor_slide_move(h_talk_acts[1], 4)
        talk_event_slide_move_wait(h_talk_acts[0])
    }

    if(in_out == 1) {
        fadeout_actor_alpha(h_talk_acts[0], 1)
        fadeout_actor_alpha(h_talk_acts[1], 1)
        set_talk_event_actor_pos_index(h_talk_acts[0], 3)
        set_talk_event_actor_pos_index(h_talk_acts[1], 4)
        fadein_actor_alpha(h_talk_acts[0], 8)
        fadein_actor_alpha(h_talk_acts[1], 8)
        wait(5)
    }

    return h_talk_acts;
}

function TalkDemo_1_1_Finalize(h_talk_acts, in_out) {
    if(h_talk_acts[0] == 0) return;
    if(h_talk_acts[1] == 0) return;

    if(in_out == 0) {
        talk_actor_slide_move(h_talk_acts[0], 7)
        talk_actor_slide_move(h_talk_acts[1], 8)
        talk_event_slide_move_wait(h_talk_acts[0])
    }

    if(in_out == 1) {
        fadeout_actor_alpha(h_talk_acts[0], 5)
        fadeout_actor_alpha(h_talk_acts[1], 5)
        wait(5)
    }

    destroy_actor(h_talk_acts[0])
    destroy_actor(h_talk_acts[1])

    finalize_talk_event()
}

function ForceStartOptionalQuestEvent(quest_key) {
    return ForceStartOptionalQuestEventArgs_SetEventMode(quest_key, null, true);
}

function ForceStartOptionalQuestEvent_SetEventMode(quest_key, set_event) {
    return ForceStartOptionalQuestEventArgs_SetEventMode(quest_key, null, set_event);
}

function ForceStartOptionalQuestEventArgs(quest_key, args) {
    return ForceStartOptionalQuestEventArgs_SetEventMode(quest_key, args, true);
}

function ForceStartOptionalQuestEventArgs_SetEventMode(quest_key, args, set_event) {
    local quest_result = force_optional_quest_event(quest_key)

    if(quest_result[0] < 0) {
        return false;
    }

    local event_id = quest_result[0]
    local script_type = quest_result[1]

    if(set_event) {
        EventStart(0)
    }

    {
        local demo_event_ = null

        if(script_type == 0) {
            demo_event_ = DemoEventSet()
        } else if(script_type == 1) {
            demo_event_ = CommonDemoEventSet()
        }

        if(set_event) {
            demo_event_.StartDemo(event_id, args)
        } else {
            demo_event_.StartInnerDemo(event_id, args)
        }
    }

    if(set_event) {
        EventEnd()
    }

    return true;
}

function CallAfterPlayerActionEvent(obj_handle, layout_id) {
    local scene = GetCurrentSceneObj()

    scene.AfterPlayerActionEvent(obj_handle, layout_id)
}

function StartVisitorListUI(hact) {
    if(0 == hact) {
        print("!!!!! [Warning] StartVisitorListUI(): アクターハンドルが取得できません !!!!!")
        return;
    }

    local scene_type = get_scene_type()
    local is_field = scene_type == 5 || scene_type == 3
    local chara_id = get_charaid(hact)
    local visitor_state = get_visitor_list_state(hact)
    local ui_mode = 0

    switch(visitor_state) {
        case 0:
            ui_mode = 1;
            break;
        case 1:
            ui_mode = 2;
            break;
    }

    if(is_field && 0 == ui_mode) {
        print("!!!!! [Warning] StartVisitorListUI(): フィールドシーンで ui_mode が 0 !!!!!")
        return;
    }

    local switch_state = 5
    local flag = false

    if(is_field) {
        flag = ui_mode > 0
        switch_state = 2
    } else {
        flag = ui_mode >= 0
        if(748 == chara_id) {
            switch_state = 3
        } else if(749 == chara_id) {
            switch_state = 4
        } else {
            switch_state = 2
        }
    }

    if(flag) {
        set_actor_visitor_status(hact, 0)
        ui_activate(14, [hact])
        switch_visitor_list_state(hact, switch_state)
        ui_push_env(2)
        start_visitor_list_update_ui(chara_id, ui_mode)

        func_wait(is_finish_visitor_list_update_ui)

        ui_deactivate(24)
        ui_pop_env()
        ui_deactivate(14)
        set_actor_visitor_status(hact, 1)
        set_actor_visitor_status(hact, 5)
    } else {
        print("!!!!! [Warning] StartVisitorListUI(): ui_mode が 不正 -> " + ui_mode + "!!!!!")
    }
}

function GetNpcMessageId(chara_id, msg_type) {
    return (chara_id * 100) + msg_type;
}

function GetFieldChaosStatus() {
    local chaos_kind = get_chaos_kind()
    local result = false

    switch(chaos_kind) {
        case 2:
        case 3:
        case 4:
        case 8:
        case 6:
            result = true
            break;
        default:
            result = false
            break;
    }

    return result;
}

function ResetToBehindCamera(frame) {
    local reset_param = get_reset_param_of_behind_camera()

    set_petit_dst_param(reset_param)
    begin_petit(frame)

    const neg8 = -8
    wait(neg8)

    end_petit()
}

function GetSceneScriptData() {
    return g_scene_common.aSceneData_
}

function SetSceneScriptData(arg) {
    g_scene_common.aSceneData_ = arg
}

function VisitDemoJump(params) {
    if(params != null) {
        set_var(79, params[0])
        set_var(75, params[1])
        set_var(76, params[2])
        set_var(77, params[3])
        set_var(78, params[4])
    }

    set_var(74, 3)

    local entrance_scene = get_scene_id_from_zone(4, get_var(100), 0)
    local scene_id = 0

    switch(entrance_scene) {
        case 24:
            scene_id = 1017
            break;
        case 25:
            scene_id = 1018
            break;
        case 26:
            scene_id = 1019
            break;
        default:
            print("飛び先が不正です:" + entrance_scene)
            assert(0)
    }

    request_jump_scene(scene_id, 88.0, 27.0, 90.0, 0.0, 0)
}

function SetAngleToDirectionOfTarget(hact) {
    local h_player = get_player()
    local angleY = get_actor_to_actor_angle_y(h_player, hact)
    set_actor_angleY(h_player, angleY)
}

function ChangeSceneForDebug(next_zone_id, next_scene_id) {
    local eval_scene_id = next_scene_id

    if(next_zone_id <= 20) {
        eval_scene_id = get_scene_id_from_zone(next_zone_id, get_var(100), 0)
    }

    local tag_point_id = get_debug_change_scene_tagpoint(next_zone_id, eval_scene_id)

    if(tag_point_id <= 0) {
        print("ERROR:ChangeSceneForDebug 行き先タグポイントIDが取得できませんでした tag_point_id = " + tag_point_id)
        return;
    }

    ChangeSceneForTag(eval_scene_id, tag_point_id)
}

function IsunaScarabAppearCameraFunc(htarget) {
    local hplayer = get_player()
    if(htarget != hplayer) {
        local target_pos = get_actor_position(htarget)
        local player_pos = get_actor_position(hplayer)

        local add_vec = [
            target_pos[0] - player_pos[0],
            target_pos[1] - player_pos[1],
            target_pos[2] - player_pos[2]
        ]

        local src_cam_param = get_current_camera_pos()
        local dst_cam_param = src_cam_param

        dst_cam_param[0] = src_cam_param[0] + add_vec[0]
        dst_cam_param[1] = src_cam_param[1] + add_vec[1]
        dst_cam_param[2] = src_cam_param[2] + add_vec[2]
        dst_cam_param[3] = src_cam_param[3] + add_vec[0]
        dst_cam_param[4] = src_cam_param[4] + add_vec[1]
        dst_cam_param[5] = src_cam_param[5] + add_vec[2]

        init_petit()
        set_petit_dst_param(dst_cam_param)
        begin_petit(30)

        const neg8 = -8
        wait(neg8)
    }
}

function IsunaScarabLeaveCameraFunc(htarget) {
    local player = get_player()
    if(htarget != player) {
        local src_cam_param = get_current_camera_pos()
        local dst_cam_param = get_reset_param_of_behind_camera()

        set_petit_src_param(src_cam_param)
        set_petit_dst_param(dst_cam_param)
        begin_petit(30)

        const neg8 = -8
        wait(neg8)

        end_petit()
    }
}

function CreateSimpleScarabAndIsuna(htarget) {
    local pos = get_actor_position(htarget)
    local angle_y = get_actor_angle_y(htarget)
    local h_scarab = create_demo_event_actor(8)
    local h_isuna = create_demo_event_actor(3)

    set_actor_visible(h_isuna, false)
    set_disable_gravity(h_isuna)
    set_actor_position_angle_y(h_scarab, pos[0], pos[1], pos[2], angle_y, 1)
    set_actor_position_angle_y(h_isuna, pos[0], pos[1], pos[2], angle_y, 1)

    local result = [h_scarab, h_isuna]
    return result;
}

function AppearSimpleScarabAndIsunaSetAngleY(h_scarab, h_isuna, htarget, angle_y, is_look) {
    local pos = get_actor_position(htarget)
    local is_visible_ball = is_actor_mesh_visible(h_scarab, "o_ball")

    set_actor_position_angle_y(h_scarab, pos[0], pos[1], pos[2], angle_y, 1)

    if(is_visible_ball) {
        start_actor_motion_auto_idle(h_scarab, 903)
        wait_for_true2(is_motion_finished, h_scarab, 903)
    } else {
        start_actor_motion_auto_idle(h_scarab, 934)
        wait_for_true2(is_motion_finished, h_scarab, 934)
    }

    local to_target_angle_y = get_actor_to_actor_angle_y(h_scarab, htarget)
    set_actor_angleY(h_scarab, to_target_angle_y)

    if(is_look) {
        begin_actor_look_target(htarget, h_scarab)
    }

    local scarab_pos = get_actor_position(h_scarab)
    local scarab_angle = get_actor_angle_y(h_scarab)

    set_actor_position_angle_y(h_isuna, scarab_pos[0], scarab_pos[1], scarab_pos[2], scarab_angle, 1)

    wait_for_true1(is_set_actor_position_finished, h_isuna)

    start_actor_motion(h_scarab, 922)
    start_actor_motion(h_isuna, 920)

    wait(1)

    set_actor_visible(h_isuna, true)

    wait(6)

    SetSimpleScarabBallVisible(h_scarab, false)

    wait_for_true2(is_motion_finished, h_scarab, 922)
    wait_for_true2(is_motion_finished, h_isuna, 920)

    if(!is_look) {
        local to_scarab_angle_y = get_actor_to_actor_angle_y(htarget, h_scarab)
        turn_actor(htarget, 1, h_scarab, 5)
        wait_for_false1(is_actor_turning, htarget)
    }
}

function AppearSimpleScarabAndIsuna(h_scarab, h_isuna, htarget) {
    local angle_y = get_actor_angle_y(htarget)
    AppearSimpleScarabAndIsunaSetAngleY(h_scarab, h_isuna, htarget, angle_y, true)
}

function AppearSimpleScarabAndIsunaBack(h_scarab, h_isuna, htarget) {
    local angle_y = get_actor_angle_y(htarget) + 180.0
    AppearSimpleScarabAndIsunaSetAngleY(h_scarab, h_isuna, htarget, angle_y, false)
}

function LeaveSimpleScarabAndIsuna(hscarab, hisuna, htarget) {
    local to_target_angle_y = get_actor_to_actor_angle_y(hscarab, htarget)
    set_actor_angleY(hscarab, to_target_angle_y)
    start_actor_motion(hscarab, 924)
    start_actor_motion(hisuna, 921)
    
    wait(6)

    SetSimpleScarabBallVisible(hscarab, true)

    wait_for_true2(is_motion_finished, hscarab, 905)
    wait_for_true2(is_motion_finished, hisuna, 921)

    set_actor_visible(hisuna, false)
    start_actor_motion_auto_idle(hscarab, 905)
    
    wait_for_true2(is_motion_finished, hscarab, 905)

    end_actor_look_target(htarget)
}

function DestroySimpleScarabAndIsuna(hscarab, hisuna) {
    destroy_actor(hscarab)
    destroy_actor(hisuna)
}

function CreateAndAppearSimpleScarabAndIsuna(htarget) {
    local result = CreateSimpleScarabAndIsuna(htarget)
    AppearSimpleScarabAndIsuna(result[0], result[1], htarget)
    return result;
}

function CreateAndAppearSimpleScarabAndIsunaToPlayerAndCamera() {
    local htarget = get_party_index(0)
    IsunaScarabAppearCameraFunc(htarget)
    local result = CreateSimpleScarabAndIsuna(htarget)
    AppearSimpleScarabAndIsuna(result[0], result[1], htarget)
    return result;
}

function CreateAndAppearSimpleScarabAndIsunaBack(htarget) {
    local result = CreateSimpleScarabAndIsuna(htarget)
    AppearSimpleScarabAndIsunaBack(result[0], result[1], htarget)
    return result;
}

function CreateAndAppearSimpleScarabAndIsunaSetAngleY(htarget, angle_y) {
    local result = CreateSimpleScarabAndIsuna(htarget)
    AppearSimpleScarabAndIsunaSetAngleY(result[0], result[1], htarget, angle_y, false)
    return result;
}

function CreateAndAppearSimpleScarabAndIsunaInvisibleScarabBall(htarget) {
    local result = CreateSimpleScarabAndIsuna(htarget)
    SetSimpleScarabBallVisible(result[0], false)
    AppearSimpleScarabAndIsuna(result[0], result[1], htarget)
    return result;
}

function CreateAndAppearSimpleScarabAndIsunaBackInvisibleScarabBall(htarget) {
    local result = CreateSimpleScarabAndIsuna(htarget)
    SetSimpleScarabBallVisible(result[0], false)
    AppearSimpleScarabAndIsunaBack(result[0], result[1], htarget)
    return result;
}

function CreateAndAppearSimpleScarabAndIsunaSetAngleYInvisibleScarabBall(htarget, angle_y) {
    local result = CreateSimpleScarabAndIsuna(htarget)
    SetSimpleScarabBallVisible(result[0], false)
    AppearSimpleScarabAndIsunaSetAngleY(result[0], result[1], htarget, angle_y, true)
    return result;
}

function LeaveAndDestroySimpleScarabAndIsuna(hscarab, hisuna, htarget) {
    LeaveSimpleScarabAndIsuna(hscarab, hisuna, htarget)
    DestroySimpleScarabAndIsuna(hscarab, hisuna)
}

function LeaveAndDestroySimpleScarabAndIsunaToPlayerAndCamera(hscarab, hisuna) {
    local htarget = get_party_index(0)

    LeaveSimpleScarabAndIsuna(hscarab, hisuna, htarget)
    DestroySimpleScarabAndIsuna(hscarab, hisuna)
    IsunaScarabLeaveCameraFunc(htarget)
}

function SetSimpleScarabBallVisible(h_scarab, is_visible) {
    set_actor_mesh_visible(h_scarab, "o_ball", is_visible)
}

function CreateSimpleScarab(htarget) {
    local pos = get_actor_position(htarget)
    local angle_y = get_actor_angle_y(htarget)
    local h_scarab = create_demo_event_actor(8)
    set_actor_position_angle_y(h_scarab, pos[0], pos[1], pos[2], angle_y, 1)
    return h_scarab;
}

function AppearSimpleScarabSetAngleY(h_scarab, htarget, angle_y, is_look) {
    local pos = get_actor_position(htarget)
    local is_visible_ball = is_actor_mesh_visible(h_scarab, "o_ball")

    set_actor_position_angle_y(h_scarab, pos[0], pos[1], pos[2], angle_y, 1)

    if(is_visible_ball) {
        start_actor_motion_auto_idle(h_scarab, 903)
        wait_for_true2(is_motion_finished, h_scarab, 903)
    } else {
        start_actor_motion_auto_idle(h_scarab, 934)
        wait_for_true2(is_motion_finished, h_scarab, 934)
    }

    local to_target_angle_y = get_actor_to_actor_angle_y(h_scarab, htarget)
    set_actor_angleY(h_scarab, to_target_angle_y)

    if(is_look) {
        begin_actor_look_target(htarget, h_scarab)
    } else {
        local to_scarab_angle_y = get_actor_to_actor_angle_y(htarget, h_scarab)
        turn_actor(htarget, 1, h_scarab, 5)
        wait_for_false1(is_actor_turning, htarget)
    }
}

function AppearSimpleScarab(h_scarab, htarget) {
    local angle_y = get_actor_angle_y(htarget)

    AppearSimpleScarabSetAngleY(h_scarab, htarget, angle_y, true)
}

function AppearSimpleScarabBack(h_scarab, htarget) {
    local angle_y = get_actor_angle_y(htarget) + 180.0

    AppearSimpleScarabSetAngleY(h_scarab, htarget, angle_y, false)
}

function LeaveSimpleScarab(hscarab, htarget) {
    // it's a miracle this game even runs
    local is_visible_ball = is_actor_mesh_visible(h_scarab, "o_ball")
    local to_target_angle = get_actor_to_actor_angle_y(hscarab, htarget)

    set_actor_angleY(hscarab, to_target_angle)
    if(is_visible_ball) {
        start_actor_motion_auto_idle(hscarab, 905)
        wait_for_true2(is_motion_finished, hscarab, 905)
    } else {
        start_actor_motion_auto_idle(hscarab, 936)
        wait_for_true2(is_motion_finished, hscarab, 936)
    }

    end_actor_look_target(htarget)
}

function DestroySimpleScarab(hscarab) {
    destroy_actor(hscarab)
}

function CreateAndAppearSimpleScarab(htarget) {
    local result = CreateSimpleScarab(htarget)

    AppearSimpleScarab(result, htarget)

    return result;
}

function CreateAndAppearSimpleScarabBack(htarget) {
    local result = CreateSimpleScarab(htarget)

    AppearSimpleScarabBack(result, htarget)

    return result;
}

function CreateAndAppearSimpleScarabSetAngleY(htarget, angle_y) {
    local result = CreateSimpleScarab(htarget)

    AppearSimpleScarabSetAngleY(result, htarget, angle_y, false)

    return result;
}

function CreateAndAppearSimpleScarabInvisibleScarabBall(htarget) {
    local result = CreateSimpleScarab(htarget)

    SetSimpleScarabBallVisible(result, false)
    AppearSimpleScarab(result, htarget)

    return result;
}

function CreateAndAppearSimpleScarabBackInvisibleScarabBall(htarget) {
    local result = CreateSimpleScarab(htarget)

    SetSimpleScarabBallVisible(result, false)
    AppearSimpleScarabBack(result, htarget)

    return result;
}

function CreateAndAppearSimpleScarabSetAngleYInvisibleScarabBall(htarget, angle_y) {
    local result = CreateSimpleScarab(htarget)

    SetSimpleScarabBallVisible(result, false)
    AppearSimpleScarabSetAngleY(result, htarget, angle_y, false)

    return result;
}

function LeaveAndDestroySimpleScarab(hscarab, htarget) {
    LeaveSimpleScarab(hscarab, htarget)
    DestroySimpleScarab(hscarab)
}

function StartScarabIsunaTalkEventStandard() {
    local h_player_talk, h_isuna_talk

    h_player_talk = create_talk_event_actor_index(get_dbkey_by_charaId(0), 1, 3, 0.0)
    h_isuna_talk = create_talk_event_actor_index(get_dbkey_by_charaId(3), 1, 4, 0.0)

    set_talk_event_actor_angle_index(h_player_talk, 1)
    set_talk_event_actor_angle_index(h_isuna_talk, 0)

    set_talk_event_actor_pos_index_and_pos_y(h_isuna_talk, 4, -2.5)
    set_actor_scale(h_isuna_talk, 0.7, 0.7, 0.7)

    initialize_talk_event(true)

    local result = [h_player_talk, h_isuna_talk]
    return result;
}

function EndScarabIsunaTalkEventStandard(h_player, h_isuna) {
    finalize_talk_event()
    destroy_actor(h_isuna)
    destroy_actor(h_player)
}

function StartScarabIsunaTalkEventAppear() {
    local result = StartScarabIsunaTalkEventAppearSetFacial(0, 0)
    return result;
}

function StartScarabIsunaTalkEventAppearSetFacial(player_face, isuna_face) {
    local h_player_talk, h_isuna_talk, h_scarab_talk

    h_player_talk = create_talk_event_actor_index(get_dbkey_by_charaId(0), 1, 3, 0.0)
    h_isuna_talk = create_talk_event_actor_index(get_dbkey_by_charaId(3), 1, 4, 0.0)
    h_scarab_talk = create_talk_event_actor_index(get_dbkey_by_charaId(8), 1, 3, 0.0)

    set_talk_event_actor_angle_index(h_player_talk, 1)
    set_talk_event_actor_angle_index(h_isuna_talk, 0)
    set_talk_event_actor_angle_index(h_scarab_talk, 1)

    set_talk_event_actor_pos_index_and_pos_y(h_isuna_talk, 4, -2.5)
    set_actor_scale(h_isuna_talk, 0.7, 0.7, 0.7)

    set_actor_facial(h_player_talk, player_face)
    set_actor_facial(h_isuna_talk, isuna_face)

    set_actor_visible(h_isuna_talk, false)

    initialize_talk_event(true)

    start_actor_motion_auto_idle(h_scarab_talk, 927)
    start_actor_motion_auto_idle(h_isuna_talk, 930)

    wait(42)

    SetSimpleScarabBallVisible(h_scarab_talk, false)

    set_actor_visible(h_isuna_talk, true)

    wait_for_true2(is_motion_finished, h_scarab_talk, 927)
    start_actor_motion_auto_idle(h_scarab_talk, 932)

    local result = [h_player_talk, h_isuna_talk, h_scarab_talk]
    return result;
}

function EndScarabIsunaTalkEventLeave(h_player, h_isuna, h_scarab) {
    start_actor_motion_auto_idle(h_scarab, 933)
    start_actor_motion_auto_idle(h_isuna, 931)
    wait(11)
    SetSimpleScarabBallVisible(h_scarab, true)
    wait_for_true2(is_motion_finished, h_scarab, 933)
    finalize_talk_event()
    destroy_actor(h_scarab)
    destroy_actor(h_isuna)
    destroy_actor(h_player)
}

function EndScarabIsunaTalkEventDestroyOnly(h_player, h_isuna, h_scarab) {
    finalize_talk_event()
    destroy_actor(h_scarab)
    destroy_actor(h_isuna)
    destroy_actor(h_player)
}

function SimpleScarabAndIsunaCreateOnly() {
    local h_scarab = create_demo_event_actor(8)
    local h_isuna = create_demo_event_actor(3)

    set_actor_visible(h_isuna, false)
    set_actor_visible(h_scarab, false)

    local result = [h_isuna, h_scarab]
    return result;
}

function SimpleScarabAndIsunaDestroyOnly(h_isuna, h_scarab) {
    destroy_actor(h_scarab)
    destroy_actor(h_isuna)
}

function MoveSimpleScarabAndIsunaSync(h_scarab, h_isuna, pos, time) {
    move_isun_and_scarab_actor(h_isuna, h_scarab, pos, time)
    wait_for_false1(is_actor_moving, h_scarab)
    wait_for_false1(is_actor_moving, h_isuna)
    wait(1)
}

function SeHazure() {
    wait(15)
    play_se(0x1000083)
    wait(15)
}

function BackHieroEntrance() {
    local party_count = get_party_count()

    for(local i = 0; i < party_count; i++) {
        local hact = get_party_order(i)
        start_actor_motion(hact, 1787)
    }

    wait(15)

    play_se(0x1000085)
    clear_fade_info()

    fadeout(0, 0, 2.0, 0, 1)

    const neg7 = -7
    wait(neg7)

    BackHieroJumpOnly()
}

function BackHieroJumpOnly() {
    switch(get_current_hiero_id()) {
        case 0:
            request_jump_scene(308, 75.0, -39.0, 180.0, -90.0, 0)
            set_flag(358)
            break;
        case 1:
            request_jump_scene(359, 72.5, 0.5, 750.0, -90.0, 0)
            set_flag(358)
            break;
        case 2:
            request_jump_scene(361, 780.0, 20.0, 78.5, 180.0, 0)
            set_flag(358)
            break;
        default:
            print("ERROR:HieroDungeon " + get_current_hiero_id() + " Is Not Exist")
            break;
    }
}

function ChangeSceneFromDungeonToEvent(next_scene_id, return_tag_point_id, next_tag_point_id = 0, posX = 0, posY = 0, posZ = 0, angle = 0) {
    fadeout_sync(0, 0, 0.25)
    set_flag(3920)
    set_var(152, get_scene_id())
    set_var(153, GetCurrentRoomId())
    set_var(156, return_tag_point_id)

    if(return_tag_point_id == 0) {
        local h_player = get_player()
        local pos = get_actor_position(h_player)
        local angleY = get_actor_angle_y(h_player)

        set_var(75, pos[0])
        set_var(76, pos[1])
        set_var(77, pos[2])
        set_var(78, angleY)
    }

    if(next_tag_point_id != 0) {
        request_jump_scene_tag(next_scene_id, next_tag_point_id, 0)
    } else {
        request_jump_scene(next_scene_id, posX, posY, posZ, angle, 0)
    }
}

function ChangeSceneFromEventToDungeon() {
    if(!test_flag(3920)) {
        assert(0)
    }

    local last_scene_id = get_var(152)

    if(last_scene_id < 0) {
        assert(0)
    }

    set_var(152, -1)

    request_jump_scene(last_scene_id, 0, 0, 0, 0, 0)
}

function ForcePlayerTalked(hplayer, htarget, start_act_enable = true) {
    SetNpcStartTalkActEnable(htarget, start_act_enable)

    local actor = get_actor_script(htarget)

    actor.OnPlayerTalked(hplayer, htarget)
    SetNpcStartTalkActEnable(htarget, true)
}

function PlayNextRoomBgm(next_area_id, prev_area_id = -1) {
    local zone_id = get_zone_id()

    if(zone_id == 20) {
        if(next_area_id == 16) {
            start_bgm(0x100002F)
            return true;
        } else if(next_area_id == 15 && prev_area_id == 16) {
            start_bgm(get_dungeon_bgm_id())
            return true;
        }
    } else if(zone_id == 21) {
        if(next_area_id == 18) {
            start_bgm(0x100002F)
            return true;
        } else if(next_area_id == 15 && prev_area_id == 18) {
            start_bgm(get_dungeon_bgm_id())
            return true;
        }
    } else if(zone_id == 22) {
        if(next_area_id == 21) {
            start_bgm(0x100002F)
            return true;
        } else if(next_area_id == 18 && prev_area_id == 21) {
            start_bgm(get_dungeon_bgm_id())
            return true;
        }
    } else if(zone_id == 23) {
        if(next_area_id == 29) {
            start_bgm(0x100002F)
            return true;
        } else if(next_area_id == 28 && prev_area_id == 29) {
            start_bgm(get_dungeon_bgm_id())
            return true;
        }
    }

    return false;
}

function OnHitWindowMasic(hplayer, htarget) {
    print("OnHitWindowMasic:" + hplayer + "," + htarget)

    foreach(group_table in bgobj_table_) {
        foreach(bgobj_list in group_table) {
            foreach(bgobj in bgobj_list) {
                if(bgobj.hself_ == htarget) {
                    bgobj.OnHitWindowMasic(hplayer, htarget)
                    return;
                }
            }
        }
    }
}

class EbioDrinkSequence {
    function CheckCompleteAllMaterial() {
        local result = check_drink_sequence_material_all()
        return result
    }

    function CheckCompleteMaterial(item_offset) {
        local result = check_drink_sequence_material(item_offset)
        return result
    }

    function GiveItem() {
        give_drink_sequence_item()
    }

    function SaveTime() {
        save_drink_sequence_time()
    }

    function ChackTime() {
        local result = check_drink_sequence_time()
        return result
    }

    function GetState(mode) {
        local state = get_drink_sequence_state(mode)
        return state
    }

    function UpdateSequence_FirstTalkMaterialComplete() {
        set_flag(1997)
        SaveTime()
        GiveItem()
        delete_idle_optional_quest(39)
        clear_sub_mission(4)
        set_mission_ui_to_do(43)
        set_var(13, 701)
    }

    function UpdateSequence_FirstTalkMaterialNotYet() {
        set_flag(1994)
        set_mission_ui_to_do(42)
        run_sub_mission(4)
        if(CheckCompleteMaterial(1) == false) {
            run_get_item_optional_quest(66)
        }
        if(CheckCompleteMaterial(2) == false) {
            run_get_item_optional_quest(67)
        }
        if(!check_optional_quest_completed(93)) {
            create_extend_mission_map_symbol(96)
        }
        set_var(13, 701)
    }

    function UpdateSequence_MaterialAllGet() {
        clear_sub_mission(4)
    }

    function UpdateSequence_MaterialComplete() {
        set_flag(1997)
        reset_flag(1994)
        SaveTime()
        GiveItem()
        clear_sub_mission(4)
        set_mission_ui_to_do(43)
        if(!check_optional_quest_completed(66)) {
            delete_idle_optional_quest(66)
        }
        if(!check_optional_quest_completed(67)) {
            delete_idle_optional_quest(67)
        }
    }

    function UpdateSequence_DrinkComplete() {
        reset_flag(1997)
        set_var(13, 0)
        add_item(7341, 1)
        set_mission_ui_to_do(44)
        create_extend_mission_map_symbol(95)
    }
}
