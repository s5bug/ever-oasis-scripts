// TODO match line infos

class CactusBallActor extends RoomObjActor {
    function CallQueFunction(que_func) {
        if(que_func) {
            begin_bgobj_route_que(this.hself_)
            
            que_func(this.hself_)

            end_bgobj_route_que(this.hself_)
            change_state_switch_actor(this.hself_, true, true)
        }
    }
}
