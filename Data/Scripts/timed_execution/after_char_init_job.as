#include "timed_execution/basic_job_interface.as"

funcdef void AFTER_CHAR_CALLBACK(MovementObject@);

class AfterCharInitJob : BasicJobInterface {
    protected int char_id;
    protected AFTER_CHAR_CALLBACK @callback;

    AfterCharInitJob(){}

    AfterCharInitJob(int _char_id, AFTER_CHAR_CALLBACK @_callback){
        char_id = _char_id;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(char_id)){
            return;
        }
        MovementObject @char = ReadCharacterID(char_id);

        callback(char);
    }

    bool IsExpired(){
        if(!MovementObjectExists(char_id)){
            return false;
        }
        MovementObject @char = ReadCharacterID(char_id);

        return char.GetIntVar("updated") > 0;
    }

    bool IsRepeating(){
        return false;
    }
}
