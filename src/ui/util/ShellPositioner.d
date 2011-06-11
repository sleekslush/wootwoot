module ui.util.ShellPositioner;

import dwt.graphics.Point;
import dwt.widgets.Monitor : DwtMonitor = Monitor;
import dwt.widgets.Shell;

enum ScreenPosition
{
    TOP_LEFT,
    TOP_MIDDLE,
    TOP_RIGHT,
    LEFT_CENTER,
    CENTER,
    RIGHT_CENTER,
    BOTTOM_LEFT,
    BOTTOM_MIDDLE,
    BOTTOM_RIGHT
}

Point calculateLocation(Shell shell, ScreenPosition position)
{
    auto monitor = shell.getDisplay().getPrimaryMonitor();
    auto screenArea = monitor.getClientArea();
    auto shellBounds = shell.getBounds();

    int x = 0;
    int y = 0;

    switch (position) {
        case ScreenPosition.BOTTOM_LEFT:
            y = screenArea.height - shellBounds.height;
            break;

        case ScreenPosition.BOTTOM_MIDDLE:
            x = (screenArea.width - shellBounds.width) / 2;
            y = screenArea.height - shellBounds.height;
            break;

        case ScreenPosition.BOTTOM_RIGHT:
            x = screenArea.width - shellBounds.width;
            y = screenArea.height - shellBounds.height;
            break;

        default:
            assert(false, "Invalid screen position provided");
    }

    return new Point(x, y);
}

void toBottomRight(Shell shell)
{
    setLocation(shell, ScreenPosition.BOTTOM_RIGHT);
}

private void setLocation(Shell shell, ScreenPosition position)
{
    shell.setLocation(calculateLocation(shell, position));
}
