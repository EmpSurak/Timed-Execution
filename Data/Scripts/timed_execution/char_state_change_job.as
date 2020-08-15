#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_STATE_CHANGE_CALLBACK(MovementObject@, int);

class CharStateChangeJob : BasicJobInterface {
    protected MovementObject @char;
    protected int initial_state;
    protected CHAR_STATE_CHANGE_CALLBACK @callback;
    protected bool repeat;

    CharStateChangeJob(){}

    CharStateChangeJob(MovementObject @_char, CHAR_STATE_CHANGE_CALLBACK @_callback){
        @char = @_char;
        @callback = @_callback;
        SetInitialValues(_char);
    }

    void ExecuteExpired(){
        repeat = callback(char, initial_state);
    }

    bool IsExpired(){
        if(initial_state != char.GetIntVar("state")){
            return true;
        }

        return false;
    }

    bool IsRepeating(){
        if(repeat){
            SetInitialValues(char);
        }

        return repeat;
    }
    
    private void SetInitialValues(MovementObject @_char){
        initial_state = _char.GetIntVar("state");
    }
}
