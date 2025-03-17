// TODO match line infos

class BgobjActorCreator {
    bgobj_table_ = null
    static __BgobjSetupTable = {
        [4000] = [BreakableActor, 42, 4],
        [4002] = [ChaosGrassActor, 67, 0],
        [4003] = [ChaosGrassActor, 67, 0],
        [4004] = [ChaosGrassActor, 67, 0],
        [4005] = [BreakableActor, 42, 4],
        [4006] = [BreakableActor, 42, 4],
        [4007] = [BreakableActor, 42, 4],
        [4034] = [TreasureBoxActor, 16, 1 | 2],
        [4048] = [RoomObjActor, 1, 2],
        [4063] = [SwitchMonitorActor, 0, 2],
        [4073] = [HieroAtlarActor, 51, 0],
        [4076] = [SpearSwitchActor, 37, 2],
        [4077] = [ChaosForTreasureBoxActor, 53, 1],
        [4078] = [RoomObjActor, 38, 1],
        [4080] = [TreasureBoxActor, 16, 1 | 2],
        [4081] = [TreasureBoxActor, 16, 1 | 2],
        [4082] = [SignPanelActor, 39, 0],
        [4083] = [WarpGateActor, 25, 1],
        [4084] = [LightSwitchActor, 40, 2],
        [4085] = [DoorActor, 502, 1 | 2],
        [4086] = [DoorActor, 509, 1 | 2],
        [4087] = [DoorActor, 510, 1 | 2],
        [4092] = [HammerSwitchActor, 6, 2],
        [4094] = [BreakableActor, 42, 4],
        [4098] = [SwitchObjActor, 28, 2],
        [4100] = [SwitchObjActor, 29, 2],
        [4101] = [ImpactSwitchActor, 1010, 2],
        [4102] = [ResponderSwitchActor, 1016, 2],
        [4103] = [WeightSwitchActor, 10, 2],
        [4104] = [SkillPanelActor, 45, 1],
        [4107] = [RoomObjActor, 1, 0],
        [4110] = [CreateWhenFlagOffActor, 1, 0],
        [4111] = [RoomObjActor, 1, 0],
        [4115] = [BreakableActor, 42, 4],
        [4116] = [BreakableActor, 42, 4],
        [4117] = [BreakableActor, 42, 4],
        [4124] = [PieceOfPotActor, 62, 2],
        [4125] = [PieceOfPotActor, 62, 2],
        [4126] = [PropellerCactus, 58, 0],
        [4127] = [ChaosFenceActor, 60, 2],
        [4128] = [HookObjActor, 59, 2],
        [4129] = [SwitchObjActor, 56, 2],
        [4131] = [SwitchObjActor, 63, 2],
        [4132] = [PropellerSwitchActor, 61, 2],
        [4135] = [BreakableActor, 42, 4],
        [4114] = [BreakableActor, 42, 4],
        [4136] = [SwitchObjActor, 64, 2],
        [4137] = [SandpileActor, 13, 2],
        [4138] = [SwitchObjActor, 64, 2],
        [4141] = [TreasureBoxActor, 16, 1 | 2],
        [4142] = [SandpileActor, 13, 0],
        [4143] = [SandpileActor, 13, 0],
        [4144] = [RoomObjActor, 0, 2],
        [4145] = [RoomObjActor, 0, 0],
        [4146] = [BreakableWallActor, 43, 2],
        [4147] = [SwitchObjActor, 0, 2],
        [4148] = [HammerStakeActor, 0, 2],
        [4149] = [HammerStakeActor, 0, 2],
        [4150] = [RoomObjActor, 1, 2],
        [4151] = [ChaosOrbActor, 0, 2],
        [4152] = [FixedArtilleryActor, 0, 2],
        [4580] = [FixedArtilleryActor, 0, 2],
        [4154] = [SkillPanelActor, 45, 1],
        [4155] = [SkillPanelActor, 45, 1],
        [4156] = [LeafWallActor, 1, 2],
        [4157] = [RoomObjActor, 0, 0],
        [4264] = [RoomObjActor, 0, 0],
        [4158] = [CactusBallActor, 0, 2],
        [4160] = [CocoonActor, 0, 2],
        [4161] = [SpiderWebActor, 0, 2],
        [4163] = [RoomObjActor, 0, 0],
        [4166] = [DSwordSwitchActor, 37, 2],
        [4173] = [EventResponderActor, 54, 0],
        [4174] = [BossDoorResponderActor, 47, 0],
        [4175] = [DoorActor, 500, 1 | 2],
        [4176] = [DoorActor, 508, 1 | 2],
        [4177] = [DoorActor, 519, 1 | 2],
        [4178] = [BreakableActor, 42, 0],
        [4179] = [BreakableActor, 42, 0],
        [4180] = [LightSwitchActor, 40, 2],
        [4183] = [SwitchObjActor, 0, 2],
        [4184] = [SwitchObjActor, 0, 2],
        [4185] = [SwitchObjActor, 0, 2],
        [4186] = [SwitchObjActor, 0, 2],
        [4187] = [SwitchObjActor, 0, 2],
        [4188] = [DieObjActor, 0, 0],
        [4495] = [DieObjActor, 0, 0],
        [4194] = [CreateWhenFlagOnActor, 0, 0],
        [4199] = [RoomObjActor, 0, 0],
        [4200] = [InvisibleWallActor, 0, 0],
        [4201] = [BreakableActor, 42, 4],
        [4202] = [PortalActor, 0, 0],
        [4206] = [CollectingObjActor, 41, 0],
        [4207] = [DoorActor, 0, 1 | 2],
        [4208] = [HieroSymbolSwitchActor, 0, 0],
        [4209] = [DoorActor, 0, 1 | 2],
        [4211] = [DoorActor, 0, 1 | 2],
        [4212] = [PropellerSwitchActor, 61, 2],
        [4213] = [SpearSwitchActor, 37, 2],
        [4214] = [PropellerCactus, 58, 0],
        [4215] = [GenericFenceActor, 0, 2],
        [4216] = [CollectingObjActor, 41, 0],
        [4218] = [CollectingObjActor, 41, 0],
        [4219] = [ResponderSwitchActor, 0, 2],
        [4228] = [DoorActor, 500, 1 | 2],
        [4229] = [DoorActor, 508, 1 | 2],
        [4230] = [DoorOnceActor, 0, 2],
        [4231] = [DoorActor, 500, 1 | 2],
        [4232] = [DoorActor, 502, 1 | 2],
        [4233] = [DoorActor, 509, 1 | 2],
        [4234] = [DoorOnceActor, 0, 2],
        [4235] = [DoorActor, 510, 1 | 2],
        [4236] = [DoorActor, 508, 1 | 2],
        [4237] = [DoorActor, 502, 1 | 2],
        [4238] = [DoorActor, 509, 1 | 2],
        [4239] = [DoorOnceActor, 0, 2],
        [4240] = [DoorActor, 510, 1 | 2],
        [4241] = [DoorOnceActor, 0, 2],
        [4242] = [PieceOfPotActor, 62, 2],
        [4243] = [SwitchMonitorActor, 0, 2],
        [4248] = [LeverSwitchActor, 0, 2],
        [4251] = [DoorActor, 500, 1 | 2],
        [4252] = [DoorActor, 508, 1 | 2],
        [4474] = [DoorActor, 500, 1 | 2],
        [4475] = [DoorActor, 500, 1 | 2],
        [4476] = [DoorActor, 500, 1 | 2],
        [4477] = [DoorActor, 508, 1 | 2],
        [4478] = [DoorActor, 508, 1 | 2],
        [4479] = [DoorActor, 508, 1 | 2],
        [4480] = [DoorActor, 508, 1 | 2],
        [4253] = [DoorActor, 0, 1 | 2],
        [4254] = [DoorActor, 0, 1 | 2],
        [4255] = [DoorOnceActor, 0, 2],
        [4256] = [DoorActor, 0, 1 | 2],
        [4260] = [ChaosGrassActor, 0, 2],
        [4265] = [BreakableActor, 42, 4],
        [4266] = [DoorOnceActor, 0, 2],
        [4268] = [PropellerSwitchActor, 61, 2],
        [4277] = [HieroglyphStone, 0, 0],
        [4278] = [RoomObjActor, 0, 0],
        [4279] = [DoorOnceActor, 0, 2],
        [4280] = [RespawnObjActor, 0, 0],
        [4299] = [DoorWadjetActor, 0, 1 | 2],
        [4338] = [FieldsCactusActor, 0, 0],
        [4641] = [FieldsCactusActor, 0, 0],
        [4300] = [RoomObjActor, 0, 0],
        [4301] = [RoomObjActor, 0, 0],
        [4302] = [RoomObjActor, 0, 0],
        [4303] = [RoomObjActor, 0, 0],
        [4304] = [RoomObjActor, 0, 0],
        [4305] = [RoomObjActor, 0, 0],
        [4306] = [RoomObjActor, 0, 0],
        [4307] = [RoomObjActor, 0, 0],
        [4309] = [RoomObjActor, 0, 0],
        [4310] = [RoomObjActor, 0, 0],
        [4311] = [RoomObjActor, 0, 0],
        [4319] = [RoomObjActor, 1, 0],
        [4324] = [TreasureBoxActor, 16, 1 | 2],
        [4331] = [RoomObjActor, 0, 0],
        [4332] = [RoomObjActor, 0, 0],
        [4333] = [RoomObjActor, 0, 0],
        [4334] = [RoomObjActor, 0, 0],
        [4335] = [RoomObjActor, 0, 0],
        [4336] = [RoomObjActor, 0, 0],
        [4337] = [RoomObjActor, 0, 0],
        [4339] = [RoomObjActor, 1, 0],
        [4457] = [DoorActor, 500, 1 | 2],
        [4458] = [DoorActor, 500, 1 | 2],
        [4460] = [RoomObjActor, 0, 0],
        [4497] = [RoomObjActor, 0, 0],
        [4244] = [SwitchObjActor, 0, 2],
        [4245] = [SimpleSwitchActor, 0, 2],
        [4249] = [SimpleSwitchActor, 0, 2],
        [4250] = [SimpleSwitchActor, 0, 2],
        [4281] = [HieroAltarOfLightActor, 0, 0],
        [4261] = [EnemyGeneratorActor, 0, 0],
        [4262] = [EnemyGeneratorActor, 0, 0],
        [4263] = [EnemyGeneratorActor, 0, 0],
        [4283] = [GenericFenceActor, 0, 2],
        [4298] = [RoomObjActor, 0, 2],
        [4455] = [BgobjActorBase, 0, 0],
        [4486] = [SwitchObjActor, 0, 2],
        [4488] = [DoorActor, 502, 1 | 2],
        [4489] = [DoorActor, 509, 1 | 2],
        [4487] = [TotemBatteryActor, 0, 2],
        [4491] = [DoorActor, 500, 1 | 2],
        [4565] = [ShinySandActor, 0, 2],
        [4568] = [SwitchObjActor, 56, 2],
        [4577] = [SimpleSwitchActor, 0, 2],
        [4571] = [DoorActor, 509, 1 | 2],
        [4578] = [DoorActor, 500, 1 | 2],
        [4579] = [DoorActor, 502, 1 | 2],
        [4581] = [RoomObjActor, 0, 0],
        [4582] = [RoomObjActor, 0, 0],
        [4583] = [RoomObjActor, 0, 0],
        [4584] = [RoomObjActor, 0, 0],
        [4585] = [RoomObjActor, 0, 0],
        [4586] = [RoomObjActor, 0, 0],
        [4587] = [RoomObjActor, 0, 0],
        [4588] = [RoomObjActor, 0, 0],
        [4589] = [RoomObjActor, 0, 0],
        [4590] = [BreakableActor, 0, 4],
        [4591] = [BreakableActor, 0, 4],
        [4592] = [BreakableActor, 0, 4],
        [4593] = [BreakableActor, 0, 4],
        [4594] = [BreakableActor, 0, 4],
        [4595] = [BreakableActor, 0, 4],
        [4596] = [BreakableActor, 0, 4],
        [4597] = [BreakableActor, 0, 4],
        [4598] = [BreakableActor, 0, 4],
        [4599] = [BreakableActor, 0, 4],
        [4492] = [RespawnObjActor, 0, 0],
        [4614] = [HieroRecoveryObjectActor, 0, 0],
        [4615] = [HieroPortalActor, 0, 0],
        [4298] = [PropellerSwitchActor, 61, 2],
        [4620] = [PropellerSwitchActor, 61, 2],
        [4569] = [GenericFenceActor, 0, 2],
        [4624] = [DoorActor, 0, 1 | 2],
        [4632] = [FlagActor, 0, 0],
        [4633] = [RoomObjActor, 0, 0],
        [4628] = [SandpileActor, 13, 0],
        [4629] = [SandpileActor, 13, 0],
        [4630] = [SandpileActor, 13, 0],
        [4631] = [SandpileActor, 13, 0],
        [4636] = [GenericFenceActor, 0, 2],
        [4637] = [WadjetSteleActor, 0, 2],
        [4638] = [HieroAtlarActor, 51, 0],
        [4646] = [DoorOnceActor, 0, 2],
        [4647] = [DoorOnceActor, 0, 2],
        [4648] = [DoorOnceActor, 0, 2],
        [4642] = [DoorActor, 508, 1 | 2],
        [4643] = [DoorActor, 502, 1 | 2],
        [4645] = [DoorActor, 508, 1 | 2],
        [4663] = [ResponderSwitchActor, 0, 2],
        [4665] = [BreakableActor, 42, 4],
        [4666] = [BreakableActor, 42, 0],
        [4667] = [BreakableActor, 42, 0]
    }

    constructor(bgobj_table) {
        this.bgobj_table_ = bgobj_table
    }

    function CreateDoorActorByAreaID(area_id) {
        if(__GetStateOfUiInitialize() != 0) return false;

        local bgobj_group_ids = get_bgobj_group_ids_by_area_id(area_id)
        foreach(group_id in bgobj_group_ids) {
            local bgobjCreateIdList = get_door_obj_ids(group_id)
            if(bgobjCreateIdList) {
                check_bgobj_respawn(group_id)
                this.__CreateBgobjByCreateList(area_id, group_id, bgobjCreateIdList)
                this.__InitializeAfterCreateInGroup(area_id, group_id)
            }
        }

        return true;
    }

    function CreateBgobjActorByAreaID(area_id) {
        if(__GetStateOfUiInitialize() != 0) return false;

        local bgobj_group_ids = get_bgobj_group_ids_by_area_id(area_id)
        foreach(group_id in bgobj_group_ids) {
            local bgobjCreateIdList = get_bgobj_ids_without_door(group_id)
            if(bgobjCreateIdList) {
                check_bgobj_respawn(group_id)
                this.__CreateBgobjByCreateList(area_id, group_id, bgobjCreateIdList)
                this.__InitializeAfterCreateInGroup(area_id, group_id)
            }
        }

        return true;
    }

    function CreateBgobjActorByGroupID(area_id, group_id) {
        if(__GetStateOfUiInitialize() != 0) return false;
        if(is_exsists_bgobj(group_id) == false) return false;

        check_bgobj_respawn(group_id)

        local bgobjCreateIdList = get_bgobj_ids(group_id)
        this.__CreateBgobjByCreateList(area_id, group_id, bgobjCreateIdList)
        this.__InitializeAfterCreateInGroup(area_id, group_id)

        return true;
    }

    function __CreateBgobjByCreateList(area_id, group_id, bgobjCreateIdList) {
        if(!(area_id in this.bgobj_table_)) {
            this.bgobj_table_[area_id] <- {}
            this.bgobj_table_[area_id][group_id] <- {}
        } else if(!(group_id in this.bgobj_table_[area_id])) {
            this.bgobj_table_[area_id][group_id] <- {}
        }

        this.bgobj_table_[area_id][group_id].clear()

        for(local i = 0; i < bgobjCreateIdList.len(); i += 2) {
            local actor = this.__CreateBgobj_sub(group_id, bgobjCreateIdList[i], bgobjCreateIdList[i + 1])
            this.bgobj_table_[area_id][group_id][bgobjCreateIdList[i + 1]] <- actor
        }
    }

    function __InitializeAfterCreateInGroup(area_id, group_id) {
        if(this.bgobj_table_.len() > 0) {
            foreach(actor in this.bgobj_table_[area_id][group_id]) {
                if(actor && actor.hself_) {
                    if(actor.AfterCreateActionInGroup_) {
                        actor.AfterCreateActionInGroup_()
                    }
                }
            }
        }
    }

    function InitializeAfterCreate(area_id) {
        if(this.bgobj_table_.len() > 0) {
            foreach(group_table in this.bgobj_table_[area_id]) {
                foreach(actor in group_table) {
                    if(actor && actor.hself_) {
                        if(actor.AfterCreateAction_) {
                            actor.AfterCreateAction_()
                        }
                    }
                }
            }
        }
    }

    function DestroyAllBgobjActorsInArea(area_id) {
        if(area_id in this.bgobj_table_) {
            local room_id = get_room_id_by_area_id(area_id)
            local unit_id = get_dungeon_unit_index_by_room(room_id)

            foreach(key, value in this.bgobj_table_[area_id]) {
                destroy_bgobj_by_group_id(key, unit_id)
                foreach(actor in this.bgobj_table_[area_id][key]) {
                    actor.DestroyActor()
                }
                this.bgobj_table_[area_id][key].clear()
            }

            return true;
        }

        return false;
    }

    function __CreateBgobj_sub(group_id, bgobj_id, layout_id) {
        if(bgobj_id in this.__BgobjSetupTable) {
            local actor = this.__BgobjSetupTable[bgobj_id][0](
                group_id, bgobj_id, layout_id,
                this.__BgobjSetupTable[bgobj_id][1],
                this.__BgobjSetupTable[bgobj_id][2]
            )
            actor.CreateAndInit()
            return actor;
        } else {
            local actor = RoomObjActor(group_id, bgobj_id, layout_id, 0, 0)
            actor.CreateAndInit()
            return actor;
        }
    }

    function SetRouteIdToPartyAI_InArea(area_id) {
        local primary_route_id = 0
        local primary_obj = 0

        if(this.bgobj_table_.len() > 0) {
            foreach(group_table in this.bgobj_table_[area_id]) {
                foreach(bgobj in group_table) {
                    if(bgobj == 0) continue;

                    local tmp_route_id = bgobj.GetRouteId()
                    if(tmp_route_id < primary_route_id) continue;

                    if(bgobj.hself_ == 0) {
                        primary_route_id = tmp_route_id
                        primary_obj = bgobj
                    } else if(
                        bgobj.bgobj_id_ in __BgobjSetupTable &&
                        (__BgobjSetupTable[bgobj.bgobj_id_][2] & 2)
                    ) {
                        if(bgobj.hself_ && get_state_switch_actor(bgobj.hself_)) {
                            primary_route_id = tmp_route_id
                            primary_obj = bgobj
                        }
                    }
                }
            }
        }

        if(primary_obj != 0) {
            primary_obj.SetRouteIdToPartyAI()
        }
    }
}

class BgobjActorManager {
    bgobj_table_ = null

    constructor(bgobj_table) {
        this.bgobj_table_ = bgobj_table
    }
    
    function IsExistsBgobjActorByActType(act_type) {
        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_group in group_table) {
                foreach(bgobj in bgobj_group) {
                    if(bgobj.act_type_ == act_type) return true;
                }
            }
        }

        return false;
    }

    function FindBgobjActorByActType(act_type) {
        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_group in group_table) {
                foreach(bgobj in bgobj_group) {
                    if(bgobj.act_type_ == act_type) return bgobj;
                }
            }
        }

        return 0;
    }

    function FindBgobjActorByActTypeWithGroupId(act_type, group_id) {
        foreach(group_table in this.bgobj_table_) {
            if(group_id in group_table) {
                foreach(bgobj in group_table[group_id]) {
                    if(bgobj.act_type_ == act_type) return bgobj;
                }
            }
        }

        return 0;
    }

    function FindBgobjActorByActTypeInArea(act_type, area_id) {
        if(area_id in this.bgobj_table_) {
            foreach(bgobj_group in this.bgobj_table_[area_id]) {
                foreach(bgobj in bgobj_group) {
                    if(bgobj.act_type_ == act_type) return bgobj;
                }
            }
        }

        return 0;
    }

    function FindAllBgobjActorByActType(act_type) {
        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_list in group_table) {
                foreach(bgobj in bgobj_list) {
                    if(bgobj.act_type_ == act_type) yield bgobj;
                }
            }
        }

        return 0;
    }

    function FindAllBgobjActorByActTypeWithGroupId(act_type, group_id) {
        foreach(group_table in this.bgobj_table_) {
            if(group_id in group_table) {
                foreach(bgobj in group_table[group_id]) {
                    if(bgobj.act_type_ == act_type) yield bgobj;
                }
            }
        }

        return 0;
    }

    function FindAllBgobjActorByActTypeInArea(act_type, area_id) {
        if(area_id in this.bgobj_table_) {
            foreach(bgobj_group in this.bgobj_table_[area_id]) {
                foreach(bgobj in bgobj_group) {
                    if(bgobj.act_type_ == act_type) yield bgobj;
                }
            }
        }

        return 0;
    }

    function FindBgobjActorByHandle(hactor) {
        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_list in group_table) {
                foreach(bgobj in bgobj_list) {
                    if(bgobj.hself_ == hactor) return bgobj;
                }
            }
        }

        return 0;
    }

    function FindBgobjActorByHandleWithGroupId(hactor, group_id) {
        foreach(group_table in this.bgobj_table_) {
            if(group_id in group_table) {
                foreach(bgobj in group_table[group_id]) {
                    if(bgobj.hself_ == hactor) return bgobj;
                }
            }
        }

        return 0;
    }

    function FindBgobjActorByLayoutId(layout_id) {
        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_group_table in group_table) {
                if(layout_id in bgobj_group_table) return bgobj_group_table[layout_id];
            }
        }

        return 0;
    }

    function FindBgobjActorByLayoutIdWithGroupId(layout_id, group_id) {
        foreach(group_table in this.bgobj_table_) {
            if(group_id in group_table) {
                if(layout_id in group_table[group_id]) {
                    return group_table[group_id][layout_id];
                }
            }
        }

        return 0;
    }

    function FindBgobjActorByBgobjId(bgobj_id) {
        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_group in group_table) {
                foreach(bgobj in bgobj_group) {
                    if(bgobj.bgobj_id_ == bgobj_id) return bgobj;
                }
            }
        }

        return 0;
    }

    function FindAllBgobjActorByBgobjId(bgobj_id) {
        foreach(group_table in this.bgobj_table_) {
            foreach(bgobj_list in group_table) {
                foreach(bgobj in bgobj_list) {
                    if(bgobj.bgobj_id_ == bgobj_id) yield bgobj;
                }
            }
        }

        return 0;
    }
}
