#include "timed_execution/timer_job_interface.as"

funcdef bool TIMED_REPEATING_CALLBACK();

class RepeatingDelayedJob : TimerJobInterface {
    protected float wait;
    protected TIMED_REPEATING_CALLBACK @callback;
    protected float started;
    protected bool repeat = false;

    RepeatingDelayedJob(){}

    RepeatingDelayedJob(float _wait, TIMED_REPEATING_CALLBACK @_callback){
        wait = _wait;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        repeat = callback();
    }

    bool IsExpired(float time){
        return time > GetEndTime();
    }

    bool IsRepeating(){
        return repeat;
    }

    void SetStarted(float time){
        started = time;
    }

    private float GetEndTime(){
        return started+wait;
    }
}
