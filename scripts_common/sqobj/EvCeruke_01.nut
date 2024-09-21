// TODO match line infos

class EvCeruke_01 extends ActorBase {
    function OnPlayerTalked(hplayer, htarget) {
        print("EvCeruke_01::OnPlayerTalked:" + hplayer + "," + htarget)

        PadOffWait(0)

        local chara_id = get_charaid(this.hself)

        print("EvCeruke_01::OnPlayerTalked: chara_id = " + chara_id)
        print("EvCeruke_01::OnPlayerTalked: CHARACTER_PROPERTY_SQID.MI_CERUKE_WORKER = " + 78)

        if(chara_id == 78) {
            local area_id = GetAreaId()

            print("EvCeruke_01::OnPlayerTalked: CHARACTER_PROPERTY_SQID.MI_CERUKE_WORKER = " + 78)
            print("EvCeruke_01::OnPlayerTalked: area_id = " + area_id)
                
            if(area_id == 1) {
                print("EvCeruke_01::OnPlayerTalked: 001 ")
                if(test_flag(1984) && check_mission_running(67)) {
                    print("!!!!!!!!!!RUN_SEQUENCE_FD02!!!!!!!!!!")

                    set_actor_talk_enabled(this.hself, true)
                    CompletedSpiritMission(67)
                    set_demo_event(true)
                    ActivateBgobj(171)
                    set_flag(2094)
                    set_flag(826)
                    ui_deactivate(14)
                    set_demo_event(false)
                    return;
                } else if(get_prev_scene() == 0) {
                    print("!!!!!!!!!!DEBUG_NOW!!!!!!!!!!")

                    set_actor_talk_enabled(this.hself, true)
                    load_module_sync("EvFD02")

                    local obj = DemoEventSet()
                    obj.StartDemo(4, null)

                    set_demo_event(true)
                    ActivateBgobj(171)
                    set_flag(2094)
                    set_flag(826)
                    ui_deactivate(14)
                    set_demo_event(false)
                    return;
                } else {
                    print("!!!!!!!!!!CERUKE_NORMAL_TALK!!!!!!!!!!")

                    start_idle_town_npc()
                    start_invisible_town_npc()
                    set_actor_visible(htarget, true)
                    begin_talk_action(htarget)

                    func_wait(is_talk_ready)

                    turn_actor(htarget, 1, hplayer, 5)

                    wait_for_false1(is_actor_turning, htarget)

                    msg_sync(92035, htarget)
                }
            } else if(area_id == 3) {
                print("EvCeruke_01::OnPlayerTalked: 003 ")
                if(!test_flag(827)) {
                    print("!!!!!!!!!!DEBUG_NOW!!!!!!!!!!")

                    load_module_sync("EvFD02")

                    local obj = DemoEventSet()
                    local event_result = ForceStartOptionalQuestEvent(16)

                    if(!event_result) {
                        obj.StartDemo(5, [])
                    }

                    set_flag(2063)
                    set_flag(827)
                    set_demo_event(true)
                    ui_deactivate(14)
                    set_demo_event(false)
                    return;
                }
            } else if(area_id == 7) {
                print("EvCeruke_01::OnPlayerTalked: 007 ")
                if(!test_flag(825)) {
                    print("!!!!!!!!!!DEBUG_NOW!!!!!!!!!!")

                    load_module_sync("EvFD02")

                    local obj = DemoEventSet()
                    local event_result = ForceStartOptionalQuestEvent(19)

                    if(!event_result) {
                        obj.StartDemo(6, [])
                    }

                    set_demo_event(true)
                    set_flag(2064)
                    set_flag(825)
                    ActivateBgobj(213)
                    ui_deactivate(14)
                    set_demo_event(false)
                    return;
                }
            }
        } else {
            start_idle_town_npc()
            start_invisible_town_npc()
            set_actor_visible(htarget, true)
            begin_talk_action(htarget)

            func_wait(is_talk_ready)

            switch(chara_id) {
                case 752:
                    if(check_mission_completed(113)) {
                        msg_sync(81013, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(110) && !check_mission_completed(113)) {
                        msg_sync(81012, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(104) && !check_mission_completed(110)) {
                        msg_sync(81011, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(91) && !check_mission_completed(104)) {
                        msg_sync(81010, htarget, [0, false, 0, 5])
                    } else if(test_flag(1965) && !check_mission_completed(91)) {
                        msg_sync(81009, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(63) && !test_flag(1965)) {
                        msg_sync(81008, htarget, [0, false, 0, 5])
                    } else {
                        msg_sync(81007, htarget, [0, false, 0, 5])
                    }
                    break;
                case 753:
                    if(check_mission_completed(113)) {
                        msg_sync(81020, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(110) && !check_mission_completed(113)) {
                        msg_sync(81019, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(104) && !check_mission_completed(110)) {
                        msg_sync(81018, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(91) && !check_mission_completed(104)) {
                        msg_sync(81017, htarget, [0, false, 0, 5])
                    } else if(test_flag(1965) && !check_mission_completed(91)) {
                        msg_sync(81016, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(63) && !test_flag(1965)) {
                        msg_sync(81015, htarget, [0, false, 0, 5])
                    } else {
                        msg_sync(81014, htarget, [0, false, 0, 5])
                    }
                    break;
                case 754:
                    if(check_mission_completed(113)) {
                        msg_sync(81027, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(110) && !check_mission_completed(113)) {
                        msg_sync(81026, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(104) && !check_mission_completed(110)) {
                        msg_sync(81025, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(91) && !check_mission_completed(104)) {
                        msg_sync(81024, htarget, [0, false, 0, 5])
                    } else if(test_flag(1965) && !check_mission_completed(91)) {
                        msg_sync(81023, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(63) && !test_flag(1965)) {
                        msg_sync(81022, htarget, [0, false, 0, 5])
                    } else {
                        msg_sync(81021, htarget, [0, false, 0, 5])
                    }
                    break;
                case 755:
                    if(check_mission_completed(113)) {
                        msg_sync(81034, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(110) && !check_mission_completed(113)) {
                        msg_sync(81033, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(104) && !check_mission_completed(110)) {
                        msg_sync(81032, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(91) && !check_mission_completed(104)) {
                        msg_sync(81031, htarget, [0, false, 0, 5])
                    } else if(test_flag(1965) && !check_mission_completed(91)) {
                        msg_sync(81030, htarget, [0, false, 0, 5])
                    } else if(check_mission_completed(63) && !test_flag(1965)) {
                        msg_sync(81029, htarget, [0, false, 0, 5])
                    } else {
                        msg_sync(81028, htarget, [0, false, 0, 5])
                    }
                    break;
            }

        }
        
        end_invisible_town_npc()
        ui_deactivate(14)
        end_idle_town_npc()
            
        PadOnWait(0)
    }
}
