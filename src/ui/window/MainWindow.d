module ui.window.MainWindow;

import dwt.DWT;
import dwt.graphics.Point;
import dwt.layout.FillLayout;
import dwt.widgets.Composite;
import dwt.widgets.Control;
import dwt.widgets.Shell;
import dwt.widgets.Tray;
import sleekui.dwt.util.PropertyResourceBundle;
import sleekui.jface.window.DesktopWindow;
import ui.events.ShellResizeListener;
import ui.widgets.WootPanel;
import ui.widgets.WootTrayItem;
import ShellPositioner = ui.util.ShellPositioner : ScreenPosition;
import util.log.Log;
import woot.WootClient;

private static Logger logger;

static this()
{
    logger = Log.lookup("ui.window.MainWindow");
}

class MainWindow : DesktopWindow
{
    private WootPanel wootPanel;
    private WootTrayItem trayItem;

    protected void handleShellCloseEvent()
    {
        wootPanel.dispose();
        trayItem.dispose();
        super.handleShellCloseEvent();
    }

    protected void createTrayIcon(Tray tray)
    {
        if (tray !is null) {
            trayItem = new WootTrayItem(getShell(), tray);
        }
    }

    protected void configureShell(Shell shell)
    {
        super.configureShell(shell);
        shell.setText("WootWoot!");
        shell.addControlListener(new ShellResizeListener);
    }

    protected Point getInitialLocation(Point initialSize)
    {
        return ShellPositioner.calculateLocation(getShell(), ScreenPosition.BOTTOM_RIGHT);
    }

    /**
     * Make sure the window doesn't have any styles. We'll control it completely through
     * the tray icon.
     *
     * Returns: DWT.NO_TRIM
     */
    protected int getShellStyle()
    {
        return DWT.NO_TRIM;
    }

    protected Control createContents(Composite parent)
    {
        auto composite = cast(Composite) super.createContents(parent);
        composite.setLayout(new FillLayout(DWT.HORIZONTAL));

        wootPanel = new WootPanel(composite);
        wootPanel.addWootType(WootClient.Woot);
        wootPanel.addWootType(WootClient.ShirtWoot);
        wootPanel.addWootType(WootClient.SelloutWoot);
        wootPanel.addWootType(WootClient.KidsWoot);
        wootPanel.addWootType(WootClient.WineWoot);

        return composite;
    }
}
