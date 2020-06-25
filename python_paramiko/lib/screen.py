#import os
import os.path

import mss


def on_exists(fname):
    # type: (str) -> None
    """
    Callback example when we try to overwrite an existing screenshot.
    """
    #fname="../images/sct-160x160_460x635.PNG"
    if os.path.isfile(fname):
        newfile = fname + '.old'
        print('{0} -> {1}'.format(fname, newfile))
        os.rename(fname, newfile)
    ############################
    #full screen 
    ##########################

    
    with mss.mss() as sct:
    # The screen part to capture
        monitor = {'top': 0, 'left': 0, 'width': 1600, 'height': 800}
        output = './images/sct-{top}x{left}_{width}x{height}.png'.format(**monitor)
    # Grab the data
        sct_img = sct.grab(monitor)
    # Save to the picture file
        mss.tools.to_png(sct_img.rgb, sct_img.size, output)
        print(output)


"""with mss.mss() as sct:
    filename = sct.shot(output='../images/mon-%d.png', callback=on_exists)
    print(filename)
    
    
    

with mss.mss() as sct:
    # The screen part to capture
    monitor = {'top': 160, 'left': 160, 'width': 460, 'height': 635}
    output = '../images/sct-{top}x{left}_{width}x{height}.png'.format(**monitor)

    # Grab the data
    sct_img = sct.grab(monitor)

    # Save to the picture file
    mss.tools.to_png(sct_img.rgb, sct_img.size, output)
    print(output)
    """