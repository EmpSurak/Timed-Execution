#include "timed_execution/event_job_interface.as"

funcdef bool LEVEL_EVENT_CALLBACK(array<string>);

class LevelEventJob : EventJobInterface {
    string event;
    LEVEL_EVENT_CALLBACK @callback;
    bool repeat;

    LevelEventJob(){}

    LevelEventJob(string _event, LEVEL_EVENT_CALLBACK @_callback){
        event = _event;
        @callback = @_callback;
    }

    void ExecuteEvent(array<string> _props){
        _props.removeAt(0);
        repeat = callback(_props);
    }

    bool IsEvent(array<string> _event){
        if (_event[0] != "level_event")
            return false;
    
        return event == _event[1];
    }

    bool IsRepeating(){
        return repeat;
    }
}
