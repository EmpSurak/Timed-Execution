#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_RAGDOLL_CALLBACK(MovementObject@);

class CharRagdollJob : BasicJobInterface {
    protected int char_id;
    protected CHAR_RAGDOLL_CALLBACK @callback;
    protected bool repeat = false;

    CharRagdollJob(){}

    CharRagdollJob(int _char_id, CHAR_RAGDOLL_CALLBACK @_callback){
        char_id = _char_id;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(char_id)){
            return;
        }
        MovementObject@ char = ReadCharacterID(char_id);
        repeat = callback(char);
    }

    bool IsExpired(){
        if(!MovementObjectExists(char_id)){
            return true;
        }
        MovementObject@ char = ReadCharacterID(char_id);
        return char.GetIntVar("state") == 4; // _ragdoll_state
    }

    bool IsRepeating(){
        return repeat;
    }
}
