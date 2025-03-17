// TODO match line infos

class Scene extends TownSceneBase {
    function Initialize() {
        print("initialize:CharaMaking")
    }

    function Finalize() {
        // empty
    }

    function OnPhantomEnterEvent(lytid, hact) {
        // empty
    }

    function OnPhantomLeaveEvent(lytid, hact) {
        // empty
    }

    function OnActorDeadEvent(hact, group_id, rest_group_member_num) {
        // empty
    }

    function OnPostLoadTown() {
        print("onPostLoadTown")
        
        __StaticInitialize_6ThTest()
    }
}
