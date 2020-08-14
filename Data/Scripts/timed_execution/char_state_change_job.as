#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_STATE_CHANGE_CALLBACK(MovementObject@, int, int);

class CharStateChangeJob : BasicJobInterface {
    protected MovementObject @char;
    protected int initial_state;
    protected CHAR_STATE_CHANGE_CALLBACK @callback;
    protected bool repeat;

    CharStateChangeJob(){}

    CharStateChangeJob(MovementObject @_char, CHAR_STATE_CHANGE_CALLBACK @_callback){
        @char = @_char;
        initial_state = _char.GetIntVar("state");
        @callback = @_callback;
    }

    void ExecuteExpired(){
        repeat = callback(char, initial_state, char.GetIntVar("state"));
    }

    bool IsExpired(){
        if(initial_state != char.GetIntVar("state")){
            return true;
        }

        return false;
    }

    bool IsRepeating(){
        if(repeat){
            initial_state = char.GetIntVar("state");
        }
        return repeat;
    }
}
