#include "timed_execution/delayed_job.as"

// DEPRECATED
class SimpleDelayedJob : DelayedJob {
    SimpleDelayedJob(){}

    SimpleDelayedJob(float _wait, TIMED_CALLBACK @_callback){
        wait = _wait;
        @callback = @_callback;
    }
}
