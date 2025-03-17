// TODO match line infos

class CocoonActor extends BgobjActorBase {
    skill_action_ = null

    function CreateAndInit() {
        this.SetSwitchState(false)
        this.SetSwitchMode(3)
        this.SetFrame(0.0)
        this.skill_action_ = this.__OnPlayerSkillAction

        this.CreateActor()
    }

    function OnPlayerSkill(hplayer, htarget, result) {
        if(this.skill_action_) {
            this.skill_action_(hplayer, result)
        }
    }

    function OnActorDeadEvent(hact) {
        NextPopGroupCheckerFromEnemyGenerator(hact)
    }

    function __OnPlayerSkillAction(hplayer, result) {
        this.BeginResponseAction(hplayer, 7, 0, result, -5.0, 6.0)
    }
}
