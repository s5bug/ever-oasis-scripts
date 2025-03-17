// TODO match line numbers

class Task {
    id_ = -1
    thread_ = null
    obj_ = null
    demo_exception_ = false
    commands_ = []
    cmd_count = 0

    constructor(id, obj, thread) {
        this.id_ = id
        this.thread_ = thread
        this.obj_ = obj
        this.commands_ = []
        this.demo_exception_ = false
        this.cmd_count = 0
    }
}

class Application {
    area_index = 0
    task_list = []
    coroutine_list = []
    event_skip = false
    demo_exceptoin_ = false // misspelled in original

    constructor() {
        this.area_index = this.task_list.len()
        this.task_list.append(Task(-1, Scene(), newthread(SceneMain)))
        this.coroutine_list.append(Task(100, null, newthread(__CoMain)))
        this.coroutine_list.append(Task(101, null, newthread(__CoMain)))
        this.coroutine_list.append(Task(102, null, newthread(__CoMain)))
        this.coroutine_list.append(Task(103, null, newthread(__CoMain)))
    }

    function Dispose() {
        this.task_list.clear()
        this.coroutine_list.clear()
        this.task_list = null
        this.coroutine_list = null
    }

    function GetCommand() {
        return this.task_list[this.area_index].commands_;
    }

    function GetTask() {
        return this.task_list[this.area_index];
    }

    function ClearCommand() {
        this.task_list[this.area_index].commands_.clear();
        this.task_list[this.area_index].cmd_count = 0;
    }

    function ClearCommandPriority(priority) {
        local temp = []
        local task = this.task_list[this.area_index]
        while(task.commands_.len() != task.cmd_count) {
            local notify_cmd = task.commands_[task.cmd_count++]
            local pri = task.commands_[task.cmd_count++]
            local args_count = task.commands_[task.cmd_count++]
            if(priority <= pri) {
                temp.append(notify_cmd)
                temp.append(pri)
                temp.append(args_count)
                local i = 0
                while(i < args_count) {
                    temp.append(task.commands_[task.cmd_count++])
                    i++
                }
            } else {
                task.cmd_count += args_count
            }
        }
        this.ClearCommand()
        foreach(cmd in temp) {
            task.commands_.append(cmd)
        }
    }

    function IsExistCommand(scene_event_id) {
        local task = this.task_list[this.area_index]
        local cmd_i = 0
        while(cmd_i < task.commands_.len()) {
            local notify_cmd = task.commands_[cmd_i++]
            local priority = task.commands_[cmd_i++]
            local args_count = task.commands_[cmd_i++]
            if(notify_cmd == scene_event_id) {
                return true
            } else {
                cmd_i += args_count
            }
        }
        return false
    }
}

g_app <- null

function initialize() {
    g_app = Application()
    init_scene_common()
}

function create_building_script(hact) {
    local scene = GetCurrentSceneObj()
    if(scene != null) {
        scene.build_list_.append(Building(hact))
    }
}

function remove_building_script(hact) {
    local scene = GetCurrentSceneObj()
    if(scene != null) {
        local i = 0
        while(i < scene.build_list_.len()) {
            if(scene.build_list_[i].hself == hact) {
                scene.build_list_.remove(i)
                --i
            }
            ++i
        }
    }
}

function debug_room_jump(next_area_id) {
    local cmd = g_app.GetCommand()

    cmd.append(8191)
    cmd.append(1)
    cmd.append(1)
    cmd.append(next_area_id)
}

function debug_change_scene(next_zone_id, next_scene_id) {
    local cmd = g_app.GetCommand()

    cmd.append(8190)
    cmd.append(1)
    cmd.append(2)
    cmd.append(next_zone_id)
    cmd.append(next_scene_id)
}

function __CreateChara(hact, chara_id) {
    print("CREATE:" + chara_id)
    
    switch(chara_id) {
        case 1:
        case 2:
            return Spirit(hact);
        case 748:
            return GuildMan(hact);
        case 749:
            return GuildMan2(hact);
        case 7:
            return Scarab(hact);
        case 25:
        case 26:
        case 27:
        case 28:
        case 29:
        case 30:
        case 31:
            return VendorNpc(hact);
        case 767:
        case 771:
        case 772:
        case 773:
        case 88:
            return EvUa_01(hact);
        case 78:
        case 752:
        case 753:
        case 754:
        case 755:
            return EvCeruke_01(hact);
        case 783:
        case 784:
        case 785:
        case 786:
            return EvIkune_01(hact);
        case 701:
            if(is_encounter_npc(hact) == true) {
                return EncounterNpc(hact);
            } else {
                return Ebio(hact);
            }
        case 710:
            if(is_encounter_npc(hact) == true) {
                return EncounterNpc(hact);
            } else {
                return Eseherc(hact);
            }
        case 769:
            if(is_encounter_npc(hact) == true) {
                return EncounterNpc(hact);
            } else {
                return Kaera(hact);
            }
        case 778:
            if(is_encounter_npc(hact) == true) {
                return EncounterNpc(hact);
            } else {
                return Miu(hact);
            }
        case 86:
            return OldmanCeruke(hact);
        case 87:
            return OldmanRikos(hact);
        case 85:
            return OldmanUa(hact);
        default:
            if(800 <= chara_id && chara_id <= 899) {
                return Penkurou(hact);
            } else if(is_quest_npc_actor(hact) == true) {
                return QuestNpc(hact);
            } else if(is_encounter_npc(hact) == true) {
                    return EncounterNpc(hact);
            } else {
                return GenericNpc(hact);
            }
    }
}

function create_chara_script(hact, chara_id) {
    local scene = GetCurrentSceneObj()

    if(scene != null) {
        local chara = __CreateChara(hact, chara_id)
        scene.chara_list_.append(chara)
    }
}

function remove_chara_script(hact) {
    local scene = GetCurrentSceneObj()

    if(scene != null) {
        local i = 0

        while(i < scene.chara_list_.len()) {
            if(scene.chara_list_[i].hself == hact) {
                print("remove_chara_script:" + hact)
                
                scene.chara_list_.remove(i)
                return;
            }
            ++i
        }
    }
}

function get_actor_script(hact) {
    local scene = GetCurrentSceneObj()

    foreach(actor in scene.chara_list_) {
        if(actor.hself == hact) {
            return actor
        }
    }
    return null
}

function load_and_create_multi_item_model_actor(multi_item_model_db_key, is_talk_event_actor) {
    local hact = null

    load_multi_item_model_archive(multi_item_model_db_key)
    func_wait(is_archive_loaded)
    hact = create_multi_item_model_actor(multi_item_model_db_key, is_talk_event_actor)
    return hact
}

function load_and_create_multi_item_model_actor_by_item_key(item_key, is_talk_event_actor) {
    local hact = null

    load_multi_item_model_archive_by_item_key(item_key)
    func_wait(is_archive_loaded)
    hact = create_multi_item_model_actor_by_item_key(item_key, is_talk_event_actor)
    return hact
}

function create_demo_event_actor(chara_id, rc_enabeld = false) {
    local hact = get_hactor_by_chara_id(chara_id)

    if(hact == 0) {
        load_actor_archive_sync(1, chara_id, rc_enabeld)
        local dbkey = get_dbkey_by_charaId(chara_id)

        if(dbkey == -1) {
            hact = create_temp_actor(chara_id, 10.0, 0.0, 10.0, 0.0, true)
        } else {
            hact = create_actor(dbkey, 1, 10.0, 0.0, 10.0, 0.0)
        }
    }

    return hact
}

function create_talk_event_actor(chara_id) {
    local hact = null

    load_actor_archive_sync(1, chara_id)
    local dbkey = get_dbkey_by_charaId(chara_id)

    if(dbkey == -1) {
        hact = create_temp_talk_event_actor_index(chara_id, 1, 0, 0.0)
    } else {
        hact = create_talk_event_actor_index(dbkey, 1, 0, 0.0)
    }
    return hact
}

function move_talk_event_actor(hact, walk_type, pos_x, time) {
    move_actor(hact, walk_type, [
        pos_x,
        0.0,
        0.0
    ], time)
}

function move_talk_event_actor_by_index(hact, walk_type, index, time) {
    local pos_x = get_talk_event_actor_pos_x(index)

    move_talk_event_actor(hact, walk_type, pos_x, time)
}

function turn_talk_event_actor_by_index(hact, index, time) {
    local angle_y = get_talk_event_actor_angle_y(index)

    turn_actor(hact, 0, angle_y, time)
}

function msg_talk_event(text_id, speaker, opt = 0, argv = 0) {
    local _opt = [
        0,
        false,
        149,
        0
    ]

    if(typeof(opt) != "array") {
        opt = [opt]
    }
    
    {
        local i = 0
        while(i < opt.len()) {
            _opt[i] = opt[i]
            i++
        }
    }

    msg(text_id, speaker, _opt, argv)
}

function msg_sync_talk_event(text_id, speaker = 0, opt = 0) {
    msg_talk_event(text_id, speaker, opt)

    func_wait(is_msg_finished)
}

function msg_argv_sync_talk_event(text_id, speaker, opt, argv) {
    msg_talk_event(text_id, speaker, opt, argv)

    func_wait(is_msg_finished)
}

function msg_sync_talk_event_system_blue_window(text_id, speaker) {
    msg(text_id, speaker, [0, false, 149, 1])

    func_wait(is_msg_finished)
}

function talk_event_slide_move_wait(hact) {
    wait_for_true2(is_action_finished, hact, 109)
}

function talk_event_slide_move_sync(hact, index) {
    talk_actor_slide_move(hact, index)
    talk_event_slide_move_wait(hact)
}

function action_wait(hact, action) {
    while(is_action_finished(hact, action) == false) {
        Suspend()
    }
}

function motion_wait(hact) {
    Suspend()
    while(is_motion_finished(hact) == false) {
        Suspend()
    }
}

function motion_wait_with_id(hact, motion_id) {
    Suspend()
    while(is_motion_finished(hact, motion_id) == false) {
        Suspend()
    }
}

function party_weapon_in_out_sync(weapon_io, is_motion) {
    local party = [
        get_party_index(0),
        get_party_index(1),
        get_party_index(2)
    ]

    if(party[0] != 0) {
        idle_actor(party[0], weapon_io, is_motion)
    }
    if(party[1] != 0) {
        idle_actor(party[1], weapon_io, is_motion)
    }
    if(party[2] != 0) {
        idle_actor(party[2], weapon_io, is_motion)
    }

    if(party[0] != 0) {
        wait_for_false1(is_actor_equipping_weapon, party[0])
    }
    if(party[1] != 0) {
        wait_for_false1(is_actor_equipping_weapon, party[1])
    }
    if(party[2] != 0) {
        wait_for_false1(is_actor_equipping_weapon, party[2])
    }
}

function ui_wait(uiid) {
    while(is_ui_active(uiid)) {
        Suspend()
    }
}

function ui_sync(uiid, args = []) {
    ui_activate(uiid, args)

    while(is_ui_active(uiid)) {
        Suspend()
    }

    return get_ui_results(uiid)
}

function fadein_sync(color = 3, display = 0, speed = 1.0, layer = 0, type = 0) {
    fadein(color, display, speed, layer, type)
    const neg7 = -7
    wait(neg7)
}

function fadeout_sync(color = 0, display = 0, speed = 1.0, layer = 0, type = 0) {
    fadeout(color, display, speed, layer, type)
    const neg7 = -7
    wait(neg7)
}

function msg_sync(text_id, speaker = 0, opt = 0) {
    msg(text_id, speaker, opt)
    func_wait(is_msg_finished)
}

function msg_argv_sync(text_id, speaker, opt, argv) {
    msg(text_id, speaker, opt, argv)
    func_wait(is_msg_finished)
}

function telop_valign_sync(text_id, valign, use_border = false) {
    local align_pos_array = [150, 85, 0]
    local window_type = 3

    if(use_border) {
        window_type = 4
    }

    msg_sync(text_id, 0, [0, false, align_pos_array[valign], window_type])
}

function load_actor_archive_sync(actor_part, id, ref_cnt = false) {
    load_actor_archive(actor_part, id, ref_cnt)
    func_wait(is_archive_loaded)
}

function load_archive_direct_sync(data_name) {
    load_actor_archive_direct(data_name)
    func_wait(is_archive_loaded)
}

function load_and_init_time_line_demo(data_name) {
    load_actor_archive_direct(data_name)
    func_wait(is_archive_loaded)
    build_time_line_demo(data_name, data_name)
}

function load_and_init_time_line_demo_deffer_name(data_name, tla_name) {
    load_actor_archive_direct(data_name)
    func_wait(is_archive_loaded)
    build_time_line_demo(data_name, tla_name)
}

function load_module_sync(module_name) {
    load_module(module_name)
    func_wait(is_module_loaded)
}

function set_demo_event_sync() {
    set_demo_event(true)
    while(is_demo_event_ready() == false) {
        Suspend()
    }
}

function wait_for_true1(func, args) {
    Suspend()
    while(func(args) == false) {
        Suspend()
    }
}

function wait_for_true2(func, args1, args2) {
    Suspend()
    while(func(args1, args2) == false) {
        Suspend()
    }
}

function func_wait(func) {
    Suspend()
    while(func() == false) {
        Suspend()
    }
}

function wait_for_false1(func, arg) {
    Suspend()
    while(func(arg) == true) {
        Suspend()
    }
}

function wait_for_false2(func, args1, args2) {
    Suspend()
    while(func(args1, args2) == true) {
        Suspend()
    }
}

function wait_for_false(func) {
    Suspend()
    while(func() == true) {
        Suspend()
    }
}

function wait(frame) {
    const neg9 = -9
    const neg8 = -8
    const neg7 = -7
    const neg3 = -3
    if(frame == neg9) {
        Suspend()
        while(is_finished_camera_target() == false) {
            Suspend()
        }
        return false
    } else if(frame == neg8) {
        while(is_finished_petit() == false) {
            Suspend()
        }
        return false
    } else if(frame == neg7) {
        while(is_fade() == true) {
            Suspend()
        }
        return false
    } else if(frame == neg3) {
        while(pad_trig(16) == false) {
            Suspend()
        }
        return false
    }

    local f_frame = frame.tofloat()
    while(0.0 < f_frame) {
        Suspend()
        f_frame -= get_delta_frame()
    }

    return false
}

function main() {
    g_app.demo_exceptoin_ = false
    
    for(local i = 0; i < g_app.task_list.len(); i++) {
        local task = g_app.task_list[i]
        if(task.thread_.getstatus() == "idle") {
            if(task.thread_.call(task)) {
                task.thread_ = null
            }
        } else if(task.thread_.getstatus() == "suspended") {
            if(task.thread_.wakeup()) {
                task.thread_ = null
            }
        }
    }

    foreach(task in g_app.coroutine_list) {
        if(task.thread_.getstatus() == "suspended") {
            g_app.demo_exceptoin_ = task.demo_exception_
            task.thread_.wakeup()
        }
    }

    return -1
}

function finalize() {
    print("ui_choice_destroy")
    ui_choice_destroy()
    destory_scene_common()
    g_app.Dispose()
    g_app = null
}

function scene_event(type, demo_flag) {
    local cmd = g_app.GetCommand()
    switch(type) {
        case 2:
            cmd.append(4098)
            cmd.append(1)
            cmd.append(1)
            cmd.append(demo_flag)
            break;
        case 1:
            cmd.append(4096)
            cmd.append(1)
            cmd.append(0)
            break;
        case 0:
            print("scene_event::Finalize")
            g_app.task_list[g_app.area_index].obj_.Finalize()
            StopCoroutineAll()
            finalize()
            break;
    }
}

function StopCoroutineAll() {
    request_demo_skip()
    g_app.demo_exceptoin_ = true
    foreach(task in g_app.coroutine_list) {
        if(task.thread_.getstatus() == "suspended") {
            g_app.demo_exceptoin_ = true
            task.thread_.wakeup()
        }
    }
}

function phantom_event(act, phm_lytid, hact) {
    local cmd = g_app.GetCommand()
    cmd.append(4099)
    cmd.append(1)
    cmd.append(3)
    cmd.append(hact)
    cmd.append(phm_lytid)
    cmd.append(act)
}

function actor_event(kind, hact, group_id, rest_group_member_num) {
    local cmd = g_app.GetCommand()

    if(kind == 1) {
        print("actor_event:ActorLifeZero [act:" + hact + "]")
        cmd.append(4119)
        cmd.append(1)
        cmd.append(3)
        cmd.append(hact)
        cmd.append(group_id)
        cmd.append(rest_group_member_num)
    } else {
        print("actor_event:ActorDead [act:" + hact + "]")
        cmd.append(4102)
        cmd.append(1)
        cmd.append(3)
        cmd.append(hact)
        cmd.append(group_id)
        cmd.append(rest_group_member_num)
    }
}

function timer_event(id) {
    local cmd = g_app.GetCommand()

    cmd.append(4100)
    cmd.append(1)
    cmd.append(1)
    cmd.append(id)
}

function switch_event(id) {
    local cmd = g_app.GetCommand()

    cmd.append(4101)
    cmd.append(1)
    cmd.append(1)
    cmd.append(id)
}

function pl_response_event(type, hplayer, htarget, kind) {
    local cmd = g_app.GetCommand()

    cmd.append(4103 + type)
    cmd.append(1)
    cmd.append(3)
    cmd.append(hplayer)
    cmd.append(htarget)
    cmd.append(kind)
}

function date_time_period_event(date_period) {
    local cmd = g_app.GetCommand()

    cmd.append(4109)
    cmd.append(1)
    cmd.append(1)
    cmd.append(date_period)
}

function day_end_in_town() {
    local cmd = g_app.GetCommand()

    cmd.append(4129)
    cmd.append(1)
    cmd.append(0)
}

function constract_event(hact, px, py, pz, angle) {
    local cmd = g_app.GetCommand()

    cmd.append(4110)
    cmd.append(1)
    cmd.append(5)
    cmd.append(hact)
    cmd.append(px)
    cmd.append(py)
    cmd.append(pz)
    cmd.append(angle)
}

function mission_start_event(event_id) {
    local cmd = g_app.GetCommand()

    cmd.append(4111)
    cmd.append(1)
    cmd.append(1)
    cmd.append(event_id)
}

function mission_complete_event(event_id) {
    local cmd = g_app.GetCommand()

    cmd.append(4112)
    cmd.append(1)
    cmd.append(1)
    cmd.append(event_id)
}

function quest_complete_event(event_id, target_handle, script_type) {
    local cmd = g_app.GetCommand()

    cmd.append(4113)
    cmd.append(1)
    cmd.append(3)
    cmd.append(event_id)
    cmd.append(target_handle)
    cmd.append(script_type)
}

function quest_battle_event(event_id, enemy_handle) {
    local cmd = g_app.GetCommand()

    cmd.append(4121)
    cmd.append(1)
    cmd.append(2)
    cmd.append(event_id)
    cmd.append(enemy_handle)
}

function optional_quest_event(event_id, target_handle, script_type) {
    local cmd = g_app.GetCommand()

    cmd.append(4114)
    cmd.append(1)
    cmd.append(3)
    cmd.append(event_id)
    cmd.append(target_handle)
    cmd.append(script_type)
}

function boss_dying_event(hact, state) {
    local cmd = g_app.GetCommand()

    cmd.append(4115)
    cmd.append(1)
    cmd.append(2)
    cmd.append(hact)
    cmd.append(state)
}

function visit_timing_event() {
    assert(0)
}

function battle_event(state) {
    local cmd = g_app.GetCommand()

    cmd.append(4118)
    cmd.append(1)
    cmd.append(1)
    cmd.append(state)
}

function on_achieve(achieve_flags_1, achieve_flags_2) {
    local cmd = g_app.GetCommand()

    cmd.append(4130)
    cmd.append(0)
    cmd.append(2)
    cmd.append(achieve_flags_1)
    cmd.append(achieve_flags_2)
}

function on_hit_happower(player, target) {
    local cmd = g_app.GetCommand()

    cmd.append(4120)
    cmd.append(1)
    cmd.append(2)
    cmd.append(player)
    cmd.append(target)
}

function on_pull_grass(player, target) {
    local cmd = g_app.GetCommand()

    cmd.append(4128)
    cmd.append(1)
    cmd.append(2)
    cmd.append(player)
    cmd.append(target)
}

function on_change_road() {
    local cmd = g_app.GetCommand()

    cmd.append(4131)
    cmd.append(1)
    cmd.append(0)
}

function on_skill_panel_touched(type, hplayer, htarget, kind) {
    local cmd = g_app.GetCommand()

    cmd.append(4132)
    cmd.append(1)
    cmd.append(3)
    cmd.append(hplayer)
    cmd.append(htarget)
    cmd.append(kind)
}

function on_approach_chaos_butterfly(htarget) {
    local cmd = g_app.GetCommand()

    cmd.append(4133)
    cmd.append(1)
    cmd.append(1)
    cmd.append(htarget)
}

function on_first_down_tutorial(htarget) {
    local cmd = g_app.GetCommand()

    cmd.append(4134)
    cmd.append(1)
    cmd.append(1)
    cmd.append(htarget)
}

function generic_event(parameters) {
    local cmd = g_app.GetCommand()

    cmd.append(6144)
    cmd.append(1)
    cmd.append(1)
    cmd.append(parameters)
}

function request_jump_scene(scene, posX, posY, posZ, angle, option) {
    print("===== request_jump_scene()")
    g_app.ClearCommandPriority(1)

    local cmd = g_app.GetCommand()

    cmd.append(8192)
    cmd.append(2)
    cmd.append(7)
    cmd.append(0)
    cmd.append(scene)
    cmd.append(posX)
    cmd.append(posY)
    cmd.append(posZ)
    cmd.append(angle)
    cmd.append(option)
}

function request_jump_scene_tag(scene, tag_point_id, option) {
    print("===== request_jump_scene_tag()")
    g_app.ClearCommandPriority(1)

    local cmd = g_app.GetCommand()

    cmd.append(8192)
    cmd.append(2)
    cmd.append(4)
    cmd.append(1)
    cmd.append(scene)
    cmd.append(tag_point_id)
    cmd.append(option)
}

function request_interrupt_mission_start_event(event_id) {
    print("===== request_interrupt_mission_start_event()")

    local cmd = g_app.GetCommand()
    local next_cmd_count = g_app.task_list[g_app.area_index].cmd_count

    cmd.insert(next_cmd_count + 0, 4111)
    cmd.insert(next_cmd_count + 1, 1)
    cmd.insert(next_cmd_count + 2, 1)
    cmd.insert(next_cmd_count + 3, event_id)
}

function request_interrupt_mission_complete_event(event_id) {
    print("===== request_interrupt_mission_complete_event()")

    local cmd = g_app.GetCommand()
    local next_cmd_count = g_app.task_list[g_app.area_index].cmd_count

    cmd.insert(next_cmd_count + 0, 4112)
    cmd.insert(next_cmd_count + 1, 1)
    cmd.insert(next_cmd_count + 2, 1)
    cmd.insert(next_cmd_count + 3, event_id)
}

function request_demo_skip() {
    g_app.event_skip = true
}

function is_requested_achieve() {
    return g_app.IsExistCommand(4130);
}

function SceneMain(task) {
    if(task.commands_.len() == 0) {
        return false
    }
    task.cmd_count = 0
    while(task.commands_.len() != task.cmd_count) {
        local notify_cmd = task.commands_[task.cmd_count++]
        local pri = task.commands_[task.cmd_count++]
        local arg_count = task.commands_[task.cmd_count++]

        // For some reason, this just doesn't show up in the local variables list...
        local unk0 = task.cmd_count
        task.cmd_count += arg_count;
        switch(notify_cmd) {
            case 4099:
                local hact = task.commands_[unk0]
                local phm_lytid = task.commands_[unk0 + 1]
                local act = task.commands_[unk0 + 2]
                if(act == 1) {
                    task.obj_.OnPhantomEnterEvent(phm_lytid, hact)
                } else {
                    task.obj_.OnPhantomLeaveEvent(phm_lytid, hact)
                }
                break;
            case 4102:
                local hact = task.commands_[unk0]
                local group_id = task.commands_[unk0 + 1]
                local rest_group_member_num = task.commands_[unk0 + 2]
                task.obj_.OnActorDeadEvent(hact, group_id, rest_group_member_num)
                
                request_auto_run_mission()
                break;
            case 4119:
                local hact = task.commands_[unk0]
                local group_id = task.commands_[unk0 + 1]
                local rest_group_member_num = task.commands_[unk0 + 2]
                task.obj_.OnActorLifeZeroEvent(hact, group_id, rest_group_member_num)

                request_auto_run_mission()
                break;
            case 4101:
                local switch_id = task.commands_[unk0]
                task.obj_.OnSwitchChanged(switch_id)
                break;
            case 4132:
                task.obj_.OnSkillPanelTouched(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            case 4133:
                local hact = task.commands_[unk0]
                task.obj_.OnApproachChaosButterfly(hact)
                break;
            case 4134:
                local hact = task.commands_[unk0]
                task.obj_.OnFirstDownTutorial(hact)
                break;
            case 6144:
                local parameters = task.commands_[unk0]
                task.obj_.GenericEvent(parameters)
                break;
            case 4118:
                local begin = task.commands_[unk0]
                task.obj_.OnBattleEvent(begin)
                break;
            case 4100:
                local timer_id = task.commands_[unk0]
                task.obj_.OnTick(timer_id)
                break;
            case 4103:
                task.obj_.OnPlayerTalked(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )

                request_auto_run_mission()
                update_actor_head_info()
                break;
            case 4104:
                task.obj_.OnPlayerShopping(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            case 4105:
                task.obj_.OnPlayerCarry(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            case 4106:
                task.obj_.OnPlayerDoor(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            case 4107:
                task.obj_.OnPlayerHatena(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            case 4108:
                task.obj_.OnPlayerSkill(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1],
                    task.commands_[unk0 + 2]
                )
                break;
            case 4109:
                task.obj_.OnDateTimePeriod(
                    task.commands_[unk0]
                )
                break;
            case 4129:
                task.obj_.OnDayEndInTown()
                break;
            case 4110:
                task.obj_.OnConstruct(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1],
                    task.commands_[unk0 + 2],
                    task.commands_[unk0 + 3],
                    task.commands_[unk0 + 4]
                )
                break;
            case 4111:
                task.obj_.OnMissionStartEvent(
                    task.commands_[unk0]
                )
                update_actor_head_info()
                break;
            case 4112:
                task.obj_.OnMissionCompleteEvent(
                    task.commands_[unk0]
                )
                request_auto_run_mission()
                update_actor_head_info()
                break;
            case 4113:
                task.obj_.OnQuestCompleteEvent(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1],
                    task.commands_[unk0 + 2]
                )
                request_auto_run_mission()
                break;
            case 4121:
                task.obj_.OnQuestBattleEvent(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            case 4114:
                task.obj_.OnOptionalQuestEvent(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1],
                    task.commands_[unk0 + 2]
                )
                update_actor_head_info()
                break;
            case 4115:
                task.obj_.OnBossDyingEvent(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            case 4130:
                task.obj_.OnAchieve([
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                ])
                break;
            case 4120:
                task.obj_.OnHitHappower(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            case 4128:
                task.obj_.OnPullGrass(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            case 4131:
                task.obj_.OnChangeRoad()
                break;
            case 8192:
                print("SceneEvent.SceneChangeEvent")
                if(task.commands_[unk0] == 0) {
                    local scene = task.commands_[unk0 + 1]
                    local posX = task.commands_[unk0 + 2]
                    local posY = task.commands_[unk0 + 3]
                    local posZ = task.commands_[unk0 + 4]
                    local angle = task.commands_[unk0 + 5]
                    local option = task.commands_[unk0 + 6]

                    jump_scene(scene, posX, posY, posZ, angle, option)
                } else if(task.commands_[unk0] == 1) {
                    local scene = task.commands_[unk0 + 1]
                    local tag_point_id = task.commands_[unk0 + 2]
                    local option = task.commands_[unk0 + 3]

                    jump_scene(scene, tag_point_id, option)
                }
                break;
            case 4096:
                task.obj_.Initialize()
                break;
            case 4097:
                task.obj_.Finalize()
                break;
            case 4098:
                task.obj_.mission_demo_flag = task.commands_[unk0]
                task.obj_.OnPostLoad()
                break;
            case 8191:
                ChangeRoomForEventJump(task.commands_[unk0])
                break;
            case 8190:
                ChangeSceneForDebug(
                    task.commands_[unk0],
                    task.commands_[unk0 + 1]
                )
                break;
            default:
                // TODO convert files to Shift-JIS before compiling them
                print("SceneMain: コマンドエラー")
                local cnt = 0
                foreach(cmd in task.commands_) {
                    print("cmd >" + cmd)
                    if(cnt == unk0) {
                        break
                    }
                    cnt++
                }
                assert(0)
                break;
        }
    }
    task.commands_.clear()
    return false;
}

function __CoMain(task, func, args) {
    func(args)
}

function GetCurrentSceneObj() {
    return g_app.task_list[g_app.area_index].obj_;
}

function Async(func, args) {
    foreach(task in g_app.coroutine_list) {
        if(task.thread_.getstatus() == "idle") {
            task.demo_exception_ = false
            task.thread_.call(task, func, args)
            return task;
        }
    }
    return null;
}

function Await(task) {
    if(task == null || task.thread_ == null) {
        return true
    }
    while(1) {
        if(task.thread_.getstatus() == "idle") {
            return true
        }
        suspend(false)
    }
}

function DemoProc__(args) {
    args.Initialize()   

    local is_event_skip = false

    try {
        set_demo_skip_fade_white(args.IsSkipFadeWhite())
        demo_skip_enabled(args.IsEnableSkip())
        args.Process()
    } catch (e) {
        if(e == "demoskip") {
            print("------------------------------------------------")
            print("EVENT SKIP")
            print("------------------------------------------------")

            is_event_skip = true
        }
    }

    g_app.demo_exceptoin_ = false
    demo_skip_enabled(false)
    g_app.event_skip = false

    if(is_event_skip) {
        args.AfterSkipFunc()
    }

    skippable_demo(false)
    args.Finalize()
}

function AsyncDemo(args) {
    skippable_demo(true)
    demo_skip_enabled(false)
    local th = Async(DemoProc__, args)
    th.demo_exception_ = true
    return th;
}

function Suspend() {
    if(g_app.demo_exceptoin_ && g_app.event_skip) {
        throw "demoskip"
    }
    suspend(false)
}
