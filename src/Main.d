module Main;

debug {
    import tango.core.tools.TraceExceptions;
    import tango.io.Stdout;
} else {
    import util.log.AppendHttp;
}
import ui.window.MainWindow;
import util.log.Log;
import woot.WootWatcher;

void main()
{
    try {
        (new MainWindow).run();
    } catch (Exception ex) {
        debug {
            ex.writeOut((char[] s) { Stdout(s); });
            Stdout.flush();
        } else {
            with (Log.lookup("Main")) {
                add(new AppendHttp("http://www.postbin.org/zl7k1l"));
                fatal(ex.toString());
            }
        }
    }
}
