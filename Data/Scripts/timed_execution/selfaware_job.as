#include "timed_execution/execution_job_interface.as"

funcdef void SELFAWARE_CALLBACK(SelfawareJob@);

class SelfawareJob : ExecutionJobInterface {
    SelfawareJob(){}

    SelfawareJob(SELFAWARE_CALLBACK @_callback){
        @callback = @_callback;
    }

    SELFAWARE_CALLBACK @callback;
    float started;
    bool repeating = false;
    bool expired = true;

    void Execute(){
        callback(this);
    }
    
    bool IsRepeating(){
        return repeating;
    }

    void SetRepeating(bool _repeating){
        repeating = _repeating;
    }
    
    bool IsExpired(float time){
        return expired;
    }
    
    void SetExpired(bool _expired){
        expired = _expired;
    }
    
    void SetStarted(float time){
        started = time;
    }
    
    float GetStarted(){
        return started;
    }
    
    void Execute(array<string> _props){}
    
    bool IsEvent(string _event){
        return false;
    }
}