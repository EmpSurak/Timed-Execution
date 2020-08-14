interface TimerJobInterface{
    void ExecuteExpired();
    bool IsExpired(float _time);
    void SetStarted(float _time);
    bool IsRepeating();
}
