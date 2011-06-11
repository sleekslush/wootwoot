module ui.events.ExitMenuListener;

import dwt.events.SelectionAdapter;
import dwt.events.SelectionEvent;
import dwt.widgets.MenuItem;

class ExitMenuListener : SelectionAdapter
{
    void widgetSelected(SelectionEvent evt)
    {
        auto menuItem = cast(MenuItem) evt.widget;
        menuItem.getParent().getShell().close();
    }
}
