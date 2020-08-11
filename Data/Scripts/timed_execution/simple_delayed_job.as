#include "timed_execution/execution_job_interface.as"

funcdef void TIMED_SIMPLE_CALLBACK();

class SimpleDelayedJob : ExecutionJobInterface {
    SimpleDelayedJob(){}

    SimpleDelayedJob(float _wait, TIMED_SIMPLE_CALLBACK @_callback){
        wait = _wait;
        @callback = @_callback;
    }

    float wait;
    TIMED_SIMPLE_CALLBACK @callback;
    float started;
    
    float GetEndTime(){
        if(started == 0.0f){
            DisplayError("Error", "Job was not started");
            return 0.0f;
        }
        return started+wait;
    }
    
    void Execute(){
        callback();
    }
    
    bool IsRepeating(){
        return false;
    }
    
    bool IsExpired(float time){
        return time > GetEndTime();
    }
    
    void SetStarted(float time){
        started = time;
    }
    
    void Execute(array<string> _props){}
    
    bool IsEvent(string _event){
        return false;
    }
}