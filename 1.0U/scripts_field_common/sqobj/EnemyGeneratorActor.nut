// TODO match line infos

class EnemyGeneratorActor extends BgobjActorBase {
    function OnActorDeadEvent(hact) {
        NextPopGroupCheckerFromEnemyGeneratorCallLifeZero(hact)
    }
}
