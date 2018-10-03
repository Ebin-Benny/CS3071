%{
#include <math.h>
#include <string.h>

int validCounty(char* st, int yearF){

  char str[] = "    ";
  int offset = 0;
  while(st[offset]!='-'){
    str[offset] = st[offset];
    offset++;
  }
  str[offset] = 0;

  if(!strcmp(str,"C"))
    return 2;
  else if(!strcmp(str,"CE"))
    return 2;
  else if(!strcmp(str,"CN"))
    return 2;
  else if(!strcmp(str,"CW"))
    return 2;
  else if(!strcmp(str,"D"))
    return 1;
  else if(!strcmp(str,"DL"))
    return 2;
  else if(!strcmp(str,"G"))
    return 1; 
  else if(!strcmp(str,"KE"))
    return 2;
  else if(!strcmp(str,"KK"))
    return 2;
  else if(!strcmp(str,"KY"))
    return 2;
  else if((!strcmp(str,"L")&&yearF))
    return 1;
  else if(!strcmp(str,"LK")&&!yearF)
    return 2;
  else if(!strcmp(str,"LD"))
    return 2;
  else if(!strcmp(str,"LH"))
    return 2; 
  else if(!strcmp(str,"LM"))
    return 2;
  else if(!strcmp(str,"LS"))
    return 2;
  else if(!strcmp(str,"MH"))
    return 2;            
  else if(!strcmp(str,"MO"))
    return 2;
  else if(!strcmp(str,"OY"))
    return 2;
  else if(!strcmp(str,"RN"))
    return 2;
  else if(!strcmp(str,"SO"))
    return 2;
  else if((!strcmp(str,"T")&&yearF))
    return 1;
  else if((!strcmp(str,"TN")&&!yearF)||(!strcmp(str,"TS")&&!yearF))
    return 2;
  else if(!strcmp(str,"W"))
    return 1;
  else if(!strcmp(str,"WD")&&!yearF)
    return 2;
  else if(!strcmp(str,"WH"))
    return 2;
  else if(!strcmp(str,"WX"))
    return 2;
  else if(!strcmp(str,"WW"))
    return 2;         
  return 0;
}

int difference2(int year){
  if(year<13)
    year+=100;
  return 118-year;  
}

int difference3(int year){
  return 18 - year;
}

int countyFormat(int year){
  if((year<14&&year>=0)||(year<100&&year>=87))
    return 0;
  else return 1;
}

%}

%%
([0-9]{2}[-][A-z]{1,2}[-][0-9]+)*     {int len = strlen(yytext);
                                      yytext[2] = 0;
                                      int y = atoi(yytext); 
                                      if((y<13&&y>=0)||(y<100&&y>=87)){
                                        if(validCounty(yytext+3,0)){
                                          len = len - validCounty(yytext+3,countyFormat(y))-4;
                                          if(len<=6){
                                            printf("%d\n",difference2(y));
                                          }else{
                                            printf("INVALID\n");
                                          }
                                        }else{
                                          printf("INVALID\n");
                                        }
                                      }else{
                                        printf("INVALID\n");
                                      }}
([0-9]{3}[-][A-z]{1,2}[-][0-9]+)*     {int len = strlen(yytext);
                                      yytext[2] = 0;
                                      int y = atoi(yytext); 
                                      if(y>=13&&y<=18){
                                        if(validCounty(yytext+4,1)){
                                          len = len - validCounty(yytext+4,countyFormat(y))-5;
                                          if(len<=6){
                                            printf("%d\n",difference3(y));
                                          }else{
                                            printf("INVALID\n");
                                          }
                                        }else{
                                          printf("INVALID\n");
                                        }
                                      }else{printf("INVALID\n");
                                      }}
[\n]                                  {}                                        
[\ \t\n\r\f\v]*                       {}
[(A-z)|(0-9)|-]*                      {printf("INVALID\n");}
%%

int main()
{
    yylex();
    return 0;
}
