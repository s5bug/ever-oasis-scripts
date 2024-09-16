// TODO match line infos

class Scarab extends ActorBase {
    hquest = 0

    function OnPlayerTalked(hplayer, htarget) {
        print("OnTalkedEvent:Scarab")

        PadOffWait(0)
        PadOnWait(0)
    }
}
