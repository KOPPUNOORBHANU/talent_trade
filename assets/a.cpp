#include<iostream>
#include<vector>
#include<queue>
using namespace std;

void RoundRobin(int &totalProcesses, int &TQ, vector<int> &at, vector<int> &bt, vector<int> &ct)
{
    queue<int> q;
    
    //stores the current process in execution
    int currProcess;
    
    //stores the previous process which was preempted
    int prev = -1; 
    
    //current time -> x
    for(int x = 0 ; x >= 0 ; x += TQ)
    {
        //pushing processes which arrived at current time
        for(int y = 0 ; y < totalProcesses ; y++)
          if(at[y] <= x)
            q.push(y);
        
        //pushing the previous preempted process in the queue
        if(prev != -1)
          q.push(prev);
        
        //executing current process for specified TQ
        currProcess = q.front();
        q.pop();
        
        bt[currProcess] -= TQ;
        
        //checking if this process has completed and taking its completion time
        if(bt[currProcess] <= 0)
        {
            ct[currProcess] = x;
            prev = -1;
        }
        else
          prev = currProcess;
        
        //if queue is empty and prev dont have a preempted process, all processes are excecuted
        if(q.empty() && prev == -1)
          break;
    }
}

void input(int &totalProcesses, int &TQ, vector<int> &at, vector<int> &bt, vector<int> &ct)
{
    cout << "Enter total number of processes : ";
    cin >> totalProcesses;
    
    at = vector<int>(totalProcesses);
    bt = vector<int>(totalProcesses);
    ct = vector<int>(totalProcesses);
    
    cout << "Enter arrival times : ";
    for(int x = 0 ; x < totalProcesses ; x++)
      cin >> at[x];
    
    cout << "Enter burst times : ";
    for(int x = 0 ; x < totalProcesses ; x++)
      cin >> bt[x];
      
    cout << "Enter time quantum : ";
    cin >> TQ;
    
    cout << "here";
    
    for(int x = 0 ; x < totalProcesses ; x++)
      cout << at[x] << " " << bt[x] << " ";
}

int main()
{
    vector<int> at;
    vector<int> bt;
    vector<int> ct;
    int totalProcesses;
    int TQ;
    
    input(totalProcesses, TQ, at, bt, ct);
    RoundRobin(totalProcesses, TQ, at, bt, ct);
    
    for(int x = 0 ; x < totalProcesses ; x++)
      cout << ct[x] << " ";
}