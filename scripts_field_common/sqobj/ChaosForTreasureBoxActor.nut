// TODO match line infos

class ChaosForTreasureBoxActor extends BgobjActorBase {
    chaos_action_type_ = null
    b_lock = false

    function CreateAndInit() {
        local was_locked_flag = this.GetFlag()
        local was_cleaned_flag = this.GetLockFlag()

        this.CreateActor()

        if(this.hself_ <= 0) return;

        if(was_cleaned_flag > 0 && test_flag(was_cleaned_flag)) {
            start_actor_motion(this.hself_, 96)
            set_actor_collision(this.hself_, false)
            this.chaos_action_type_ = 2
            this.b_lock = false
        } else if(was_locked_flag <= 0 || test_flag(was_locked_flag)) {
            start_actor_motion(this.hself_, 94)
            set_actor_collision(this.hself_, true)
            this.chaos_action_type_ = 0
            this.b_lock = true
        } else {
            start_actor_motion(this.hself_, 96)
            set_actor_collision(this.hself_, false)
            this.chaos_action_type_ = 1
            this.b_lock = false
        }
    }

    function Activate() {
        if(this.IsEventAppear()) {
            if(this.b_lock == false) {
                start_actor_motion(this.hself_, 93)
                set_actor_collision(this.hself_, true)
                this.SetSelfFlag()
                this.b_lock = true
            }
        }
    }

    function IsEventAppear() {
        return this.chaos_action_type_ == 1;
    }

    function IsEventDisappear() {
        local was_cleaned_flag = this.GetLockFlag()

        if(was_cleaned_flag > 0 && test_flag(was_cleaned_flag)) {
            return false;
        }

        return true;
    }

    function Deactivate() {
        if(this.IsEventDisappear() == false) return;
        if(this.b_lock == false) return;

        local was_cleaned_flag = this.GetLockFlag()

        set_flag(was_cleaned_flag)
        this.ResetSelfFlag()
        start_actor_motion(this.hself_, 95)
        set_actor_collision(this.hself_, false)
        this.b_lock = false

        return true;
    }
}
