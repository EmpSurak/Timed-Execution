#include "timed_execution/basic_job_interface.as"

funcdef void AFTER_CHAR_RAGDOLL_CALLBACK(MovementObject@);

class AfterCharRagdollJob : BasicJobInterface {
    protected int char_id;
    protected AFTER_CHAR_RAGDOLL_CALLBACK @callback;
    protected bool was_ragdoll = false;

    AfterCharRagdollJob(){}

    AfterCharRagdollJob(int _char_id, AFTER_CHAR_RAGDOLL_CALLBACK @_callback){
        char_id = _char_id;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(char_id)){
            return;
        }
        MovementObject@ char = ReadCharacterID(char_id);
        callback(char);
    }

    bool IsExpired(){
        if(!MovementObjectExists(char_id)){
            return true;
        }
        MovementObject@ char = ReadCharacterID(char_id);
        
        if(char.GetIntVar("state") == 4){ // _ragdoll_state
            was_ragdoll = true;
            return false;
        }
        return was_ragdoll;
    }

    bool IsRepeating(){
        return false;
    }
}
