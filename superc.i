# 1 "superc.c"
# 1 "<built-in>"
# 1 "<command line>"
# 1 "superc.c"
# 13 "superc.c"
# 1 "/usr/include/stdio.h" 1 3 4
# 28 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 295 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 296 "/usr/include/features.h" 2 3 4
# 318 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4
# 319 "/usr/include/features.h" 2 3 4
# 29 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 1 3 4
# 213 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 3 4
typedef unsigned int size_t;
# 35 "/usr/include/stdio.h" 2 3 4

# 1 "/usr/include/bits/types.h" 1 3 4
# 28 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4


# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 1 3 4
# 32 "/usr/include/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;




__extension__ typedef signed long long int __int64_t;
__extension__ typedef unsigned long long int __uint64_t;







__extension__ typedef long long int __quad_t;
__extension__ typedef unsigned long long int __u_quad_t;
# 129 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 130 "/usr/include/bits/types.h" 2 3 4






__extension__ typedef unsigned long long int __dev_t;
__extension__ typedef unsigned int __uid_t;
__extension__ typedef unsigned int __gid_t;
__extension__ typedef unsigned long int __ino_t;
__extension__ typedef unsigned long long int __ino64_t;
__extension__ typedef unsigned int __mode_t;
__extension__ typedef unsigned int __nlink_t;
__extension__ typedef long int __off_t;
__extension__ typedef long long int __off64_t;
__extension__ typedef int __pid_t;
__extension__ typedef struct { int __val[2]; } __fsid_t;
__extension__ typedef long int __clock_t;
__extension__ typedef unsigned long int __rlim_t;
__extension__ typedef unsigned long long int __rlim64_t;
__extension__ typedef unsigned int __id_t;
__extension__ typedef long int __time_t;
__extension__ typedef unsigned int __useconds_t;
__extension__ typedef long int __suseconds_t;

__extension__ typedef int __daddr_t;
__extension__ typedef long int __swblk_t;
__extension__ typedef int __key_t;


__extension__ typedef int __clockid_t;


__extension__ typedef int __timer_t;


__extension__ typedef long int __blksize_t;




__extension__ typedef long int __blkcnt_t;
__extension__ typedef long long int __blkcnt64_t;


__extension__ typedef unsigned long int __fsblkcnt_t;
__extension__ typedef unsigned long long int __fsblkcnt64_t;


__extension__ typedef unsigned long int __fsfilcnt_t;
__extension__ typedef unsigned long long int __fsfilcnt64_t;

__extension__ typedef int __ssize_t;



typedef __off64_t __loff_t;
typedef __quad_t *__qaddr_t;
typedef char *__caddr_t;


__extension__ typedef int __intptr_t;


__extension__ typedef unsigned int __socklen_t;
# 37 "/usr/include/stdio.h" 2 3 4









typedef struct _IO_FILE FILE;





# 62 "/usr/include/stdio.h" 3 4
typedef struct _IO_FILE __FILE;
# 72 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/libio.h" 1 3 4
# 32 "/usr/include/libio.h" 3 4
# 1 "/usr/include/_G_config.h" 1 3 4
# 14 "/usr/include/_G_config.h" 3 4
# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 1 3 4
# 325 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 3 4
typedef long int wchar_t;
# 354 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 3 4
typedef unsigned int wint_t;
# 15 "/usr/include/_G_config.h" 2 3 4
# 24 "/usr/include/_G_config.h" 3 4
# 1 "/usr/include/wchar.h" 1 3 4
# 48 "/usr/include/wchar.h" 3 4
# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 1 3 4
# 49 "/usr/include/wchar.h" 2 3 4

# 1 "/usr/include/bits/wchar.h" 1 3 4
# 51 "/usr/include/wchar.h" 2 3 4
# 76 "/usr/include/wchar.h" 3 4
typedef struct
{
  int __count;
  union
  {
    wint_t __wch;
    char __wchb[4];
  } __value;
} __mbstate_t;
# 25 "/usr/include/_G_config.h" 2 3 4

typedef struct
{
  __off_t __pos;
  __mbstate_t __state;
} _G_fpos_t;
typedef struct
{
  __off64_t __pos;
  __mbstate_t __state;
} _G_fpos64_t;
# 44 "/usr/include/_G_config.h" 3 4
# 1 "/usr/include/gconv.h" 1 3 4
# 28 "/usr/include/gconv.h" 3 4
# 1 "/usr/include/wchar.h" 1 3 4
# 48 "/usr/include/wchar.h" 3 4
# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 1 3 4
# 49 "/usr/include/wchar.h" 2 3 4
# 29 "/usr/include/gconv.h" 2 3 4


# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 1 3 4
# 32 "/usr/include/gconv.h" 2 3 4





enum
{
  __GCONV_OK = 0,
  __GCONV_NOCONV,
  __GCONV_NODB,
  __GCONV_NOMEM,

  __GCONV_EMPTY_INPUT,
  __GCONV_FULL_OUTPUT,
  __GCONV_ILLEGAL_INPUT,
  __GCONV_INCOMPLETE_INPUT,

  __GCONV_ILLEGAL_DESCRIPTOR,
  __GCONV_INTERNAL_ERROR
};



enum
{
  __GCONV_IS_LAST = 0x0001,
  __GCONV_IGNORE_ERRORS = 0x0002
};



struct __gconv_step;
struct __gconv_step_data;
struct __gconv_loaded_object;
struct __gconv_trans_data;



typedef int (*__gconv_fct) (struct __gconv_step *, struct __gconv_step_data *,
                            __const unsigned char **, __const unsigned char *,
                            unsigned char **, size_t *, int, int);


typedef wint_t (*__gconv_btowc_fct) (struct __gconv_step *, unsigned char);


typedef int (*__gconv_init_fct) (struct __gconv_step *);
typedef void (*__gconv_end_fct) (struct __gconv_step *);



typedef int (*__gconv_trans_fct) (struct __gconv_step *,
                                  struct __gconv_step_data *, void *,
                                  __const unsigned char *,
                                  __const unsigned char **,
                                  __const unsigned char *, unsigned char **,
                                  size_t *);


typedef int (*__gconv_trans_context_fct) (void *, __const unsigned char *,
                                          __const unsigned char *,
                                          unsigned char *, unsigned char *);


typedef int (*__gconv_trans_query_fct) (__const char *, __const char ***,
                                        size_t *);


typedef int (*__gconv_trans_init_fct) (void **, const char *);
typedef void (*__gconv_trans_end_fct) (void *);

struct __gconv_trans_data
{

  __gconv_trans_fct __trans_fct;
  __gconv_trans_context_fct __trans_context_fct;
  __gconv_trans_end_fct __trans_end_fct;
  void *__data;
  struct __gconv_trans_data *__next;
};



struct __gconv_step
{
  struct __gconv_loaded_object *__shlib_handle;
  __const char *__modname;

  int __counter;

  char *__from_name;
  char *__to_name;

  __gconv_fct __fct;
  __gconv_btowc_fct __btowc_fct;
  __gconv_init_fct __init_fct;
  __gconv_end_fct __end_fct;



  int __min_needed_from;
  int __max_needed_from;
  int __min_needed_to;
  int __max_needed_to;


  int __stateful;

  void *__data;
};



struct __gconv_step_data
{
  unsigned char *__outbuf;
  unsigned char *__outbufend;



  int __flags;



  int __invocation_counter;



  int __internal_use;

  __mbstate_t *__statep;
  __mbstate_t __state;



  struct __gconv_trans_data *__trans;
};



typedef struct __gconv_info
{
  size_t __nsteps;
  struct __gconv_step *__steps;
  __extension__ struct __gconv_step_data __data [];
} *__gconv_t;
# 45 "/usr/include/_G_config.h" 2 3 4
typedef union
{
  struct __gconv_info __cd;
  struct
  {
    struct __gconv_info __cd;
    struct __gconv_step_data __data;
  } __combined;
} _G_iconv_t;

typedef int _G_int16_t __attribute__ ((__mode__ (__HI__)));
typedef int _G_int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int _G_uint16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int _G_uint32_t __attribute__ ((__mode__ (__SI__)));
# 33 "/usr/include/libio.h" 2 3 4
# 53 "/usr/include/libio.h" 3 4
# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stdarg.h" 1 3 4
# 43 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 54 "/usr/include/libio.h" 2 3 4
# 163 "/usr/include/libio.h" 3 4
struct _IO_jump_t; struct _IO_FILE;
# 173 "/usr/include/libio.h" 3 4
typedef void _IO_lock_t;





struct _IO_marker {
  struct _IO_marker *_next;
  struct _IO_FILE *_sbuf;



  int _pos;
# 196 "/usr/include/libio.h" 3 4
};


enum __codecvt_result
{
  __codecvt_ok,
  __codecvt_partial,
  __codecvt_error,
  __codecvt_noconv
};
# 264 "/usr/include/libio.h" 3 4
struct _IO_FILE {
  int _flags;




  char* _IO_read_ptr;
  char* _IO_read_end;
  char* _IO_read_base;
  char* _IO_write_base;
  char* _IO_write_ptr;
  char* _IO_write_end;
  char* _IO_buf_base;
  char* _IO_buf_end;

  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;



  int _flags2;

  __off_t _old_offset;



  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];



  _IO_lock_t *_lock;
# 312 "/usr/include/libio.h" 3 4
  __off64_t _offset;





  void *__pad1;
  void *__pad2;

  int _mode;

  char _unused2[15 * sizeof (int) - 2 * sizeof (void *)];

};


typedef struct _IO_FILE _IO_FILE;


struct _IO_FILE_plus;

extern struct _IO_FILE_plus _IO_2_1_stdin_;
extern struct _IO_FILE_plus _IO_2_1_stdout_;
extern struct _IO_FILE_plus _IO_2_1_stderr_;
# 351 "/usr/include/libio.h" 3 4
typedef __ssize_t __io_read_fn (void *__cookie, char *__buf, size_t __nbytes);







typedef __ssize_t __io_write_fn (void *__cookie, __const char *__buf,
                                 size_t __n);







typedef int __io_seek_fn (void *__cookie, __off64_t *__pos, int __w);


typedef int __io_close_fn (void *__cookie);
# 403 "/usr/include/libio.h" 3 4
extern int __underflow (_IO_FILE *) ;
extern int __uflow (_IO_FILE *) ;
extern int __overflow (_IO_FILE *, int) ;
extern wint_t __wunderflow (_IO_FILE *) ;
extern wint_t __wuflow (_IO_FILE *) ;
extern wint_t __woverflow (_IO_FILE *, wint_t) ;
# 433 "/usr/include/libio.h" 3 4
extern int _IO_getc (_IO_FILE *__fp) ;
extern int _IO_putc (int __c, _IO_FILE *__fp) ;
extern int _IO_feof (_IO_FILE *__fp) ;
extern int _IO_ferror (_IO_FILE *__fp) ;

extern int _IO_peekc_locked (_IO_FILE *__fp) ;





extern void _IO_flockfile (_IO_FILE *) ;
extern void _IO_funlockfile (_IO_FILE *) ;
extern int _IO_ftrylockfile (_IO_FILE *) ;
# 463 "/usr/include/libio.h" 3 4
extern int _IO_vfscanf (_IO_FILE * __restrict, const char * __restrict,
                        __gnuc_va_list, int *__restrict) ;
extern int _IO_vfprintf (_IO_FILE *__restrict, const char *__restrict,
                         __gnuc_va_list) ;
extern __ssize_t _IO_padn (_IO_FILE *, int, __ssize_t) ;
extern size_t _IO_sgetn (_IO_FILE *, void *, size_t) ;

extern __off64_t _IO_seekoff (_IO_FILE *, __off64_t, int, int) ;
extern __off64_t _IO_seekpos (_IO_FILE *, __off64_t, int) ;

extern void _IO_free_backup_area (_IO_FILE *) ;
# 73 "/usr/include/stdio.h" 2 3 4
# 86 "/usr/include/stdio.h" 3 4


typedef _G_fpos_t fpos_t;




# 138 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 139 "/usr/include/stdio.h" 2 3 4



extern struct _IO_FILE *stdin;
extern struct _IO_FILE *stdout;
extern struct _IO_FILE *stderr;







extern int remove (__const char *__filename) ;

extern int rename (__const char *__old, __const char *__new) ;









extern FILE *tmpfile (void);
# 178 "/usr/include/stdio.h" 3 4
extern char *tmpnam (char *__s) ;

# 201 "/usr/include/stdio.h" 3 4





extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);

# 235 "/usr/include/stdio.h" 3 4






extern FILE *fopen (__const char *__restrict __filename,
                    __const char *__restrict __modes);




extern FILE *freopen (__const char *__restrict __filename,
                      __const char *__restrict __modes,
                      FILE *__restrict __stream);
# 262 "/usr/include/stdio.h" 3 4

# 294 "/usr/include/stdio.h" 3 4



extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) ;



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
                    int __modes, size_t __n) ;

# 316 "/usr/include/stdio.h" 3 4





extern int fprintf (FILE *__restrict __stream,
                    __const char *__restrict __format, ...);




extern int printf (__const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
                    __const char *__restrict __format, ...) ;





extern int vfprintf (FILE *__restrict __s, __const char *__restrict __format,
                     __gnuc_va_list __arg);




extern int vprintf (__const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, __const char *__restrict __format,
                     __gnuc_va_list __arg) ;





extern int snprintf (char *__restrict __s, size_t __maxlen,
                     __const char *__restrict __format, ...)
     __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
                      __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 3, 0)));

# 388 "/usr/include/stdio.h" 3 4





extern int fscanf (FILE *__restrict __stream,
                   __const char *__restrict __format, ...);




extern int scanf (__const char *__restrict __format, ...);

extern int sscanf (__const char *__restrict __s,
                   __const char *__restrict __format, ...) ;








extern int vfscanf (FILE *__restrict __s, __const char *__restrict __format,
                    __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0)));





extern int vscanf (__const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0)));


extern int vsscanf (__const char *__restrict __s,
                    __const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0)));









extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);

# 469 "/usr/include/stdio.h" 3 4








extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);

# 521 "/usr/include/stdio.h" 3 4





extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream);






extern char *gets (char *__s);

# 578 "/usr/include/stdio.h" 3 4





extern int fputs (__const char *__restrict __s, FILE *__restrict __stream);





extern int puts (__const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
                     size_t __n, FILE *__restrict __stream);




extern size_t fwrite (__const void *__restrict __ptr, size_t __size,
                      size_t __n, FILE *__restrict __s);

# 638 "/usr/include/stdio.h" 3 4





extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream);




extern void rewind (FILE *__stream);

# 686 "/usr/include/stdio.h" 3 4






extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos);




extern int fsetpos (FILE *__stream, __const fpos_t *__pos);
# 709 "/usr/include/stdio.h" 3 4

# 718 "/usr/include/stdio.h" 3 4


extern void clearerr (FILE *__stream) ;

extern int feof (FILE *__stream) ;

extern int ferror (FILE *__stream) ;

# 735 "/usr/include/stdio.h" 3 4





extern void perror (__const char *__s);






# 1 "/usr/include/bits/sys_errlist.h" 1 3 4
# 748 "/usr/include/stdio.h" 2 3 4
# 831 "/usr/include/stdio.h" 3 4

# 14 "superc.c" 2
# 1 "/usr/include/stdlib.h" 1 3 4
# 33 "/usr/include/stdlib.h" 3 4
# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 1 3 4
# 34 "/usr/include/stdlib.h" 2 3 4


# 93 "/usr/include/stdlib.h" 3 4


typedef struct
  {
    int quot;
    int rem;
  } div_t;



typedef struct
  {
    long int quot;
    long int rem;
  } ldiv_t;







__extension__ typedef struct
  {
    long long int quot;
    long long int rem;
  } lldiv_t;


# 137 "/usr/include/stdlib.h" 3 4
extern size_t __ctype_get_mb_cur_max (void) ;




extern double atof (__const char *__nptr) __attribute__ ((__pure__));

extern int atoi (__const char *__nptr) __attribute__ ((__pure__));

extern long int atol (__const char *__nptr) __attribute__ ((__pure__));





__extension__ extern long long int atoll (__const char *__nptr)
     __attribute__ ((__pure__));





extern double strtod (__const char *__restrict __nptr,
                      char **__restrict __endptr) ;





extern float strtof (__const char *__restrict __nptr,
                     char **__restrict __endptr) ;

extern long double strtold (__const char *__restrict __nptr,
                            char **__restrict __endptr) ;





extern long int strtol (__const char *__restrict __nptr,
                        char **__restrict __endptr, int __base) ;

extern unsigned long int strtoul (__const char *__restrict __nptr,
                                  char **__restrict __endptr, int __base)
     ;

# 197 "/usr/include/stdlib.h" 3 4


__extension__
extern long long int strtoll (__const char *__restrict __nptr,
                              char **__restrict __endptr, int __base) ;

__extension__
extern unsigned long long int strtoull (__const char *__restrict __nptr,
                                        char **__restrict __endptr, int __base)
     ;

# 264 "/usr/include/stdlib.h" 3 4
extern double __strtod_internal (__const char *__restrict __nptr,
                                 char **__restrict __endptr, int __group)
     ;
extern float __strtof_internal (__const char *__restrict __nptr,
                                char **__restrict __endptr, int __group)
     ;
extern long double __strtold_internal (__const char *__restrict __nptr,
                                       char **__restrict __endptr,
                                       int __group) ;

extern long int __strtol_internal (__const char *__restrict __nptr,
                                   char **__restrict __endptr,
                                   int __base, int __group) ;



extern unsigned long int __strtoul_internal (__const char *__restrict __nptr,
                                             char **__restrict __endptr,
                                             int __base, int __group) ;




__extension__
extern long long int __strtoll_internal (__const char *__restrict __nptr,
                                         char **__restrict __endptr,
                                         int __base, int __group) ;



__extension__
extern unsigned long long int __strtoull_internal (__const char *
                                                   __restrict __nptr,
                                                   char **__restrict __endptr,
                                                   int __base, int __group)
     ;
# 471 "/usr/include/stdlib.h" 3 4


extern int rand (void) ;

extern void srand (unsigned int __seed) ;

# 554 "/usr/include/stdlib.h" 3 4


extern void *malloc (size_t __size) __attribute__ ((__malloc__));

extern void *calloc (size_t __nmemb, size_t __size)
     __attribute__ ((__malloc__));







extern void *realloc (void *__ptr, size_t __size) __attribute__ ((__malloc__));

extern void free (void *__ptr) ;

# 592 "/usr/include/stdlib.h" 3 4


extern void abort (void) __attribute__ ((__noreturn__));



extern int atexit (void (*__func) (void)) ;

# 608 "/usr/include/stdlib.h" 3 4




extern void exit (int __status) __attribute__ ((__noreturn__));






extern void _Exit (int __status) __attribute__ ((__noreturn__));






extern char *getenv (__const char *__name) ;




extern char *__secure_getenv (__const char *__name) ;
# 697 "/usr/include/stdlib.h" 3 4





extern int system (__const char *__command);

# 728 "/usr/include/stdlib.h" 3 4
typedef int (*__compar_fn_t) (__const void *, __const void *);









extern void *bsearch (__const void *__key, __const void *__base,
                      size_t __nmemb, size_t __size, __compar_fn_t __compar);



extern void qsort (void *__base, size_t __nmemb, size_t __size,
                   __compar_fn_t __compar);



extern int abs (int __x) __attribute__ ((__const__));
extern long int labs (long int __x) __attribute__ ((__const__));



__extension__ extern long long int llabs (long long int __x)
     __attribute__ ((__const__));







extern div_t div (int __numer, int __denom)
     __attribute__ ((__const__));
extern ldiv_t ldiv (long int __numer, long int __denom)
     __attribute__ ((__const__));




__extension__ extern lldiv_t lldiv (long long int __numer,
                                    long long int __denom)
     __attribute__ ((__const__));

# 827 "/usr/include/stdlib.h" 3 4



extern int mblen (__const char *__s, size_t __n) ;


extern int mbtowc (wchar_t *__restrict __pwc,
                   __const char *__restrict __s, size_t __n) ;


extern int wctomb (char *__s, wchar_t __wchar) ;



extern size_t mbstowcs (wchar_t *__restrict __pwcs,
                        __const char *__restrict __s, size_t __n) ;

extern size_t wcstombs (char *__restrict __s,
                        __const wchar_t *__restrict __pwcs, size_t __n)
     ;

# 922 "/usr/include/stdlib.h" 3 4

# 15 "superc.c" 2
# 1 "/usr/include/string.h" 1 3 4
# 28 "/usr/include/string.h" 3 4





# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stddef.h" 1 3 4
# 34 "/usr/include/string.h" 2 3 4




extern void *memcpy (void *__restrict __dest,
                     __const void *__restrict __src, size_t __n) ;


extern void *memmove (void *__dest, __const void *__src, size_t __n)
     ;

# 56 "/usr/include/string.h" 3 4


extern void *memset (void *__s, int __c, size_t __n) ;


extern int memcmp (__const void *__s1, __const void *__s2, size_t __n)
     __attribute__ ((__pure__));


extern void *memchr (__const void *__s, int __c, size_t __n)
      __attribute__ ((__pure__));

# 80 "/usr/include/string.h" 3 4


extern char *strcpy (char *__restrict __dest, __const char *__restrict __src)
     ;

extern char *strncpy (char *__restrict __dest,
                      __const char *__restrict __src, size_t __n) ;


extern char *strcat (char *__restrict __dest, __const char *__restrict __src)
     ;

extern char *strncat (char *__restrict __dest, __const char *__restrict __src,
                      size_t __n) ;


extern int strcmp (__const char *__s1, __const char *__s2)
     __attribute__ ((__pure__));

extern int strncmp (__const char *__s1, __const char *__s2, size_t __n)
     __attribute__ ((__pure__));


extern int strcoll (__const char *__s1, __const char *__s2)
     __attribute__ ((__pure__));

extern size_t strxfrm (char *__restrict __dest,
                       __const char *__restrict __src, size_t __n) ;

# 160 "/usr/include/string.h" 3 4


extern char *strchr (__const char *__s, int __c) __attribute__ ((__pure__));

extern char *strrchr (__const char *__s, int __c) __attribute__ ((__pure__));











extern size_t strcspn (__const char *__s, __const char *__reject)
     __attribute__ ((__pure__));


extern size_t strspn (__const char *__s, __const char *__accept)
     __attribute__ ((__pure__));

extern char *strpbrk (__const char *__s, __const char *__accept)
     __attribute__ ((__pure__));

extern char *strstr (__const char *__haystack, __const char *__needle)
     __attribute__ ((__pure__));



extern char *strtok (char *__restrict __s, __const char *__restrict __delim)
     ;




extern char *__strtok_r (char *__restrict __s,
                         __const char *__restrict __delim,
                         char **__restrict __save_ptr) ;
# 228 "/usr/include/string.h" 3 4


extern size_t strlen (__const char *__s) __attribute__ ((__pure__));

# 241 "/usr/include/string.h" 3 4


extern char *strerror (int __errnum) ;

# 253 "/usr/include/string.h" 3 4
extern void __bzero (void *__s, size_t __n) ;
# 379 "/usr/include/string.h" 3 4

# 16 "superc.c" 2
# 1 "/usr/include/ctype.h" 1 3 4
# 30 "/usr/include/ctype.h" 3 4

# 41 "/usr/include/ctype.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 37 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 38 "/usr/include/endian.h" 2 3 4
# 42 "/usr/include/ctype.h" 2 3 4






enum
{
  _ISupper = ((0) < 8 ? ((1 << (0)) << 8) : ((1 << (0)) >> 8)),
  _ISlower = ((1) < 8 ? ((1 << (1)) << 8) : ((1 << (1)) >> 8)),
  _ISalpha = ((2) < 8 ? ((1 << (2)) << 8) : ((1 << (2)) >> 8)),
  _ISdigit = ((3) < 8 ? ((1 << (3)) << 8) : ((1 << (3)) >> 8)),
  _ISxdigit = ((4) < 8 ? ((1 << (4)) << 8) : ((1 << (4)) >> 8)),
  _ISspace = ((5) < 8 ? ((1 << (5)) << 8) : ((1 << (5)) >> 8)),
  _ISprint = ((6) < 8 ? ((1 << (6)) << 8) : ((1 << (6)) >> 8)),
  _ISgraph = ((7) < 8 ? ((1 << (7)) << 8) : ((1 << (7)) >> 8)),
  _ISblank = ((8) < 8 ? ((1 << (8)) << 8) : ((1 << (8)) >> 8)),
  _IScntrl = ((9) < 8 ? ((1 << (9)) << 8) : ((1 << (9)) >> 8)),
  _ISpunct = ((10) < 8 ? ((1 << (10)) << 8) : ((1 << (10)) >> 8)),
  _ISalnum = ((11) < 8 ? ((1 << (11)) << 8) : ((1 << (11)) >> 8))
};
# 81 "/usr/include/ctype.h" 3 4
extern __const unsigned short int **__ctype_b_loc (void)
     __attribute__ ((__const));
extern __const __int32_t **__ctype_tolower_loc (void)
     __attribute__ ((__const));
extern __const __int32_t **__ctype_toupper_loc (void)
     __attribute__ ((__const));
# 96 "/usr/include/ctype.h" 3 4






extern int isalnum (int) ;
extern int isalpha (int) ;
extern int iscntrl (int) ;
extern int isdigit (int) ;
extern int islower (int) ;
extern int isgraph (int) ;
extern int isprint (int) ;
extern int ispunct (int) ;
extern int isspace (int) ;
extern int isupper (int) ;
extern int isxdigit (int) ;



extern int tolower (int __c) ;


extern int toupper (int __c) ;








extern int isblank (int) ;


# 323 "/usr/include/ctype.h" 3 4

# 17 "superc.c" 2
# 1 "/usr/lib/gcc-lib/i486-linux/3.3.3/include/stdbool.h" 1 3 4
# 18 "superc.c" 2

enum Token {
    IF = 256,
    ELSE,
    WHILE,
    DO,
    BREAK,
    TrueToken,
    FalseToken
};




static char* parseString;
static int i = 0;
static int lookahead;
static int numGlobals = 0;
static char* globalNames[256];





void RegisterGlobal(char *name)
{

    for (int i = 0; i < numGlobals; ++i) {
        if (strcmp(globalNames[i], name) == 0) return;
    }


    globalNames[numGlobals] = name;
    ++numGlobals;
}

void* SafeMalloc(int n)
{
    void *result;
    result = malloc(n);
    if (result == ((void *)0)) {
        fprintf(stderr, "SafeMalloc: out of memory\n");
        abort();
    }

    return result;
}


void *GcMalloc(int n)
{
    return SafeMalloc(n);
}

char *GcStrDup(char *s)
{
    char *newString = GcMalloc(strlen(s) + 1);
    strcpy(newString, s);
    return newString;
}




static int labelNum = 0;

char *NewLabel()
{
    ++labelNum;
    char label[256];
    sprintf(label, ".L%d", labelNum);

    return GcStrDup(label);
}




void Emit(char *s)
{
    printf("\t%s", s);
}




void EmitLn(char *s)
{
   Emit(s);
   printf("\n");
}

void EmitLabel(char *label)
{
    printf("%s:\n", label);
}




void EmitOp1(char *instruction, char *p1)
{
    char op[256];
    sprintf(op, "%s\t%s\n", instruction, p1);
    Emit(op);
}





struct Keyword {
    char *keyword;
    int keywordLength;
    enum Token token;
};



struct Keyword keywords[] = {
    {"if", strlen("if"), IF},
    {"else", strlen("else"), ELSE},
    {"while", strlen("while"), WHILE},
    {"do", strlen("do"), DO},
    {"break", strlen("break"), BREAK},
    {"true", strlen("true"), TrueToken},
    {"false", strlen("false"), FalseToken},
};







void GetChar(void)
{


    _Bool found = 0;
    for (int i = 0; i < (sizeof(keywords)/sizeof(*keywords)); ++i) {
        if (strncmp(parseString+i, keywords[i].keyword,
                    keywords[i].keywordLength) == 0)
        {
            lookahead = keywords[i].token;
            i += keywords[i].keywordLength;
            found = 1;
            break;
        }
    }

    if (!found) {
        lookahead = parseString[i];
        ++i;
    }
}


void EatWhite(void)
{
    while (((*__ctype_b_loc ())[(int) ((lookahead))] & (unsigned short int) _ISspace)) {
        GetChar();
    }
}




void Error(char *s)
{
    fprintf(stderr, "Error: %s (position %d).\n", s, i);
}




void Abort(char *s) __attribute__ ((noreturn));

void Abort(char *s)
{
    Error(s);
    exit(1);
}




void Expected(char *s) __attribute__ ((noreturn));
void Expected(char *s)
{
    const char *e = " expected";
    char *newString = GcMalloc(strlen(s) + strlen(e) + 1);
    strcpy(newString, s);
    strcat(newString, e);

    Abort(newString);
}




void Match(int c)
{
    if (lookahead == c) {
        GetChar();
        EatWhite();
    }
    else if (c == '\0') {
        Expected("End of stream");
    }
    else {
        char s[] = "'_'";
        s[1] = c;
        Expected(s);
    }
}




char* GetName()
{
    if (!((*__ctype_b_loc ())[(int) ((lookahead))] & (unsigned short int) _ISalpha)) Expected("Name");

    char name[256];
    int i = 0;

    while (((*__ctype_b_loc ())[(int) ((lookahead))] & (unsigned short int) _ISalnum)) {
       name[i++] = lookahead;
       GetChar();
    }
    name[i++] = '\0';
    EatWhite();


    char *result = GcMalloc(i);
    strcpy(result, name);
    return result;
}




char* GetNum()
{
    if (!((*__ctype_b_loc ())[(int) ((lookahead))] & (unsigned short int) _ISdigit)) Expected("Integer");

    char value[256];
    int i = 0;

    while (((*__ctype_b_loc ())[(int) ((lookahead))] & (unsigned short int) _ISdigit)) {
       value[i++] = lookahead;
       GetChar();
    }
    value [i++] = '\0';
    EatWhite();


    char *result = GcMalloc(i);
    strcpy(result, value);
    return result;
}


_Bool GetBoolean()
{
    if (lookahead == TrueToken) {
        return 1;
    }
    else if (lookahead == FalseToken) {
        return 0;
    }
    else {
        Expected("Boolean literal");
    }
}





void Init(char *s)
{
    parseString = s;
    GetChar();
    EatWhite();
}
# 316 "superc.c"
void Factor(void)
{
    void Expression(void);

    if (lookahead == '(') {
        Match('(');
        Expression();
        Match(')');
    }
    else if (((*__ctype_b_loc ())[(int) ((lookahead))] & (unsigned short int) _ISalpha)) {
        char *name = GetName();
        if (lookahead == '(') {

            Match('(');

            char s[256];
            sprintf(s, "call\t%s", name);
            EmitLn(s);
            Match(')');
        }
        else {

            char s[256];
            sprintf(s, "movl\t%s, %%eax", name);
            EmitLn(s);
            RegisterGlobal(name);
        }
    }
    else {
        char s[256];
        sprintf(s, "movl\t$%s, %%eax", GetNum());
        EmitLn(s);
    }
}


void Multiply(void)
{
    Match('*');
    Factor();
    EmitLn("popl\t%ebx");
    EmitLn("imul\t%ebx,%eax");
}


void Divide(void)
{
    Match('/');
    Factor();
    EmitLn("movl\t%eax,%ebx");
    EmitLn("popl\t%eax");
    EmitLn("cltd");
    EmitLn("idiv\t%ebx,%eax");
}




void Term(void)
{
    Factor();
    while (lookahead == '*' || lookahead == '/') {
        EmitLn("push\t%eax");
        switch (lookahead) {
            case '*': Multiply(); break;
            case '/': Divide(); break;
        };
    }
}




void Add(void)
{
    Match('+');
    Term();
    EmitLn("popl\t%ebx");
    EmitLn("addl\t%ebx,%eax");
}




void Subtract(void)
{
    Match('-');
    Term();
    EmitLn("popl\t%ebx");
    EmitLn("subl\t%ebx,%eax");
    EmitLn("negl\t%eax");
}


_Bool IsAddOp()
{
    return lookahead == '+' || lookahead == '-';
}




void Expression(void)
{
    if (IsAddOp(lookahead)) {
        EmitLn("movl\t$0,%eax");
    }
    else Term();

    while (IsAddOp(lookahead)) {
        EmitLn("push\t%eax");
        switch (lookahead) {
            case '+': Add(); break;
            case '-': Subtract(); break;
        }
    }

}


void Assignment(void)
{
    char *name = GetName();
    RegisterGlobal(name);
    Match('=');
    Expression();
    char op[256];
    sprintf(op, "movl %%eax, %s", name);
    EmitLn(op);
}


void If(char *innermostLoopLabel)
{
    void Statement(char *innermostLoopLabel);

    Match(IF);
    char *label1 = NewLabel();
    char *label2 = label1;

    Expression();


    {
        char op[256];
        sprintf(op, "je\t%s\n", label1);
        Emit(op);
    }
    Statement(innermostLoopLabel);

    if (lookahead == ELSE) {
        Match(ELSE);
        label2 = NewLabel();
        {
            char op[256];
            sprintf(op, "jmp\t%s", label2);
            EmitLn(op);
        }
        EmitLabel(label1);
        Statement(innermostLoopLabel);
    }

    EmitLabel(label2);
}


void While()
{
    void Statement(char *innermostLoopLabel);

    Match(WHILE);
    char *conditionLabel = NewLabel();
    EmitLabel(conditionLabel);

    Expression();

    char *endLabel = NewLabel();

    EmitOp1("je", endLabel);
    Statement(endLabel);
    EmitOp1("jmp", conditionLabel);
    EmitLabel(endLabel);
}


void DoWhile()
{
    void Statement(char *innermostLoopLabel);

    Match(DO);
    char *startLabel = NewLabel();
    char *endLabel = NewLabel();
    EmitLabel(startLabel);
    Statement(endLabel);
    Match(WHILE);
    Expression();
    EmitOp1("jne", startLabel);
    EmitLabel(endLabel);
}


void Break(char* innermostLoopLabel)
{
    Match(BREAK);
    if (innermostLoopLabel == ((void *)0)) {
        Abort("break statement not within loop");
    }
    EmitOp1("jmp", innermostLoopLabel);
}


void Statement(char* innermostLoopLabel)
{
    void Block(char *innermostLoopLabel);

    if (lookahead == '{') {
        Block(innermostLoopLabel);
    }
    else if (lookahead == IF) {
        If(innermostLoopLabel);
    }
    else if (lookahead == WHILE) {
        While();
    }
    else if (lookahead == DO) {
        DoWhile();
    }
    else if (lookahead == BREAK) {
        Break(innermostLoopLabel);
    }
    else {
        Assignment();
    }
}

void Statements(char *innermostLoopLabel)
{
    while (lookahead == IF || lookahead == WHILE ||
           lookahead == DO || lookahead == BREAK ||
           ((*__ctype_b_loc ())[(int) ((lookahead))] & (unsigned short int) _ISalpha))
    {
        Statement(innermostLoopLabel);
    }
}


void Block(char *innermostLoopLabel)
{
    Match('{');
    Statements(innermostLoopLabel);
    Match('}');
}


void EmitFunctionPreamble(char *name)
{
    printf(".globl %s\n", name);
    printf("\t.type\t%s, @function\n", name);
    printf("%s:\n", name);


    EmitLn("pushl\t%ebp");
    EmitLn("movl\t%esp, %ebp");
}


void EmitFunctionPostamble(char *name)
{
    EmitLn("pop\t%ebp");
    EmitLn("ret");
    {
        char op[256];
        sprintf(op, ".size\t%s, .-%s", name, name);
        EmitLn(op);
    }

}


void EmitGlobalVariableDefinitions(void)
{
    for (int i = 0; i < numGlobals; ++i) {
        char op[256];
        sprintf(op, ".comm\t%s,4,4", globalNames[i]);
        EmitLn(op);
    }
}


void Top(void)
{
    EmitFunctionPreamble("expression");

    if (lookahead == '{') {
        Block(((void *)0));
    }
    else {
        Statements(((void *)0));
    }

    EmitFunctionPostamble("expression");
    EmitGlobalVariableDefinitions();

    Match('\0');
}




int main(int argc, char*argv[])
{
    if (argc != 2) {
        fprintf(stderr, "usage: superc \"<expression>\"\n");
        exit(2);
    }
    Init(argv[1]);
    Top();

    return 0;
}
