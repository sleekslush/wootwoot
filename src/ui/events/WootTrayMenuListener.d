module ui.events.WootTrayMenuListener;

import dwt.events.MenuDetectEvent;
import dwt.events.MenuDetectListener;
import dwt.widgets.Menu;

class WootTrayMenuListener : MenuDetectListener
{
    private Menu menu;

    this(Menu menu)
    {
        this.menu = menu;
    }

    void menuDetected(MenuDetectEvent evt)
    {
        menu.setVisible(true);
    }
}
