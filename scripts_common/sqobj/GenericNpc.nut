// TODO match line infos

function SetNpcStartTalkActEnable(hact, enable) {
    local actor = get_actor_script(hact)
    actor.start_talk_act_enable = enable
}

class GenericNpc extends ActorBase {
    hplayer_ = 0
    key_ = 0
    town_account_kind_ = 4
    is_suppluy_quest_ = false
    quest_key_ = -1
    eff_quest_complete_ = [0, 0]
    start_talk_act_enable = true
    h_talk_left_ = 0
    h_talk_right_ = 0
    h_talk_player_ = 0
    h_talk_target_ = 0
    is_talk_demo_ = false
    talk_in_out_ = 0
    talk_player_dir_ = 0
    no_sync_ = false
    default_in_out_ = 2
    is_shop_talk = 0
    is_quest_clear = 0
    
    function OnPlayerTalked(htalker, htarget) {
        print("GenericNpc::OnPlayerTalked:" + htalker + "," + htarget)

        this.hplayer_ = htalker
        this.key_ = get_charadb(this.hself, 0)

        PadOffWait(0)

        ui_push_env(0)
        if(is_grassland_situation(this.key_)) {
            this.__TalkEvent_Grassland()
        } else {
            this.town_account_kind_ = get_town_account(this.hself)

            switch(this.town_account_kind_) {
                case 2:
                    print("TalkEvent: 来訪前 -> " + this.key_)
                    this.__TalkEvent_Wandering()
                    break;
                case 0:
                    print("TalkEvent: タビビト -> " + this.key_)
                    this.__TalkEvent_Guest()
                    break;
                case 1:
                    print("TalkEvent: 住人 -> " + this.key_)
                    this.__TalkEvent_Resident()
                    break;
            }

            this.town_account_kind_ = 4
        }
        ui_pop_env()

        PadOnWait(0)
    }

    function OnRankUpQuestTalked(htalker, htarget) {
        print("GenericNpc::OnRankUpQuestTalked:" + htalker + "," + htarget)

        this.hplayer_ = htalker
        this.key_ = get_charadb(this.hself, 0)

        this.is_shop_talk = 1

        ui_push_env(0)
        
        this.town_account_kind_ = get_town_account(this.hself)

        switch(this.town_account_kind_) {
            case 1:
                ui_activate(14, [this.hself])
                this.__StartTalkDemo(this.hplayer_, this.hself, this.default_in_out_, false)
                this.__TalkEvent_Resident_Main()
                this.__EndTalkDemo()
                ui_deactivate(14)
                break;
        }

        ui_pop_env()

        this.is_shop_talk = 0

        return this.is_quest_clear
    }

    function __Message(mes_type) {
        local id = GetNpcMessageId(this.key_, mes_type)

        print("[NPC]: __Message(): " + id)

        if(this.is_talk_demo_) {
            if(this.no_sync_) {
                msg_talk_event(id, this.h_talk_target_)
            } else {
                msg_sync_talk_event(id, this.h_talk_target_)
            }
        } else {
            if(this.no_sync_) {
                msg(id, this.hself)
            } else {
                msg_sync(id, this.hself)
            }
        }
    }

    function __Message_NoSync(mes_type) {
        this.no_sync_ = true
        this.__Message(mes_type)
        this.no_sync_ = false
    }

    function __RandomMessageVisitor() {
        local id = (this.key_ * 100) + this.get_actor_visitor_random_message_offset(this.hself)
        print("[NPC]: __RandomMessageVisitor(): " + id)

        if(this.is_talk_demo_) {
            if(this.no_sync_) {
                msg_talk_event(id, this.h_talk_target_)
            } else {
                msg_sync_talk_event(id, this.h_talk_target_)
            }
        } else {
            if(this.no_sync_) {
                msg(id, this.hself)
            } else {
                msg_sync(id, this.hself)
            }
        }
    }

    function __RandomMessageVisitor_NoSync() {
        this.no_sync_ = true
        this.__RandomMessageVisitor()
        this.no_sync_ = false
    }

    function __RandomMessageResident() {
        local id = (this.key_ * 100) + this.get_actor_resident_random_message_offset(this.hself)
        print("[NPC]: __RandomMessageResident(): " + id)

        if(this.is_talk_demo_) {
            if(this.no_sync_) {
                msg_talk_event(id, this.h_talk_target_)
            } else {
                msg_sync_talk_event(id, this.h_talk_target_)
            }
        } else {
            if(this.no_sync_) {
                msg(id, this.hself)
            } else {
                msg_sync(id, this.hself)
            }
        }
    }

    function __RandomMessageResident_NoSync() {
        this.no_sync_ = true
        this.__RandomMessageResident()
        this.no_sync_ = false
    }

    function __GreetMessageResident() {
        local id = (this.key_ * 100) + this.get_actor_resident_greet_message_offset(this.hself)
        print("[NPC]: __GreetMessageResident(): " + id)

        if(this.is_talk_demo_) {
            if(this.no_sync_) {
                msg_talk_event(id, this.h_talk_target_)
            } else {
                msg_sync_talk_event(id, this.h_talk_target_)
            }
        } else {
            if(this.no_sync_) {
                msg(id, this.hself)
            } else {
                msg_sync(id, this.hself)
            }
        }
    }

    function __GreetMessageResident_NoSync() {
        this.no_sync_ = true
        this.__GreetMessageResident()
        this.no_sync_ = false
    }

    function __QuestClearMessage(mes_id) {
        local first = true
        local id = mes_id

        print("[NPC]: __QuestClearMessage(): " + id)

        if(this.is_talk_demo_) {
            if(this.no_sync_) {
                msg_talk_event(id, this.h_talk_target_)
            } else {
                msg_sync_talk_event(id, this.h_talk_target_)
            }
        } else {
            if(this.no_sync_) {
                msg(id, this.hself)
            } else {
                msg_sync(id, this.hself)
            }
        }
    }

    function __QuestClearMessage_NoSync() {
        this.no_sync_ = true
        this.__QuestClearMessage()
        this.no_sync_ = false
    }

    function __TalkEvent_Grassland() {
        __StartTownTalkAction(this.hplayer_, this.hself)
        
        local exist_chaos = is_chaos_talk(1)

        if(exist_chaos) {
            __Message(45)
        } else {
            __Message(53)
        }

        local msg_id_array = [4035, 4037, 4036, 4169]

        ui_choice_reset(msg_id_array, 3)
        ui_choice_register(0)
        ui_choice_register(1)
        ui_choice_register(2)
        ui_choice_register(3)
        
        local loop_finish = false
        while(!loop_finish) {
            ui_choice_activate()

            switch(ui_choice_get_result()) {
                case 0:
                    this.__RecoveryHarvest()
                    break;
                case 1:
                    this.__AddToSeed()
                    break;
                case 2:
                    if(this.__AbortAgent() == true) {
                        loop_finish = true
                    }
                    break;
                case 3:
                    loop_finish = true
                    break;
            }
        }

        this.__EndTownTalkAction(this.hplayer_, this.hself)
    }

    function __RecoveryHarvest() {
        local is_harvest = false

        if(is_exist_harvest(get_charadb(this.hself, 0)) == true) {
            local result = ui_sync(58, [get_charadb(this.hself, 0), 0])
            if(result[0] == 1) {
                is_harvest = true
            }
        } else {
            msg_sync(4047)
        }

        return is_harvest;
    }

    function __AbortAgent() {
        local is_aborted = false
        local result = ui_sync(58, [get_charadb(this.hself, 0), 1])

        if(result[0] == 1) {
            msg_sync(4247)
            fadeout_sync(0, 0, 1.0)
            destroy_actor(this.hself)
            ui_deactivate(75)
            fadein_sync(0, 0, 1.0)
            is_aborted = true
        }

        return is_aborted;
    }

    function __AddToSeed() {
        if(is_available_add_seed(get_charadb(this.hself, 0)) == true) {
            local result = ui_sync(58, [get_charadb(this.hself, 0), 2])
            if(result[0] == 1) {
                // empty
            }
        } else {
            msg_sync(4494)
        }
    }

    function __TalkEvent_Wandering() {
        this.__StartFieldTalkAction(this.hplayer_, this.hself)
        this.__StartTalkDemo(this.hplayer_, this.hself, this.default_in_out_, true)

        local first_find = get_actor_visitor_status(this.hself, 0)

        if(first_find) {
            print("来訪前:発見")

            start_actor_motion_auto_idle(this.h_talk_target_, 231)
            this.__Message_NoSync(0)

            wait(30)
            func_wait(is_msg_finished)

            set_actor_visitor_status(this.hself, 0)
            ui_activate(14, [this.hself])
            switch_visitor_list_state(this.hself, 2)
            ui_push_env(2)

            {
                local rumor = get_actor_visitor_status(this.hself, 5)

                if(rumor) {
                    start_visitor_list_update_ui(this.key_, 2)
                } else {
                    start_visitor_list_update_ui(this.key_, 1)
                }

                start_actor_motion(this.h_talk_player_, 0)
                start_actor_motion(this.h_talk_target_, 0)

                func_wait(is_finish_visitor_list_update_ui)

                ui_deactivate(24)
            }

            ui_pop_env()
            set_actor_visitor_status(this.hself, 1)
            set_actor_visitor_status(this.hself, 5)

            local encounter_key = get_encounter_key(this.hself)

            finish_encounter_name_hide(encounter_key)
        } else {
            ui_activate(14, [this.hself])
        }

        if(first_find) {
            print("来訪前:来訪可能、初回")
            start_actor_motion(this.h_talk_target_, 231)
            __Message_NoSync(1)

            wait(30)
            func_wait(is_msg_finished)
        } else {
            print("来訪前:来訪可能、繰り返し")
            start_actor_motion(this.h_talk_target_, 231)
            __Message_NoSync(86)

            wait(30)
            func_wait(is_msg_finished)
        }

        ui_deactivate(14)
        this.__EndTalkDemo()
        this.__EndFieldTalkAction(this.hplayer_, this.hself)
    }

    function __TalkEvent_Guest() {
        this.__StartTownTalkAction(this.hplayer_, this.hself)
        this.__StartTalkDemo(this.hplayer_, this.hself, this.default_in_out_, false)
        
        func_wait(is_talk_camera_ready)

        this.__TalkEvent_Guest_Main()
        this.__EndTalkDemo()
        this.__EndTownTalkAction(this.hplayer_, this.hself)
    }

    function __TalkEvent_Resident() {
        this.__StartTownTalkAction(this.hplayer_, this.hself)
        this.__StartTalkDemo(this.hplayer_, this.hself, this.default_in_out_, false)
        
        func_wait(is_talk_camera_ready)

        this.__TalkEvent_Resident_Main()
        this.__EndTalkDemo()
        this.__EndTownTalkAction_Resident(this.hplayer_, this.hself)
    }

    function __StartTownTalkAction(hplayer, htarget) {
        start_idle_town_npc()
        start_invisible_town_npc()
        set_actor_visible(htarget, true)
        begin_talk_camera_zoom_in(htarget)

        if(this.start_talk_act_enable) {
            begin_talk_action(htarget)

            func_wait(is_talk_ready)
        }

        if(!is_grassland_situation(this.key_)) {
            ui_activate(14, [htarget])
        } else {
            ui_activate(75, [this.key_])
        }
    }

    function __EndTownTalkAction(hplayer, htarget) {
        begin_talk_camera_zoom_out()
        end_invisible_town_npc()
        ui_deactivate(14)
        ui_deactivate(75)

        func_wait(is_talk_camera_finished)

        end_talk_camera()
        end_idle_town_npc()
    }

    function __EndTownTalkAction_Resident(hplayer, htarget) {
        local f1 = this.is_quest_clear
        local f2 = 0 == this.is_shop_talk
        local f3 = false == get_actor_visitor_status(this.hself, 4)
        local shop_handle = 0

        if(f1 && f2 && f3) {
            shop_handle = get_own_shop_handle(this.hself)
        }

        Suspend()
        while(is_playing_bgm(0x100003E) == 1) {
            Suspend()
        }

        if(shop_handle != 0) {
            begin_talk_camera_zoom_out()
            ui_deactivate(14)

            func_wait(is_talk_camera_finished)

            end_talk_camera()

            StartShopRankupDemo(shop_handle, this.hself)
            destroy_actor(this.hself)

            wait(5)

            end_invisible_town_npc()
            end_idle_town_npc()
        } else {
            this.__EndTownTalkAction(this.hplayer_, this.hself)
        }
    }

    function __StartFieldTalkAction(hplayer, htarget) {
        local scene_type = get_scene_type()

        if(scene_type == 5 || scene_type == 3) {
            party_weapon_in_out_sync(0, true)
        }

        start_idle_town_npc()
        start_invisible_town_npc()
        set_actor_visible(htarget, true)

        if(this.start_talk_act_enable) {
            begin_talk_action(htarget)
            func_wait(is_talk_ready)
        }
    }

    function __EndFieldTalkAction(hplayer, htarget) {
        end_invisible_town_npc()
        end_idle_town_npc()
    }

    function __TalkEvent_Guest_Main() {
        local hquest = get_quest_handle(2, this.hself)
        this.quest_key_ = hquest

        if(0 <= hquest) {
            this.is_suppluy_quest_ = 0 == get_npc_questdb(hquest, 21)

            local status = get_quest_status(2, hquest)

            switch(status) {
                case 0:
                    this.__GuestFree(hquest)
                    break;
                case 1:
                    this.__QuestRunning(hquest)
                    break;
                case 2:
                    this.__GuestQuestComplete(hquest)
                    break;
                default:
                    assert(false)
                    break;
            }
        } else {
            this.__GuestFree(-1)
        }

        this.__GuestToResident()
        this.__OptionalEvent_Ririsya(hquest)
        this.__OptionalEvent_Zyasupa(hquest)
    }

    function __GuestFree(hquest) {
        local heart_status_list = get_actor_heart_status(this.hself)
        local hit_num = heart_status_list[1]
        local miss_num = heart_status_list[2]
        local can_quest = 0 <= hquest && heart_status_list[3]
        local miss_shop_ignore = heart_status_list[4]
        local free_talk = true

        {
            local first_meeting = get_actor_visitor_status(this.hself, 2)
            if(first_meeting) {
                print("タビビト:自己紹介")
                this.__ResumeTalkDemo(null)
                play_voice_greeting(this.h_talk_target_)
                start_actor_motion(this.h_talk_target_, 231)
                this.__Message_NoSync(5)

                func_wait(is_msg_finished)

                set_actor_visitor_status(this.hself, 2)
            }
        
            local first_entrance = get_actor_visitor_status(this.hself, 13)
            if(first_entrance) {
                print("タビビト:3時間ルールをキャンセルでゾーン移動要求")
                set_actor_visitor_status(this.hself, 14)
            }
        
            this.__GuestHeartUpdate(heart_status_list, true)

            if(hit_num == 0 && miss_num == 0) {
                free_talk = true
            } else {
                free_talk = false
            }
        }

        if(free_talk) {
            local exist_chaos = is_chaos_talk(0)
            if(can_quest && false == exist_chaos) {
                this.__QuestAccept(hquest)
                set_actor_visitor_status(this.hself, 3)
            } else if(exist_chaos) {
                print("タビビト:カオス草")
                this.__Message(45)
            } else if(miss_shop_ignore) {
                print("タビビト:ランダム会話")
                this.__RandomMessageVisitor()
            }
        }

        local shop_no_match = is_no_match_heart_shop_condition(this.hself)
        if(shop_no_match) {
            print("タビビト:ハナミセ条件不一致でゾーン移動要求")
            set_actor_visitor_status(this.hself, 14)
        }
    }

    function __GuestHeartUpdate(heart_status_list, with_talk) {
        local now_index = 0
        local fix_num = heart_status_list[now_index++]
        local hit_num = heart_status_list[now_index++]
        local miss_num = heart_status_list[now_index++]
        local can_quest = heart_status_list[now_index++]
        local miss_shop_ignore = heart_status_list[now_index++]

        print("ハート情報: hit -> " + hit_num +
            ", miss -> " + miss_num)
        
        if(hit_num > 0) {
            local hit_index = heart_status_list[now_index++]
            local hit_mes_index = heart_status_list[now_index++]

            print("タビビト:ハート確定 -> " + hit_index +
                ", mes -> " + hit_mes_index)

            if(with_talk) {
                this.__ResumeTalkDemo(null)
                play_voice_joy(this.h_talk_target_)
                start_actor_motion(this.h_talk_target_, 312)
                this.__Message_NoSync(6 + hit_mes_index)

                wait(30)

                start_actor_motion(this.h_talk_player_, 300)

                func_wait(is_msg_finished)
            }

            fix_actor_heart_index(this.hself, hit_index)
            start_actor_heart_effect(this.h_talk_target_, fix_num)

            wait_for_true1(is_end_actor_heart_effect, this.h_talk_target_)
        } else if(miss_num > 0) {
            local miss_index = heart_status_list[now_index++]
            local miss_mes_index = heart_status_list[now_index++]

            print("タビビト:ハート不一致 -> " + miss_index +
                ", mes -> " + miss_mes_index)

            if(with_talk) {
                this.__ResumeTalkDemo(null)
                play_voice_surprise(this.h_talk_target_)
                start_actor_motion(this.h_talk_target_, 340)
                this.__Message_NoSync(11 + miss_mes_index)

                wait(30)

                start_actor_motion(this.h_talk_player_, 290)

                func_wait(is_msg_finished)
                this.__PauseTalkDemo()
            }
        }
    }

    function __GuestToResident() {
        if(is_actor_heart_max_fix_only(this.hself)) {
            print("タビビト:住人化")

            this.__ResumeTalkDemo(null)
            start_actor_motion_auto_idle(this.h_talk_target_, 321)
            this.__Message(16)

            wait(30)

            start_actor_motion_auto_idle(this.h_talk_player_, 312)

            func_wait(is_msg_finished)

            this.__PauseTalkDemo()
            this.__StartEffect_QuestComplete()

            wait(40)

            fadeout(1, 2, 1.0)

            wait(35)

            this.__EndEffect_QuestComplete()
            open_resident_system_message(this.key_)

            func_wait(is_msg_finished)

            local is_tanebito = open_resident_building_message(this.key_)
            if(is_tanebito) {
                func_wait(is_msg_finished)
            }

            local count_before = get_actor_count(1, [3, 1])

            ui_deactivate(14)
            ui_activate(34, [1])

            wait_for_true1(is_ui_active, 34)

            fadein_sync(1, 2, 1.0)
            set_town_account_resident(this.hself)
            ui_post(34, [this.hself])

            func_wait(IsEndOasisLevelAnim)

            ui_deactivate(34)
            CheckCanLvUpEffect()

            local check = check_spirit_level_up_equal()
            if(check) {
                local demo_event = DemoEventSet()
                if(null != demo_event) {
                    demo_event.StartInnerDemo(13, null)
                }
            }

            if(count_before == 1) {
                CompletedSpiritMission(14)
            }

            local count = get_resident_count(2)
            if(count >= 5) {
                set_flag(1021)
            }

            this.__OptionalEvent_Ebio()
            this.__OptionalEvent_Loht()
            this.__JoinedFlagSet_Maraia()
            achieve_resident_count(this.hself)
        }
    }

    function __GuestQuestComplete(hquest) {
        if(this.is_suppluy_quest_) {
            this.__Message(71)
            ui_activate(14, [this.hself])

            wait(15)

            local result = this.__QuestComplete_suppluy_check(hquest)
            if(false == result) {
                return;
            }
        }

        this.__GuestQuestComplete_main(hquest)
    }

    function __GuestQuestComplete_after_accept(hquest) {
        if(this.is_suppluy_quest_) {
            local status = get_quest_status(2, hquest)
            switch(status) {
                case 2:
                    ui_activate(14, [this.hself])

                    wait(15)

                    local result = this.__QuestComplete_suppluy_check(hquest)
                    if(false == result) {
                        this.__PauseTalkDemo()
                        return;
                    }

                    this.__GuestQuestComplete_main(hquest)
                    break;
            }
        }
    }

    function __GuestQuestComplete_main(hquest) {
        this.__QuestComplete_common(hquest)
        this.__HelpEvent_Equip()

        local heart_status_list = get_actor_heart_status(this.hself)

        this.__GuestHeartUpdate(heart_status_list, true)
    }

    function __TalkEvent_Resident_Main() {
        local hquest = get_quest_handle(2, this.hself)
        local exist_shop = exist_own_shop(this.hself)

        this.quest_key_ = hquest
        this.is_quest_clear = false

        if(0 <= hquest && exist_shop) {
            this.is_suppluy_quest_ = 0 == get_npc_questdb(hquest, 21)

            local status = get_quest_status(2, hquest)
            switch(status) {
                case 0:
                    if(0 == this.is_shop_talk) {
                        if(this.__ResidentGreeting()) {
                            if(this.__QuestFree(true)) {
                                this.__QuestAccept(hquest)
                            }
                        }
                    } else {
                        this.__QuestAccept(hquest)
                    }
                    break;
                case 1:
                    this.__QuestRunning(hquest)
                    break;
                case 2:
                    this.__QuestComplete(hquest)
                    break;
                default:
                    assert(false)
                    break;
            }
        } else {
            if(this.__ResidentGreeting()) {
                this.__QuestFree(false)
            }
        }
    }

    function __ResidentGreeting() {
        local exist_chaos = is_chaos_talk(0)
        if(exist_chaos) {
            print("住人:カオス草")
            this.__Message(45)
            return false;
        }

        local first_talk = get_actor_visitor_status(this.hself, 3)
        if(first_talk) {
            print("住人:あいさつ")
            play_voice_greeting(this.hself)
            this.__GreetMessageResident()
            set_actor_visitor_status(this.hself, 3)
        }

        local deliver_yesterday = get_actor_visitor_status(this.hself, 17)
        if(deliver_yesterday) {
            play_voice_greeting(this.hself)
            this.__Message(22)
            clear_actor_visitor_status(this.hself, 17)
        }

        return true;
    }

    function __QuestFree(has_quest) {
        local result_array = get_actor_resident_important_message_offset(this.hself)

        if(has_quest) {
            switch(result_array[0]) {
                case 1:
                    break;
                default:
                    return true;
            }
        }

        switch(result_array[0]) {
            case 0:
                print("住人:ランダム会話")
                this.__RandomMessageResident()
                break;
            case 1:
                local chara_id = result_array[2]

                print("住人:ウワサ -> " + chara_id)
                this.__ResumeTalkDemo(null)
                start_actor_motion(this.h_talk_target_, 231)
                this.__Message(result_array[1])
                this.__PauseTalkDemo()
                ui_push_env(2)
                start_visitor_list_update_ui(chara_id, 0)

                func_wait(is_finish_visitor_list_update_ui)

                ui_deactivate(24)
                ui_pop_env()
                this.__OptionalEvent_Pami()
                break;
            case 2:
                print("住人:ダンジョンウワサ")
                this.__Message(result_array[1])
                break;
        }

        return false;
    }

    function __QuestAccept(hquest) {
        this.__QuestAccept_Start(hquest)

        switch(get_npc_quest_info_level(hquest)) {
            case 0:
                print("クエスト依頼: やること追加")
                set_npc_quest_info_unlock(hquest)
                ui_sync(23, [1, hquest])
                break;
            case 1:
                switch(this.town_account_kind_) {
                    case 0:
                        if(check_supply_quest(hquest)) {
                            print("クエスト依頼: やること表示しない")
                        } else {
                            print("クエスト依頼: やること表示済み")
                            ui_sync(23, [2, hquest])
                        }
                        break;
                    case 1:
                        ui_sync(23, [1, hquest])
                        break;
                }
                break;
            case 2:
                print("===== [ERROR]: __QuestAccept() 到達しない箇所です =====")
                break;
        }

        local status = get_quest_status(2, hquest)

        switch(status) {
            case 0:
                switch(this.town_account_kind_) {
                    case 0:
                        this.__PauseTalkDemo()
                        break;
                    case 1:
                        this.__QuestAccept_Cancel(hquest)
                        break;
                }
                check_supply_quest(hquest)
                break;
            case 1:
                this.__PauseTalkDemo()
                break;
            case 2:
                switch(this.town_account_kind_) {
                    case 0:
                        this.__GuestQuestComplete_after_accept(hquest)
                        break;
                    case 1:
                        this.__QuestComplete_after_accept(hquest)
                        break;
                }
                break;
        }
    }

    function __QuestAccept_Start(hquest) {
        local result = get_actor_resident_quest_start_message(hquest)
        local result_mes = result[0]
        local result_mes_repeart = result[1]
        local status_bit = result[2]

        local result = get_npc_quest_start_event_id(hquest)
        local event_id = result[0]
        local player_dir = result[1]
        local first_appear = result[2]
        
        if(0 <= event_id) {
            local mes_id = 0
            local repeart = get_actor_visitor_status(this.hself, status_bit)

            if(false == repeart) {
                mes_id = result_mes
                print("タビビト/住人:クエスト依頼 -> " + mes_id)
            } else {
                mes_id = result_mes_repeart
                print("タビビト/住人:クエスト依頼、繰り返し -> " + mes_id)
            }

            this.__ResumeTalkDemo([player_dir, first_appear])

            local demo_event_ = DemoEventSet()
            demo_event_.StartInnerDemo(event_id, [
                this.h_talk_player_, this.h_talk_target_, repeart, mes_id
            ])
        } else {
            print("[NPC]: ===== WARNING!! ===== __QuestAccept_Start(): クエストイベントがありません")
        }

        set_actor_visitor_status(this.hself, status_bit)
        this.__FlagSet_Ririsya(hquest)
    }

    function __QuestAccept_Cancel(hquest) {
        print("タビビト/住人:クエスト受けない")
        
        local talk_demo = this.__IsTalkDemo()
        local local_hplayer = 0
        local local_hact = 0

        if(talk_demo) {
            local_hplayer = this.h_talk_player_
            local_hact = this.h_talk_target_
        } else {
            local_hplayer = this.hplayer_
            local_hact = this.hself
        }

        this.__Message(72)
        this.__PauseTalkDemo()
    }

    function __QuestRunning(hquest) {
        print("住人:クエスト受けている")
        this.__Message(71)
        set_actor_visitor_status(this.hself, 3)
    }

    function __RemoveOwnerNpc() {
        local party_removed = false

        if(get_party(2) != 0) {
            remove_party_by_kind(2, 1)
            party_removed = true
        }

        return party_removed
    }

    function __QuestComplete(hquest) {
        if(this.is_suppluy_quest_) {
            this.__Message(71)
            ui_activate(14, [this.hself])

            wait(15)

            local result = this.__QuestComplete_suppluy_check(hquest)
            if(false == result) {
                return;
            }
        }

        this.__QuestComplete_main(hquest)
    }

    function __QuestComplete_after_accept(hquest) {
        if(this.is_suppluy_quest_) {
            local status = this.get_quest_status(2, hquest)
            switch(status) {
                case 2:
                    ui_activate(14, [this.hself])

                    wait(15)

                    local result = this.__QuestComplete_suppluy_check(hquest)
                    if(false == result) {
                        this.__PauseTalkDemo()
                        return;
                    }

                    this.__QuestComplete_main(hquest)
                    break;
            }
        }
    }

    function __QuestComplete_main(hquest) {
        local is_party = is_npc_quest_accompanying(hquest)

        if(is_party) {
            local running_hquest = get_running_npc_quest_handle()
            local running_chara_id = -1

            if(0 <= running_hquest) {
                running_chara_id = get_npc_questdb(running_hquest, 6)
            }

            print("[QUEST]: run chara: " + running_chara_id +
                    ", talk chara: " + this.key_)
                
            if(0 <= running_chara_id) {
                if(this.key_ != running_chara_id) {
                    print("[QUEST]: 別のクエストのクリアなのでパーティ解散しない")
                    is_party = false
                }
            }
        }

        local title_id = get_npc_questdb(hquest, 3)

        this.__QuestComplete_common(hquest)
        this.__PauseTalkDemo()
        this.__StartEffect_QuestComplete()

        wait(120)

        print("[QUEST]: title msg -> " + title_id)
        msg(4260, 0, 0, [this.key_, title_id])

        wait(90)

        this.__EndEffect_QuestComplete()

        func_wait(is_msg_finished)

        set_actor_visitor_status(this.hself, 3)

        if(is_party) {
            if(this.__RemoveOwnerNpc()) {
                msg_argv_sync(4009, 0, 0, [this.key_])
            }
        }

        this.is_quest_clear = true
    }

    function __QuestComplete_suppluy_check(hquest) {
        local result = false
        local item_id = get_npc_questdb(hquest, 7)
        local item_num = get_npc_questdb(hquest, 23)

        local ui_result = ui_sync(64, [4909, 1, item_id, item_num])

        if(ui_result[0] == 1) {
            result = true
        }

        return result;
    }

    function __QuestComplete_common(hquest) {
        local result = get_npc_quest_end_event_id(hquest)
        local event_id = result[0]
        local player_dir = result[1]
        local first_appear = result[2]

        this.__ResumeTalkDemo([player_dir, first_appear])

        local talk_demo = this.__IsTalkDemo()
        local local_hplayer = 0
        local local_hact = 0

        if(talk_demo) {
            local_hplayer = this.h_talk_player_
            local_hact = this.h_talk_target_
        } else {
            local_hplayer = this.hplayer_
            local_hact = this.hself
        }

        local tribeType = get_charadb(local_hact, 54)

        if(this.is_suppluy_quest_) {
            start_actor_motion_auto_idle(local_hplayer, 378)

            wait_for_true1(is_motion_finished, local_hplayer)

            switch(tribeType) {
                case 0:
                    start_actor_motion_auto_idle(local_hact, 350)
                    break;
                case 1:
                    start_actor_motion_auto_idle(local_hact, 350)
                    break;
                case 2:
                    start_actor_motion_auto_idle(local_hact, 301)
                    break;
                case 3:
                    start_actor_motion_auto_idle(local_hact, 310)
                    break;
            }
        }

        print("タビビト/住人:クエストクリア")

        {
            local mes_id = get_actor_resident_quest_clear_message(hquest, true)
            if(0 <= event_id) {
                if(this.is_suppluy_quest_) {
                    wait_for_true1(is_motion_finished, local_hact)
                }

                local demo_event_ = DemoEventSet()
                demo_event_.StartInnerDemo(event_id, [
                    this.h_talk_player_,
                    this.h_talk_target_,
                    false,
                    mes_id
                ])
            } else {
                this.__QuestClearMessage(mes_id)
            }
        }

        start_actor_motion_auto_idle(local_hact, 378)

        wait_for_true1(is_motion_finished, local_hact)

        start_actor_motion_auto_idle(local_hplayer, 389)
        play_se(0x100007D)
        
        {
            local reward_type = get_npc_questdb(hquest, 26)
            if(reward_type == 0) {
                local reward = get_npc_questdb(hquest, 14)
                if(talk_demo) {
                    msg_argv_sync_talk_event(4477, 0, 0, [reward])
                } else {
                    msg_argv_sync(4477, 0, 0, [reward])
                }
            } else if(reward_type == 1) {
                local reward = get_npc_questdb(hquest, 13)
                if(talk_demo) {
                    msg_argv_sync_talk_event(4449, 0, 0, [reward])
                } else {
                    msg_argv_sync(4449, 0, 0, [reward])
                }
            }
        }

        ui_sync(23, [3, hquest])
        finish_quest(2, hquest)
    }

    function __StartEffect_QuestComplete() {
        local local_hact = 0

        if(this.__IsTalkDemo()) {
            local_hact = this.h_talk_target_
        } else {
            local_hact = this.hself
        }

        this.eff_quest_complete_ = StartEffectQuestComplete(local_hact, this.town_account_kind_)
    }

    function __EndEffect_QuestComplete() {
        EndEffectQuestComplete(eff_quest_complete_)
    }

    function __StartTalkDemo(hact_left, hact_right, in_out, start) {
        this.talk_in_out_ = in_out
        this.h_talk_left_ = create_talk_event_actor_index(get_actor_dbkey(hact_left), 1, 0, 0.0)
        this.h_talk_right_ = create_talk_event_actor_index(get_actor_dbkey(hact_right), 1, 0, 0.0)
        set_talk_actor_visible(this.h_talk_left_, false)
        set_talk_actor_visible(this.h_talk_right_, false)

        if(hact_left == this.hself) {
            this.h_talk_target_ = this.h_talk_left_
            this.h_talk_player_ = this.h_talk_right_
        } else if(hact_right == this.hself) {
            this.h_talk_target_ = this.h_talk_right_
            this.h_talk_player_ = this.h_talk_left_
        } else {
            print("ERROR!! __StartTalkDemo(): 話者のアクターハンドルを取得できません")
        }

        print("[TalkDemo]: START")

        if(start) {
            this.__ResumeTalkDemo(null)
        }
    }

    function __EndTalkDemo() {
        if(this.__IsTalkDemo()) {
            if(this.talk_in_out_ == 0) {
                if(this.talk_player_dir_ == 0) {
                    talk_actor_slide_move(this.h_talk_player_, 7)
                    talk_actor_slide_move(this.h_talk_target_, 8)
                } else {
                    talk_actor_slide_move(this.h_talk_target_, 7)
                    talk_actor_slide_move(this.h_talk_player_, 8)
                }
                talk_event_slide_move_wait(this.h_talk_left_)
            }
            finalize_talk_event()
        }

        destroy_actor(this.h_talk_left_)
        destroy_actor(this.h_talk_right_)
        this.h_talk_left_ = 0
        this.h_talk_right_ = 0
        this.is_talk_demo_ = false

        print("[TalkDemo]: END")
    }

    function __PauseTalkDemo() {
        if(false == this.__IsTalkDemo()) return;

        if(this.talk_in_out_ == 0) {
            if(this.talk_player_dir_ == 0) {
                talk_actor_slide_move(this.h_talk_player_, 7)
                talk_actor_slide_move(this.h_talk_target_, 8)
            } else {
                talk_actor_slide_move(this.h_talk_target_, 7)
                talk_actor_slide_move(this.h_talk_player_, 8)
            }
            talk_event_slide_move_wait(this.h_talk_left_)
        }
        finalize_talk_event()

        set_talk_actor_visible(this.h_talk_left_, false)
        set_talk_actor_visible(this.h_talk_right_, false)
        this.is_talk_demo_ = false

        print("[TalkDemo]: PAUSE")
    }

    function __ResumeTalkDemo(args) {
        if(this.__IsTalkDemo()) return;

        initialize_talk_event(true)

        local player_dir = 0
        local appear_mode = 0

        if(args != null) {
            player_dir = args[0]
            appear_mode = args[1]
        }

        this.talk_player_dir_ = player_dir
        
        local player_appear = appear_mode == 0 || appear_mode == 1
        local target_appear = appear_mode == 0 || appear_mode == 2
        local appear_pos = [0, 0]

        switch(player_dir) {
            case 0:
                set_talk_event_actor_angle_index(this.h_talk_player_, 1)
                set_talk_event_actor_angle_index(this.h_talk_target_, 0)
                switch(this.talk_in_out_) {
                    case 0:
                        set_talk_event_actor_pos_index(this.h_talk_player_, 7)
                        set_talk_event_actor_pos_index(this.h_talk_target_, 8)
                        appear_pos[0] = 3
                        appear_pos[1] = 4
                        break;
                    case 2:
                        if(player_appear) {
                            set_talk_event_actor_pos_index(this.h_talk_player_, 3)
                        } else {
                            set_talk_event_actor_pos_index(this.h_talk_player_, 7)
                        }
                        if(target_appear) {
                            set_talk_event_actor_pos_index(this.h_talk_target_, 4)
                        } else {
                            set_talk_event_actor_pos_index(this.h_talk_target_, 8)
                        }
                        break;
                }
                break;
            default:
                set_talk_event_actor_angle_index(this.h_talk_target_, 1)
                set_talk_event_actor_angle_index(this.h_talk_player_, 0)
                switch(this.talk_in_out_) {
                    case 0:
                        set_talk_event_actor_pos_index(this.h_talk_target_, 7)
                        set_talk_event_actor_pos_index(this.h_talk_player_, 8)
                        appear_pos[1] = 3
                        appear_pos[0] = 4
                        break;
                    case 2:
                        if(target_appear) {
                            set_talk_event_actor_pos_index(this.h_talk_target_, 3)
                        } else {
                            set_talk_event_actor_pos_index(this.h_talk_target_, 7)
                        }
                        if(player_appear) {
                            set_talk_event_actor_pos_index(this.h_talk_player_, 4)
                        } else {
                            set_talk_event_actor_pos_index(this.h_talk_player_, 8)
                        }
                        break;
                }
        }

        wait(1)

        set_talk_actor_visible(this.h_talk_left_, true)
        set_talk_actor_visible(this.h_talk_right_, true)

        if(this.talk_in_out_ == 0) {
            if(player_appear) {
                talk_actor_slide_move(this.h_talk_player_, appear_pos[0])
            }
            if(target_appear) {
                talk_actor_slide_move(this.h_talk_target_, appear_pos[1])
            }
            if(player_appear || target_appear) {
                talk_event_slide_move_wait(this.h_talk_left_)
            }
        }

        this.is_talk_demo_ = true

        print("[TalkDemo]: RESUME: player dir: " + player_dir +
            ", mode: " + appear_mode)
    }

    function __IsTalkDemo() {
        return this.is_talk_demo_;
    }

    function __FlagSet_Ririsya(hquest) {
        local check = this.key_ == 721
        if(check && this.town_account_kind_ == 0) {
            set_flag(4058)
            set_flag(4059)
        }
    }

    function __OptionalEvent_Ririsya(hquest) {
        local check = this.key_ == 721
        if(check) {
            if(0 == get_town_account(this.hself)) {
                set_mission_ui_to_do(15)
            }

            local status = get_quest_status(2, hquest)
            switch(status) {
                case 0:
                    ForceStartOptionalQuestEvent_SetEventMode(91, false)
                    break;
                case 1:
                case 2:
                    ForceStartOptionalQuestEvent_SetEventMode(68, false)
                    break;
            }
        }
    }

    function __OptionalEvent_Zyasupa(hquest) {
        local check = this.key_ == 720
        if(check) {
            if(!check_optional_quest_completed(13) && !check_optional_quest_completed(28)) {
                this.__PauseTalkDemo()
                ForceStartOptionalQuestEvent_SetEventMode(28, false)
            }
        }
    }

    function __OptionalEvent_Ebio() {
        if(this.key_ == 701) {
            ForceStartOptionalQuestEvent_SetEventMode(6, false)
        }
    }

    function __OptionalEvent_Loht() {
        if(this.key_ == 705) {
            local check = check_mission_completed(76)
            if(false == check) {
                ForceStartOptionalQuestEvent_SetEventMode(76, false)
            }

            if(4 <= get_var(100) &&
                test_flag(334) &&
                !check_mission_running(37) &&
                !check_mission_completed(37)) {
                local hquest = get_quest_handle(3, 37)
                local ret = run_quest(3, hquest)
            }
        }
    }

    function __OptionalEvent_Pami() {
        local check = this.key_ == 707
        if(check) {
            ForceStartOptionalQuestEvent_SetEventMode(69, false)
        }
    }

    function __HelpEvent_Equip() {
        local check = this.key_ == 778
        if(check) {
            if(false == test_flag(1952)) {
                wait_for_true2(is_motion_finished, this.h_talk_player_, 389)
                wait(15)

                black_mask_d_start()
                ui_sync(5, [83046, 83047])
                black_mask_d_end()
                set_flag(1952)

                wait(15)
            }
        }
    }

    function __JoinedFlagSet_Maraia() {
        if(this.key_ == 724) {
            set_flag(341)
            start_actor_head_icon(0, 748)
        }
    }
}
