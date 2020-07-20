interface ExecutionJobInterface{
    void Execute();
    bool IsExpired(float time);
    bool IsRepeating();
    void SetStarted(float time);
}