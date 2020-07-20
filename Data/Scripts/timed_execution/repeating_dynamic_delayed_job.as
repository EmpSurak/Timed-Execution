#include "timed_execution/execution_job_interface.as"

funcdef float TIMED_REPEATING_DYNAMIC_CALLBACK();

class RepeatingDynamicDelayedJob : ExecutionJobInterface {
    RepeatingDynamicDelayedJob(){}

    RepeatingDynamicDelayedJob(float _wait, TIMED_REPEATING_DYNAMIC_CALLBACK @_callback) {
        wait = _wait;
        @callback = @_callback;
    }

    float wait;
    TIMED_REPEATING_DYNAMIC_CALLBACK @callback;
    float started;
    
    float GetEndTime(){
        if(started == 0.0f){
            DisplayError("Error", "Job was not started");
            return 0.0f;
        }
        return started+wait;
    }
    
    void Execute(){
        wait = callback();
    }
    
    bool IsRepeating(){
        return wait > 0.0f;
    }
    
    bool IsExpired(float time){
        return time > GetEndTime();
    }
    
    void SetStarted(float time){
        started = time;
    }
}