#include "timed_execution/execution_job_interface.as"

funcdef void SELFAWARE_CALLBACK(SelfawareJob@);

class SelfawareJob : ExecutionJobInterface {
    SELFAWARE_CALLBACK @callback;
    float started;
    bool repeating = false;
    bool expired = true;

    SelfawareJob(){}

    SelfawareJob(SELFAWARE_CALLBACK @_callback){
        @callback = @_callback;
    }

    void ExecuteExpired(){
        callback(this);
    }
    
    void ExecuteEvent(array<string> _props){}
    
    bool IsExpired(float time){
        return expired;
    }
    
    bool IsEvent(array<string> _event){
        return false;
    }
    
    bool IsRepeating(){
        return repeating;
    }
    
    void SetStarted(float time){
        started = time;
    }
    
    float GetStarted(){
        return started;
    }

    void SetRepeating(bool _repeating){
        repeating = _repeating;
    }

    void SetExpired(bool _expired){
        expired = _expired;
    }
}
