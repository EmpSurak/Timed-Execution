#include "timed_execution/basic_job_interface.as"

funcdef void AFTER_INIT_CALLBACK();

class AfterInitJob : BasicJobInterface {
    AFTER_INIT_CALLBACK @callback;

    AfterInitJob(){}

    AfterInitJob(AFTER_INIT_CALLBACK @_callback){
        @callback = @_callback;
    }

    void ExecuteExpired(){
        callback();
    }

    bool IsExpired(){
        return true;
    }

    bool IsRepeating(){
        return false;
    }
}
