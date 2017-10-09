#include <stdio.h>

void cmd_pack_unpack()
{
    int src;
    int dst;

    printf( "=== Pack ===\n" );
    src = 0x2000;
    dst = 0x4000;
    while( src < 0x4000 )
    {
//      printf( "$%04X .. $%04X -> $%04X\n", src, src+0x77, dst );
        printf( "%04X<%04X.%04XM\n", dst, src, src+0x77 );
        src += 0x80;
        dst += 0x78;
    }

    printf( "=== Pack ===\n" );
    src = 0x4000;
    dst = 0x2000;
    while( src < 0x5E00 )
    {
//      printf( "$04X\n", src );
        printf( "%04X<%04X.%04XM\n", dst, src, src+0x77 );
        src += 0x80;
        dst += 0x78;
    }
}

int main()
{
    cmd_pack_unpack();
    return 0;
}

