#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_STATE_CHANGE_CALLBACK(MovementObject@, int);

class CharStateChangeJob : BasicJobInterface {
    protected int char_id;
    protected int initial_state;
    protected CHAR_STATE_CHANGE_CALLBACK @callback;
    protected bool repeat = false;

    CharStateChangeJob(){}

    CharStateChangeJob(int _char_id, CHAR_STATE_CHANGE_CALLBACK @_callback){
        char_id = _char_id;
        @callback = @_callback;
        
        if(MovementObjectExists(char_id)){
            MovementObject @char = ReadCharacterID(char_id);
            SetInitialValues(char);
        }
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(char_id)){
            return;
        }
        MovementObject @char = ReadCharacterID(char_id);

        repeat = callback(char, initial_state);
    }

    bool IsExpired(){
        if(!MovementObjectExists(char_id)){
            return true;
        }
        MovementObject @char = ReadCharacterID(char_id);

        if(initial_state != char.GetIntVar("state")){
            return true;
        }

        return false;
    }

    bool IsRepeating(){
        if(!MovementObjectExists(char_id)){
            return false;
        }
        MovementObject @char = ReadCharacterID(char_id);

        if(repeat){
            SetInitialValues(char);
        }

        return repeat;
    }
    
    private void SetInitialValues(MovementObject @_char){
        initial_state = _char.GetIntVar("state");
    }
}
