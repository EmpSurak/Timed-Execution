#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_DEATH_CALLBACK(MovementObject@);

class CharDeathJob : BasicJobInterface {
    protected int char_id;
    protected CHAR_DEATH_CALLBACK @callback;
    protected bool repeat = false;

    CharDeathJob(){}

    CharDeathJob(int _char_id, CHAR_DEATH_CALLBACK @_callback){
        char_id = _char_id;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        if(!MovementObjectExists(char_id)){
            return;
        }
        MovementObject @char = ReadCharacterID(char_id);

        repeat = callback(char);
    }

    bool IsExpired(){
        if(!MovementObjectExists(char_id)){
            return true;
        }
        MovementObject @char = ReadCharacterID(char_id);

        return char.GetIntVar("knocked_out") != _awake;
    }

    bool IsRepeating(){
        return repeat;
    }
}
