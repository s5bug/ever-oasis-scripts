// TODO match line infos

class UIChoise {
    msg_id_array = []
    retval_cancel = -1
    register_index = []
    register_enable = []
    option = []
    result = -1

    function Dispose() {
        msg_id_array = null
        register_index = null
        register_enable = null
        option = null
    }
}

g_ui_choice <- null

function ui_choice_destroy() {
    if(g_ui_choice != null) {
        g_ui_choice.Dispose()
        g_ui_choice = null
    }
}

function ui_choice_reset(msg_id_array, retval_cancel = -1) {
    if(g_ui_choice == null) {
        g_ui_choice = UIChoise()
    }

    g_ui_choice.msg_id_array = msg_id_array
    g_ui_choice.retval_cancel = retval_cancel
    g_ui_choice.register_index = []
    g_ui_choice.register_enable = []
    g_ui_choice.option = [1, 0, 3, 0]
    g_ui_choice.result = retval_cancel
}

function ui_choice_register(index, enable = true) {
    g_ui_choice.register_index.append(index)
    g_ui_choice.register_enable.append(enable)
}

function ui_choice_register_cancel(retval) {
    g_ui_choice.retval_cancel = retval
}

function ui_choice_set_option(option) {
    g_ui_choice.option = option
}

function ui_choice_get_choices_count() {
    return g_ui_choice.register_index.len();
}

function ui_choice_get_valid_choices_count() {
    local count = 0
    for(local i = 0; i < g_ui_choice.register_index.len(); ++i) {
        if(g_ui_choice.register_index[i] != g_ui_choice.retval_cancel) {
            ++count
        }
    }
    return count;
}

function ui_choice_activate(force_select = false) {
    if(ui_choice_get_valid_choices_count() < 2 && !force_select) {
        g_ui_choice.result = g_ui_choice.retval_cancel

        for(local i = 0; i < g_ui_choice.register_index.len(); ++i) {
            if(g_ui_choice.register_index[i] != g_ui_choice.retval_cancel) {
                g_ui_choice.result = g_ui_choice.register_index[i]
            }
        }

        return;
    }

    local arg = []

    for(local i = 0; i < 4; ++i) {
        arg.append(g_ui_choice.option[i])
    }

    for(local i = 0; i < g_ui_choice.register_index.len(); ++i) {
        local msg_id = g_ui_choice.msg_id_array[g_ui_choice.register_index[i]]

        if(!g_ui_choice.register_enable[i]) {
            msg_id = ChoiceDisable(msg_id)
        }

        arg.append(msg_id)
    }

    local result = ui_sync(17, arg)

    if(result[0] == -1) {
        g_ui_choice.result = g_ui_choice.retval_cancel
    } else {
        g_ui_choice.result = g_ui_choice.register_index[result[0]]
    }
}

function ui_choice_get_result() {
    return g_ui_choice.result;
}
