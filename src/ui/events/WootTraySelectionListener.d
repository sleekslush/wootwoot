module ui.events.WootTraySelectionListener;

import dwt.events.SelectionAdapter;
import dwt.events.SelectionEvent;
import dwt.widgets.Shell;

class WootTraySelectionListener : SelectionAdapter
{
    private Shell shell;

    this(Shell shell)
    {
        this.shell = shell;
    }

    void widgetSelected(SelectionEvent evt)
    {
        shell.setVisible(!shell.isVisible());
        if (shell.isVisible()) {
            shell.setActive();
        }
    }
}
