Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbeBGPIj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:08:39 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31033 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbeBGPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:08:14 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180207150812epoutp03f21e3ddc8700991cd8f4b4e553952d3b~RE5fzZYHv3125331253epoutp03e
X-AuditID: b6c32a39-47fff70000000fc5-81-5a7b165b7e39
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev changes for v4.16
Date: Wed, 07 Feb 2018 16:08:09 +0100
Message-id: <3114277.dUeCUFPaAu@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWy7bCmgW6MWHWUwcz7TBZXvr5nszjR94HV
        4vKuOWwWj/resjuweJyY8ZvF4373cSaPz5vkApijuGxSUnMyy1KL9O0SuDKWz1/BWnBWvWJ5
        63nGBsZbsl2MnBwSAiYSvxoWsXcxcnEICexglPi2YwGU851R4trHLWwwVZufzmKGSOxmlJhw
        7jA7SEJI4CujxNrpTCA2m4CVxMT2VYwgtoiAkcTnF1dYQWxmgQSJ/+d3gtUIC2hLHGtfD9bL
        IqAqMX3ne7A4r4CmxLtlfWD1ogJeElv2tUPFBSV+TL7HAjFHXmLf/qlQM3Ukzh5bxwhykITA
        T1aJw/+PMUNc6iIxa/o5qKuFJV4d3wK0jAPIlpa4dNQWIjydUWL7bwmI3s2MEqt2T2CHSFhL
        HD5+EWoBn8S7rz2sEL28Eh1tQhAlHhJT2iZBlTtKPD3SzAwJh1iJ/kmLmScwysxCcvYsJGfP
        QnL2AkbmVYxiqQXFuempxYYFpnrFibnFpXnpesn5uZsYwZGtZbmD8dg5n0OMAhyMSjy8Bhsq
        o4RYE8uKK3MPMUpwMCuJ8LqzV0cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5w0IcIkSEkhPLEnN
        Tk0tSC2CyTJxcEo1MK4pZBE2zG6XmWF086tS6NQzk4wzhDVnzL7ApnJicdu72k6VHx7yW6Mv
        f/yzzy5N86CNyiOtp494/rGtan8bPavMQutZi/uKRZUuor6mtSsO6Glw7nyVwrspNOo1q4d/
        T9UJlw57u4qt0Q8LejuN0tYwOdzdr7n7EGdokOTTnSxnRDcUHfmqo8RSnJFoqMVcVJwIAKuD
        gXfoAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsVy+t9jAd1oseoog0WHVCyufH3PZnGi7wOr
        xeVdc9gsHvW9ZXdg8Tgx4zeLx/3u40wenzfJBTBHcdmkpOZklqUW6dslcGUsn7+CteCsesXy
        1vOMDYy3ZLsYOTkkBEwkNj+dxdzFyMUhJLCTUeLToxvsEM5XRok53XeZQKrYBKwkJravYgSx
        RQSMJD6/uMIKYjMLJEhsXtnIDGILC2hLHGtfzw5iswioSkzf+R6sl1dAU+Ldsj6welEBL4kt
        +9qh4oISPybfY4GYIy+xb/9UqJlaEut3HmeawMg7C0nZLCRls5CULWBkXsUomVpQnJueW2xU
        YJiXWq5XnJhbXJqXrpecn7uJERh02w5r9e1gvL8k/hCjAAejEg9vx6bKKCHWxLLiytxDjBIc
        zEoivO7s1VFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW/nHYsUEkhPLEnNTk0tSC2CyTJxcEo1
        MHqbzMrJ2fWRXZnV9V3iL/9w9sCwhWpZ+06bnjlslyjFbxn3/fBVtymf1vvc8mt5+8fm6Kxt
        HsX7bqsoKO79UXnv/ZllzcUmX3suTtrlwp+4OMC+XuGlRNaL1RkC3xSLvX+E3rytcrYp1sik
        iV8yh2VqUvRf8xNfxIOCRPT9X8z5rL3v4+JX4kosxRmJhlrMRcWJAFhmNlE2AgAA
X-CMS-MailID: 20180207150811epcas1p3a2777b685e023aa843a3ecf2c32fd7dc
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180207150811epcas1p3a2777b685e023aa843a3ecf2c32fd7dc
X-RootMTR: 20180207150811epcas1p3a2777b685e023aa843a3ecf2c32fd7dc
References: <CGME20180207150811epcas1p3a2777b685e023aa843a3ecf2c32fd7dc@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v4.16.  There is nothing really major here
(please see the signed tag description for details).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 464e1d5f23cca236b930ef068c328a64cab78fb1:

  Linux 4.15-rc5 (2017-12-23 20:47:16 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.16

for you to fetch changes up to 5865889fe4319415e439095391dda52f23030d60:

  video: udlfb: Switch from the pr_*() to the dev_*() logging functions (2018-01-16 16:35:20 +0100)

----------------------------------------------------------------
fbdev changes for v4.16:

- fix display-timings lookup in the Device Tree in atmel_lcdfb
  driver (Johan Hovold)

- fix video mode and line_length to be set correctly in vfb driver
  (Pieter "PoroCYon" Sluys)

- fix returning nonsensical values to the user-space on GIO_FONTX
  ioctl when using dummy console (Nicolas Pitre)

- add missing license tag to mmpfb driver (Arnd Bergmann)

- convert radeonfb and pxa3xx_gcu drivers to use ktime_get[_ts64]()
  instead of the deprecated do_gettimeofday() (Arnd Bergmann)

- switch udlfb driver from using the pr_*() logging functions to
  the dev_*() ones + related cleanups (Ladislav Michl)

- use __raw I/O accessors also on arm64 (Ji Zhang)

- fix Kconfig help text for intelfb driver (Randy Dunlap)

- do not duplicate features data in omapfb driver (Ladislav Michl)

- misc cleanups (Colin Ian King, Markus Elfring, Rasmus Villemoes,
  Vasyl Gomonovych, Himanshu Jha, Michael Trimarchi)

----------------------------------------------------------------
Arnd Bergmann (3):
      fbdev: radeon: use ktime_get() for HZ calibration
      fbdev: pxa3xx: use ktime_get_ts64 for time stamps
      video: fbdev/mmp: add MODULE_LICENSE

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v4.15-rc5' of git://git.kernel.org/.../torvalds/linux into fbdev-for-next

Colin Ian King (1):
      video: fbdev: remove redundant self assignment of 'height'

Himanshu Jha (1):
      fbdev: auo_k190x: Use zeroing memory allocator instead of allocator/memset

Ji Zhang (1):
      fbdev: arm64 use __raw I/O memory api

Johan Hovold (1):
      video: fbdev: atmel_lcdfb: fix display-timings lookup

Ladislav Michl (7):
      omapfb: dss: Do not duplicate features data
      video: udlfb: Remove unnecessary local variable
      video: udlfb: Remove redundant gdev variable
      video: udlfb: Remove noisy warnings
      video: udlfb: Do not name private data 'dev'
      video: udlfb: Constify read only data
      video: udlfb: Switch from the pr_*() to the dev_*() logging functions

Markus Elfring (5):
      video/fbdev/wm8505fb: Delete an error message for a failed memory allocation in wm8505fb_probe()
      video/fbdev/vt8500lcdfb: Delete an error message for a failed memory allocation in vt8500lcd_probe()
      video: udlfb: Improve a size determination in dlfb_alloc_urb_list()
      video: udlfb: Delete an unnecessary return statement in two functions
      video: smscufx: Improve a size determination in two functions

Michael Trimarchi (1):
      fbdev: mxsfb: use framebuffer_alloc in the correct way

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL

Pieter \"PoroCYon\" Sluys (1):
      vfb: fix video mode and line_length being set when loaded

Randy Dunlap (1):
      fb: intelfb: fix Kconfig symbol info in help text

Rasmus Villemoes (1):
      fbdev: au1200fb: delete duplicate header contents

Vasyl Gomonovych (1):
      video: fbdev: omap2: Use PTR_ERR_OR_ZERO()

 drivers/video/console/dummycon.c                |   1 -
 drivers/video/fbdev/Kconfig                     |   2 +-
 drivers/video/fbdev/atmel_lcdfb.c               |   8 +-
 drivers/video/fbdev/aty/radeon_base.c           |  18 +-
 drivers/video/fbdev/au1200fb.h                  | 286 -----------
 drivers/video/fbdev/auo_k190x.c                 |   3 +-
 drivers/video/fbdev/mmp/core.c                  |   5 +
 drivers/video/fbdev/mxsfb.c                     |  45 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c    |  39 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.c      |  45 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c    |   5 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c |  31 +-
 drivers/video/fbdev/pxa3xx-gcu.c                |  16 +-
 drivers/video/fbdev/smscufx.c                   |   5 +-
 drivers/video/fbdev/udlfb.c                     | 655 ++++++++++++------------
 drivers/video/fbdev/vfb.c                       |  17 +
 drivers/video/fbdev/vga16fb.c                   |   1 -
 drivers/video/fbdev/vt8500lcdfb.c               |   4 +-
 drivers/video/fbdev/wm8505fb.c                  |   4 +-
 include/linux/fb.h                              |   5 +-
 include/video/udlfb.h                           |   3 +-
 21 files changed, 421 insertions(+), 777 deletions(-)
