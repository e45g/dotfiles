#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
    XEvent e;

    Display *display = XOpenDisplay(NULL);
    if (display == NULL) {
        fprintf(stderr, "Cannot open display\n");
        exit(1);
    }

    int screen = DefaultScreen(display);
    Window window = XCreateSimpleWindow(display, RootWindow(display, screen), 0, 0, 1, 1, 0, 0, 0);
    XMapWindow(display, window);

    XClassHint *ch = XAllocClassHint();
    ch->res_name = "bspwm_discord";
    ch->res_class = "bspwm_discord";
    XSetClassHint(display, window, ch);
    XFree(ch);

    XFlush(display);
    usleep(0.5 * 1000 * 1000);

    XCloseDisplay(display);

    return 0;
}
