// TODO match line infos

class SaveProfile {
    function ForceSave(start_scene) {
        disable_homebutton()
        start_save_dialog(4443, false)

        func_wait(is_active_save_dialog)

        save_profile(true, 0, 0, start_scene)

        wait(60)
        func_wait(sync_profile)

        close_save_dialog()
        
        func_wait(is_end_save_dialog)

        enable_homebutton()

        if(get_save_result() == true) {
            play_se(0x10000AA)
            ui_sync(72, [4444, false])
        } else {
            ui_sync(72, [4059, false])
        }

        return true;
    }

    function Save() {
        if(get_save_mode() == 1) {
            return this.__SaveForProd();
        } else {
            return this.__SaveForDev();
        }
    }

    function __SaveForProd() {
        local dlog_res = ui_sync(60, [4124, 1])

        if(dlog_res[0] == 1) {
            disable_homebutton()
            start_save_dialog(4443)

            func_wait(is_active_save_dialog)

            save_profile(true, 0, 0)

            wait(60)
            func_wait(sync_profile)

            close_save_dialog()
        
            func_wait(is_end_save_dialog)

            enable_homebutton()

            if(get_save_result() == true) {
                play_se(0x10000AA)
                ui_sync(72, [4444])
            } else {
                ui_sync(72, [4059])
            }

            return true;
        }

        return false;
    }

    function __SaveForDev() {
        local dlog_res = ui_sync(60, [65004, 1])

        if(dlog_res[0] == 1) {
            local overwrite = false

            if(is_save_profie_empty() == false) {
                local dlog_res2 = ui_sync(60, [65005, 1])
                if(dlog_res2[0] == 1) {
                    overwrite = true
                }
            }

            if(overwrite == true) {
                disable_homebutton()
                start_save_dialog(4443)

                func_wait(is_active_save_dialog)

                save_profile(overwrite, 0, 0)
            } else {
                local msg1_id_array = [65012, 65013, 65014, 4169]
                local msg2_id_array = [65015, 65016, 4169]

                ui_choice_reset(msg1_id_array, 3)
                ui_choice_register(0)
                ui_choice_register(1)
                ui_choice_register(2)
                ui_choice_register(3)

                local save_index = this.__GetSaveIndex()

                ui_choice_activate()
                
                local device = 0

                switch(ui_choice_get_result()) {
                    case 0:
                        device = 3
                        break;
                    case 1:
                        device = 2
                        break;
                    case 2:
                        device = 1
                        break;
                    case 3:
                        return false;
                        break;
                }

                local card_slot_index = 0

                if(device == 1) {
                    ui_choice_reset(msg2_id_array, 2)
                    ui_choice_register(0)
                    ui_choice_register(1)
                    ui_choice_register(2)
                    ui_choice_activate()
                    switch(ui_choice_get_result()) {
                        case 0:
                            card_slot_index = 0
                            break;
                        case 1:
                            card_slot_index = 1
                            break;
                        case 2:
                            return false;
                            break;
                    }
                }

                print("card_slot_index=" + card_slot_index)

                disable_homebutton()
                start_save_dialog(4443)

                func_wait(is_active_save_dialog)

                save_profile(false, device, card_slot_index)
            }
            
            wait(60)
            func_wait(sync_profile)

            close_save_dialog()
        
            func_wait(is_end_save_dialog)

            enable_homebutton()

            if(get_save_result() == true) {
                play_se(0x10000AA)
                ui_sync(72, [4444])
            } else {
                ui_sync(72, [4059])
            }

            return true;
        }

        return false;
    }

    function __GetSaveIndex() {
        switch(get_save_target()) {
            case 1: return 2;
            case 2: return 1;
            case 3: return 0;
        }

        return 0;
    }
}
