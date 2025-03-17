// TODO match line infos

class DungeonUnitControl {
    units_ = []

    function Init(scene) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!!DungeonUnitControl!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")

        for(local i = 0; i < 4; i++) {
            local unit = get_dungeon_unit_name(i)
            if(unit != null) {
                local unit_obj = this.CreateInstance__(scene, unit)
                this.units_.append(unit_obj)
            }
        }
    }

    function CreateInstance__(scene, name) {
        if(name == "Underpass_01") {
            print("CreateInstance:" + name)
            return Underpass_01(scene);
        } else if(name == "Underpass_02") {
            print("CreateInstance:" + name)
            return Underpass_02(scene);
        } else if(name == "Underpass_03") {
            print("CreateInstance:" + name)
            return Underpass_03(scene);
        } else if(name == "Underpass_04") {
            print("CreateInstance:" + name)
            return Underpass_04(scene);
        } else if(name == "FD_01_00_01") {
            print("CreateInstance:" + name)
            return FD_01_00_01(scene);
        } else if(name == "FD_01_01_01") {
            print("CreateInstance:" + name)
            return FD_01_01_01(scene);
        } else if(name == "FD_01_02_01") {
            print("CreateInstance:" + name)
            return FD_01_02_01(scene);
        } else if(name == "FD_01_03_01") {
            print("CreateInstance:" + name)
            return FD_01_03_01(scene);
        } else if(name == "FixedDungeon02") {
            print("CreateInstance:" + name)
            return FixedDungeon02(scene);
        } else if(name == "FixedDungeon03") {
            print("CreateInstance:" + name)
            return FixedDungeon03(scene);
        } else if(name == "Underpass_05") {
            print("CreateInstance:" + name)
            return Underpass_05(scene);
        } else if(name == "Underpass_06") {
            print("CreateInstance:" + name)
            return Underpass_06(scene);
        } else if(name == "Underpass_07") {
            print("CreateInstance:" + name)
            return Underpass_07(scene);
        } else if(name == "Underpass_08") {
            print("CreateInstance:" + name)
            return Underpass_08(scene);
        } else if(name == "Underpass_09") {
            print("CreateInstance:" + name)
            return Underpass_09(scene);
        } else if(name == "Underpass_10") {
            print("CreateInstance:" + name)
            return Underpass_10(scene);
        } else if(name == "Underpass_11") {
            print("CreateInstance:" + name)
            return Underpass_11(scene);
        } else if(name == "Underpass_12") {
            print("CreateInstance:" + name)
            return Underpass_12(scene);
        } else if(name == "Underpass_13") {
            print("CreateInstance:" + name)
            return Underpass_13(scene);
        } else if(name == "Underpass_14") {
            print("CreateInstance:" + name)
            return Underpass_14(scene);
        } else if(name == "Underpass_15") {
            print("CreateInstance:" + name)
            return Underpass_15(scene);
        } else if(name == "Underpass_16") {
            print("CreateInstance:" + name)
            return Underpass_16(scene);
        } else if(name == "Underpass_17") {
            print("CreateInstance:" + name)
            return Underpass_17(scene);
        } else if(name == "Underpass_18") {
            print("CreateInstance:" + name)
            return Underpass_18(scene);
        } else if(name == "Underpass_19") {
            print("CreateInstance:" + name)
            return Underpass_19(scene);
        } else if(name == "Underpass_20") {
            print("CreateInstance:" + name)
            return Underpass_20(scene);
        } else if(name == "Underpass_30") {
            print("CreateInstance:" + name)
            return Underpass_30(scene);
        } else if(name == "Underpass_31") {
            print("CreateInstance:" + name)
            return Underpass_31(scene);
        } else if(name == "Underpass_32") {
            print("CreateInstance:" + name)
            return Underpass_32(scene);
        } else if(name == "Underpass_33") {
            print("CreateInstance:" + name)
            return Underpass_33(scene);
        } else if(name == "Underpass_34") {
            print("CreateInstance:" + name)
            return Underpass_34(scene);
        } else if(name == "Underpass_35") {
            print("CreateInstance:" + name)
            return Underpass_35(scene);
        } else if(name == "Underpass_36") {
            print("CreateInstance:" + name)
            return Underpass_36(scene);
        } else if(name == "act_test_dungeon") {
            print("CreateInstance:" + name)
            return act_test_dungeon(scene);
        } else if(name == "dg_battle_test01") {
            print("CreateInstance:" + name)
            return dg_battle_test01(scene);
        } else if(name == "dg_battle_test02") {
            print("CreateInstance:" + name)
            return dg_battle_test02(scene);
        } else if(name == "test") {
            print("CreateInstance:" + name)
            return test(scene);
        } else if(name == "HD01_01_00") {
            print("CreateInstance:" + name)
            return HD01_01_00(scene);
        } else if(name == "HD01_01_01") {
            print("CreateInstance:" + name)
            return HD01_01_01(scene);
        } else if(name == "HD01_01_02") {
            print("CreateInstance:" + name)
            return HD01_01_02(scene);
        } else if(name == "HD01_01_03") {
            print("CreateInstance:" + name)
            return HD01_01_03(scene);
        } else if(name == "HD01_02_00") {
            print("CreateInstance:" + name)
            return HD01_02_00(scene);
        } else if(name == "HD01_02_01") {
            print("CreateInstance:" + name)
            return HD01_02_01(scene);
        } else if(name == "HD01_02_02") {
            print("CreateInstance:" + name)
            return HD01_02_02(scene);
        } else if(name == "HD01_02_03") {
            print("CreateInstance:" + name)
            return HD01_02_03(scene);
        } else if(name == "HD02_01_00") {
            print("CreateInstance:" + name)
            return HD02_01_00(scene);
        } else if(name == "HD02_01_01") {
            print("CreateInstance:" + name)
            return HD02_01_01(scene);
        } else if(name == "HD02_01_02") {
            print("CreateInstance:" + name)
            return HD02_01_02(scene);
        } else if(name == "HD02_01_03") {
            print("CreateInstance:" + name)
            return HD02_01_03(scene);
        } else if(name == "HD02_02_00") {
            print("CreateInstance:" + name)
            return HD02_02_00(scene);
        } else if(name == "HD02_02_01") {
            print("CreateInstance:" + name)
            return HD02_02_01(scene);
        } else if(name == "HD02_02_02") {
            print("CreateInstance:" + name)
            return HD02_02_02(scene);
        } else if(name == "HD02_02_03") {
            print("CreateInstance:" + name)
            return HD02_02_03(scene);
        } else if(name == "HD03_01_00") {
            print("CreateInstance:" + name)
            return HD03_01_00(scene);
        } else if(name == "HD03_01_01") {
            print("CreateInstance:" + name)
            return HD03_01_01(scene);
        } else if(name == "HD03_01_02") {
            print("CreateInstance:" + name)
            return HD03_01_02(scene);
        } else if(name == "HD03_01_03") {
            print("CreateInstance:" + name)
            return HD03_01_03(scene);
        } else if(name == "HD03_02_00") {
            print("CreateInstance:" + name)
            return HD03_02_00(scene);
        } else if(name == "HD03_02_01") {
            print("CreateInstance:" + name)
            return HD03_02_01(scene);
        } else if(name == "HD03_02_02") {
            print("CreateInstance:" + name)
            return HD03_02_02(scene);
        } else if(name == "HD03_02_03") {
            print("CreateInstance:" + name)
            return HD03_02_03(scene);
        } else if(name == "act_test_dungeon02") {
            print("CreateInstance:" + name)
            return act_test_dungeon02(scene);
        } else if(name == "FixedDungeon04") {
            print("CreateInstance:" + name)
            return FixedDungeon04(scene);
        } else if(name == "HieroDungeon02") {
            print("CreateInstance:" + name)
            return HieroDungeon02(scene);
        } else if(name == "LastDungeon") {
            print("CreateInstance:" + name)
            return LastDungeon(scene);
        } else if(name == "BattleTestRush01") {
            print("CreateInstance:" + name)
            return BattleTestRush01(scene);
        } else if(name == "BattleTestRush02") {
            print("CreateInstance:" + name)
            return BattleTestRush02(scene);
        } else if(name == "HD01_03_EV") {
            print("CreateInstance:" + name)
            return HD01_03_EV(scene);
        } else if(name == "HD02_03_EV") {
            print("CreateInstance:" + name)
            return HD02_03_EV(scene);
        } else if(name == "HD03_03_EV") {
            print("CreateInstance:" + name)
            return HD03_03_EV(scene);
        } else if(name == "sound_test") {
            print("CreateInstance:" + name)
            return sound_test(scene);
        } else if(name == "FixedDungeon05") {
            print("CreateInstance:" + name)
            return FixedDungeon05(scene);
        }

        print("[DungeonUnitControl:ERROR] " + name + " is Not Define")
        return null;
    }
}
