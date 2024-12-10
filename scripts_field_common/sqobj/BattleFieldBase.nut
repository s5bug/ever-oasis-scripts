// TODO match line infos

class BattleFieldBase extends SceneBase {
    period_index_ = 0

    constructor() {
        SceneBase.constructor()
    }

    function CreateBgobjActorByGroupID(area_id, group_id) {
        this.bgobj_creator_.CreateBgobjActorByGroupID(area_id, group_id)
    }

    function RegisterEnemyAndBgobj(res_name) {
        print("[!][!][!]<<< Search : Archive >>>[!][!][!]")

        local archive = find_archive(0, res_name)

        print("[!][!][!]<<< SET : EnemyArchive >>>[!][!][!]")

        register_enemygroup(archive, res_name)
        create_enemy_archive_group(archive, res_name)
        this.__LoadEnemyResourceArchive()

        print("[!][!][!]<<< SET : OBJArchive >>>[!][!][!]")

        register_bgobjgroup(archive, res_name)
        register_quest_target_npc(archive, res_name)

        print("[!][!][!]<<< Wait : Archive Load >>>[!][!][!]")

        func_wait(is_archive_loaded)

        begin_field_enemy_pop_manager()
    }

    function __LoadEnemyResourceArchive() {
        load_archive_group_member(0)
    }


    function OnPlayerTalked(hplayer, htarget) {
        print("BattleFieldBase::onPlayerTalked:" + hplayer + "," + htarget)

        foreach(actor in this.chara_list_) {
            if(actor.hself == htarget) {
                set_actor_bit(hplayer, 14)
                set_actor_bit(htarget, 14)
                actor.OnPlayerTalked(hplayer, htarget)
                reset_actor_bit(hplayer, 14)
                reset_actor_bit(htarget, 14)
                return;
            }
        }
    }

    function InitializeNpcResources() {
        print("BattleFieldBase::InitializeNpcResources")
    }

    function OnPlayerShopping(hplayer, htarget) {
        print("BattleFieldBase::onPlayerShopping:" + hplayer + "," + htarget)
    }

    function OnPlayerCarry(hplayer, htarget) {
        print("BattleFieldBase::onPlayerCarry:" + hplayer + "," + htarget)
    }

    function OnPlayerDoor(hplayer, htarget) {
        print("BattleFieldBase::onPlayerDoor:" + hplayer + "," + htarget)
    }

    function OnDateTimePeriod(period_index) {
        print("BattleFieldBase::OnDateTimePeriod:" + period_index)
        onDateTimePeriodCommon(period_index)
    }

    function OnBattleEvent(begin) {
        if(begin == 1) {
            if(check_mission_completed(9)) {
                // empty
            }
        }
    }

    function LifeZeroEventFirstChecker(hact, member_num, group_id) {
        print("BattleFieldBace::LifeZeroEventFirstChecker [act:" + hact + "]")

        if(!test_flag(1972) && check_mission_completed(9)) {
            GazeCameraForHact(hact, false, 30, 0.0)
            ForceStartOptionalQuestEvent_SetEventMode(2, false)
            set_flag(1972)
        }
    }

    function AfterPlayerActionEvent(switch_id, layout_id) {
        // empty
    }

    function OnActorDeadEvent(hact, group_id, rest_group_member_num) {
        print("onActorDead:BattleFieldBase [act:" + hact +
            " group_id:" + group_id +
            " rest_group_member_num:" + rest_group_member_num + "]")
        
        SceneBase.OnActorDeadEvent(hact, group_id, rest_group_member_num)
    }
}
