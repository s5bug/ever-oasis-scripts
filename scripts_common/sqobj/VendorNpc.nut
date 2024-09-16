// TODO match line infos

class VendorNpc extends ActorBase {
    vendor_type_ = 0
    hplayer_ = 0
    htarget_ = 0

    constructor(hact) {
        this.hself = hact

        switch(get_charaid(hact)) {
            case 25:
                this.vendor_type_ = 5
                break;
            case 26:
                this.vendor_type_ = 6
                break;
            case 27:
                this.vendor_type_ = 7
                break;
            case 28:
                this.vendor_type_ = 8
                break;
            case 29:
                this.vendor_type_ = 9
                break;
            case 30:
                this.vendor_type_ = 10
                break;
            case 31:
                this.vendor_type_ = 11
                break;
        }
    }

    function OnPlayerTalked(hplayer, htarget) {
        print("VendorNpc::OnPlayerTalked( hplayer=" + hplayer +
            ", htarget=" + htarget + " )")
        
        this.hplayer_ = hplayer
        this.htarget_ = htarget

        if(this.vendor_type_ == 0) {
            msg_sync(65110, htarget)
            return;
        }

        PadOffWait(0)

        ui_push_env(0)

        {
            local c1_event = this.__Vender_Event_Chapter_1(htarget)
            if(false == c1_event) {
                start_idle_town_npc()
                start_invisible_town_npc()
                set_actor_visible(htarget, true)

                begin_actor_look_target(this.htarget_, this.hplayer_)
                this.__Vendor_msg_op()
                this.__Help()
                end_actor_look_target(this.htarget_)

                this.__Menu()

                begin_actor_look_target(this.htarget_, this.hplayer_)
                this.__Vendor_msg_cl()
                end_actor_look_target(this.htarget_)

                end_invisible_town_npc()
                end_idle_town_npc()
                set_actor_visitor_status(this.hself, 2)
            }
        }

        ui_pop_env()

        PadOnWait(0)
    }

    function __Menu() {
        print("VendorNpc::__Menu()")

        local msg_id_array = [4205, 4204, 4169]

        ui_choice_reset(msg_id_array, 2)
        ui_choice_set_option([2, 2, 0, 0])
        ui_choice_register(0)

        if(is_vendor_trade_available(this.vendor_type_, get_var(100))) {
            ui_choice_register(1)
        }

        ui_choice_register(2)

        if(ui_choice_get_valid_choices_count() >= 2) {
            this.__menu_camera(this.hplayer_, this.htarget_)
        }

        local loop_finish = false
        while(!loop_finish) {
            ui_choice_activate()
            switch(ui_choice_get_result()) {
                case 0:
                    this.__Buy()
                    break;
                case 1:
                    this.__Trade()
                    break;
                default:
                    loop_finish = true
            }
            if(ui_choice_get_valid_choices_count() < 2) {
                loop_finish = true
            }
        }

        if(ui_choice_get_valid_choices_count() >= 2) {
            this.__menu_camera_end(this.hplayer_, this.htarget_)
        }
    }

    function __menu_camera(hplayer, htarget) {
        local pos_ent = get_actor_position(htarget)

        init_petit()
        set_petit_dst_param(pos_ent[0] + 3.0, pos_ent[1] + 7.0, pos_ent[2] + 20.0,
            pos_ent[0] + 5.0, pos_ent[1] + 6.0, pos_ent[2],
            -0.0, 42.029)
        begin_petit(15)
        set_actor_visible_fade(hplayer, false, 0.25)
    }

    function __menu_camera_end(hplayer, htarget) {
        init_petit()

        local reset_param = get_reset_param_of_rail_camera()

        set_petit_dst_param(reset_param)
        begin_petit(15)
        set_actor_visible_fade(hplayer, true, 0.25)

        const neg8 = -8
        wait(neg8)

        end_petit()
    }

    function __Buy() {
        print("VendorNpc::__Buy()")

        fadeout_sync(0, 0, 0.25)
        ui_push_env(4)
        ui_sync(21, [this.vendor_type_, get_var(100)])
        ui_pop_env()
        fadein(0, 0, 0.25)
    }

    function __Trade() {
        print("VendorNpc::__Trade()")

        fadeout_sync(0, 0, 0.25)
        ui_push_env(2)
        ui_sync(49, [this.vendor_type_])
        ui_pop_env()
        fadein_sync(0, 0, 0.25)
    }

    function __Help() {
        switch(this.vendor_type_) {
            case 5:
            case 7:
                if(false == test_flag(1014)) {
                    ui_sync(5, [83148, 83149])
                    set_flag(1014)
                }
            case 8:
                if(false == test_flag(936)) {
                    ui_sync(5, [83105, 83106])
                    if(!check_optional_quest_completed(11)) {
                        delete_idle_optional_quest(11)
                    }
                    set_flag(936)
                }
        }
    }

    function __Vendor_msg_op() {
        switch(this.vendor_type_) {
            case 5:
            case 7:
            case 9:
                msg_sync(988, this.htarget_)
                break;
            case 11:
                local first = get_actor_visitor_status(this.hself, 2)
                if(first) {
                    msg_sync(61152, this.htarget_)
                } else {
                    msg_sync(988, this.htarget_)
                }
                break;
            case 10:
                msg_sync(988, this.htarget_)
                break;
            case 8:
                if(false == this.__Vendor_msg_op_R1(this.htarget_)) {
                    msg_sync(988, this.htarget_)
                }
                break;
            case 6:
                if(false == this.__Vendor_msg_op_C1(this.htarget_)) {
                    msg_sync(988, this.htarget_)
                }
                break;
        }
    }

    function __Vendor_msg_cl() {
        local rate = get_random(100)
        local mes = [993, 994, 995, 996]
        local no = get_random(4)

        if(rate < 30) {
            print("VendorNpc::Random Message :" + mes[no])
            msg_sync(mes[no], this.htarget_)
        }

        switch(this.vendor_type_) {
            case 5:
            case 7:
            case 9:
            case 11:
                msg_sync(989, this.htarget_)
                break;
            case 8:
            case 6:
            case 10:
                msg_sync(990, this.htarget_)
                break;
        }
    }

    function __Vendor_msg_op_C1(htarget) {
        print("Vendor_msg_op_C1")

        local result = false

        if(!check_optional_quest_completed(11)) {
            ForceStartOptionalQuestEvent_SetEventMode(11, false)
            set_demo_event(true)
            result = true
        }

        if(check_mission_completed(87) &&
            !check_optional_quest_completed(107) &&
            !check_optional_quest_completed(109)) {
            ForceStartOptionalQuestEvent_SetEventMode(107, false)
            set_demo_event(true)
            result = true
        } else if(check_optional_quest_completed(109) &&
            !check_optional_quest_completed(42)) {
            ForceStartOptionalQuestEvent(42)
            set_demo_event(true)
            
            local hquest2 = get_quest_handle(3, 92)
            local ret = run_quest(3, hquest2)
            
            result = true
        }

        return result;
    }

    function __Vendor_msg_op_R1(htarget) {
        local result = false

        if(check_mission_completed(87) &&
            !check_optional_quest_completed(107) &&
            !check_optional_quest_completed(116)) {
            ForceStartOptionalQuestEvent(116)
            set_demo_event(true)
            result = true
        }
        
        if(check_optional_quest_completed(107) &&
            !check_optional_quest_completed(31) &&
            !test_flag(1958)) {
            ForceStartOptionalQuestEvent(31)
            set_demo_event(true)
            
            result = true
        } else if(test_flag(1958) &&
            !check_optional_quest_completed(105)) {
            ForceStartOptionalQuestEvent(105)
            set_demo_event(true)
            result = true
        }

        return result;
    }

    function __Vender_Event_Chapter_1(htarget) {
        local result = false

        if(this.vendor_type_ == 9 && test_flag(1954)) {
            if(!check_optional_quest_completed(77)) {
                ForceStartOptionalQuestEvent(77)
                set_flag(1955)
            } else if(check_optional_quest_completed(77) && !check_optional_quest_completed(78)) {
                msg_sync(45096, htarget)
            } else if(check_optional_quest_completed(78) && !check_optional_quest_completed(79)) {
                ForceStartOptionalQuestEvent(79)
                reset_flag(1955)
                reset_flag(1954)
            }

            result = true
        }

        return result;
    }
}
