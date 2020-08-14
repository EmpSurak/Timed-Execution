#include "timed_execution/timer_job_interface.as"

funcdef float TIMED_REPEATING_DYNAMIC_CALLBACK();

class RepeatingDynamicDelayedJob : TimerJobInterface {
    protected float wait;
    protected TIMED_REPEATING_DYNAMIC_CALLBACK @callback;
    protected float started;

    RepeatingDynamicDelayedJob(){}

    RepeatingDynamicDelayedJob(float _wait, TIMED_REPEATING_DYNAMIC_CALLBACK @_callback){
        wait = _wait;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        wait = callback();
    }

    bool IsExpired(float time){
        return time > GetEndTime();
    }

    bool IsRepeating(){
        return wait > 0.0f;
    }

    void SetStarted(float time){
        started = time;
    }

    private float GetEndTime(){
        return started+wait;
    }
}
