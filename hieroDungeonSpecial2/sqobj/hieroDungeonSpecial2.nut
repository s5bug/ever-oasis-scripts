// TODO match line infos

class Scene extends DungeonSceneBase {
    function InitializeDungeonCore() {
        initialize_hieroglyph(12)
        InitializeHieroDungeon(this, 2627, 2627)
    }

    function Finalize() {
        finalize_hieroglyph()
    }

    function InitializeEnemyGroup() {
        this.__RegisterEnemyAndBgobj()
        create_enemy_archive_group_for_hieroglyph()
        this.__LoadEnemyResourceArchive()

        for(local i = 0; i < 4; i++) {
            local unit = get_dungeon_unit_name(i)
            if(unit != null) {
                this.dunits_ctrl.units_[i].InitializeEnemyResources()
                if(this.dunits_ctrl.units_[i].IsRegisterBossSymbol()) {
                    register_boss_symbol()
                }
            }
        }
    }
}
