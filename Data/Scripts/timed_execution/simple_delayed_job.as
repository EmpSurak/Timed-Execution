#include "timed_execution/execution_job_interface.as"

funcdef void TIMED_SIMPLE_CALLBACK();

class SimpleDelayedJob : ExecutionJobInterface {
    float wait;
    TIMED_SIMPLE_CALLBACK @callback;
    float started;

    SimpleDelayedJob(){}

    SimpleDelayedJob(float _wait, TIMED_SIMPLE_CALLBACK @_callback){
        wait = _wait;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        callback();
    }
    
    void ExecuteEvent(array<string> _props){}

    bool IsExpired(float time){
        return time > GetEndTime();
    }
    
    bool IsEvent(array<string> _event){
        return false;
    }
    
    bool IsRepeating(){
        return false;
    }
    
    void SetStarted(float time){
        started = time;
    }

    float GetEndTime(){
        return started+wait;
    }
}
