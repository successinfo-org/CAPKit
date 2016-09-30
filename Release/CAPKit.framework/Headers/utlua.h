#include <lua53/lua.h>

lua_State* utlua_open_state();
lua_State* utlua_newthread(lua_State *L);
int utlua_resume(lua_State *co, lua_State *from, int count);

lua_State* utlua_mainthread(lua_State *L);

void d2tv(double x, struct timeval *tv);

LUALIB_API int secure_loadfile (lua_State *L, const char *filename,
                                const char *mode);
