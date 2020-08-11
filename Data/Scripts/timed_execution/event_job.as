#include "timed_execution/execution_job_interface.as"

funcdef bool EVENT_CALLBACK(array<string>);

class EventJob : ExecutionJobInterface {
    EventJob(){}

    EventJob(string _event, EVENT_CALLBACK @_callback){
        event = _event;
        @callback = @_callback;
    }

    string event;
    EVENT_CALLBACK @callback;
    float started;
    bool repeat;

    void Execute(){}
    
    void Execute(array<string> _props){
        repeat = callback(_props);
    }
    
    bool IsRepeating(){
        return repeat;
    }
    
    bool IsExpired(float _time){
        return false;
    }
    
    bool IsEvent(string _event){
        return event == _event;
    }
    
    void SetStarted(float _time){
        started = _time;
    }
}