#include "timed_execution/execution_job_interface.as"

funcdef bool EVENT_CALLBACK(array<string>);

class EventJob : ExecutionJobInterface {
    string event;
    EVENT_CALLBACK @callback;
    float started;
    bool repeat;
    
    EventJob(){}

    EventJob(string _event, EVENT_CALLBACK @_callback){
        event = _event;
        @callback = @_callback;
    }

    void ExecuteExpired(){}
    
    void ExecuteEvent(array<string> _props){
        repeat = callback(_props);
    }
    
    bool IsExpired(float _time){
        return false;
    }
    
    bool IsEvent(array<string> _event){
        return event == _event[0];
    }
    
    bool IsRepeating(){
        return repeat;
    }

    void SetStarted(float _time){
        started = _time;
    }
}
