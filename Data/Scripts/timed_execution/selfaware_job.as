#include "timed_execution/basic_job_interface.as"

funcdef void SELFAWARE_CALLBACK(SelfawareJob@);

class SelfawareJob : BasicJobInterface {
    protected SELFAWARE_CALLBACK @callback;
    protected float started;
    protected bool repeating = false;
    protected bool expired = true;

    SelfawareJob(){}

    SelfawareJob(SELFAWARE_CALLBACK @_callback){
        @callback = @_callback;
    }

    void ExecuteExpired(){
        callback(this);
    }

    bool IsExpired(){
        return expired;
    }

    bool IsRepeating(){
        return repeating;
    }

    void SetRepeating(bool _repeating){
        repeating = _repeating;
    }

    void SetExpired(bool _expired){
        expired = _expired;
    }
}
