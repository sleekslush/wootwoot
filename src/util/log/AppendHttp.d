module util.log.AppendHttp;

import tango.io.device.Array;
import tango.net.Uri;
import tango.net.http.HttpPost;
import tango.util.log.Log;

class AppendHttp : Appender
{
    private HttpPost httpClient_;
    private Mask mask_;

    this(char[] url)
    {
        this(new Uri(url));
    }

    this(Uri uri)
    {
        mask_ = register(uri.toString());
        httpClient_ = new HttpPost(uri);
    }

    Mask mask()
    {
        return mask_;
    }

    char[] name()
    {
        return this.classinfo.name;
    }

    void append(LogEvent event)
    {
        auto buffer = new Array(256, 256);
        layout.format(event, &buffer.write);
        client.write(buffer.slice(), "text/plain");
    }

    HttpPost client()
    {
        return httpClient_;
    }
}
