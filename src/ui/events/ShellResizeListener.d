module ui.events.ShellResizeListener;

import dwt.events.ControlAdapter;
import dwt.events.ControlEvent;
import dwt.widgets.Shell;
import ShellPositioner = ui.util.ShellPositioner;

class ShellResizeListener : ControlAdapter
{
    void controlMoved(ControlEvent evt)
    {
        reposition(evt);
    }

    void controlResized(ControlEvent evt)
    {
        reposition(evt);
    }

    private void reposition(ControlEvent evt)
    {
        ShellPositioner.toBottomRight(cast(Shell) evt.widget);
    }
}
