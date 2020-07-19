#include "execution_job_interface.as"

funcdef bool TIMED_CALLBACK();

class DelayedExecutionJob : ExecutionJobInterface {
    DelayedExecutionJob(){}

    DelayedExecutionJob(float _wait, TIMED_CALLBACK @_callback) {
        wait = _wait;
        @callback = @_callback;
    }

    float wait;
    TIMED_CALLBACK @callback;
    float started;
    bool repeat;
    
    float GetEndTime(){
        if(started == 0.0f){
            DisplayError("Error", "Job was not started");
            return 0.0f;
        }
        return started+wait;
    }
    
    void Execute(){
        repeat = callback();
    }
    
    bool IsRepeating(){
        return repeat;
    }
    
    bool IsExpired(float time){
        return time > GetEndTime();
    }
    
    void SetStarted(float time){
        started = time;
    }
}