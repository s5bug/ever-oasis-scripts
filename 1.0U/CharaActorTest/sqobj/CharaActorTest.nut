// TODO match line infos

class CharaActorTest {
    hself = 0
    hquest = 0

    constructor(hact) {
        this.hself = hact
        this.hquest = 0

        print("constructor:CharaActorTest")
    }

    function Initialize() {
        print("initialize:CharaActorTest")
    }

    function Finalize() {
        print("finalize:CharaActorTest")
    }

    function onTalkedEvent(hact) {
        print("CharaActorTest::onTalkedEvent:" + this.hself + "\n")
    }
}
