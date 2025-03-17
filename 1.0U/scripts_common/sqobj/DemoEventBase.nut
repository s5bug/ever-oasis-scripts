// TODO match line infos

class DemoEventSetBase {
    function StartDemo(demo_id, args) {
        return true;
    }

    function StartInnerDemo(demo_id, args) {
        return true;
    }

    function IsEnabled(demo_id) {
        return true;
    }
}

class SkipDemoEventBase {
    function Initialize() {

    }

    function Process() {

    }

    function Finalize() {

    }

    function AfterSkipFunc() {

    }

    function IsEnableSkip() {
        return false;
    }

    function IsSkipFadeWhite() {
        return false;
    }
}
