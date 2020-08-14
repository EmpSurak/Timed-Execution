#include "timed_execution/event_job_interface.as"

funcdef bool EVENT_CALLBACK(array<string>);

class EventJob : EventJobInterface {
    EVENT_CALLBACK @callback;
    bool repeat;

    EventJob(){}

    EventJob(EVENT_CALLBACK @_callback){
        @callback = @_callback;
    }

    void ExecuteExpired(){}

    void ExecuteEvent(array<string> _props){
        repeat = callback(_props);
    }

    bool IsEvent(array<string> _event){
        return true;
    }

    bool IsRepeating(){
        return repeat;
    }
}
