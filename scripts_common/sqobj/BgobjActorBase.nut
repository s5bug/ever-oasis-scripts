// TODO match line infos

class BgobjActorBase {
    hself_ = 0
    group_id_ = 0
    layout_id_ = 0
    bgobj_id_ = 0
    act_type_ = 0
    camera_event_control_ = null
    AfterCreateAction_ = null
    AfterCreateActionInGroup_ = null

    constructor(group_id, bgobj_id, layout_id, act_type, create_flag) {
        this.group_id_ = group_id
        this.layout_id_ = layout_id
        this.bgobj_id_ = bgobj_id
        this.act_type_ = act_type
        
        if(create_flag & 1) {
            this.SetCreateWithCollision()
        }
        if(create_flag & 2) {
            this.SetCreateAsSwitch()
        }
        if(create_flag & 4) {
            this.SetCreateAsBreakable()
        }
        
        this.camera_event_control_ = CameraEventControl(this)
    }

    function CreateActor() {
        if(this.hself_ == null || this.hself_ == 0 || !exists_actor(this.hself_)) {
            this.hself_ = create_bgobj_from_res(this.group_id_, this.layout_id_)
        }
    }

    function DestroyActor() {
        this.camera_event_control_.Destroy()
        this.camera_event_control_ = null
        this.AfterCreateAction_ = null
        this.AfterCreateActionInGroup_ = null
    }

    function GetLinkObjHandleArray() {
        local ret_list = []
        local layout_id_list = GetLinkLayoutIdArray()

        if(layout_id_list == false) {
            return ret_list;
        }

        foreach(layout_id in layout_id_list) {
            local handle = FindBgobjHandleByLayoutId(layout_id, this.group_id_)
            if(handle != 0) {
                if(!(handle in ret_list)) {
                    ret_list.append(handle)
                }
            }
        }

        return ret_list;
    }

    function SetGazeCameraForHact(target_hact, cam_ofsY = 0.0, was_watch_flag = 0) {
        this.camera_event_control_.SetGazeCameraForHact(target_hact, cam_ofsY, was_watch_flag)
    }

    function SetGazeCameraForLayoutId(target_layout_id, cam_ofsY = 0.0, was_watch_flag = 0) {
        this.camera_event_control_.SetGazeCameraForLayoutId(target_layout_id, cam_ofsY, was_watch_flag)
    }

    function SetGazeCameraForRouteAtBegin(aPath, cam_ofsY = 0.0, was_watch_flag = 0) {
        this.camera_event_control_.SetGazeCameraForRouteAtBegin(aPath, cam_ofsY, was_watch_flag)
    }

    function SetGazeCameraForRouteAtMiddle(aPath, cam_ofsY, was_watch_flag = 0) {
        this.camera_event_control_.SetGazeCameraForRouteAtBegin(aPath, cam_ofsY, was_watch_flag)
    }

    function SetCameraEventParam(camera_pos_array, target_pos_or_hact = 0, was_watch_flag = 0) {
        this.camera_event_control_.SetParam(camera_pos_array, target_pos_or_hact, was_watch_flag)
    }

    function SetCameraEventFrame(move_frame, return_frame) {
        this.camera_event_control_.SetFrame(move_frame, return_frame)
    }

    function SetCameraEventBank(bank) {
        this.camera_event_control_.SetBank(bank)
    }

    function SetCameraEventViewAngle(view_angle) {
        this.camera_event_control_.SetViewAngle(view_angle)
    }

    function SetCameraEventFade(begin_fade_enable, end_fade_enable = true) {
        this.camera_event_control_.SetFade(begin_fade_enable, end_fade_enable)
    }

    function SetCameraEventFadeOff() {
        this.camera_event_control_.SetFadeOff()
    }

    function SetCameraEventFadeColor(fade_color) {
        this.camera_event_control_.SetFadeColor(fade_color)
    }

    function SetCameraEventFadeColorWhite() {
        this.camera_event_control_.SetFadeColorWhite()
    }

    function SetCameraEventFadeDisplay(fade_display) {
        this.camera_event_control_.SetFadeDisplay(fade_display)
    }

    function SetCameraEventFadeDisplayUpper() {
        this.camera_event_control_.SetFadeDisplayUpper()
    }

    function SetCameraEventFadeDisplayLower() {
        this.camera_event_control_.SetFadeDisplayLower()
    }

    function SetCameraEventFadeLayer(fade_layer) {
        this.camera_event_control_.SetFadeLayer(fade_layer)
    }

    function SetCameraEventFadeLayer3D() {
        this.camera_event_control_.SetFadeLayer3D()
    }

    function SetCameraEventFadeType(fade_type) {
        this.camera_event_control_.SetFadeType(fade_type)
    }

    function SetCameraEventFadeTypeCircle() {
        this.camera_event_control_.SetFadeTypeCircle()
    }

    function SetCameraEventFadeSpeed(begin_fade_speed, end_fade_speed = 0.25) {
        this.camera_event_control_.SetFadeSpeed(begin_fade_speed, end_fade_speed)
    }

    function SetCameraEventFadeSpeedFast() {
        this.camera_event_control_.SetFadeSpeedFast()
    }

    function SetCameraEventFadeSpeedNormal() {
        this.camera_event_control_.SetFadeSpeedNormal()
    }

    function SetCameraEventFadeSpeedSlow() {
        this.camera_event_control_.SetFadeSpeedSlow()
    }

    function DoBeginEventAction() {
        this.camera_event_control_.DoBeginEventAction()
    }

    function DoEndEventAction() {
        this.camera_event_control_.DoEndEventAction()
    }

    function DoMiddleEventAction() {
        this.camera_event_control_.DoMiddleEventAction()
    }

    function SetWasWatch() {
        this.camera_event_control_.SetWasWatch()
    }

    function IsValidOption(cmd_idx) {
        return is_valid_bgobj_option(this.group_id_, this.layout_id_, cmd_idx);
    }

    function GetSwitchMode() {
        return get_bgobj_option_mode(this.group_id_, this.layout_id_);
    }

    function GetBgobjMode() {
        return get_bgobj_option_bgobj_mode(this.group_id_, this.layout_id_);
    }

    function GetIntegerParam(idx) {
        return get_bgobj_option_integer_param(this.group_id_, this.layout_id_, idx);
    }

    function GetIntegerParamArray() {
        return get_bgobj_option_integer_param_array(this.group_id_, this.layout_id_);
    }

    function GetFlag(idx = 0) {
        return get_bgobj_option_flag_var_key(this.group_id_, this.layout_id_, idx);
    }

    function GetChangeActFlag() {
        return get_bgobj_option_change_act_flag_index(this.group_id_, this.layout_id_);
    }

    function GetLockFlag() {
        return get_bgobj_option_lock_flag_index(this.group_id_, this.layout_id_);
    }

    function GetAutoOffInterval() {
        return get_bgobj_option_autooff_interval(this.group_id_, this.layout_id_);
    }

    function GetNotificationInterval() {
        return get_bgobj_option_notification_interval(this.group_id_, this.layout_id_);
    }

    function GetPhantom() {
        return get_bgobj_option_phantom_id(this.group_id_, this.layout_id_);
    }

    function GetReaction() {
        return get_bgobj_option_reaction_id(this.group_id_, this.layout_id_);
    }

    function GetDefaultSwitchState() {
        return get_bgobj_option_state_default(this.group_id_, this.layout_id_);
    }

    function GetLinkLayoutIdArray() {
        return get_bgobj_option_link_layout_id_array(this.group_id_, this.layout_id_);
    }

    function GetRouteId() {
        return get_bgobj_option_route_id(this.group_id_, this.layout_id_);
    }

    function GetDropTableId() {
        return get_bgobj_option_drop_table_id(this.group_id_, this.layout_id_);
    }

    function GetAttackId() {
        return get_bgobj_option_attack_id(this.group_id_, this.layout_id_);
    }

    function GetFloatParam(idx) {
        return get_bgobj_option_float_param(this.group_id_, this.layout_id_, idx);
    }

    function GetFrame() {
        return get_bgobj_option_frame(this.group_id_, this.layout_id_);
    }

    function GetDoorLockType() {
        return get_bgobj_option_door_lock_type(this.group_id_, this.layout_id_);
    }

    function GetPos() {
        return get_bgobj_pos(this.group_id_, this.layout_id_);
    }

    function GetAngle() {
        return get_bgobj_angle(this.group_id_, this.layout_id_);
    }

    function GetRoomId() {
        return get_bgobj_room_id(this.group_id_, this.layout_id_);
    }

    function SetDoorType(door_type) {
        set_bgobj_option_door_type(this.group_id_, this.layout_id_, door_type);
    }

    function SetDoorLockType(door_lock_type) {
        set_bgobj_option_door_lock_type(this.group_id_, this.layout_id_, door_lock_type)
    }

    function SetDoorState(door_state) {
        set_bgobj_option_door_state(this.group_id_, this.layout_id_, door_state)
    }

    function SetSwitchState(sw_state) {
        set_bgobj_option_switch_state(this.group_id_, this.layout_id_, sw_state)
    }

    function SetSwitchMode(sw_mode) {
        set_bgobj_option_switch_mode(this.group_id_, this.layout_id_, sw_mode)
    }

    function SetBgobjMode(bgobj_mode) {
        set_bgobj_option_bgobj_mode(this.group_id_, this.layout_id_, bgobj_mode)
    }

    function SetMotion(motion_array) {
        set_bgobj_option_motion_array(this.group_id_, this.layout_id_, motion_array)
    }

    function SetFrame(frame) {
        set_bgobj_option_frame(this.group_id_, this.layout_id_, frame)
    }

    function SetAutoOffInterval(interval) {
        set_bgobj_option_autooff_interval(this.group_id_, this.layout_id_, interval)
    }

    function SetNotificationInterval(interval) {
        set_bgobj_option_notification_interval(this.group_id_, this.layout_id_, interval)
    }

    function SetOffDrawDisable(flag = true) {
        set_bgobj_option_off_draw_disable(this.group_id_, this.layout_id_, flag)
    }

    function SetAttackId(id) {
        set_bgobj_option_attack_id(this.group_id_, this.layout_id_, id)
    }

    function SetFloatParam(idx, param) {
        set_bgobj_option_float_param(this.group_id_, this.layout_id_, idx, param)
    }

    function SetDropTableId(drop_tbl_id) {
        set_bgobj_option_drop_table_id(this.group_id_, this.layout_id_, drop_tbl_id)
    }

    function SetCreateWithCollision() {
        set_bgobj_data_create_with_collision(this.group_id_, this.layout_id_)
    }

    function SetCreateAsSwitch() {
        set_bgobj_option_create_as_switch(this.group_id_, this.layout_id_)
    }

    function SetCreateAsBreakable() {
        set_bgobj_option_create_as_breakable(this.group_id_, this.layout_id_)
    }

    function SetSwitchCameraShake(data_key) {
        set_bgobj_option_sw_camera_shake(this.group_id_, this.layout_id_, data_key)
    }

    function SetRouteIdToPartyAI() {
        set_route_id_to_party_ai(this.group_id_, this.layout_id_)
    }

    function SendReaction() {
        local reaction = GetReaction()

        if(reaction == 0) return;

        if(reaction == 1) SendDoorOpened()
        else if(reaction == 2) SendDoorOpened2()
        else if(reaction == 3) SendDoorOpened3()
        else if(reaction == 4) SendTreasureAppear()
        else if(reaction == 5) SendEventStart()
        else if(reaction == 6) SendEventStart2()
        else if(reaction == 7) SendEventStart3()
        else if(reaction == 10) SendItemGet()
    }

    function BeginResponseAction(hplayer, eff_id, flag, result, camera_offset_y, target_pos_range = 1.0, is_notify = false, link_action = null) {
        PadOffWait(0)

        if(flag > 0 && test_flag(flag)) {
            PadOnWait(10)
            return false;
        }

        local is_switch = is_switch_actor(this.hself_)
        local old_switch_state = false
        if(is_switch) {
            old_switch_state = get_state_switch_actor(this.hself_)
        }

        set_camera_target(this.hself_, camera_offset_y)
        this.DoBeginEventAction()
        begin_response_action(hplayer, 5, this.hself_, result, target_pos_range, is_notify)

        if(link_action && result == 1) {
            link_action()
        }

        wait_for_true1(is_response_action_finished, hplayer)

        idle_actor(hplayer)

        if(result == 1) {
            if(is_switch) {
                if(old_switch_state) {
                    wait_for_false1(get_state_switch_actor, this.hself_)
                } else {
                    wait_for_true1(get_state_switch_actor, this.hself_)
                }
            }

            if(flag > 0) {
                set_flag(flag)
            }

            this.SendReaction()
        } else {
            this.EventSkillResponderFailure(hplayer, eff_id)
        }

        this.DoEndEventAction()
        this.SetWasWatch()
        reset_camera_target()
        CallAfterPlayerActionEvent(this.hself_, this.layout_id_)

        PadOnWait(0)
        return true;
    }

    function ReactResponderSwitchTypeContinueMain(hplayer, result, eff_id, mot_st, mot_lp, mot_ed, tribe, pos, opt, is_wait_action = true, link_action = null) {
        if(is_wait_action) {
            PadOffWait(0)
            this.DoBeginEventAction()
        }

        local check = request_switch_link_action(hplayer, this.hself_, mot_st, mot_lp, mot_ed, tribe, pos, opt)
        if(!check) {
            PadOffWait(0)
            begin_response_action(hplayer, 5, this.hself_, result)

            wait_for_true1(is_response_action_finished, hplayer)

            this.EventSkillResponderFailure(hplayer, eff_id)

            if(is_wait_action) {
                this.DoEndEventAction()
            }

            PadOnWait(0)

            return false;
        }

        if(link_action) {
            if(result == 1) {
                link_action()
            }
        }

        if(is_wait_action) {
            wait_for_true1(is_response_action_finished, hplayer)

            this.SendReaction()
            this.DoEndEventAction()
            this.SetWasWatch()
            CallAfterPlayerActionEvent(this.hself_, this.layout_id_)

            PadOnWait(0)
        }

        return true;
    }

    function EventSkillResponderFailure(hplayer, eff_id) {
        local heff = create_eff(419, 1, hplayer)

        change_texptn_eff(heff, eff_id)
        disp_hit_request(eff_id)
    }

    function SetSelfFlag(flag_id = 0) {
        local flag = this.GetFlag(flag_id)

        if(flag > 0) {
            set_flag(flag)
        }
    }

    function ResetSelfFlag(flag_id = 0) {
        local flag = this.GetFlag(flag_id)

        if(flag > 0) {
            reset_flag(flag)
        }
    }

    function CreateAndInit() {
        print("WARNING:必要であれば各アクターでSetup()を実装してください bgobj_id = " + this.bgobj_id_)

        this.CreateActor()
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        print("ERROR:BgobjActorBase::onPlayerSkill_begin:" + hplayer +
            "," + htarget +
            "," + result)
        
        return 0;
    }

    function OnSwitchChanged(switch_state) {
        return 0;
    }

    function OnPlayerHatena(hplayer, htarget) {
        print("ERROR:BgobjActorBase::onPlayerHatena_begin:" + hplayer +
            "," + htarget)
        
        return 0;
    }

    function OnActorDeadEvent(hact) {
        print("ERROR:BgobjActorBase::onActorDead [act:" + hact + "]")
    }

    function OnPlayerDoor(hplayer, htarget) {
        print("ERROR:BgobjActorBase::onPlayerDoor:" + hplayer +
            "," + htarget)
    }

    function OnHitWindowMasic(hplayer, htarget) {
        // empty
    }

    function Activate() {
        print("ERROR:BgobjActorBase::Activate:" + this.hself_)
    }

    function Deactivate() {
        print("ERROR:BgobjActorBase::Deactivate:" + this.hself_)
    }
}
