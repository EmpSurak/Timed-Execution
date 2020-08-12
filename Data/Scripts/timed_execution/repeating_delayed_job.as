#include "timed_execution/execution_job_interface.as"

funcdef bool TIMED_REPEATING_CALLBACK();

class RepeatingDelayedJob : ExecutionJobInterface {
    float wait;
    TIMED_REPEATING_CALLBACK @callback;
    float started;
    bool repeat;
    
    RepeatingDelayedJob(){}

    RepeatingDelayedJob(float _wait, TIMED_REPEATING_CALLBACK @_callback){
        wait = _wait;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        repeat = callback();
    }
    
    void ExecuteEvent(array<string> _props){}
    
    bool IsExpired(float time){
        return time > GetEndTime();
    }
    
    bool IsEvent(array<string> _event){
        return false;
    }
    
    bool IsRepeating(){
        return repeat;
    }

    void SetStarted(float time){
        started = time;
    }

    float GetEndTime(){
        return started+wait;
    }
}
