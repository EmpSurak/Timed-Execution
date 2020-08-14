#include "timed_execution/selfaware_job.as"

funcdef void SELFAWARE_NAME_CALLBACK(SelfawareJobWithName@);

class SelfawareJobWithName : SelfawareJob {
    protected SELFAWARE_NAME_CALLBACK @new_callback;
    protected string name;

    SelfawareJobWithName(){}

    SelfawareJobWithName(SELFAWARE_NAME_CALLBACK @_callback){
        @new_callback = @_callback;
    }

    void ExecuteExpired(){
        new_callback(this);
    }

    void SetName(string _name){
        name = _name;
    }

    string GetName(){
        return name;
    }
}
