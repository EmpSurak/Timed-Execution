#include "timed_execution/basic_job_interface.as"

funcdef void SELFAWARE_CALLBACK(SelfawareJob@);

class SelfawareJob : BasicJobInterface {
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
