module ui.widgets.WootTrayItem;

import dwt.DWT;
import dwt.dwthelper.utils : getImportData;
import dwt.graphics.Image;
import dwt.widgets.Display;
import dwt.widgets.Menu;
import dwt.widgets.MenuItem;
import dwt.widgets.Shell;
import dwt.widgets.Tray;
import dwt.widgets.TrayItem;
import dwtx.jface.resource.DeviceResourceException;
import dwtx.jface.resource.ImageDescriptor;
import ui.events.ExitMenuListener;
import ui.events.WootTrayMenuListener;
import ui.events.WootTraySelectionListener;

class WootTrayItem
{
    protected ImageDescriptor trayIconDescriptor;
    protected Menu menu;
    protected TrayItem trayItem;

    this(Shell shell, Tray tray)
    {
        createMenu(shell);
        createTrayItem(shell, tray);
        createTrayIcon(shell.getDisplay());
    }

    void dispose()
    {
        if (auto image = trayItem.getImage()) {
            trayIconDescriptor.destroyResource(image);
        }
    }

    protected void createTrayItem(Shell shell, Tray tray)
    {
        trayItem = new TrayItem(tray, DWT.NONE);
        trayItem.setToolTipText("WootWoot!");
        trayItem.addMenuDetectListener(new WootTrayMenuListener(menu));
        trayItem.addSelectionListener(new WootTraySelectionListener(shell));
    }

    protected void createTrayIcon(Display display)
    {
        trayIconDescriptor = ImageDescriptor.createFromFile(getImportData!("wootwoot16x16.ico"));

        try {
            trayItem.setImage(cast(Image) trayIconDescriptor.createResource(display));
        } catch (DeviceResourceException) {
            // oh well.
        }
    }

    protected void createMenu(Shell shell)
    {
        menu = new Menu(shell, DWT.POP_UP);

        auto refreshMenuItem = new MenuItem(menu, DWT.PUSH);
        refreshMenuItem.setText("Refresh");
        refreshMenuItem.setEnabled(false);

        new MenuItem(menu, DWT.SEPARATOR);

        auto exitMenuItem = new MenuItem(menu, DWT.PUSH);
        exitMenuItem.setText("Exit");
        exitMenuItem.addSelectionListener(new ExitMenuListener);
    }
}
