#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_STATE_CHANGE_CALLBACK(MovementObject@, int);

class CharStateChangeJob : BasicJobInterface {
    protected int id;
    protected int initial_state;
    protected CHAR_STATE_CHANGE_CALLBACK @callback;
    protected bool repeat;

    CharStateChangeJob(){}

    CharStateChangeJob(int _id, CHAR_STATE_CHANGE_CALLBACK @_callback){
        id = _id;
        @callback = @_callback;
        
        MovementObject @char = ReadCharacterID(id);
        SetInitialValues(char);
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(id)){
            return;
        }
        MovementObject @char = ReadCharacterID(id);

        repeat = callback(char, initial_state);
    }

    bool IsExpired(){
        if(!MovementObjectExists(id)){
            return true;
        }
        MovementObject @char = ReadCharacterID(id);

        if(initial_state != char.GetIntVar("state")){
            return true;
        }

        return false;
    }

    bool IsRepeating(){
        if(!MovementObjectExists(id)){
            return false;
        }
        MovementObject @char = ReadCharacterID(id);

        if(repeat){
            SetInitialValues(char);
        }

        return repeat;
    }
    
    private void SetInitialValues(MovementObject @_char){
        initial_state = _char.GetIntVar("state");
    }
}
