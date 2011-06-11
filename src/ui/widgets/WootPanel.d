module ui.widgets.WootPanel;

import dwt.widgets.Composite;
import ui.widgets.WootPanelItem;
import woot.WootClient;

class WootPanel
{
    protected Composite parent;
    protected WootPanelItem[WootClient.WootType] items;

    this(Composite parent)
    {
        this.parent = parent;
    }

    void addWootType(WootClient.WootType type)
    {
        if (!(type in items)) {
            items[type] = new WootPanelItem(type, parent);
        }
    }

    void dispose()
    {
        foreach (item; items) {
            item.dispose();
        }
    }
}
