#include "timed_execution/basic_job_interface.as"

funcdef bool INPUT_PRESSED_CALLBACK();

class OnInputPressedJob : BasicJobInterface {
    protected int controller_id;
    protected string input_label;
    protected INPUT_PRESSED_CALLBACK @callback;
    protected bool repeat;

    OnInputPressedJob(){}

    OnInputPressedJob(int _controller_id, string _input_label, INPUT_PRESSED_CALLBACK @_callback){
        controller_id = _controller_id;
        input_label = _input_label;
        @callback = @_callback;
    }

    void ExecuteExpired(){
        repeat = callback();
    }

    bool IsExpired(){
        return GetInputPressed(controller_id, input_label);
    }

    bool IsRepeating(){
        return repeat;
    }
}
