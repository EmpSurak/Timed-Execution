#include "timed_execution/execution_job_interface.as"

funcdef void AFTER_INIT_CALLBACK();

class AfterInitJob : ExecutionJobInterface {
    AFTER_INIT_CALLBACK @callback;
    float started;

    AfterInitJob(){}

    AfterInitJob(AFTER_INIT_CALLBACK @_callback){
        @callback = @_callback;
    }

    void ExecuteExpired(){
        callback();
    }
    
    void ExecuteEvent(array<string> _props){}
    
    bool IsExpired(float time){
        return true;
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
}
