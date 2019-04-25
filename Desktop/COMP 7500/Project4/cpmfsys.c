#include <stdint.h> 
#include <stdlib.h> 
#include "diskSimulator.h"
#include <stdbool.h> 
#include <string.h> 
#include <stdio.h> 
#include "cpmfsys.h"

// #define EXTENT_SIZE 32
// #define BLOCKS_PER_EXTENT 16 
// #define debugging false

// typedef struct dirStruct { 
// uint8_t status; // 0xe5 = unused, 0-16 = user number
// char  name[9]; // no need to support attributes in msb  of bytes 0,1,2,7
// char  extension[4]; // no need to support attributes in msb  of bytes 0,1,2
// uint8_t XL; // see below for these 4  bytes' meaning
// uint8_t BC; 
// uint8_t XH; 
// uint8_t RC;  
// uint8_t blocks[BLOCKS_PER_EXTENT]; // array of disk sectors used
// } DirStructType;
static bool FreeList[256];

/* XL and XH store the extent number, bits 5-7 of XL are zero, bits 0-4 are
   low-order bits of extent number, bits 6-7 of XH are zero, bits 0-5 hold high
   -order bits of extent number
   
   BC = number of bytes in last used physical sector
   RC = number of 128 byte sectors in last used block 
   blocks are logical block numbers 0-255, 0 indicates a hole in file, 
   
*/ 

typedef uint8_t Extent[32];

//function to allocate memory for a DirStructType (see above), and populate it, given a
//pointer to a buffer of memory holding the contents of disk block 0 (e), and an integer index
// which tells which extent from block zero (extent numbers start with 0) to use to make the
// DirStructType value to return. 
DirStructType *mkDirStruct(int index,uint8_t *e){
   int i;
   DirStructType *head;
   head=malloc(sizeof(DirStructType));
   memset(head,0,sizeof(DirStructType));
   head->status= (e+EXTENT_SIZE*index)[0];
   for(i=0;i<8;i++)
      if ((e+index*EXTENT_SIZE)[i+1]!=' ')
         head->name[i]=(e+index*EXTENT_SIZE)[i+1];
   for(i=0;i<3;i++)
      if ((e+index*EXTENT_SIZE)[i+9]!=' ')
         head->extension[i]=(e+index*EXTENT_SIZE)[i+9];
   head->XL=(e+index*EXTENT_SIZE)[12];
   head->BC=(e+index*EXTENT_SIZE)[13];
   head->XH=(e+index*EXTENT_SIZE)[14];
   head->RC=(e+index*EXTENT_SIZE)[15];
   for(i=0;i<16;i++)
      head->blocks[i]=(e+index*EXTENT_SIZE)[i+16];
   return head;
}

// function to write contents of a DirStructType struct back to the specified index of the extent
// in block of memory (disk block 0) pointed to by e
void writeDirStruct(DirStructType *d, uint8_t index, uint8_t *e){
   int i;
   (e+EXTENT_SIZE*index)[0]= d->status;
   for(i=0;i<8;i++)
      if(d->name[i]!=0)
         (e+index*EXTENT_SIZE)[i+1]=d->name[i];
      else
         (e+index*EXTENT_SIZE)[i+1]=' ';
   for(i=0;i<3;i++)
      if(d->extension[i]!=0)
         (e+index*EXTENT_SIZE)[i+9]=d->extension[i];
      else
         (e+index*EXTENT_SIZE)[i+9]=' ';
   (e+index*EXTENT_SIZE)[12]=d->XL;
   (e+index*EXTENT_SIZE)[13]=d->BC;
   (e+index*EXTENT_SIZE)[14]=d->XH;
   (e+index*EXTENT_SIZE)[15]=d->RC;
   for(i=0;i<16;i++)
      (e+index*EXTENT_SIZE)[i+16]=d->blocks[i];
}

// populate the FreeList global data structure. freeList[i] == true means 
// that block i of the disk is free. block zero is never free, since it holds
// the directory. freeList[i] == false means the block is in use. 
void makeFreeList()
{
   DirStructType *head;
   uint8_t e[1024];
   blockRead(e,0);
   memset(FreeList,1,256);
   FreeList[0]=false;
   for(int index=0;index<32;index++)
   {
      head=mkDirStruct(index,e);
      if (head->status==0xe5)
         continue;
      else 
      {  
         for (int x=0;x<16;x++)
         {
            if(head->blocks[x]>0)
               FreeList[head->blocks[x]]=false;
         }
      }
   }
}
// debugging function, print out the contents of the free list in 16 rows of 16, with each 
// row prefixed by the 2-digit hex address of the first block in that row. Denote a used
// block with a *, a free block with a . 
void printFreeList()
{  
   printf("FREE BLOCK LIST: (* means in-use)" );
   for (int i=0;i<256;i++)
   {  
      if (i%16==0)
         printf("\n%2x:",i);
      if(FreeList[i]==true)
         printf(" .");
      else
         printf(" *");
      
   }
   printf("\n");

}



// internal function, returns -1 for illegal name or name not found
// otherwise returns extent nunber 0-31
int findExtentWithName(char *name, uint8_t *block0)
{     int index;
      char *filename;
      char *extent;
      char namecpy[15];
      DirStructType *head;
      if (checkLegalName(name)==false)
      {
         printf("findExtentWithName:checkLegalName error");
         return -1;
      }
      strcpy(namecpy,name);
      filename=strtok(namecpy,".");
      extent=strtok(NULL,"\0");
      for(index=0;index<32;index++)
      {  
         head=mkDirStruct(index,block0);
         if(head->status==0xe5)//unused
            continue;
         if(strcmp(filename,head->name)==0)
         {  
            if (extent==NULL)
            {
               if(head->extension[0]==0)
                  return index;
               else
                  continue;  
            }
            else
            {
               if(strcmp(extent,head->extension)==0)
                  return index;
               else
                  continue;
            }
         }
         else
            continue;         
      }  
      //printf("cannot find the name or extent\n");
      return -1;
}


            

// internal function, returns true for legal name (8.3 format), false for illegal
// (name or extension too long, name blank, or  illegal charact  ers in name or extension)
bool checkLegalName(char *name)
{  int index;
   char *filename;
   char *extent;
   char namecpy[15];

   strcpy(namecpy,name);
   filename=strtok(namecpy,".");
   extent=strtok(NULL,"\0");
   
   if (strlen(filename)==0)
   {
      printf("1");
      return false;
   }
   if (strlen(filename)>8)
   {
      printf("2");
      return false;
   }
   if (extent!=NULL && strlen(extent)>3){
      printf("3");
      return false;
   }
   for (int i=0; i<strlen(filename); i++)
   {
      if((filename[i]>='0' && filename[i]<='9')|| (filename[i]>='a' && filename[i]<='z') || (filename[i]>='A' && filename[i]<='Z'))
         continue;
      else
         return false;
      
   }
   if (extent!=NULL)
   {
      for (int j=0; j<strlen(extent); j++)
      {
         if((extent[j]>='0' && extent[j]<='9')|| (extent[j]>='a' && extent[j]<='z') || (extent[j]>='A' && extent[j]<='Z'))
            continue;
         else
            return false;
      }
   }
      return true;
}





// print the file directory to stdout. Each filename should be printed on its own line, 
// with the file size, in base 10, following the name and extension, with one space between
// the extension and the size. If a file does not have an extension it is acceptable to print
// the dot anyway, e.g. "myfile. 234" would indicate a file whose name was myfile, with no 
// extension and a size of 234 bytes. This function returns no error codes, since it should
// never fail unless something is seriously wrong with the disk 
void cpmDir()
{  
   int blocknum;
   int size;
   uint8_t block0[1024];

   DirStructType *head;
   blockRead(block0,0);
   printf("DIRECTORY LISTING\n");
   for (int index=0;index<32;index++)
   {  
      blocknum=0;
      head=mkDirStruct(index,block0);
      if (head->status==0xe5)
         continue;
      printf("%s",head->name);
      printf(".");
      printf("%s",head->extension);
      printf(" ");
      for(int i=0;i<16;i++)
      { 
         if(head->blocks[i]!=0)
            blocknum++;
         else
            continue;         
      }
      size=head->RC*128+head->BC+(blocknum-1)*1024;
      printf("%d\n",size);

   }
}
   
   

// error codes for next five functions (not all errors apply to all 5 functions)  
/* 
    0 -- normal completion
   -1 -- source file not found
   -2 -- invalid  filename
   -3 -- dest filename already exists 
   -4 -- insufficient disk space 
*/ 

//read directory block, 
// modify the extent for file named oldName with newName, and write to the disk
int cpmRename(char *oldName, char * newName)
{
   uint8_t block0[1024];
   DirStructType *head;
   int index;
   char *filename;
   char *extent;
   char namecpy[15];
   if (checkLegalName(oldName)==false)
      return -1;
   if (checkLegalName(newName)==false)
      return -2;
   if (findExtentWithName(newName,block0)>0)
      return -3;
   blockRead(block0,0);
   index=findExtentWithName(oldName,block0);
   head=mkDirStruct(index,block0);
   strcpy(namecpy,newName);
   filename=strtok(namecpy,".");
   extent=strtok(NULL,"\0");
   strcpy(head->name,filename);
   //printf("get newName\n");
   if(extent!=NULL)
      strcpy(head->extension,extent);
   else
      strcpy(head->extension,"\0\0\0\0");
   writeDirStruct(head,index,block0);
   blockWrite(block0,0);
   return 0;
}

// delete the file named name, and free its disk blocks in the free list 
int  cpmDelete(char * name)
{     
   uint8_t block0[1024];
   DirStructType *head;
   int index;
   if (checkLegalName(name)==false)
      return -2;
   blockRead(block0,0);  
   index=findExtentWithName(name,block0);
   head=mkDirStruct(index,block0);
   memset(head,0,sizeof(DirStructType));
   head->status=0xe5;
   writeDirStruct(head,index,block0);
   blockWrite(block0,0);
   makeFreeList();
   return 0;

}

// following functions need not be implemented for Lab 2 

//int  cpmCopy(char *oldName, char *newName); 


//int  cpmOpen( char *fileName, char mode); 

// non-zero return indicates filePointer did not point to open file 
//int cpmClose(int filePointer); 

// returns number of bytes read, 0 = error 
//int cpmRead(int pointer, uint8_t *buffer, int size);

// returns number of bytes written, 0 = error 
// int cpmWrite(int pointer, uint8_t *buffer, int size);  

