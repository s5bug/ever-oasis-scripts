// TODO match line infos

class CameraEventControl {
    bgobj_actor_ = null
    begin_event_action_ = null
    end_event_action_ = null
    was_watch_flag_ = 0
    event_target_pos_ = null
    event_camera_pos_ = null
    gaze_target_hact_ = 0
    gaze_target_offset_y_ = 0.0
    middle_event_action_ = null
    gaze_middle_target_hact_ = null
    gaze_middle_target_offset_y_ = 0.0
    camera_move_frame_ = 0
    camera_return_frame_ = 0
    camera_bank_ = 0.0
    camera_view_angle_ = 50.0
    camera_fade_enable_ = null
    camera_fade_color_ = 0
    camera_fade_display_ = 0
    camera_fade_speed_ = null
    camera_fade_layer_ = 0
    camera_fade_type_ = 0
    quake_enable_ = false
    quake_power_ = 1

    constructor(bgobj_actor) {
        this.bgobj_actor_ = bgobj_actor
        this.camera_fade_enable_ = [true, true]
        this.camera_fade_speed_ = [0.25, 0.25]
    }

    function Destroy() {
        this.bgobj_actor_ = null
        this.begin_event_action_ = null
        this.end_event_action_ = null
        this.was_watch_flag_ = 0
        this.event_target_pos_ = null
        this.event_camera_pos_ = null
        this.gaze_target_hact_ = 0
        this.gaze_target_offset_y_ = 0.0
        this.middle_event_action_ = null
        this.gaze_middle_target_hact_ = null
        this.gaze_middle_target_offset_y_ = 0.0
        this.camera_move_frame_ = 0
        this.camera_return_frame_ = 0
        this.camera_bank_ = 0.0
        this.camera_view_angle_ = 50.0
        this.camera_fade_enable_ = null
        this.camera_fade_color_ = 0
        this.camera_fade_display_ = 0
        this.camera_fade_speed_ = null
        this.camera_fade_layer_ = 0
        this.camera_fade_type_ = 0
        this.quake_enable_ = false
        this.quake_power_ = 1
    }

    function SetGazeCameraForHact(target_hact, cam_ofsY = 0.0, was_watch_flag = 0) {
        if(target_hact == 0) {
            print("ERROR:SetGazeCameraForHact target_hact is invaild")
            return;
        }

        if(exists_actor(target_hact)) {
            this.gaze_target_hact_ = target_hact
        } else {
            print("ERROR:SetGazeCameraForHact target_hact is not exists actor")
            return;
        }

        this.gaze_target_offset_y_ = cam_ofsY
        this.begin_event_action_ = this.__BeginGazeCameraEvent
        this.end_event_action_ = this.__EndGazeCameraEvent
        this.was_watch_flag_ = was_watch_flag
    }

    function SetGazeCameraForLayoutId(target_layout_id, cam_ofsY = 0.0, was_watch_flag = 0) {
        if(target_layout_id == 0) { 
            print("ERROR:SetGazeCameraForLayoutId target_layout_id is invaild")
            return;
        }

        local target_handle = FindBgobjHandleByLayoutId(target_layout_id)
        if(target_handle) {
            this.SetGazeCameraForHact(target_handle, cam_ofsY, was_watch_flag)
        } else {
            print("ERROR:SetGazeCameraForLayoutId target_layout_id does not found")
            return;
        }
    }

    function SetGazeCameraForRouteAtBegin(aPath, cam_ofsY = 0.0, was_watch_flag = 0) {
        if(this.bgobj_actor_ == null) {
            print("ERROR:SetGazeCameraForRouteAtBegin を使用するにはbgobj_actorをセットしている必要があります")
        }

        if(this.__CheckEnablePath(aPath) == false) {
            return;
        }

        local end_pos = get_route_end_pos(aPath[0], aPath[1])
        if(end_pos == false) {
            print("ERROR:SetGazeCameraForRoute couldn\'t get pos")
            return;
        }

        this.gaze_target_hact_ = create_temp_actor_in_bgobj_group(
            this.bgobj_actor_.group_id_,
            4059,
            end_pos[0],
            end_pos[1],
            end_pos[2],
            0.0
        )
        this.gaze_target_offset_y_ = cam_ofsY

        if(this.gaze_target_hact_ > 0) {
            set_actor_visible(this.gaze_target_hact_, false)
        }

        this.begin_event_action_ = this.__BeginGazeCameraEvent
        this.end_event_action_ = this.__EndGazeCameraEvent
        this.was_watch_flag_ = was_watch_flag
    }

    function SetGazeCameraForRouteAtMiddle(aPath, cam_ofsY, was_watch_flag = 0) {
        if(this.bgobj_actor_ == null) {
            print("ERROR:SetGazeCameraForRouteAtBegin を使用するにはbgobj_actorをセットしている必要があります")
        }

        if(this.__CheckEnablePath(aPath) == false) {
            return;
        }

        local end_pos = get_route_end_pos(aPath[0], aPath[1])
        if(end_pos == false) {
            print("ERROR:SetGazeCameraForRoute couldn\'t get pos")
            return;
        }

        this.gaze_middle_target_hact_ = create_temp_actor_in_bgobj_group(
            this.bgobj_actor_.group_id_,
            4059,
            end_pos[0],
            end_pos[1],
            end_pos[2],
            0.0
        )

        this.gaze_middle_target_offset_y_ = cam_ofsY
        this.middle_event_action_ = this.__MiddleGazeCameraEvent
        this.end_event_action_ = this.__EndGazeCameraEvent
        this.was_watch_flag_ = was_watch_flag
    }

    function __CheckEnablePath(aPath) {
        local is_enable = true

        if(type(aPath) != "array") {
            print("ERROR:CameraEventControl SetParam path type error.")
            is_enable = false
        } else if(aPath.len() != 2) {
            print("ERROR:CameraEventControl SetParam path would has 2 members.")
            is_enable = false
        }

        if(!is_enable) {
            print("ERROR:CameraEventControl SetParam argment error.")
        }

        return is_enable;
    }

    function SetParam(camera_pos_array, target_pos_or_hact = 0, was_watch_flag = 0) {
        const arg1_error = "ERROR:SetParam 1st Argument would set camera xyz array."
        const arg2_error = "ERROR:SetParam 2nd Argument would set target xyz array or target actor handle."

        if(type(camera_pos_array) == "array") {
            if(camera_pos_array.len() != 3) {
                print(arg1_error)
                return;
            }

            this.event_camera_pos_ = camera_pos_array
        } else {
            print(arg1_error)
            return;
        }

        if(type(target_pos_or_hact) == "array") {
            if(target_pos_or_hact.len() != 3) {
                print(arg2_error)
                return;
            }

            this.event_target_pos_ = target_pos_or_hact
        } else if(type(target_pos_or_hact) == "integer") {
            if(target_pos_or_hact != 0) {
                this.event_target_pos_ = get_actor_position(target_pos_or_hact)
            } else if(this.bgobj_actor_ != null) {
                this.event_target_pos_ = get_actor_position(this.bgobj_actor_.hself_)
            } else {
                print(arg2_error)
                return;
            }
        } else {
            print(arg2_error)
            return;
        }

        this.was_watch_flag_ = was_watch_flag
        if(this.was_watch_flag_ == 0 || test_flag(this.was_watch_flag_) == false) {
            this.begin_event_action_ = this.__BeginCameraEvent
            this.end_event_action_ = this.__EndCameraEvent
        }
    }

    function SetFrame(move_frame, return_frame) {
        this.camera_move_frame_ = move_frame
        this.camera_return_frame_ = return_frame
    }

    function SetBank(bank) {
        if(type(bank) != "float") {
            print("ERROR:SetBank 第１引数にはバンクの実数値（ex:0.0)を渡してください.")
            return;
        }

        this.camera_bank_ = bank
    }

    function SetViewAngle(view_angle) {
        // this function will ALWAYS fail because type(bank) will be "null"
        // don't know how this made it through like this
        if(type(bank) != "float") {
            print("ERROR:SetBank 第１引数には画角の実数値（ex:50.0)を渡してください.")
            return;
        }

        this.camera_view_angle_ = view_angle
    }

    function SetFade(begin_fade_enable, end_fade_enable = true) {
        this.camera_fade_enable_[0] = begin_fade_enable
        this.camera_fade_enable_[1] = end_fade_enable
    }

    function SetFadeOff() {
        this.camera_fade_enable_[0] = false
        this.camera_fade_enable_[1] = false
    }

    function SetFadeColor(fade_color) {
        if(fade_color == 0 || fade_color == 1) {
            this.camera_fade_color_ = fade_color
        } else {
            print("ERROR:SetFadeColor fade color colud set FADE_COLOR.BLACK or FADE_COLOR.WHITE")
        }
    }

    function SetFadeColorWhite() {
        this.camera_fade_color_ = 1
    }

    function SetFadeDisplay(fade_display) {
        if(fade_display == 0 || fade_display == 1 || fade_display == 2) {
            this.camera_fade_display_ = fade_display
        } else {
            print("ERROR:SetFadeDisplay fade display colud set FADE_DISPLAY.BOTH / .UPPER / .LOWER")
        }
    }

    function SetFadeDisplayUpper() {
        this.camera_fade_display_ = 1
    }

    function SetFadeDisplayLower() {
        this.camera_fade_display_ = 2
    }

    function SetFadeLayer(fade_layer) {
        if(fade_layer == 0 || fade_layer == 1) {
            this.camera_fade_layer_ = fade_layer
        } else {
            print("ERROR:SetFadeLayer fade layer colud set FADE_LAYER.LAYER_0 or FADE_LAYER.LAYER_3D")
        }
    }

    function SetFadeLayer3D() {
        this.camera_fade_layer_ = 1
    }

    function SetFadeType(fade_type) {
        if(fade_type == 0 || fade_type == 1) {
            this.camera_fade_type_ = fade_type
        } else {
            print("ERROR:SetFadeType fade type colud set FADE_TYPE.NORMAL or FADE_TYPE.CIRCLE")
        }
    }

    function SetFadeTypeCircle() {
        this.camera_fade_type_ = 1
    }

    function SetFadeSpeed(begin_fade_speed, end_fade_speed = 0.25) {
        if(this.__CheckEnableFadeSpeed(begin_fade_speed)) {
            this.camera_fade_speed_[0] = begin_fade_speed
        }
        if(this.__CheckEnableFadeSpeed(end_fade_speed)) {
            this.camera_fade_speed_[1] = end_fade_speed
        }
    }

    function SetFadeSpeedFast() {
        this.camera_fade_speed_[0] = 0.5
        this.camera_fade_speed_[1] = 0.5
    }

    function SetFadeSpeedNormal() {
        this.camera_fade_speed_[0] = 1.0
        this.camera_fade_speed_[1] = 1.0
    }

    function SetFadeSpeedSlow() {
        this.camera_fade_speed_[0] = 2.0
        this.camera_fade_speed_[1] = 2.0
    }

    function __CheckEnableFadeSpeed(fade_speed) {
        if(0.25 == fade_speed || 0.5 == fade_speed || 1.0 == fade_speed || 2.0 == fade_speed) {
            return true;
        }

        return type(fade_speed) == "float";
    }

    function SetQuakeOn() {
        this.quake_enable_ = true
    }

    function SetQuakeOff() {
        this.quake_enable_ = false
    }

    function SetQuakePower(quakePower) {
        if(0 <= quakePower && quakePower < 3) {
            this.quake_power_ = quakePower
        } else {
            print("ERROR:SetQuakePower 0-2までで指定してください")
        }
    }

    function DoBeginEventAction() {
        if(this.begin_event_action_) {
            this.begin_event_action_()
        }
    }

    function Begin(camPos = null, tgtPos_or_hact = null) {
        if(camPos != null) {
            this.SetParam(camPos, tgtPos_or_hact)
        }
        if(this.begin_event_action_) {
            this.begin_event_action_()
        }
    }

    function DoEndEventAction() {
        if(this.end_event_action_) {
            this.end_event_action_()
        }
    }

    function End() {
        if(this.end_event_action_) {
            this.end_event_action_()
        }
    }

    function DoMiddleEventAction() {
        if(this.middle_event_action_) {
            this.middle_event_action_()
        }
    }

    function SetWasWatch() {
        if(this.was_watch_flag_ > 0) {
            set_flag(this.was_watch_flag_)
            this.begin_event_action_ = null
            this.end_event_action_ = null
        }
    }

    function __BeginCameraEvent() {
        if(this.was_watch_flag_ > 0 && test_flag(this.was_watch_flag_)) return;

        this.InitPetit()
        set_petit_dst_param(
            this.event_camera_pos_[0], this.event_camera_pos_[1], this.event_camera_pos_[2],
            this.event_target_pos_[0], this.event_target_pos_[1], this.event_target_pos_[2],
            this.camera_bank_, this.camera_view_angle_
        )

        if(this.camera_fade_enable_[0]) {
            this.FadeOut(0)
        }

        begin_petit(this.camera_move_frame_)

        if(this.quake_enable_) {
            stop_camera_shake()
            QuakeStart(this.quake_power_)
        }

        const neg8 = -8
        wait(neg8)

        if(this.quake_enable_) {
            stop_camera_shake()
        }

        if(this.camera_fade_enable_[0]) {
            this.FadeIn(0)
        }
    }

    function __EndCameraEvent() {
        if(this.was_watch_flag_ > 0 && test_flag(this.was_watch_flag_)) return;

        if(this.camera_fade_enable_[1]) {
            this.FadeOut(1)
        }

        set_petit_slide_dst_to_src()

        local reset_param = get_reset_param_of_behind_camera()

        set_petit_dst_param(reset_param)
        begin_petit(this.camera_return_frame_)

        const neg8 = -8
        wait(neg8)

        this.EndPetit()

        if(this.camera_fade_enable_[1]) {
            this.FadeIn(1)
        }
    }

    function __BeginGazeCameraEvent() {
        if(this.was_watch_flag_ > 0 && test_flag(this.was_watch_flag_)) return;

        set_camera_target(this.gaze_target_hact_, this.gaze_target_offset_y_)
    }

    function __EndGazeCameraEvent() {
        if(this.was_watch_flag_ > 0 && test_flag(this.was_watch_flag_)) return;

        reset_camera_target()
    }

    function __MiddleGazeCameraEvent() {
        if(this.was_watch_flag_ > 0 && test_flag(this.was_watch_flag_)) return;

        set_camera_target(this.gaze_middle_target_hact_, this.gaze_middle_target_offset_y_)
    }

    function FadeOut(mode) {
        fadeout_sync(
            this.camera_fade_color_,
            this.camera_fade_display_,
            this.camera_fade_speed_[mode],
            this.camera_fade_layer_,
            this.camera_fade_type_
        )
    }

    function FadeIn(mode) {
        fadein_sync(
            this.camera_fade_color_,
            this.camera_fade_display_,
            this.camera_fade_speed_[mode],
            this.camera_fade_layer_,
            this.camera_fade_type_
        )
    }

    function InitPetit() {
        if(get_camera_type() != 10) {
            init_petit()
        } else {
            end_petit()
            init_petit()
        }
    }

    function EndPetit() {
        if(get_camera_type() == 10) {
            end_petit()
        }
    }
}
