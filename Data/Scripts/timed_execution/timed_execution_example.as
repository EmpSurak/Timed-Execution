#include "timed_execution/timed_execution.as"
#include "timed_execution/after_init_job.as"
#include "timed_execution/after_char_init_job.as"
#include "timed_execution/char_state_change_job.as"
#include "timed_execution/simple_delayed_job.as"
#include "timed_execution/repeating_delayed_job.as"
#include "timed_execution/repeating_dynamic_delayed_job.as"
#include "timed_execution/selfaware_job_with_name.as"
#include "timed_execution/event_job.as"
#include "timed_execution/level_event_job.as"

TimedExecution timer;

void Init(string str){
    int char_id = 5;

    // timed_execution/after_init_job.as
    timer.Add(AfterInitJob(function(){
        Log(info, "Execute once after initialization is finished");
    }));

    // timed_execution/after_char_init_job.as
    timer.Add(AfterCharInitJob(char_id, function(id){
        Log(info, "Execute once after character " + id + " initialization is finished");
    }));

    // timed_execution/char_state_change_job.as
    if(MovementObjectExists(char_id)){
        MovementObject @_char = ReadCharacterID(char_id);
        timer.Add(CharStateChangeJob(_char, function(_char, _previous_state, _new_state){
            Log(info, "Execute once after character " + _char.GetID() + " state changed");
            Log(info, "Previous state: " + _previous_state + "\t" + "New state: " + _new_state);
            // Return true to restart the job.
            return true;
        }));
    }

    // timed_execution/simple_delayed_job.as
    timer.Add(SimpleDelayedJob(1.0f, function(){
        Log(info, "Execute once after one second");
    }));

    // timed_execution/repeating_delayed_job.as
    timer.Add(RepeatingDelayedJob(2.0f, function(){
        Log(info, "Execute once after two seconds");
        // Return true to restart the job.
        return false;
    }));

    // timed_execution/repeating_dynamic_delayed_job.as
    timer.Add(RepeatingDynamicDelayedJob(1.0f, function(){
        Log(info, "Run after one second and then repeat every minute");
        // Values above zero will restart the job with a new delay.
        return 60.0f;
    }));

    // timed_execution/selfaware_job_with_name.as
    SelfawareJobWithName job = SelfawareJobWithName(function(_job){
        // SelfawareJobWithName is just an example, create your own classes
        // with getters and setters based on timed_execution/selfaware_job.as.
        Log(info, _job.GetName());
    });
    job.SetName("Extended SelfawareJob class");
    timer.Add(job);

    // timed_execution/event_job.as
    timer.Add(EventJob(function(_params){
        Log(info, "Any Event");
        // Return true to restart the job.
        return false;
    }));

    // timed_execution/level_event_job.as
    timer.Add(LevelEventJob("knocked_over", function(_params){
        Log(info, "Level Event: " + _params[0]);
        // Return true to restart the job.
        return false;
    }));
}

void Update(int is_paused){
    timer.Update();
}

void ReceiveMessage(string msg){
    timer.AddLevelEvent(msg);
}

void DrawGUI(){}

void Draw(){}

bool HasFocus(){
    return false;
}
