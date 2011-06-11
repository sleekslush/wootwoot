module ui.widgets.WootPanelItem;

import dwt.DWT;
import dwt.dwthelper.Runnable;
import dwt.graphics.Image;
import dwt.widgets.Composite;
import dwt.widgets.Display;
import dwt.widgets.Label;
import sleek.net.http.HttpGetRequest;
import Path = tango.io.Path;
import woot.WootClient;
import woot.WootItem;
import woot.WootWatcher;
import tango.core.Thread;
import tango.io.Stdout;
import dwt.events.MouseAdapter;
import dwt.events.MouseEvent;

class WootPanelItem
{
    protected Display display;
    protected WootWatcher wootWatcher;
    protected Label label;
    protected Image thumbImage;

    this(WootClient.WootType type, Composite parent)
    {
        display = Display.getCurrent();
        createContents(parent);

        wootWatcher = new WootWatcher(type);
        wootWatcher.bindWootUpdated(&onWootUpdated);
        wootWatcher.bindWootError(&onWootError);
        wootWatcher.start();
    }

    void dispose()
    {
        wootWatcher.stop();
        disposeImage(thumbImage);
    }

    private void disposeImage(Image image)
    {
        if (image && !image.isDisposed()) {
            image.dispose();
        }
    }

    protected void onWootError(Exception ex) {
        // handle errors here
    }

    protected void onWootUpdated(WootItem item)
    {
        auto thumbnailImageThread = new DownloadThread(item.thumbnailImage);
        thumbnailImageThread.start();

        /*auto standardImageThread = new DownloadThread(item.standardImage);
        standardImageThread.start();*/

        thumbnailImageThread.join();
        display.asyncExec(dgRunnable(&updateWootItem, item, thumbnailImageThread.fileName));
    }

    protected void updateWootItem(WootItem item, char[] thumbFilename)
    {
        disposeImage(thumbImage);
        label.setImage(thumbImage = new Image(display, thumbFilename));
        label.addMouseListener(new WootItemMouseListener(item.guid));
        label.getShell().pack();
    }

    protected void createContents(Composite parent)
    {
        label = new Label(parent, DWT.CENTER);
    }
}

class DownloadThread : Thread
{
    protected HttpGetRequest client;
    protected char[] fileName_;

    this(char[] url)
    {
        super(&run);
        client = new HttpGetRequest(url);
    }

    char[] fileName()
    {
        return fileName_;
    }

    protected void run()
    {
        fileName_ = client.writeToFile();
    }
}

class WootItemMouseListener : MouseAdapter
{
    protected char[] url;

    this(char[] url)
    {
        this.url = url;
    }

    void mouseUp(MouseEvent evt)
    {
        Stdout("visit " ~ url).newline;
    }
}
