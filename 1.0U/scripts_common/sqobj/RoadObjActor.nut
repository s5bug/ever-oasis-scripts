// TODO match line infos

class RoadObjActor extends ActorBase {
    constructor() {
        local bgobj_id = this.__GetBgobjId()

        if(bgobj_id != -1) {
            load_actor_archive_sync(6, bgobj_id)
            this.hself = create_temp_actor(bgobj_id, 0.0, 0.0, 0.0, 0.0)
        }
    }

    function __GetBgobjId() {
        switch(get_zone_id()) {
            case 0:
            case 64:
                return 4351 + get_var(125);
            case 1:
            case 65:
                return 4371 + get_var(126);
        }

        return -1;
    }
}
