// TODO match line infos

class KoujiMan extends ActorBase {
    constructor() {
        ActorBase.constructor()
        this.__InitializeState()
    }

    constructor(hact) {
        ActorBase.constructor(hact)
        this.__InitializeState()
    }

    function OnPlayerTalked(hplayer, htarget) {
        print("KoujiMan::OnPlayerTalked:" + hplayer +
            "," + htarget)
    }

    function __InitializeState() {
        // empty
    }
}
