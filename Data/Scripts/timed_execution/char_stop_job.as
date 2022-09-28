#include "timed_execution/basic_job_interface.as"

funcdef bool CHAR_STOP_CALLBACK(MovementObject@);

class CharStopJob : BasicJobInterface {
    protected int char_id;
    protected CHAR_STOP_CALLBACK @callback;
    protected vec3 last_pos;
    protected bool repeat = false;

    CharStopJob(){}

    CharStopJob(int _char_id, CHAR_STOP_CALLBACK @_callback){
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

        if(last_pos == char.position){
            return true;
        }else{
            last_pos = char.position;
            return false;
        }
    }

    bool IsRepeating(){
        return repeat;
    }
}
