// TODO match line infos

class Scene extends SceneBase {
    function Initialize() {
        // empty
    }

    function Finalize() {
        // empty
    }

    function OnPostLoad() {
        print("OpeningDemo::OnPostLoad()")

        local demo = OpeningDemo()
        Await(AsyncDemo(demo))
    }
}

class OpeningDemo extends SkipDemoEventBase {
    function Initialize() {
        print("OpeningDemo::Initialize()")
    }

    function Process() {
        print("OpeningDemo::Process()")
    }

    function Finalize() {
        print("OpeningDemo::Finalize()")
    }
}
