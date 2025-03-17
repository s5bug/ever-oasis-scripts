// TODO match line infos

function SetEncOnTalkedCallback(hact, callback) {
    local actor = get_actor_script(hact)

    actor.on_talked_callback_ = callback
}

function ResetEncOnTalkedCallback(hact) {
    local actor = get_actor_script(hact)

    actor.__SetOnTalkedDefault()
}

function SetEncJoinParam(hact, first_demo_id, repeat_msg_id, unready_msg_id, approve_msg_id, reject_msg_id) {
    local actor = get_actor_script(hact)

    actor.first_demo_id_ = first_demo_id
    actor.repeat_msg_id_ = repeat_msg_id
    actor.unready_msg_id_ = unready_msg_id
    actor.approve_msg_id_ = approve_msg_id
    actor.reject_msg_id_ = reject_msg_id
}

function SetEncJoinPartyTalkWith(hact, chara_id) {
    local actor = get_actor_script(hact)

    actor.party_talk_with_chara_id_ = chara_id
}

function SetEncJoinGuestTalkWith(hact, chara_id) {
    local actor = get_actor_script(hact)

    actor.guest_talk_with_chara_id_ = chara_id
}

function SetEncOnJoinedCallback(hact, callback) {
    local actor = get_actor_script(hact)

    actor.on_joined_callback_ = callback
}

class EncounterNpc extends GenericNpc {
    encounter_db_key_ = -1
    on_talked_callback_ = null
    first_demo_id_ = 0
    repeat_msg_id_ = 0
    unready_msg_id_ = 0
    approve_msg_id_ = 0
    reject_msg_id_ = 0
    on_joined_callback_ = null
    party_talk_with_chara_id_ = -1
    guest_talk_with_chara_id_ = -1
    h_talk_guest_ = 0

    constructor(hact) {
        print("EncounterNpc.constructor()")

        this.hself = hact
        this.encounter_db_key_ = get_encounter_key(hact)
        this.on_joined_callback_ = this.__OnJoinedDefault
        this.__SetOnTalkedDefault()
    }

    function OnPlayerTalked(hplayer, htarget) {
        print("EncounterNpc.OnPlayerTalked()")

        this.hplayer_ = get_party_index(0)
        this.key_ = get_charaid(this.hself)

        EventStart(0)
        this.on_talked_callback_(this.hplayer_, htarget)
        EventEnd()
    }

    function __TalkEvent_TempParty(hplayer, htarget) {
        print("EncounterNpc.__TalkEvent_TempParty()")

        GenericNpc.__StartFieldTalkAction(this.hplayer_, this.hself)

        local first_talk = get_actor_visitor_status(this.hself, 0)

        set_actor_visitor_status(this.hself, 1)
        set_actor_visitor_status(this.hself, 0)
        this.__StartTalkDemo_Enc()

        if(first_talk) {
            DemoEventSet().StartInnerDemo(this.first_demo_id_, [
                this.h_talk_player_,
                this.h_talk_target_,
                this.h_talk_guest_
            ])
        } else {
            this.__MsgSyncArray(this.repeat_msg_id_)
        }

        if(get_encounter_need_skill(this.encounter_db_key_) != 255) {
            local have_skill = false
            for(local i = 0; i < 3; ++i) {
                local h_party = get_party_index(i)
                if(h_party == 0) {
                    // empty
                } else {
                    have_skill = have_skill || is_have_skill(h_party, get_encounter_need_skill(this.encounter_db_key_))
                }
            }

            if(!have_skill) {
                this.__MsgSyncArray(this.unready_msg_id_)
                this.__EndTalkDemo_Enc()
                GenericNpc.__EndFieldTalkAction(this.hplayer_, this.hself)
                return;
            }
        }

        local ui_arg = [
            this.key_,
            is_encounter_name_hide(this.encounter_db_key_),
            get_encounter_need_skill(this.encounter_db_key_),
            false
        ]
        local ui_ret = ui_sync(71, ui_arg)

        if(ui_ret[0] == 1) {
            set_actor_facial(this.h_talk_target_, 3)
            this.__MsgSyncArray(this.reject_msg_id_)
            reset_actor_facial(this.h_talk_target_)
            this.__EndTalkDemo_Enc()
            GenericNpc.__EndFieldTalkAction(this.hplayer_, this.hself)
            return;
        }

        const neg1 = -1
        if(ui_ret[1] != neg1) {
            local h_main_player = get_party_index(0)
            local h_ctrl_player = get_player()
            local h_rmov_member = get_hactor_by_chara_id(ui_ret[1])

            set_operation_player(0)

            wait(1)

            local ctrl_pos = get_actor_position(h_ctrl_player)
            local ctrl_ang = get_actor_angle_y(h_ctrl_player)

            set_actor_position_angle_y(h_main_player, ctrl_pos[0], ctrl_pos[1], ctrl_pos[2], ctrl_ang)
            remove_party_by_chara_id(ui_ret[1])
            destroy_actor(h_rmov_member)

            wait(1)
        }

        set_actor_facial(this.h_talk_target_, 1)
        this.__MsgSyncArray(this.approve_msg_id_)
        play_se(0x100009C)
        msg_argv_sync_talk_event(513, 0, 0, [this.key_])
        reset_actor_facial(this.h_talk_target_)
        finish_encounter_name_hide(this.encounter_db_key_)
        this.__EndTalkDemo_JoinParty()
        this.on_joined_callback_()
        GenericNpc.__EndFieldTalkAction(this.hplayer_, this.hself)
    }

    function __StartTalkDemo_Enc() {
        initialize_talk_event(true)

        local player_dbkey = get_dbkey_by_charaId(0)
        local target_dbkey = get_dbkey_by_charaId(this.key_)

        if(this.__ExistPartyTalkWith()) {
            local party_dbkey = get_dbkey_by_charaId(this.party_talk_with_chara_id_)

            this.h_talk_player_ = create_talk_event_actor_index(player_dbkey, 1, 1, 0.0)
            this.h_talk_target_ = create_talk_event_actor_index(target_dbkey, 1, 4, 0.0)
            this.h_talk_guest_ = create_talk_event_actor_index(party_dbkey, 1, 5, 0.0)

            set_talk_event_actor_angle_index(this.h_talk_player_, 1)
            set_talk_event_actor_angle_index(this.h_talk_target_, 0)
            set_talk_event_actor_angle_index(this.h_talk_guest_, 1)
        } else if(this.guest_talk_with_chara_id_ != -1) {
            local guest_dbkey = get_dbkey_by_charaId(this.guest_talk_with_chara_id_)

            this.h_talk_player_ = create_talk_event_actor_index(player_dbkey, 1, 1, 0.0)
            this.h_talk_target_ = create_talk_event_actor_index(target_dbkey, 1, 4, 0.0)
            this.h_talk_guest_ = create_talk_event_actor_index(guest_dbkey, 1, 5, 0.0)

            set_talk_event_actor_angle_index(this.h_talk_player_, 1)
            set_talk_event_actor_angle_index(this.h_talk_target_, 0)
            set_talk_event_actor_angle_index(this.h_talk_guest_, 1)
        } else {
            this.h_talk_player_ = create_talk_event_actor_index(player_dbkey, 1, 3, 0.0)
            this.h_talk_target_ = create_talk_event_actor_index(target_dbkey, 1, 4, 0.0)

            set_talk_event_actor_angle_index(this.h_talk_player_, 1)
            set_talk_event_actor_angle_index(this.h_talk_target_, 0)
        }

        this.h_talk_left_ = this.h_talk_player_
        this.h_talk_right_ = this.h_talk_target_
        this.is_talk_demo_ = true
    }

    function __EndTalkDemo_Enc() {
        destroy_actor(this.h_talk_player_)
        destroy_actor(this.h_talk_target_)
        destroy_actor(this.h_talk_guest_)

        this.h_talk_guest_ = 0

        finalize_talk_event()

        this.h_talk_left_ = 0
        this.h_talk_right_ = 0
        this.h_talk_player_ = 0
        this.h_talk_target_ = 0
        this.is_talk_demo_ = false
    }

    function __EndTalkDemo_JoinParty() {
        destroy_actor(this.h_talk_player_)
        destroy_actor(this.h_talk_target_)
        destroy_actor(this.h_talk_guest_)

        this.h_talk_guest_ = 0

        wait(1)

        encounter_npc_join_party(this.encounter_db_key_)

        wait(1)

        finalize_talk_event()

        this.h_talk_left_ = 0
        this.h_talk_right_ = 0
        this.h_talk_player_ = 0
        this.h_talk_target_ = 0
        this.is_talk_demo_ = false
    }

    function __MsgSyncArray(msg_array) {
        if(typeof(msg_array) != "array") {
            msg_sync_talk_event(msg_array, this.h_talk_target_)
            return;
        }

        local is_msg_with_name = true
        for(local i = 0; i < msg_array.len(); ++i) {
            if(typeof(msg_array[i]) == "array") {
                is_msg_with_name = false
                break;
            }
        }

        if(is_msg_with_name) {
            msg_sync_talk_event(msg_array[0], [this.h_talk_target_, msg_array[1]])
            return;
        }

        for(local i = 0; i < msg_array.len(); ++i) {
            if(msg_array[i].len() == 1) {
                msg_sync_talk_event(msg_array[i][0], this.h_talk_target_)
            } else {
                msg_sync_talk_event(msg_array[i][0], [this.h_talk_target_, msg_array[i][1]])
            }
        }
    }

    function __ExistPartyTalkWith() {
        if(this.party_talk_with_chara_id_ == -1) {
            return false;
        }

        return get_party_chara_id(1) == this.party_talk_with_chara_id_ ||
            get_party_chara_id(2) == this.party_talk_with_chara_id_;
    }

    function __SetOnTalkedDefault() {
        if(encounter_use_temp_party(this.encounter_db_key_)) {
            this.on_talked_callback_ = this.__TalkEvent_TempParty
        } else {
            this.on_talked_callback_ = this.__OnTalkedDefault
        }
    }

    function __OnTalkedDefault(hplayer, htarget) {
        GenericNpc.OnPlayerTalked(hplayer, htarget)
    }

    function __OnJoinedDefault() {
        // empty
    }
}
