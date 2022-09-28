#include "timed_execution/basic_job_interface.as"

funcdef bool PLAYER_DEATH_CALLBACK();

class PlayerDeathJob : BasicJobInterface {
    protected PLAYER_DEATH_CALLBACK @callback;
    protected bool repeat = false;

    PlayerDeathJob(){}

    PlayerDeathJob(PLAYER_DEATH_CALLBACK @_callback){
        @callback = @_callback;
    }

    void ExecuteExpired(){
        repeat = callback();
    }

    bool IsExpired(){
        return !IsPlayerLiving();
    }

    bool IsRepeating(){
        return repeat;
    }

    bool IsPlayerLiving(){
        int num = GetNumCharacters();
        for(int i = 0; i < num; ++i){
            MovementObject@ char = ReadCharacter(i);

            if(!char.controlled){
                continue;
            }

            if(char.GetIntVar("knocked_out") != _awake){
                return false;
            }
        }

        return true;
    }
}
