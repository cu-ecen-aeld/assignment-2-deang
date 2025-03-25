#include <stdio.h>
#include <string.h> // strlen()
#include <fcntl.h> // open()
#include <unistd.h> // write(), close()

int main(int argc, char *argv[])
{
	// Do we have enough commandline arguments?
	// Note that the argument count includes the program name
	// and we need two arguments.  The full path to the file
	// and the content to write to the file.
	if(argc < 3)
	{
		printf("Error: Too few arguments.\n");
		printf("Usage: $ writer <file full path> <content to write>");
		return 1;
	}

	char *writefile=argv[1];
	char *writestring=argv[2];

	// Note that the program must return 1 if the file could not be created.

	// Try to open the file.
	int fd=open(writefile,O_RDWR | O_CREAT | O_TRUNC);
	if(-1 == fd)
	{
		// Note I'm not indicating that the file couldn't be created here.
		// The failure could have been due to insufficient permissions as well.
		printf("Error: open failed.");
		return 1;
	}

	// Success!


	// Try to write the file.  Note that write can do partial writes.

	int writeoffset = 0,writelen = strlen(writestring);	

	while(writeoffset<writelen)
	{
		int writeret=write(fd,writestring + writeoffset,writelen - writeoffset);
		if(writeret == -1)
		{
			printf("Error: write failed.\n");
			break;
		}

		writeoffset+=writeret;
	}


	close(fd);

	return 0;
}
