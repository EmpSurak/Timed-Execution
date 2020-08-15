#include "timed_execution/timer_job_interface.as"

funcdef void TIMED_CALLBACK();

class DelayedJob : TimerJobInterface {
    protected float wait;
    protected TIMED_CALLBACK @callback;
    protected float started;

    DelayedJob(){}

    DelayedJob(float _wait, TIMED_CALLBACK @_callback){
        wait = _wait;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        callback();
    }

    bool IsExpired(float time){
        return time > GetEndTime();
    }

    bool IsRepeating(){
        return false;
    }

    void SetStarted(float time){
        started = time;
    }

    private float GetEndTime(){
        return started+wait;
    }
}
