#include "timed_execution/event_job.as"

funcdef bool LEVEL_EVENT_CALLBACK(array<string>);

class LevelEventJob : ExecutionJobInterface {
    string event;
    LEVEL_EVENT_CALLBACK @callback;
    float started;
    bool repeat;
    
    LevelEventJob(){}

    LevelEventJob(string _event, LEVEL_EVENT_CALLBACK @_callback){
        event = _event;
        @callback = @_callback;
    }

    void ExecuteExpired(){}
    
    void ExecuteEvent(array<string> _props){
        _props.removeAt(0);
        repeat = callback(_props);
    }
    
    bool IsExpired(float _time){
        return false;
    }
    
    bool IsEvent(array<string> _event){
        if (_event[0] != "level_event")
            return false;
    
        return event == _event[1];
    }
    
    bool IsRepeating(){
        return repeat;
    }

    void SetStarted(float _time){
        started = _time;
    }
}
