#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{   
    int male;
    int female;
    int div;

    int **Graph = malloc(sizeof(int*)*25);
    for(int i=0; i<25; i++)
    {
        Graph[i] = malloc(sizeof(int)*23);
    }

    for(int i=0; i<25; i++)
    {
        for(int j=0; j<23; j++)
        {
            Graph[i][j] = 3;
            Graph[23][j] = 1;
        }
    }
    for(int i=0; i<25; i++)
    {
        Graph[i][1] = 1;
        i+=1;        
    }
    for(int i=1; i<25; i++) 
    {
        Graph[i][1] = 4;
        i+=1;
    }
    for(int i=0; i<25; i+=2)
    {
        Graph[i][0] = 4;
    }

    int ten = 0;
    for(int i=18; i>=0; i-=2)
    {
        Graph[i][0] = ten + 10;
        ten+=10;
    } 
    for(int i=19; i>=1; i-=2) 
    {
        Graph[i][0] = 9;
    }
    ten = 0;   
    for(int j=2; j<21; j+=2)
    {   
        Graph[24][j] = ten + 2010;          
        ten++;
    }
    for(int i=0; i<21; i++) 
    {
        for(int j=2; j<21; j+=2)
        {
            Graph[i][j] = 8;
        }
    }
    for(int i=0; i<21; i++) 
    {
        for(int j=3; j<20; j+=2)
        {
            Graph[i][j] = 4;
        }
    }

    Graph[23][1] = 1;
    Graph[22][0] = 11;
    Graph[20][0] = 0;
    Graph[24][21] = 12;

    int l = 2;  
    int k;
    int m;
    while(l<=23)
    {
        system("clear");
        for(int i=0; i<25; i++)
        {
            for(int j=0; j<23; j++)
            {
                if(Graph[i][j]==12) printf(" [year]");
                else if(Graph[i][j]==9) printf("    "); 
                else if(Graph[i][j]==8) printf(" ?  "); 
                else if(Graph[i][j]==7) printf("\x1b[36m ?  \x1b[0m"); // male 
                else if(Graph[i][j]==6) printf("\x1b[35m ?  \x1b[0m"); // female
                else if(Graph[i][j]==11) printf(" [%]");
                else if(Graph[i][j]==1) printf(" ? ");
                else if(Graph[i][j]==0) printf("  0 ");
                else if(Graph[i][j]==4) printf("    "); // blank
                else if(Graph[i][j]==3) printf("   ");
                else if(Graph[i][j]==10) printf(" 10 ");
                else if(Graph[i][j]==20) printf(" 20 ");
                else if(Graph[i][j]==30) printf(" 30 ");
                else if(Graph[i][j]==40) printf(" 40 ");
                else if(Graph[i][j]==50) printf(" 50 ");
                else if(Graph[i][j]==60) printf(" 60 ");
                else if(Graph[i][j]==70) printf(" 70 ");
                else if(Graph[i][j]==80) printf(" 80 ");
                else if(Graph[i][j]==90) printf(" 90 ");
                else if(Graph[i][j]==100) printf("100 ");
                else if(Graph[i][j]==2010) printf("2010 ");
                else if(Graph[i][j]==2011) printf("2011 ");
                else if(Graph[i][j]==2012) printf("2012 ");
                else if(Graph[i][j]==2013) printf("2013 ");
                else if(Graph[i][j]==2014) printf("2014 ");
                else if(Graph[i][j]==2015) printf("2015 ");
                else if(Graph[i][j]==2016) printf("2016 ");
                else if(Graph[i][j]==2017) printf("2017 ");
                else if(Graph[i][j]==2018) printf("2018 ");
                else if(Graph[i][j]==2019) printf("2019 ");
            }
            puts("");
        }
        puts("");

        if(l<22)
        {
            printf("%d male smoking rate(int) : ",Graph[24][l]);
            scanf("%d", &male);

            div = male/10;    

            if(male%10==0) Graph[20-div*2][l] = 7;
            else if(male%10!=0)
            {
                Graph[19-div*2][l]=7; 
            }
        }
        //l+=2;

        if(l<22)
        {
            printf("%d female smoking rate(int) : ",Graph[24][l]);
            scanf("%d", &female);

            div = female/10;   

            if(female%10==0) Graph[20-div*2][l] = 6;
            else if(female%10!=0)
            {
                Graph[19-div*2][l]=6; 
            }
        }
        l+=2;
    }

    for(int i=0; i<25; i++)
    {
        free(Graph[i]);
    }

    free(Graph);

    return 0;
}
