#include "timed_execution/basic_job_interface.as"

funcdef bool PLAYER_SURVIVOR_CALLBACK();

class PlayerSurvivorJob : BasicJobInterface {
    protected PLAYER_SURVIVOR_CALLBACK @callback;
    protected bool repeat = false;

    PlayerSurvivorJob(){}

    PlayerSurvivorJob(PLAYER_SURVIVOR_CALLBACK @_callback){
        @callback = @_callback;
    }

    void ExecuteExpired(){
        repeat = callback();
    }

    bool IsExpired(){
        return !HasLivingEnemies();
    }

    bool IsRepeating(){
        return repeat;
    }

    MovementObject@ GetPlayer(){
        int num = GetNumCharacters();
        for(int i = 0; i < num; ++i){
            MovementObject@ char = ReadCharacter(i);
            
            if(char.controlled){
                return char;
            }
        }
        return null;
    }

    bool HasLivingEnemies(){
        MovementObject@ player = GetPlayer();
        int num = GetNumCharacters();
        for(int i = 0; i < num; ++i){
            MovementObject@ char = ReadCharacter(i);

            if(char.controlled || char.OnSameTeam(player)){
                continue;
            }

            if(char.GetIntVar("knocked_out") == _awake){
                return true;
            }
        }

        return false;
    }
}
