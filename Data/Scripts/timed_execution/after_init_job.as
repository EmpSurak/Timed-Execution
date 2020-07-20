#include "timed_execution/execution_job_interface.as"

funcdef void AFTER_INIT_CALLBACK();

class AfterInitJob : ExecutionJobInterface {
    AfterInitJob(){}

    AfterInitJob(AFTER_INIT_CALLBACK @_callback){
        @callback = @_callback;
    }

    AFTER_INIT_CALLBACK @callback;
    float started;
    
    void Execute(){
        callback();
    }
    
    bool IsRepeating(){
        return false;
    }
    
    bool IsExpired(float time){
        return true;
    }
    
    void SetStarted(float time){
        started = time;
    }
}