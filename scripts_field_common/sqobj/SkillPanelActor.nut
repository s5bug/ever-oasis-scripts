// TODO match line infos

class SkillPanelActor extends BgobjActorBase {
    skill_action_ = null
    skill_type_ = 0
    __next_area_id = 0
    __door_id = -1
    __next_area_seed_hole_id = -1
    __chain_switch = null
    __que_function = null
    __next_room_que_function = null
    __is_change_room = false
    __is_toggle_link_switch = true
    __begin_act_frame = 0.0

    function CreateAndInit() {
        if(this.bgobj_id_ == 4104) {
            this.skill_type_ = 1
            this.skill_action_ = this.__ActionSeedBall
            this.__chain_switch = {}
            this.__next_area_seed_hole_id = -1

            local arg_array = this.GetIntegerParamArray()

            for(local i = 0; i < arg_array.len(); i += 2) {
                if(arg_array[i] > 0 && arg_array[i + 1] > 0) {
                    this.__chain_switch[arg_array[i]] <- arg_array[i + 1]
                }
            }
        } else if(this.bgobj_id_ == 4154) {
            this.skill_type_ = 2
            this.skill_action_ = this.__ActionParaFlower
            this.__chain_switch = {}
            
            local arg_array = this.GetIntegerParamArray()
            for(local i = 0; i < arg_array.len(); i += 2) {
                if(arg_array[i] > 0 && arg_array[i + 1] > 0) {
                    this.__chain_switch[arg_array[i]] <- arg_array[i + 1]
                }
            }
        } else if(this.bgobj_id_ == 4155) {
            this.skill_type_ = 3
            this.skill_action_ = this.__ActionLeafWall
        }

        local panel_type = this.GetBgobjMode()
        local flag = this.GetFlag()

        local is_enable = false
        if(flag <= 0 || test_flag(flag)) {
            is_enable = true
        }

        this.CreateActor()
        if(this.hself_ <= 0) return;

        register_player_responder(this.hself_, 5, [12.0, 0.0, 0.0], [this.skill_type_])

        if(is_enable) {
            start_actor_motion(this.hself_, 168)
        } else if(panel_type == 1) {
            start_actor_motion(this.hself_, 168)
            set_enable_bgobj_responder(this.hself_, false)
        } else {
            start_actor_motion(this.hself_, 166)
            set_enable_bgobj_responder(this.hself_, false)
        }

        return true;
    }

    function Activate() {
        this.__AppearEvent()
        set_enable_bgobj_responder(this.hself_, true)
    }

    function __AppearEvent() {
        PadOffWait(0)

        set_camera_target(this.hself_, -20.0)
        start_actor_motion(this.hself_, 167)
        
        wait(30)

        reset_camera_target()

        wait(10)

        PadOnWait(0)
    }

    function Deactivate() {
        start_actor_motion(this.hself_, 166)
        set_enable_bgobj_responder(this.hself_, false)
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        this.__is_change_room = false

        if(this.skill_type_ != 0) {
            if(!this.__SeedSkillChecker(hplayer)) {
                this.__SkillFaliure(hplayer)
                this.__FirstAccessNotify(21)
                return;
            }
        }

        if(this.skill_action_) {
            this.__FirstAccessNotify(0)
            this.skill_action_(hplayer)
        } else {
            print("ERROR:SkillPanelActor OnPlayerSkill Not has action.")
        }

        SendSkillPanelEnd()
    }

    function __FirstAccessNotify(wait_frame) {
        // empty
    }

    function OnTouched(hplayer) {
        print("SkillPanelActor OnTouched")

        if(this.skill_type_ == 1) {
            if(test_flag(1015)) {
                print("シードボールのチュートを発生")
                ForceStartOptionalQuestEvent(57)
            }
        } else if(this.skill_type_ == 2) {
            if(test_flag(1017)) {
                print("パラフラワーのチュートを発生")
                ForceStartOptionalQuestEvent(59)
            }
        } else if(this.skill_type_ == 3) {
            if(test_flag(1016)) {
                print("リーフウォールのチュートを発生")
                ForceStartOptionalQuestEvent(24)
            }
        }
    }

    function SetQueFunction(que_func) {
        this.__que_function = que_func
    }

    function SetQueFunctionAfterRoomChange(que_func) {
        this.__next_room_que_function = que_func
    }

    function SetRoomChangeParam(next_area_id, door_direction) {
        this.__is_change_room = true
        this.__next_area_id = next_area_id
        this.__door_id = door_direction
    }

    function SetNextAreaSeedHoleLayoutID(seed_hole_id) {
        this.__next_area_seed_hole_id = seed_hole_id
    }

    function SetToggleLinkSwitchFlag(flag) {
        this.__is_toggle_link_switch = flag
    }

    function SetBeginActionEventFrame(frame) {
        this.__begin_act_frame = frame
    }

    function __ActionParaFlower(hplayer) {
        this.__ParaFlowerSimple(hplayer)
    }

    function __ActionSeedBall(hplayer) {
        this.__SeedBallBefore(hplayer, 0, [])

        if(this.__is_change_room) {
            fadeout_sync(0, 0, 0.25)
            if(this.__door_id > -1) {
                DestroyEnemyGroupBeingOutsideTheAreaForce(this.__next_area_id)
                this.__CallSeedBallMove(hplayer, this.__door_id)
            }
            this.__SeedBallAfter(hplayer, this.__next_area_id, [])
        } else {
            reset_camera_target()
            PadOnWait(0)
        }
    }

    function __ActionLeafWall(hplayer) {
        local leaf_wall = FindBgobjActorByActType(1, this.group_id_)

        if(leaf_wall && !get_enable_bgobj_responder(leaf_wall.hself_)) {
            return;
        }

        set_enable_bgobj_responder(this.hself_, false)
        start_actor_motion(this.hself_, 169)
        request_switch_link_action(hplayer, leaf_wall.hself_, 1754, 1764, 1755, [], [0.0, 0.0, 0.0], [5])
    }

    function __SeedBallBefore(hact, move_type, aPathIn) {
        PadOffWait(0)

        local aPanel_pos = this.GetPos()
        local panel_angle = this.GetAngle()

        local seed_hole = FindBgobjActorByActType(38, this.group_id_)
        local seed_ball = FindBgobjActorByActType(1, this.group_id_)

        if(seed_ball == 0) {
            print("ERROR:Could'nt found Seed Ball")
            PadOnWait(0)
            return;
        }

        if(seed_hole != 0) {
            set_camera_target(seed_hole.hself_, -20.0)
        } else {
            set_camera_target(this.hself_, -20.0)
        }

        set_actor_position(hact, aPanel_pos[0], aPanel_pos[1], aPanel_pos[2], 0)
        set_actor_angleY(hact, panel_angle)
        start_actor_motion(this.hself_, 169)
        start_actor_motion(hact, 1754)

        wait_for_true1(is_motion_finished, hact)

        set_actor_visible(hact, false)
        start_actor_motion(hact, 0)
        start_actor_motion(this.hself_, 171)

        local wait_frame = 0

        this.__is_toggle_link_switch = true

        begin_bgobj_route_que(seed_ball.hself_)
        if(this.__que_function) {
            wait_frame = this.__que_function(this, seed_ball.hself_)
        }
        end_bgobj_route_que(seed_ball.hself_)

        request_switch_link_action(hact, seed_ball.hself_, 1754, 1764, 1755, [], [], [])
        reset_camera_target()

        if(this.__is_toggle_link_switch) {
            this.__ToggleLinkSwitch()
        }

        wait(wait_frame)
    }

    function __SeedBallAfter(hact, next_area, aPathOut) {
        local seed_hole = 0

        if(this.__next_area_seed_hole_id < 0) {
            seed_hole = FindBgobjActorByActType(38)
        } else {
            seed_hole = FindBgobjActorByLayoutId(this.__next_area_seed_hole_id)
        }

        local seed_ball = FindBgobjActorByActType(1)
        local target_scene = GetTargetScene()

        if(seed_hole == 0) {
            print("ERROR:Could'nt found Seed Hole")
            PadOnWait(0)
            return;
        }
        if(seed_ball == 0) {
            print("ERROR:Could'nt found Seed Ball")
            PadOnWait(0)
            return;
        }

        local aHole_pos = seed_hole.GetPos()
        local angle = seed_hole.GetAngle()
        local ofsX = 0.0
        local ofsZ = 0.0

        if(angle <= -180.0) {
            ofsZ = -20.0
        } else if(angle <= -90.0) {
            ofsX = -20.0
        } else if(angle <= 0.0) {
            ofsZ = 20.0
        } else if(angle <= 90.0) {
            ofsX = 20.0
        } else {
            ofsZ = -20.0
        }

        set_actor_position_with_hitbgobj(hact, aHole_pos[0] + ofsX, aHole_pos[1], aHole_pos[2] + ofsZ, 0)
        
        if(GetAreaId() != next_area) {
            PopProcessMain(next_area, -1)
        }

        set_camera_target(seed_hole.hself_, 10.0)

        wait(15)

        fadein(0, 0, 0.25)

        local wait_frame = 0

        begin_bgobj_route_que(seed_ball.hself_)
        if(this.__next_room_que_function) {
            wait_frame = this.__next_room_que_function(seed_ball.hself_,
                [aHole_pos[0] + ofsX, aHole_pos[1], aHole_pos[2] + ofsZ, angle]
            )
        }
        end_bgobj_route_que(seed_ball.hself_)

        const neg1 = -1
        request_switch_link_action(hact, seed_ball.hself_, neg1, 1764, 1755, [], [], [])

        wait(wait_frame)

        const neg7 = -7
        wait(neg7)

        reset_camera_target()

        local end_pos = get_actor_position(hact)
        local end_angle_y = get_actor_angle_y(hact)

        update_player_home_pos_angle_y(end_pos[0], end_pos[1], end_pos[2], end_angle_y)

        CallAfterPlayerActionEvent(this.hself_, this.layout_id_)

        PadOnWait(0)
    }

    function __ParaFlowerSimple(hact) {
        PadOffWait(0)
        
        local aPanel_pos = this.GetPos()
        local panel_angle = this.GetAngle()
        local para_flower_obj = FindBgobjActorByActType(1, this.group_id_)

        if(para_flower_obj == 0) {
            print("ERROR:Could'nt found ParaFlower")
            PadOnWait(0)
            return;
        }

        this.DoBeginEventAction()

        set_actor_position(hact, aPanel_pos[0], aPanel_pos[1], aPanel_pos[2], 0)
        set_actor_angleY(hact, panel_angle)
        start_actor_motion(this.hself_, 169)
        start_actor_motion(hact, 1754)

        wait_for_true1(is_motion_finished, hact)

        set_actor_visible(hact, false)
        start_actor_motion(hact, 0)
        start_actor_motion(this.hself_, 171)

        local wait_frame = 0

        this.__begin_act_frame = 0.0

        begin_bgobj_route_que(para_flower_obj.hself_)
        if(this.__que_function) {
            wait_frame = this.__que_function(this, para_flower_obj.hself_)
        }
        end_bgobj_route_que(para_flower_obj.hself_)

        request_switch_link_action(hact, para_flower_obj.hself_, 1754, 1764, 1755, [], [], [])

        if(this.__is_toggle_link_switch) {
            this.__ToggleLinkSwitch()
        }

        if(this.__begin_act_frame > 0.0) {
            wait(this.__begin_act_frame)
        }

        this.DoMiddleEventAction()

        if(wait_frame - this.__begin_act_frame > 0.0) {
            wait(wait_frame - this.__begin_act_frame)
        }

        wait_for_true2(is_action_finished, hact, 93)
        wait(1)

        this.DoEndEventAction()
        this.SetWasWatch()
        CallAfterPlayerActionEvent(this.hself_, this.layout_id_)

        PadOnWait(0)
    }

    function __ToggleLinkSwitch() {
        if(this.__chain_switch == null) return;

        foreach(key, value in this.__chain_switch) {
            local hact = FindBgobjHandleByLayoutId(key)
            local is_notify = value > 3 ? true : false
            local link_type = value % 3

            if(hact) {
                if(link_type == 1) {
                    change_state_switch_actor(hact, 1, is_notify)
                } else if(link_type == 2) {
                    change_state_switch_actor(hact, 0, is_notify)
                } else if(link_type == 3) {
                    change_state_switch_actor(hact, 2, is_notify)
                }
            }
        }
    }

    function __SkillFaliure(hplayer) {
        local eff_id = 0

        if(this.skill_type_ == 1) {
            eff_id = 0
        } else if(this.skill_type_ == 2) {
            eff_id = 1
        } else if(this.skill_type_ == 3) {
            eff_id = 8
        }

        this.__SkillFailed(hplayer, eff_id)
    }

    function __SkillFailed(hplayer, eff_id) {
        start_skill_failed_action(hplayer, eff_id)
    }

    function __SeedSkillChecker(hact) {
        local tribeType = get_charadb(hact, 54)
        local current_skill = -1

        if(this.skill_type_ == 1) {
            current_skill = 1
        } else if(this.skill_type_ == 2) {
            current_skill = 2
        } else if(this.skill_type_ == 3) {
            current_skill = 3
        }

        if(tribeType == 0) {
            if(this.skill_type_ == 5 || is_have_skill(hact, current_skill)) {
                return true;
            }
        }

        return false;
    }

    function __CallSeedBallMove(hplayer, door_direction) {
        local target_scene = GetTargetScene()

        target_scene.ChengeRoomEventDuringFade(GetAreaId(), door_direction)

        local oldRoomPhantomId = GetCurrentDoorData(door_direction)
        local next_area_id = MoveToNextAreaId(door_direction)

        ChangeRoomForDungeonMain(next_area_id, oldRoomPhantomId, 0)
    }
}
