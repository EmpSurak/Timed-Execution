interface BasicJobInterface{
    void ExecuteExpired();
    bool IsExpired();
    bool IsRepeating();
}
