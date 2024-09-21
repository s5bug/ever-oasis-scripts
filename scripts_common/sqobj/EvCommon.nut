// TODO match line infos

class CommonDemoEventSet extends DemoEventSetBase {
    param_ = []

    constructor() {
        this.param_ = [
            this.__FIRST_BATTLE, 2, -1,
            this.__FIRST_VICTORY, 2, -1,
            this.__HIERO_ENTRANCE, 2, -1,
            this.__GET_MATERIAL_02, 2, -1,
            this.__GET_MATERIAL_03, 2, -1,
            this.__FIRST_SCOUT, 2, -1,
            this.__OASIS_CHAOS_AGAIN, 2, -1,
            this.__GET_ROSEBERY, 2, -1,
            this.__BATTLE_TUTO_PROTECTION, 2, -1,
            this.__FLYING_ENEMY_TUTORIAL, 2, -1,
            this.__MAGIC_TUTO, 2, -1,
            this.__WANT_WAND, 2, -1,
            this.__USE_WAND, 2, -1,
            this.__GET_WHEAT_SEED, 2, -1,
            this.__GET_WHEAT, 2, -1,
            this.__GET_STAR_SAND, 2, -1,
            this.__GET_COLORED_GLASS, 2, -1,
            this.__QUEST_NAARMA_03, 2, -1,
            this.__QUEST_ZYASUPA_03, 2, -1,
            this.__QUEST_MARAIA_02, 2, -1,
            this.__QUEST_CESSIEN_03, 2, -1,
            this.__QUEST_ZYASUPA_02, 2, -1,
            this.__QUEST_HOLUAJA_02, 2, -1,
            this.__QUEST_MAGDARENA_03, 2, -1,
            this.__QUEST_NINECZERE_01, 2, -1,
            this.__QUEST_ZERINUB_02, 2, -1,
            this.__QUEST_NUBBIT_03, 2, -1,
            this.__QUEST_BELLTSONY_01, 2, -1,
            this.__CHAOS_AGAIN_JUMP, 2, -1
        ]
    }

    function StartDemo(demo_id, args) {
        set_var(9, 0)

        if(this.param_[(demo_id * 3) + 1] == 1) {
            set_flag(this.param_[(demo_id * 3) + 2])
        }

        set_demo_event_sync()
        this.param_[demo_id * 3](args)
        set_demo_event(false)
    }

    function StartInnerDemo(demo_id, args) {
        print("☆☆☆☆☆☆☆☆☆☆demo_id = " + demo_id)

        this.param_[demo_id * 3](args)
    }

    function IsEnabled(demo_id) {
        if(this.param_[(demo_id * 3) + 1] == 1) {
            return test_flag(this.param_[(demo_id * 3) + 2]) == false;
        }

        return true;
    }

    function __FIRST_BATTLE(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__FIRST_BATTLE!!!!!!!!!!!!!!!!!!!!!!!!!")

        local h_scarab_and_isuna = 0
        local h_talk_actors = 0
        local h_player = 0

        EventStart(0)
        set_enemy_sleep(true)

        PadOffWait(0)
        wait(30)

        local h_player = get_player()
        local h_scarab_and_isuna = CreateSimpleScarabAndIsuna(h_player)
        local h_talk_actors = StartScarabIsunaTalkEventAppear()

        set_actor_facial(h_talk_actors[1], 3)
        set_actor_facial(h_talk_actors[0], 2)
        msg_sync_talk_event(50201, h_talk_actors[1])
        start_actor_motion_auto_idle(h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, h_talk_actors[0], 300)

        wait(20)

        reset_actor_facial(h_talk_actors[0])
        EndScarabIsunaTalkEventDestroyOnly(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
        DestroySimpleScarabAndIsuna(h_scarab_and_isuna[0], h_scarab_and_isuna[1])
        ui_sync(5, [83178, 83179])
        tutorial_icon_end()
        mapmenu_force_button_end()

        PadOnWait(0)

        set_enemy_sleep(false)

        reset_flag(4060)
        EventEnd()
    }

    function __FIRST_VICTORY(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__FIRST_VICTORY!!!!!!!!!!!!!!!!!!!!!!!!!")

        local h_scarab_and_isuna = 0
        local h_talk_actors = 0
        local h_player = 0

        EventStart(0)
        set_enemy_sleep(true)

        wait(30)

        local h_player = get_player()
        local h_scarab_and_isuna = SimpleScarabAndIsunaCreateOnly()
        local h_talk_actors = StartScarabIsunaTalkEventAppear()

        msg_sync_talk_event(45227, h_talk_actors[1])
        start_actor_motion_auto_idle(h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, h_talk_actors[0], 300)

        wait(15)

        EndScarabIsunaTalkEventDestroyOnly(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
        SimpleScarabAndIsunaDestroyOnly(h_scarab_and_isuna[0], h_scarab_and_isuna[1])

        EventEnd()
        PadOffWait(0)

        mapmenu_force_button(2)
        tutorial_icon_start()
        tutorial_icon_set(1)
        black_mask_d_end()
        ui_sync(5, [83162, 83163, 83164])
        tutorial_icon_end()
        mapmenu_force_button_end()

        PadOnWait(0)

        set_enemy_sleep(false)
    }

    function __HIERO_ENTRANCE(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__HIERO_ENTRANCE!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipHIERO_ENTRANCE(args)

        Await(AsyncDemo(demo))
    }

    function __GET_MATERIAL_02(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__GET_MATERIAL_02!!!!!!!!!!!!!!!!!!!!!!!!!")

        local h_player = 0
        local h_scarab_and_isuna = 0
        local h_talk_actors = 0
        local ds = EbioDrinkSequence()

        EventStart(0)
        h_player = get_party_index(0)
        set_enemy_sleep(true)

        local h_scarab_and_isuna = SimpleScarabAndIsunaCreateOnly()
        local h_talk_actors = StartScarabIsunaTalkEventAppear()

        msg_sync_talk_event(93214, h_talk_actors[1])

        if(ds.CheckCompleteAllMaterial()) {
            msg_sync_talk_event(93216, h_talk_actors[1])
            ds.UpdateSequence_MaterialAllGet()
        } else {
            msg_sync_talk_event(93217, h_talk_actors[1])
        }

        start_actor_motion_auto_idle(h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, h_talk_actors[0], 300)
        wait(15)

        EndScarabIsunaTalkEventDestroyOnly(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
        SimpleScarabAndIsunaDestroyOnly(h_scarab_and_isuna[0], h_scarab_and_isuna[1])
        EventEnd()
        set_enemy_sleep(false)
    }

    function __GET_MATERIAL_03(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__GET_MATERIAL_03!!!!!!!!!!!!!!!!!!!!!!!!!")

        local h_player = 0
        local h_scarab_and_isuna = 0
        local h_talk_actors = 0
        local ds = EbioDrinkSequence()

        EventStart(0)
        h_player = get_party_index(0)
        set_enemy_sleep(true)

        local h_scarab_and_isuna = SimpleScarabAndIsunaCreateOnly()
        local h_talk_actors = StartScarabIsunaTalkEventAppear()

        wait(10)

        msg_sync_talk_event(93215, h_talk_actors[1])

        if(ds.CheckCompleteAllMaterial()) {
            msg_sync_talk_event(93216, h_talk_actors[1])
            ds.UpdateSequence_MaterialAllGet()
        } else {
            msg_sync_talk_event(93217, h_talk_actors[1])
        }

        start_actor_motion_auto_idle(h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, h_talk_actors[0], 300)
        wait(15)

        EndScarabIsunaTalkEventDestroyOnly(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
        SimpleScarabAndIsunaDestroyOnly(h_scarab_and_isuna[0], h_scarab_and_isuna[1])
        EventEnd()
        set_enemy_sleep(false)
    }

    function __FIRST_SCOUT(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__FIRST_SCOUT!!!!!!!!!!!!!!!!!!!!!!!!!")

        local h_scarab_and_isuna = 0
        local h_talk_actors = 0
        local h_player = 0

        EventStart(0)
        
        start_idle_town_npc()
        start_invisible_town_npc()

        local h_player = get_player()
        local h_scarab_and_isuna = CreateSimpleScarabAndIsuna(h_player)
        local h_talk_actors = StartScarabIsunaTalkEventAppear()

        set_actor_facial(h_talk_actors[1], 6)

        msg_sync_talk_event(45223, h_talk_actors[1])
        start_actor_motion_auto_idle(h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, h_talk_actors[0], 300)

        wait(15)

        reset_actor_facial(h_talk_actors[1])

        EndScarabIsunaTalkEventDestroyOnly(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
        DestroySimpleScarabAndIsuna(h_scarab_and_isuna[0], h_scarab_and_isuna[1])

        end_invisible_town_npc()
        end_idle_town_npc()
        set_mission_ui_to_do(18)

        EventEnd()
    }

    function __OASIS_CHAOS_AGAIN(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__OASIS_CHAOS_AGAIN!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipOASIS_CHAOS_AGAIN(args)
        Await(AsyncDemo(demo))
    }

    function __GET_ROSEBERY(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__GET_ROSEBERY!!!!!!!!!!!!!!!!!!!!!!!!!")

        local h_scarab_and_isuna = 0
        local h_talk_actors = 0
        local h_player = 0

        EventStart(0)
        
        wait_for_false(is_item_get_effect)

        local h_player = get_player()
        local h_scarab_and_isuna = CreateSimpleScarabAndIsuna(h_player)
        local h_talk_actors = StartScarabIsunaTalkEventAppear()

        set_actor_facial(h_talk_actors[1], 6)

        msg_sync_talk_event(91006, h_talk_actors[1])
        start_actor_motion_auto_idle(h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, h_talk_actors[0], 300)

        wait(15)

        reset_actor_facial(h_talk_actors[1])

        EndScarabIsunaTalkEventDestroyOnly(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
        DestroySimpleScarabAndIsuna(h_scarab_and_isuna[0], h_scarab_and_isuna[1])

        EventEnd()
    }

    function __BATTLE_TUTO_PROTECTION(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__BATTLE_TUTO_PROTECTION!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipBATTLE_TUTO_PROTECTION(args)
        Await(AsyncDemo(demo))
    }

    function __FLYING_ENEMY_TUTORIAL(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__FLYING_ENEMY_TUTORIAL!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipFLYING_ENEMY_TUTORIAL(args)
        Await(AsyncDemo(demo))
    }

    function __MAGIC_TUTO(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__MAGIC_TUTO!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipMAGIC_TUTO(args)
        Await(AsyncDemo(demo))
    }

    function __WANT_WAND(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__WANT_WAND!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipWANT_WAND(args)
        Await(AsyncDemo(demo))
    }

    function __USE_WAND(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__USE_WAND!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipUSE_WAND(args)
        Await(AsyncDemo(demo))
    }

    function __GET_WHEAT_SEED(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__GET_WHEAT_SEED!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipGET_WHEAT_SEED(args)
        Await(AsyncDemo(demo))
    }

    function __GET_WHEAT(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__GET_WHEAT!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipGET_WHEAT(args)
        Await(AsyncDemo(demo))
    }

    function __GET_STAR_SAND(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__GET_STAR_SAND!!!!!!!!!!!!!!!!!!!!!!!!!")

        local h_scarab_and_isuna = 0
        local h_talk_actors = 0
        local h_player = 0

        EventStart(0)
        
        set_enemy_sleep(true)

        local h_player = get_player()
        local h_scarab_and_isuna = SimpleScarabAndIsunaCreateOnly()
        local h_talk_actors = StartScarabIsunaTalkEventAppear()

        set_actor_facial(h_talk_actors[1], 6)

        msg_sync_talk_event(94190, h_talk_actors[1])
        start_actor_motion_auto_idle(h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, h_talk_actors[0], 300)

        wait(20)

        EndScarabIsunaTalkEventDestroyOnly(h_talk_actors[0], h_talk_actors[1], h_talk_actors[2])
        SimpleScarabAndIsunaDestroyOnly(h_scarab_and_isuna[0], h_scarab_and_isuna[1])

        set_mission_ui_to_do(69)
        set_enemy_sleep(false)

        EventEnd()
    }

    function __GET_COLORED_GLASS(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__GET_COLORED_GLASS!!!!!!!!!!!!!!!!!!!!!!!!!")
    }

    function __QUEST_NAARMA_03(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!! __QUEST_NAARMA_03 !!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipQUEST_NAARMA_03(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_ZYASUPA_03(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!! __QUEST_ZYASUPA_03 !!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = Skip_QUEST_ZYASUPA_03(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_MARAIA_02(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__QUEST_MARAIA_02!!!!!!!!!!!!!!!!!!!!!!!!!")

        fadein(0, 0, 1.0)

        local demo = Skip_QUEST_MARAIA_02(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_CESSIEN_03(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!! __QUEST_CESSIEN_03 !!!!!!!!!!!!!!!!!!!!!!!!!")

        fadein(0, 0, 1.0)

        local demo = SkipQUEST_CESSIEN_03(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_ZYASUPA_02(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!! __QUEST_ZYASUPA_02 !!!!!!!!!!!!!!!!!!!!!!!!!")

        fadein(0, 0, 1.0)

        local demo = Skip_QUEST_ZYASUPA_02(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_HOLUAJA_02(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!! __QUEST_HOLUAJA_02 !!!!!!!!!!!!!!!!!!!!!!!!!")

        fadein(0, 0, 1.0)

        local demo = Skip_QUEST_HOLUAJA_02(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_MAGDARENA_03(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!! __QUEST_MAGDARENA_03 !!!!!!!!!!!!!!!!!!!!!!!!!")

        fadein(0, 0, 1.0)

        local demo = Skip_QUEST_MAGDARENA_03(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_NINECZERE_01(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!! __QUEST_NINECZERE_01 !!!!!!!!!!!!!!!!!!!!!!!!!")

        fadein(0, 0, 1.0)

        local demo = SkipQUEST_NINECZERE_01(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_ZERINUB_02(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!__QUEST_ZERINUB_02!!!!!!!!!!!!!!!!!!!!!!!!!")

        fadein(0, 0, 1.0)

        local demo = Skip_QUEST_ZERINUB_02(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_NUBBIT_03(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!___QUEST_NUBBIT_03!!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = Skip_QUEST_NUBBIT_03(args)
        Await(AsyncDemo(demo))
    }

    function __QUEST_BELLTSONY_01(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!! __QUEST_BELLTSONY_01 !!!!!!!!!!!!!!!!!!!!!!!!!")

        local demo = SkipQUEST_BELLTSONY_01(args)
        Await(AsyncDemo(demo))
    }

    function __CHAOS_AGAIN_JUMP(args) {
        print("!!!!!!!!!!!!!!!!!!!!!!!! __CHAOS_AGAIN_JUMP !!!!!!!!!!!!!!!!!!!!!!!!!")

        EventStart(0)

        fadein_sync(0, 0, 2.0)
        fadeout_sync(0, 0, 1.0)

        disable_town_bgm_manage()
        stop_bgm(0x2D)

        local hquest = get_quest_handle(3, 110)
        local ret = run_quest(3, hquest)

        set_flag(1963)
        force_town_chaos()

        EventEnd()

        local h_player = get_player()
        local curt_id = get_scene_id()
        local pos = get_actor_position(h_player)
        local angleY = get_actor_angle_y(h_player)

        set_var(79, curt_id)
        set_var(75, pos[0])
        set_var(76, pos[1])
        set_var(77, pos[2])
        set_var(78, angleY)

        local zone = get_zone_id()

        if(zone == 52) {
            ChangeSceneFromDungeonToEvent(1035, 0, 0, 1374.0, 14.0, -1261.0, 291.0)
        } else {
            request_jump_scene(1035, 1374.0, 14.0, -1261.0, 291.0, 0)
        }
    }
}

class SkipFIRST_BATTLE extends SkipDemoEventBase {
    h_player = 0
    h_scarab_and_isuna = 0

    function Initialize() {
        print("SkipFIRST_BATTLEInitialize")

        EventStart(0)
        set_enemy_sleep(true)

        this.h_player = get_player()
    }

    function Process() {
        print("SkipFIRST_BATTLEProcess")

        this.h_scarab_and_isuna = CreateSimpleScarabAndIsuna(this.h_player)
        AppearSimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1], this.h_player)
        msg_sync(50201, this.h_scarab_and_isuna[1])

        wait(30 * 2.5)

        LeaveSimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1], this.h_player)
        DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
    }

    function Finalize() {
        print("SkipFIRST_BATTLEFinalize")

        if(this.h_scarab_and_isuna != 0) {
            DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        }

        fadein_sync(0, 0, 1.0)
        EventEnd()
        fadein_sync(0, 0, 1.0)
        ui_sync(5, [83178, 83179])
        set_enemy_sleep(false)
    }
}

class SkipFIRST_VICTORY extends SkipDemoEventBase {
    function Initialize() {
        print("SkipFIRST_VICTORY Initialize")
    }

    function Process() {
        print("SkipFIRST_VICTORY Process")
    }

    function Finalize() {
        print("SkipFIRST_VICTORY Finalize")
    }
}

class SkipHIERO_ENTRANCE extends SkipDemoEventBase {
    h_party1 = 0
    h_party2 = 0
    h_scarab_and_isuna = 0
    h_talk_actors = 0
    h_player = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)

        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player)
        idle_actor(this.h_party1)
        idle_actor(this.h_party2)
    }

    function Process() {
        print("SampleDemo Process")

        this.h_scarab_and_isuna = SimpleScarabAndIsunaCreateOnly()
        this.h_talk_actors = StartScarabIsunaTalkEventAppear()

        msg_sync_talk_event(93090, this.h_talk_actors[1])
        msg_sync_talk_event(93258, this.h_talk_actors[1])
        start_actor_motion_auto_idle(this.h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, this.h_talk_actors[0], 300)
        wait(15)

        EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        SimpleScarabAndIsunaDestroyOnly(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
    }
    
    function Finalize() {
        print("SampleDemo Finalize")

        if(this.h_talk_actors != 0) {
            EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        }
        if(this.h_scarab_and_isuna != 0) {
            DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        }

        fadein_sync(3, 0, 1.0)
        ui_sync(5, [83100, 83101, 83102])
        set_flag(1990)

        EventEnd()
    }
}

class SkipOASIS_CHAOS_AGAIN extends SkipDemoEventBase {
    h_scarab_and_isuna = 0
    h_talk_actors = 0
    h_player = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        set_enemy_sleep(true)

        this.h_player = get_player()

        fadein_sync(0, 0, 2.0)
    }

    function Process() {
        print("SampleDemo Process")

        this.h_scarab_and_isuna = SimpleScarabAndIsunaCreateOnly()
        this.h_talk_actors = StartScarabIsunaTalkEventAppear()

        set_actor_facial(this.h_talk_actors[0], 3)
        set_actor_facial(this.h_talk_actors[1], 3)
        msg_sync_talk_event(94169, this.h_talk_actors[1])
        msg_sync_talk_event(94170, this.h_talk_actors[1])
        set_actor_facial(this.h_talk_actors[0], 2)
        set_actor_facial(this.h_talk_actors[1], 2)
        msg_sync_talk_event(94171, this.h_talk_actors[1])
        start_actor_motion_auto_idle(this.h_talk_actors[0], 291)

        wait_for_true2(is_motion_finished, this.h_talk_actors[0], 291)

        EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        SimpleScarabAndIsunaDestroyOnly(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        msg_sync(94276, 0, [0, false, 0, 3])
        start_actor_motion_auto_idle(this.h_player, 320)

        wait_for_true2(is_motion_finished, this.h_player, 320)

        msg_sync(94277, 0, [0, false, 0, 3])

        local curt_id = get_scene_id()
        if(curt_id == 25 || curt_id == 1018 || curt_id == 26 || curt_id == 1019) {
            msg_sync(94278, 0, [0, false, 0, 3])
            msg_sync(94279, 0, [0, false, 0, 3])
            start_actor_motion_auto_idle(this.h_player, 300)

            wait_for_true2(is_motion_finished, this.h_player, 300)

            this.h_scarab_and_isuna = SimpleScarabAndIsunaCreateOnly()
            this.h_talk_actors = StartScarabIsunaTalkEventAppear()

            msg_sync_talk_event(94280, this.h_talk_actors[1])
            start_actor_motion_auto_idle(this.h_talk_actors[0], 300)

            wait_for_true2(is_motion_finished, this.h_talk_actors[0], 300)

            wait(15)

            EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
            SimpleScarabAndIsunaDestroyOnly(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        } else {
            msg_sync(94281, 0, [0, false, 0, 3])
            msg_sync(94279, 0, [0, false, 0, 3])
            start_actor_motion_auto_idle(this.h_player, 300)

            wait_for_true2(is_motion_finished, this.h_player, 300)
        }
    }

    function Finalize() {
        print("SampleDemo Finalize")

        if(this.h_talk_actors != 0) {
            EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        }
        if(this.h_scarab_and_isuna != 0) {
            DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        }

        set_enemy_sleep(false)
        set_flag(999)
        set_mission_ui_to_do(81)
        create_extend_mission_map_symbol(98)
        EventEnd()

        fadein_sync(3, 0, 1.0)
    }
}

class SkipBATTLE_TUTO_PROTECTION extends SkipDemoEventBase {
    h_player = 0
    h_scarab_and_isuna = 0
    h_talk_actors = 0

    function Initialize() {
        print("SkipFIRST_BATTLEInitialize")

        EventStart(0)
        set_enemy_sleep(true)

        this.h_player = get_player()
    }

    function Process() {
        print("SkipFIRST_BATTLEProcess")

        wait(15)

        this.h_scarab_and_isuna = CreateSimpleScarabAndIsuna(this.h_player)
        this.h_talk_actors = StartScarabIsunaTalkEventAppear()

        set_actor_facial(this.h_talk_actors[0], 2)
        msg_sync_talk_event(45187, this.h_scarab_and_isuna[1])
        start_actor_motion_auto_idle(this.h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, this.h_talk_actors[0], 300)
        wait(15)
    }

    function Finalize() {
        print("SkipFIRST_BATTLEFinalize")

        EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])

        fadein_sync(0, 0, 1.0)
        ui_sync(5, [83050, 83051, 83151, 83152])

        EventEnd()
        set_enemy_sleep(false)
    }
}

class SkipFLYING_ENEMY_TUTORIAL extends SkipDemoEventBase {
    h_scarab_and_isuna = 0
    h_talk_actors = 0
    h_player = 0

    function Initialize() {
        print("SkipFLYING_ENEMY_TUTORIALInitialize")

        set_enemy_sleep(true)
        EventStart(0)

        local zone_id = get_zone_id()
        if(zone_id == 13) {
            wait(30 * 2)

            local BoneFish = get_enemygroup_member(1, 0)

            GazeCameraForHact(BoneFish, false, -1, 0.0)
        }

        this.h_player = get_player()
    }

    function Process() {
        print("SkipFLYING_ENEMY_TUTORIALProcess")

        this.h_scarab_and_isuna = CreateSimpleScarabAndIsuna(this.h_player)
        this.h_talk_actors = StartScarabIsunaTalkEventAppear()

        msg_sync_talk_event(45125, this.h_talk_actors[1])

        EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
    }

    function Finalize() {
        print("SkipFLYING_ENEMY_TUTORIALFinalize")

        if(this.h_talk_actors != 0) {
            EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        }
        if(this.h_scarab_and_isuna != 0) {
            DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        }

        ui_sync(5, [83028, 83029])
        fadein_sync(0, 0, 1.0)

        EventEnd()
        set_enemy_sleep(false)
    }
}

class SkipMAGIC_TUTO extends SkipDemoEventBase {
    h_player = 0
    h_player_talk = 0
    h_scarab_and_isuna = 0
    h_talk_actors = 0

    function Initialize() {
        print("SampleDemo Initialize")

        set_enemy_sleep(true)

        this.h_player = get_party_index(0)
        this.h_scarab_and_isuna = CreateSimpleScarabAndIsuna(this.h_player)
    }

    function Process() {
        print("SampleDemo Process")

        this.h_talk_actors = StartScarabIsunaTalkEventAppear()

        msg_sync_talk_event(45129, this.h_talk_actors[1])
        start_actor_motion_auto_idle(this.h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, this.h_talk_actors[0], 300)
        wait(15)

        EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
    }

    function Finalize() {
        print("SampleDemo Finalize")

        if(this.h_talk_actors != 0) {
            EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        }
        if(this.h_scarab_and_isuna != 0) {
            DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        }

        fadein_sync(0, 0, 1.0)
        ui_sync(5, [83217, 83218])
        set_enemy_sleep(false)
    }
}

class SkipWANT_WAND extends SkipDemoEventBase {
    h_scarab_and_isuna = 0
    h_talk_actors = 0
    h_player = 0

    function Initialize() {
        print("DG_M06_002 Demo Initialize")

        EventStart(0)

        this.h_player = get_party_index(0)

        local zone = get_zone_id()
        if(zone == 39) {
            local light_sw = FindBgobjActorByLayoutId(7)

            wait(1)

            set_camera_target(light_sw.hself_, 0.0)
        } else if(zone == 51) {
            wait(30 * 2)

            local light_sw = FindBgobjActorByLayoutId(19)

            wait(1)

            set_camera_target(light_sw.hself_, 0.0)
        }
    }

    function Process() {
        print("DG_M06_002 Demo Process")

        wait(30)

        this.h_scarab_and_isuna = SimpleScarabAndIsunaCreateOnly()
        this.h_talk_actors = StartScarabIsunaTalkEventAppear()

        msg_sync_talk_event(92093, this.h_talk_actors[1])
        start_actor_motion_auto_idle(this.h_talk_actors[0], 300)

        wait_for_true2(is_motion_finished, this.h_talk_actors[0], 300)

        wait(15)

        EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        SimpleScarabAndIsunaDestroyOnly(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
    }

    function Finalize() {
        print("DG_M06_002 Demo Finalize")

        if(this.h_talk_actors != 0) {
            EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        }
        if(this.h_scarab_and_isuna != 0) {
            DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        }

        reset_camera_target()
        fade_in(3, 0, 1.0)
        EventEnd()
    }
}

class SkipUSE_WAND extends SkipDemoEventBase {
    h_player = 0
    h_maraia = 0
    h_sekina = 0
    h_party1 = 0
    h_party2 = 0
    h_player_talk = 0
    h_maraia_talk = 0
    h_sekina_talk = 0

    function Initialize() {
        print("DG_M06_004 Demo Initialize")

        EventStart(0)
        fadein_sync(3, 0, 1.0)

        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        local zone = get_zone_id()
        if(zone == 39) {
            local light_sw = FindBgobjActorByLayoutId(7)

            wait(1)

            set_camera_target(light_sw.hself_, 0.0)
        } else if(zone == 51) {
            wait(30 * 2)

            local light_sw = FindBgobjActorByLayoutId(19)

            wait(1)

            set_camera_target(light_sw.hself_, 0.0)
        }

        wait(30)
    }

    function Process() {
        print("DG_M06_004 Demo Process")

        local menber1_id = get_party_chara_id(1)
        local menber2_id = get_party_chara_id(2)
        
        if(menber1_id == 724 || menber2_id == 724) {
            local h_talk_acts = TalkDemo_1_1_Initialize(0, 724, 2)

            this.h_player_talk = h_talk_acts[0]
            this.h_maraia_talk = h_talk_acts[1]

            msg_sync_talk_event(92109, this.h_maraia_talk)
            msg_sync_talk_event(92110, this.h_maraia_talk)
            msg_sync_talk_event(92111, this.h_maraia_talk)
            
            local h_talk_acts = [this.h_player_talk, this.h_maraia_talk]

            TalkDemo_1_1_Finalize(h_talk_acts, 2)
        }
    }

    function Finalize() {
        print("DG_M06_004 Demo Finalize")

        finalize_talk_event()
        destroy_actor(this.h_player_talk)
        destroy_actor(this.h_maraia_talk)
        destroy_actor(this.h_sekina_talk)
        reset_camera_target()

        EventEnd()
        fadein_sync(3, 0, 1.0)

        ui_sync(5, [83086, 83087])
    }
}

class SkipGET_WHEAT_SEED extends SkipDemoEventBase {
    h_player = 0
    h_talk_actors = 0
    h_scarab_and_isuna = 0

    function Initialize() {
        print("SampleDemo Initialize")

        if(test_flag(1996)) {
            EventStart(0)

            this.h_player = get_player()

            start_idle_town_npc()
            start_invisible_town_npc()
        }
    }

    function Process() {
        print("SampleDemo Process")

        if(test_flag(1996)) {
            this.h_scarab_and_isuna = SimpleScarabAndIsunaCreateOnly()
            this.h_talk_actors = StartScarabIsunaTalkEventAppear()

            set_actor_facial(this.h_talk_actors[1], 6)
            msg_sync_talk_event(93246, this.h_talk_actors[1])
            start_actor_motion_auto_idle(this.h_talk_actors[0], 300)

            wait_for_true2(is_motion_finished, this.h_talk_actors[0], 300)
            wait(15)

            EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
            SimpleScarabAndIsunaDestroyOnly(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        }
    }

    function Finalize() {
        print("SampleDemo Finalize")

        EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        if(h_scarab_and_isuna != 0) {
            DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        }

        if(test_flag(1996)) {
            end_invisible_town_npc()
            end_idle_town_npc()

            EventEnd()
        }
        
        fadein(3, 0, 1.0)

        run_get_item_optional_quest(109)
        set_mission_ui_to_do(52)
    }
}

class SkipGET_WHEAT extends SkipDemoEventBase {
    h_scarab_and_isuna = 0
    h_talk_actors = 0
    h_player = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)

        this.h_player = get_player()
    }

    function Process() {
        print("SampleDemo Process")

        start_jingle_bgm(0x1000044)
        msg_argv_sync(4043, 0, 0, [6014])
    }

    function Finalize() {
        print("SampleDemo Finalize")

        this.h_scarab_and_isuna = CreateSimpleScarabAndIsuna(this.h_player)
        this.h_talk_actors = StartScarabIsunaTalkEventAppear()

        msg_sync_talk_event(93256, this.h_talk_actors[1])

        EndScarabIsunaTalkEventDestroyOnly(this.h_talk_actors[0], this.h_talk_actors[1], this.h_talk_actors[2])
        DestroySimpleScarabAndIsuna(this.h_scarab_and_isuna[0], this.h_scarab_and_isuna[1])
        fadeout_sync(0, 0, 1.0)

        local hquest = get_quest_handle(3, 91)
        local ret = run_quest(3, hquest)

        load_actor_archive_sync(6, 4002)
        load_actor_archive_sync(6, 4003)
        load_actor_archive_sync(6, 4004)

        set_flag(1963)
        force_town_chaos()

        local h_player = get_player()
        local curt_id = get_scene_id()
        local pos = get_actor_position(h_player)
        local angleY = get_actor_angle_y(h_player)

        set_var(79, curt_id)
        set_var(75, pos[0])
        set_var(76, pos[1])
        set_var(77, pos[2])
        set_var(78, angleY)
        request_jump_scene(1035, 1374.0, 14.0, -1261.0, 291.0, 0)
    }
}

class SkipYOYAKU_02 extends SkipDemoEventBase {
    function Initialize() {
        print("SampleDemo Initialize")
    }

    function Process() {
        print("SampleDemo Process")
    }

    function Finalize() {
        print("SampleDemo Finalize")
    }
}

class QuartzBlessingDemo {
    h_player = 0
    h_party1 = 0
    h_party2 = 0
    h_quartz = 0
    h_tama = 0
    h_altar_light = 0
    pos_altar = []
    rot_y_altar = 0.0
    quartz_type = 0
    msg_id_ = 0
    item_id_ = 0

    function Initialize(quartz_actor_id, msg_id, item_id) {
        print("QuartzBlessingDemo::Initialize()")

        fadeout_sync(0, 0, 1.0)
        party_weapon_in_out_sync(0, false)

        this.msg_id_ = msg_id
        this.item_id_ = item_id
        this.h_altar_light = get_hactor_by_bgobj_id(4281)

        if(0 == this.h_altar_light) {
            print("[Warning]: BGOBJECT_DB_SQID.ALTAR_OF_LIGHT が生成されていない")

            this.h_altar_light = create_temp_actor(4281, 0.0, 0.0, 0.0, 0.0, false)
        }

        this.pos_altar = get_actor_position(this.h_altar_light)
        this.rot_y_altar = get_actor_angle_y(this.h_altar_light)

        {
            local offset = vector_rotate_y([0.762, 0.0, 0.0], this.rot_y_altar)
            
            this.pos_altar[0] += offset[0]
            this.pos_altar[1] += offset[1]
            this.pos_altar[2] += offset[2]
        }

        print("光の祭壇の座標: " + this.pos_altar[0] +
            ", " + this.pos_altar[1] +
            ", " + this.pos_altar[2])
        print("光の祭壇のY角度: " + this.rot_y_altar)

        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        {
            local pos = [this.pos_altar[0], this.pos_altar[1], this.pos_altar[2]]
            local offset = vector_rotate_y([-0.8, 0.0, 22.2], this.rot_y_altar)

            pos[0] += offset[0]
            pos[1] += offset[1]
            pos[2] += offset[2]

            local rot_y = this.rot_y_altar

            set_actor_position_angle_y(this.h_player, pos[0], pos[1], pos[2], rot_y)
            
            if(this.h_party1 != 0) {
                set_actor_visible(this.h_party1, false)
            }
            if(this.h_party2 != 0) {
                set_actor_visible(this.h_party2, false)
            }
            party_weapon_in_out_sync(0, true)
        }

        {
            local pos = [this.pos_altar[0], this.pos_altar[1], this.pos_altar[2]]
            local offset = vector_rotate_y([0.0, 0.0, 0.0], this.rot_y_altar)

            pos[0] += offset[0]
            pos[1] += offset[1]
            pos[2] += offset[2]

            local rot_y = this.rot_y_altar

            load_actor_archive(6, quartz_actor_id)

            func_wait(is_archive_loaded)

            this.h_quartz = create_temp_actor(quartz_actor_id, pos[0], pos[1], pos[2], rot_y, false)

            set_actor_visible(this.h_quartz, false)
            set_disable_culling(this.h_quartz)
            
            switch(quartz_actor_id) {
                case 4538:
                    this.quartz_type = 0
                    break;
                case 4536:
                    this.quartz_type = 1
                    break;
                case 4537:
                    this.quartz_type = 2
                    break;
            }
        }

        {
            local pos = [this.pos_altar[0], this.pos_altar[1], this.pos_altar[2]]
            local offset = vector_rotate_y([0.0, 0.0, 0.0], this.rot_y_altar)

            pos[0] += offset[0]
            pos[1] += offset[1]
            pos[2] += offset[2]

            local rot_y = this.rot_y_altar

            load_actor_archive(6, 4547)
            
            func_wait(is_archive_loaded)

            this.h_tama = create_temp_actor(4547, pos[0], pos[1], pos[2], rot_y, false)

            set_actor_visible(this.h_tama, false)
            set_disable_culling(this.h_tama)
        }

        switch(this.quartz_type) {
            case 0:
                build_time_line_demo("O542", "demo13_taimkeeper")
                break;
            case 1:
                build_time_line_demo("O542", "demo11_taimkeeper")
                break;
            case 2:
                build_time_line_demo("O542", "demo12_taimkeeper")
                break;
        }

        local archive = find_archive(1, "O542")

        begin_demo_camera(archive, "demoevent_11", [
            this.pos_altar[0], this.pos_altar[1], this.pos_altar[2], this.rot_y_altar
        ])
        play_time_line_demo()
    }

    function ProcessDemo() {
        print("QuartzBlessingDemo::ProcessDemo()")

        fadein(3, 0, 1.0)
        play_se(0x10002D4)
        idle_actor(this.h_player)
        start_actor_motion(this.h_altar_light, 699)

        wait(59)

        play_se(0x10002D5)

        wait(2)

        start_actor_motion(this.h_player, 210)
        
        wait(7)

        set_actor_visible(this.h_tama, true)
        start_actor_motion(this.h_tama, 683)
        
        wait(113)

        set_actor_visible(this.h_tama, false)
        set_actor_visible(this.h_quartz, true)

        switch(this.quartz_type) {
            case 0:
                start_actor_motion(this.h_quartz, 688)
                break;
            case 1:
                start_actor_motion(this.h_quartz, 684)
                break;
            case 2:
                start_actor_motion(this.h_quartz, 686)
                break;
        }

        wait(80)

        play_se(0x10002D6)

        wait(360)

        play_se(0x10002D7)

        wait(40)

        start_actor_motion(this.h_altar_light, 682)
        stop_hiero_altar_of_light_rolling_se(this.h_altar_light)

        wait(81)

        start_actor_motion(this.h_player, 212)

        wait(79)

        play_se(0x10002D8)

        wait(80)

        start_jingle_bgm(0x100003D)
        msg_argv_sync(this.msg_id_, 0, 0, [this.item_id_])
        fadeout_sync(1, 0, 1.0)

        func_wait(is_time_line_demo_finished)
    }

    function Finalize() {
        print("QuartzBlessingDemo::Finalize()")

        reset_hiero_goal_env()

        wait(15)

        if(this.h_party1 != 0) {
            set_actor_visible(this.h_party1, true)
        }
        if(this.h_party2 != 0) {
            set_actor_visible(this.h_party2, true)
        }

        end_demo_camera()
        destroy_actor(this.h_quartz)
        destroy_actor(this.h_tama)
        finalize_time_line_demo()

        local player_pos = [this.pos_altar[0], this.pos_altar[1], this.pos_altar[2]]
        local offset_pos = vector_rotate_y([-0.8, 0.0, 25.0], this.rot_y_altar)
        local offset_angle = 180.0

        player_pos[0] += offset_pos[0]
        player_pos[1] += offset_pos[1]
        player_pos[2] += offset_pos[2]

        local rot_y = this.rot_y_altar + offset_angle

        set_actor_position_angle_y(this.h_player, player_pos[0], player_pos[1], player_pos[2], rot_y)

        wait(1)

        reset_party_position()

        wait(1)
    }
}

class SkipQUEST_NAARMA_03 extends SkipDemoEventBase {
    h_player = 0
    h_naa = 0
    h_player_talk = 0
    h_naa_talk = 0
    h_party1 = 0
    h_party2 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(30)

        start_jingle_bgm(0x100000F)
        
        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        local h_talk_acts = TalkDemo_1_1_Initialize(0, 713, 2)
        this.h_player_talk = h_talk_acts[0]
        this.h_naa_talk = h_talk_acts[1]

        set_actor_facial(this.h_player_talk, 1)
        set_actor_facial(this.h_naa_talk, 1)
        start_actor_motion_auto_idle(this.h_naa_talk, 250)

        wait_for_true2(is_motion_finished, this.h_naa_talk, 250)

        start_actor_motion_auto_idle(this.h_naa_talk, 251)
        msg_sync_talk_event(71398, this.h_naa_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")

        stop_jingle_bgm(30.0)
        
        local h_talk_acts = [this.h_player_talk, this.h_naa_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}

class Skip_QUEST_ZYASUPA_03 extends SkipDemoEventBase {
    h_player = 0
    h_zyasu = 0
    h_player_talk = 0
    h_zyasu_talk = 0
    h_party1 = 0
    h_party2 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(30)
        
        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        local h_talk_acts = TalkDemo_1_1_Initialize(0, 720, 2)
        this.h_player_talk = h_talk_acts[0]
        this.h_zyasu_talk = h_talk_acts[1]

        wait(1)

        set_actor_facial(this.h_player_talk, 1)
        set_actor_facial(this.h_zyasu_talk, 1)
        start_actor_motion_auto_idle(this.h_zyasu_talk, 321)
        msg_sync_talk_event(72090, this.h_zyasu_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")
        
        local h_talk_acts = [this.h_player_talk, this.h_zyasu_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}

class Skip_QUEST_MARAIA_02 extends SkipDemoEventBase {
    h_player = 0
    h_mara = 0
    h_player_talk = 0
    h_mara_talk = 0
    h_party1 = 0
    h_party2 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(30)
        
        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        local h_talk_acts = TalkDemo_1_1_Initialize(0, 724, 2)
        this.h_player_talk = h_talk_acts[0]
        this.h_mara_talk = h_talk_acts[1]

        wait(1)

        set_actor_facial(this.h_player_talk, 1)
        set_actor_facial(this.h_mara_talk, 1)
        start_actor_motion_auto_idle(this.h_mara_talk, 321)
        msg_sync_talk_event(72492, this.h_mara_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")
        
        local h_talk_acts = [this.h_player_talk, this.h_mara_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}

class SkipQUEST_CESSIEN_03 extends SkipDemoEventBase {
    h_player = 0
    h_cess = 0
    h_player_talk = 0
    h_cess_talk = 0
    h_party1 = 0
    h_party2 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(70)
        
        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        local h_talk_acts = TalkDemo_1_1_Initialize(0, 728, 2)
        this.h_player_talk = h_talk_acts[0]
        this.h_cess_talk = h_talk_acts[1]

        set_actor_facial(this.h_player_talk, 1)
        set_actor_facial(this.h_cess_talk, 1)
        msg_sync_talk_event(72894, this.h_cess_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")
        
        local h_talk_acts = [this.h_player_talk, this.h_cess_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}

class Skip_QUEST_ZYASUPA_02 extends SkipDemoEventBase {
    h_player = 0
    h_zyasu = 0
    h_player_talk = 0
    h_zyasu_talk = 0
    h_party1 = 0
    h_party2 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(60)

        start_jingle_bgm(0x100002D)

        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        local h_talk_acts = TalkDemo_1_1_Initialize(0, 720, 2)
        this.h_player_talk = h_talk_acts[0]
        this.h_zyasu_talk = h_talk_acts[1]

        start_actor_motion_auto_idle(this.h_zyasu_talk, 280)
        msg_sync_talk_event(72087, this.h_zyasu_talk)
        set_actor_facial(this.h_zyasu_talk, 3)
        start_actor_motion_auto_idle(this.h_zyasu_talk, 231)
        start_actor_lip(this.h_zyasu_talk, 2)
        msg_sync_talk_event(72088, this.h_zyasu_talk)
        reset_actor_facial(this.h_zyasu_talk)
        msg_sync_talk_event(72089, this.h_zyasu_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")

        stop_jingle_bgm(30.0)
        
        local h_talk_acts = [this.h_player_talk, this.h_zyasu_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}

class Skip_QUEST_HOLUAJA_02 extends SkipDemoEventBase {
    h_player = 0
    h_holu = 0
    h_player_talk = 0
    h_holu_talk = 0
    h_party1 = 0
    h_party2 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(50)
        
        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        local h_talk_acts = TalkDemo_1_1_Initialize(0, 723, 2)
        this.h_player_talk = h_talk_acts[0]
        this.h_holu_talk = h_talk_acts[1]

        set_actor_facial(this.h_player_talk, 1)
        set_actor_facial(this.h_holu_talk, 1)
        start_actor_motion_auto_idle(this.h_holu_talk, 231)
        msg_sync_talk_event(72394, this.h_holu_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")
        
        local h_talk_acts = [this.h_player_talk, this.h_holu_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}

class Skip_QUEST_MAGDARENA_03 extends SkipDemoEventBase {
    h_player = 0
    h_tane = 0
    h_mag = 0
    h_player_talk = 0
    h_tane_talk = 0
    h_mag_talk = 0
    h_tane_base = 0
    dbkey0 = 0
    dbkey1 = 0
    dbkey2 = 0
    angle0 = 0
    angle1 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(100)

        start_jingle_bgm(0x1000027)

        this.h_tane_base = create_demo_event_actor(739)

        this.dbkey0 = get_dbkey_by_charaId(0)
        this.dbkey1 = get_dbkey_by_charaId(739)
        this.dbkey2 = get_dbkey_by_charaId(719)

        this.angle0 = get_talk_event_actor_angle_y(0)
        this.angle1 = get_talk_event_actor_angle_y(1)

        initialize_talk_event(true)

        this.h_player_talk = create_talk_event_actor_index(this.dbkey0, 1, 7, this.angle0)
        this.h_mag_talk = create_talk_event_actor_index(this.dbkey2, 1, 7, this.angle0)

        set_talk_event_actor_pos_index(this.h_player_talk, 6)
        set_talk_event_actor_pos_index(this.h_mag_talk, 2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        set_actor_facial(this.h_player_talk, 3)
        set_actor_facial(this.h_mag_talk, 3)
        fadein_sync(0, 0, 1.0)
        msg_sync_talk_event(71988, this.h_mag_talk)
        fadeout_sync(0, 0, 1.0)

        wait(10)

        this.h_tane_talk = create_talk_event_actor_index(this.dbkey1, 1, 8, this.angle1)

        set_talk_event_actor_pos_index(this.h_tane_talk, 3)
        fadein_sync(3, 0, 1.0)
        msg_sync_talk_event(71989, this.h_tane_talk)
        start_actor_motion_auto_idle(this.h_mag_talk, 280)
        msg_sync_talk_event(71990, this.h_mag_talk)
        set_actor_facial(this.h_tane_talk, 2)
        start_actor_motion_auto_idle(this.h_tane_talk, 215)
        msg_sync_talk_event(71991, this.h_tane_talk)
        fadeout_sync(0, 0, 1.0)
        set_talk_event_actor_pos_index(this.h_tane_talk, 7)
        set_talk_actor_visible(this.h_tane_talk, false)

        wait(10)

        fadein_sync(0, 0, 1.0)
        msg_sync_talk_event(71992, this.h_mag_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")

        stop_jingle_bgm(30.0)

        destroy_actor(this.h_tane)
        destroy_actor(this.h_tane_base)
        destroy_actor(this.h_player_talk)
        destroy_actor(this.h_tane_talk)
        destroy_actor(this.h_mag_talk)
        
        finalize_talk_event()
        fadein_sync(0, 0, 1.0)
        EventEnd()
    }
}

class SkipQUEST_NINECZERE_01 extends SkipDemoEventBase {
    h_player = 0
    h_nine = 0
    h_player_talk = 0
    h_nine_talk = 0
    h_party1 = 0
    h_party2 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(40)
        
        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        local h_talk_acts = TalkDemo_1_1_Initialize(0, 725, 2)
        this.h_player_talk = h_talk_acts[0]
        this.h_nine_talk = h_talk_acts[1]

        wait(1)

        set_actor_facial(this.h_player_talk, 1)
        set_actor_facial(this.h_nine_talk, 1)
        start_actor_motion_auto_idle(this.h_nine_talk, 321)
        msg_sync_talk_event(72593, this.h_nine_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")
        
        local h_talk_acts = [this.h_player_talk, this.h_nine_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}

class Skip_QUEST_ZERINUB_02 extends SkipDemoEventBase {
    h_player = 0
    h_sai = 0
    h_player_talk = 0
    h_sai_talk = 0
    h_party1 = 0
    h_party2 = 0
    h_eff = 0
    
    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(20)

        start_jingle_bgm(0x1000027)

        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        local h_talk_acts = TalkDemo_1_1_Initialize(0, 708, 2)
        this.h_player_talk = h_talk_acts[0]
        this.h_sai_talk = h_talk_acts[1]

        set_actor_facial(this.h_player_talk, 1)
        set_actor_facial(this.h_sai_talk, 1)
        start_actor_motion_auto_idle(this.h_sai_talk, 300)
        msg_sync_talk_event(70887, this.h_sai_talk)
        reset_actor_facial(this.h_sai_talk)
        reset_actor_facial(this.h_player_talk)

        this.h_eff = create_eff(483, 1, this.h_sai_talk)

        wait(50)

        start_actor_motion_auto_idle(this.h_sai_talk, 320)
        msg_sync_talk_event(71096, this.h_sai_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")

        stop_jingle_bgm(30.0)
        
        local h_talk_acts = [this.h_player_talk, this.h_sai_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}

class Skip_QUEST_NUBBIT_03 extends SkipDemoEventBase {
    h_player = 0
    h_nubb = 0
    h_player_talk = 0
    h_nubb_talk = 0
    h_party1 = 0
    h_party2 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)
        start_jingle_bgm(0x100000F)

        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        wait(30)

        local h_talk_acts = TalkDemo_1_1_Initialize(0, 726, 2)
        this.h_player_talk = h_talk_acts[0]
        this.h_nubb_talk = h_talk_acts[1]

        wait(1)

        set_actor_facial(this.h_player_talk, 1)
        set_actor_facial(this.h_nubb_talk, 1)
        start_actor_motion_auto_idle(this.h_nubb_talk, 321)
        msg_sync_talk_event(72897, this.h_nubb_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")

        stop_jingle_bgm(30.0)
        
        local h_talk_acts = [this.h_player_talk, this.h_nubb_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}

class SkipQUEST_BELLTSONY_01 extends SkipDemoEventBase {
    h_player = 0
    h_bel = 0
    h_player_talk = 0
    h_bel_talk = 0
    h_party1 = 0
    h_party2 = 0

    function Initialize() {
        print("SampleDemo Initialize")

        EventStart(0)
        fadeout_sync(0, 0, 1.0)

        wait(30)

        this.h_player = get_party_index(0)
        this.h_party1 = get_party_index(1)
        this.h_party2 = get_party_index(2)

        idle_actor(this.h_player, 0)
        idle_actor(this.h_party1, 0)
        idle_actor(this.h_party2, 0)

        wait_for_false1(is_actor_equipping_weapon, this.h_player)
        wait_for_false1(is_actor_equipping_weapon, this.h_party1)
        wait_for_false1(is_actor_equipping_weapon, this.h_party2)

        revive(0)
    }

    function Process() {
        print("SampleDemo Process")

        fadein_sync(3, 0, 1.0)

        local h_talk_actors = TalkDemo_1_1_Initialize(0, 714, 2)

        this.h_player_talk = h_talk_actors[0]
        this.h_bel_talk = h_talk_actors[1]

        set_actor_facial(this.h_player_talk, 3)
        set_actor_facial(this.h_bel_talk, 3)
        start_actor_motion_auto_idle(this.h_bel_talk, 280)
        msg_sync_talk_event(71487, this.h_bel_talk)
        reset_actor_facial(this.h_bel_talk)
        msg_sync_talk_event(71488, this.h_bel_talk)

        wait(10)

        fadeout_sync(0, 0, 1.0)

        wait(20)
    }

    function Finalize() {
        print("SampleDemo Finalize")

        local h_talk_acts = [this.h_player_talk, this.h_bel_talk]

        TalkDemo_1_1_Finalize(h_talk_acts, 2)
        fadein_sync(3, 0, 1.0)
        EventEnd()
    }
}
