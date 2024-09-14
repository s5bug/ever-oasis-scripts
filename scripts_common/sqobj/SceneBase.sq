// TODO match line infos

class SceneBase {
    chara_list_ = []
    build_list_ = []
    bgobj_table_ = {}
    bgobj_creator_ = null
    bgobj_manager_ = null
    mission_demo_flag = 0

    constructor() {
        this.chara_list_ = []
        this.build_list_ = []
        this.bgobj_table_ = {}
        this.bgobj_creator_ = BgobjActorCreator(bgobj_table_)
        this.bgobj_manager_ = BgobjActorManager(bgobj_table_)
    }

    function Initialize() {
        print("SceneBase::initialize")
    }

    function Finalize() {
        print("SceneBase::finalize")
    }

    function SetListenerEnabled(type, enabled) {
        set_scene_listener_enabeld(type, enabled)
    }

    function OnPostLoad() {
        print("SceneBase::onPostLoad")
    }

    function OnPhantomEnterEvent(lytid, hact) {
        print("SceneBase::onEnterPhantom [phm_lytid:" + lytid + " act:" + hact + "]")
    }

    function OnPhantomLeaveEvent(lytid, hact) {
        print("SceneBase::onLeavePhantom [phm_lytid:" + lytid + " act:" + hact + "]")
    }

    function OnActorDeadEvent(hact, group_id, rest_group_member_num) {
        print("SceneBase::OnActorDeadEvent [act:" + hact +
            " group_id:" + group_id +
            " rest_group_member_num:" + rest_group_member_num + "]")

        local bgobj_work = null

        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_list in group_table) {
                foreach(bgobj in bgobj_list) {
                    if(bgobj.hself_ == hact) {
                        bgobj.OnActorDeadEvent(hact)
                        bgobj_work = bgobj
                        break;
                    }
                }
            }
        }

        NextPopGroupChecker(hact, group_id, rest_group_member_num)

        return bgobj_work;
    }

    function OnActorLifeZeroEvent(hact, group_id, rest_group_member_num) {
        print("SceneBase::onActorLifeZero [act:" + hact +
            " group_id:" + group_id +
            " rest_group_member_num:" + rest_group_member_num + "]")
        
        local part = get_actor_part(hact)

        if(part == 4) {
            if(group_id == -1) {
                print("\n!!!! 敵グループのIDが不正です。開発用シーン以外ではバグとしてご報告下さい。 !!!!\n")
            }
        }

        if(group_id != -1) {
            this.LifeZeroEventChecker(hact, rest_group_member_num, group_id)
        }

        return null;
    }

    function LifeZeroEventChecker(hact, member_num, group_id) {
        print("SceneBase::LifeZeroEventChecker [act:" + hact + "]")
    }

    function DestroyEventChecker(hact, member_num, group_id) {
        print("[ !!!!!!!! SceneBase::DestroyEventChecker : member_num = " + member_num +
            "    group_id = " + group_id + " !!!!!!!! ]")
    }

    function BGObjectDeadChecker(hact) {
        print("[ !!!!!!!! SceneBase::BGObjectDeadChecker !!!!!!!! ]")
    }

    function OnTick(timer_id) {
        print("SceneBase::timer_id:" + timer_id)
    }

    function OnPlayerTalked(hplayer, htarget) {
        print("SceneBase::onPlayerTalked:" + hplayer + "," + htarget)
    }

    function OnPlayerShopping(hplayer, htarget) {
        print("SceneBase::onPlayerShopping:" + hplayer + "," + htarget)
    }

    function OnPlayerCarry(hplayer, htarget) {
        print("SceneBase::onPlayerCarry:" + hplayer + "," + htarget)
    }

    function OnPlayerDoor(hplayer, htarget) {
        print("SceneBase::onPlayerDoor:" + hplayer + "," + htarget)

        foreach(group_table in this.bgobj_table_) {
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

    function OnPlayerSkill(hplayer, htarget, result) {
        print("SceneBase::onPlayerSkill_begin:" + hplayer + "," + htarget + "," + result)

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

    function OnPlayerHatena(hplayer, htarget) {
        print("SceneBase::onPlayerHatena_begin:" + hplayer + "," + htarget)

        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_list in group_table) {
                foreach(bgobj in bgobj_list) {
                    if(bgobj.hself_ == htarget) {
                        bgobj.OnPlayerHatena(hplayer, htarget)
                        return;
                    }
                }
            }
        }
    }

    function OnDateTimePeriod(period_index) {
        print("onDateTimePeriod: " + "ピリオド: " + period_index)
    }

    function OnDayEndInTown() {
        print("SceneBase::OnDayEndInTown: ")
    }

    function OnConstruct(hactor, px, py, pz, angle_y) {
        print("SceneBase::OnConstruct: " + hactor +
            ",pos:" + px + "," + py + "," + pz +
            ", angle_y:" + angle_y)
    }

    function OnVisitTimingEvent() {
        print("SceneBase::OnVisitTimingEvent: ")
    }

    function InitializeNpcResources() {
        print("SceneBase::InitializeNpcResources")
    }

    function OnMissionStartEvent(event_id) {
        local chapter = get_var(110)

        print("SceneBase::OnMissionStartEvent: chapter -> " + chapter +
            ", event_id -> " + event_id)

        EventStart(0)

        local demo_event = null
        local scene_type = get_scene_type()

        if(scene_type == 5 || scene_type == 3) {
            demo_event = DemoEventSet()
        } else {
            demo_event = DemoEventScenarioChapterSet()
        }

        if(null != demo_event) {
            demo_event.StartDemo(event_id, null)
        }

        EventEnd()
    }

    function OnMissionCompleteEvent(event_id) {
        local chapter = get_var(110)

        print("SceneBase::OnMissionCompleteEvent: chapter -> " + chapter +
            ", event_id -> " + event_id)

        EventStart(0)

        local demo_event = null
        local scene_type = get_scene_type()

        if(scene_type == 5 || scene_type == 3) {
            demo_event = DemoEventSet()
        } else {
            demo_event = DemoEventScenarioChapterSet()
        }

        if(null != demo_event) {
            demo_event.StartDemo(event_id, null)
        }

        EventEnd()
    }

    function OnOptionalQuestEvent(event_id, target_handle, script_type) {
        print("SceneBase::OnOptionalQuestEvent: ID: " + event_id +
            ", TYPE: " + script_type)
        
        EventStart(0)

        local demo_event = null
        local scene_type = get_scene_type()
        local is_field = scene_type == 5 || scene_type == 3

        if(is_field && 0 != target_handle) {
            set_camera_target(target_handle)
        }

        switch(script_type) {
            case 0:
            case 2:
                demo_event = DemoEventSet()
                break;
            case 1:
            case 3:
                demo_event = CommonDemoEventSet()
                break;
        }

        switch(script_type) {
            case 2:
            case 3:
                wait_for_false(is_item_get_effect)
                break;
        }

        demo_event.StartDemo(event_id, null)

        if(is_field && 0 != target_handle) {
            reset_camera_target()
        }

        EventEnd()
    }

    function OnQuestCompleteEvent(event_id, target_handle, script_type) {
        print("SceneBase::OnQuestCompleteEvent: " + event_id +
            ", Handle: " + target_handle +
            ", TYPE: " + script_type)
        
        if(0 <= event_id) {
            EventStart(0)

            local demo_event = null
            local scene_type = get_scene_type()
            local is_field = scene_type == 5 || scene_type == 3

            if(is_field && 0 != target_handle) {
                set_camera_target(target_handle)
            }

            switch(script_type) {
                case 0:
                    demo_event = DemoEventSet()
                    wait_for_false(is_item_get_effect)
                    break;
                case 1:
                    demo_event = CommonDemoEventSet()
                    wait_for_false(is_item_get_effect)
                    break;
                case 2:
                    demo_event = CommonDemoEventSet()
                    break;
            }

            demo_event.StartDemo(event_id, null)

            if(is_field && 0 != target_handle) {
                reset_camera_target()
            }

            EventEnd()
        }

        start_npc_quest_clear_ui()
    }

    function OnQuestBattleEvent(event_id, enemy_handle) {
        print("SceneBase::OnQuestBattleEvent: " + event_id +
            ", enemy: " + enemy_handle)

        EventStart(0)

        local demo_event = DemoEventSet()
        demo_event.StartDemo(event_id, [enemy_handle])

        EventEnd()
    }

    function OnBossDyingEvent(hact, state) {
        print("SceneBase::onBossDyingEvent: hact=[ " + hact + " ], state=[ " + state + " ]")
    }

    function OnBattleEvent(begin) {
        print("SceneBase::OnBattleEvent: begin=[ " + begin + " ]")
        print("0:BattleEnd, 1:BattleBegin")
    }

    function OnAchieve(achieve_flags) {
        PadOffWait(0)

        for(local i = 0; i < 32 * achieve_flags.len(); ++i) {
            local mask = 1 << (i % 32)

            if(achieve_flags[i / 32] & mask) {
                set_disable_next_msg_open_se()
                msg(949, 0, 0, [900 + i])
                wait(4)
                play_se(0x10000A9)
                func_wait(is_msg_finished)
            }
        }

        achieve_notify_finish(achieve_flags)

        PadOnWait(1)
    }

    function OnHitHappower(hplayer, htarget) {
        print("SceneBase::OnHitHappower: player=[ " + hplayer +
            " ], target=[ " + htarget + " ]")
    }

    function OnPullGrass(hplayer, htarget) {
        print("SceneBase::OnPullGrass: player=[ " + hplayer +
            " ], target=[ " + htarget + " ]")
    }

    function OnChangeRoad() {
        print("SceneBase::OnChangeRoad: ")
    }

    function OnSkillPanelTouched(hplayer, htarget) {
        print("SceneBase::OnSkillPanelTouched: player=[" + hplayer +
            "], target=[ " + htarget + " ] ")
        
        local actor = this.bgobj_manager_.FindBgobjActorByHandle(htarget)

        if(actor && actor.act_type_ == 45) {
            actor.OnTouched(hplayer)
        }
    }

    function OnApproachChaosButterfly(htarget) {
        print("SceneBase::OnApproachChaosButterfly: target=[ " + htarget + " ] ")

        local demo_event = DemoEventSet()

        demo_event.StartDemo(95, null)
    }

    function OnFirstDownTutorial(htarget) {
        print("SceneBase::OnFirstDownTutorial: target=[ " + htarget + " ] ")

        PadOffWait(0)

        set_enemy_sleep(true)
        GazeCameraForHactTypeNoLook(htarget, false, 45, 0.0)

        wait(30)

        black_mask_d_start()

        local h_isuna = create_demo_event_actor(3)

        set_actor_visible(h_isuna, false)
        set_disable_gravity(h_isuna)

        local h_isuna_talk = create_talk_event_actor_index(get_dbkey_by_charaId(3), 1, 0, 0.0)

        set_talk_event_actor_angle_index(h_isuna_talk, 0)
        set_talk_event_actor_pos_index_and_pos_y(h_isuna_talk, 0, -2.5)
        set_actor_scale(h_isuna_talk, 0.7, 0.7, 0.7)
        initialize_talk_event(true)

        local chara_id = get_charaid(htarget)

        if(chara_id == 0) {
            msg_sync_talk_event(82004, h_isuna_talk)
        } else {
            msg_argv_sync_talk_event(82005, h_isuna_talk, 0, chara_id)
        }

        finalize_talk_event()
        destroy_actor(h_isuna_talk)
        destroy_actor(h_isuna)
        ui_sync(5, [83165, 83166, 83167])
        black_mask_d_end()
        set_enemy_sleep(false)

        PadOnWait(0)
    }

    function GenericEvent(parameters) {
        print("SceneBase::GenericEvent: ")
    }

    function LoadModuleScenarioChapter() {
        local chapter = get_var(110)

        switch(chapter) {
            case 1:
                load_module_sync("DemoSet_C1")
                break;
            case 2:
                load_module_sync("DemoSet_C2")
                break;
            case 3:
                load_module_sync("DemoSet_C3")
                break;
            case 4:
                load_module_sync("DemoSet_C4")
                break;
            case 5:
                load_module_sync("DemoSet_C5")
                break;
            case 6:
                break;
        }
    }

    function RegisterBgobj(res_name, vlyt_name) {
        local archive = find_archive(0, res_name)

        register_bgobjgroup(archive, res_name)

        func_wait(is_archive_loaded)
    }

    function CreateBgobjActorByAreaID(area_id) {
        this.bgobj_creator_.CreateBgobjActorByAreaID(area_id)
    }

    function CreateBgobjActorByGroupID(area_id, group_id) {
        print("SceneBase::CreateBgobjActorByGroupID")

        this.bgobj_creator_.CreateBgobjActorByGroupID(area_id, group_id)
    }
}
