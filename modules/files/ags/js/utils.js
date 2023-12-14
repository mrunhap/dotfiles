import Cairo from 'cairo';
import options from './options.js';
import icons from './icons.js';

export function createSurfaceFromWidget(widget) {
    const alloc = widget.get_allocation();
    const surface = new Cairo.ImageSurface(
        Cairo.Format.ARGB32,
        alloc.width,
        alloc.height,
    );
    const cr = new Cairo.Context(surface);
    cr.setSourceRGBA(255, 255, 255, 0);
    cr.rectangle(0, 0, alloc.width, alloc.height);
    cr.fill();
    widget.draw(cr);

    return surface;
}

export function warnOnLowBattery() {
    const { Battery } = ags.Service;
    Battery.instance.connect('changed', () => {
        const { low } = options.battaryBar;
        if (Battery.percentage < low || Battery.percentage < low / 2) {
            ags.Utils.execAsync([
                'notify-send',
                `${Battery.percentage}% Battery Percentage`,
                '-i', icons.battery.warning,
                '-u', 'critical',
            ]);
        }
    });
}
