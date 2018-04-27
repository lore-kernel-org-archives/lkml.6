Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757517AbeD0LWU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:22:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:52202 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeD0LWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:22:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180427112214epoutp01a13099822ed6aadd312d8ef7dfbe20d8~pRxwLcXFH2974729747epoutp012
X-AuditID: b6c32a47-bc7ff70000001011-94-5ae307e5e304
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Simon Horman <horms+renesas@verge.net.au>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 0/3] fbdev/drm: sh_mobile: remove unused MERAM support
Date: Fri, 27 Apr 2018 13:21:42 +0200
Message-id: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCmme5T9sdRBls3G1tsnLGe1eLK1/ds
        FnNnT2K0uPD2A5tF58Ql7BYn+j6wWlzeNYfNYuvLd0wOHB4Tz+p6zO6Yyepxv/s4k0ffllWM
        HnN+fmPx+LxJLoAtissmJTUnsyy1SN8ugSvjwpwexoJm3op/XY8YGxhnc3UxcnJICJhIfNzw
        m7GLkYtDSGAHo8Tpm7NYIZzvjBIr+q6xw1RN2vSRBSKxgVGir/MfVMsvRok1F7cwglSxCVhJ
        TGxfBWaLCKRKtO08C9bBLHCeUWLj1B2sIAlhATeJCctawWwWAVWJzU0vwWxeAQ+Jryc2skKs
        k5M4eWwy2B0SAn9ZJT6e/wp0BweQ4yLxYrsVRI2wxKvjW6DOk5Z4tmojI0R9M6PEtx17mCES
        Exgl9qwXgrCtJQ4fvwi2gFmAT6Lj8F+ombwSHW1QJR4Sr3tWQrU6SrS8P8sEYgsJxEq8bX3B
        PoFRcgEjwypGsdSC4tz01GKjAmO94sTc4tK8dL3k/NxNjOCI1HLfwbjtnM8hRgEORiUeXoV3
        D6OEWBPLiitzDzFKcDArifDuuA0U4k1JrKxKLcqPLyrNSS0+xCjNwaIkztvgeyZKSCA9sSQ1
        OzW1ILUIJsvEwSnVwOjeNM+pNFKYoShIYNr6fz1q+uKbNP31pbJfy03S0Yz+HPWowmCT5A2H
        +aE6p8oyp1TM+leYI/f/WM3sd19mPpF5O+u/w8GJc3abxBX5crBd+JP91Upv4x2lxZeE33Hn
        Swd5SkuXrOnoOX3kSQ7bqlnXb+zJXqyy3CjYZl/bnVS/qQZxMyITpZRYijMSDbWYi4oTAQIs
        LJrEAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsVy+t9jQd2n7I+jDF5NlbbYOGM9q8WVr+/Z
        LObOnsRoceHtBzaLzolL2C1O9H1gtbi8aw6bxdaX75gcODwmntX1mN0xk9XjfvdxJo++LasY
        Peb8/Mbi8XmTXABbFJdNSmpOZllqkb5dAlfGhTk9jAXNvBX/uh4xNjDO5upi5OSQEDCRmLTp
        IwuILSSwjlFi9imjLkYuIPsXo8Su23cYQRJsAlYSE9tXgdkiAqkSc/b0sYMUMQucZZS4ee0C
        WLewgJvEhGWtrCA2i4CqxOaml2A2r4CHxNcTG1khtslJnDw2mXUCI9cCRoZVjJKpBcW56bnF
        RgVGeanlesWJucWleel6yfm5mxiBgbLtsFb/DsbHS+IPMQpwMCrx8Cq8exglxJpYVlyZe4hR
        goNZSYR3x22gEG9KYmVValF+fFFpTmrxIUZpDhYlcV7+/GORQgLpiSWp2ampBalFMFkmDk6p
        BsbCtbZbJL2un542d/02FYs008jQuhvST1/e5799R2z7Lv7cynzVeXPsOk8lW87ZGS8f1D7H
        iuPcX7vXHyQ+/7UJ/DNr4+Nr9znPTb8SIcDesWnjidUr3xeevNpnKyeae27GTMtVShEvFz1v
        aPWw+Vm2YF4ud5P8tnn/zx2O5qzZrtJR0/xFd4O1EktxRqKhFnNRcSIAflloFxACAAA=
X-CMS-MailID: 20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8
X-RootMTR: 20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8
References: <CGME20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset removes unused MERAM support (last user was removed
3 years ago) from shmobile fbdev & drm drivers and then removes
MERAM driver itself.

If it is okay to merge this patches I would like patch #1 to go
through fbdev tree and patch #2 to go through drm tree. Once they
are both upstream (v4.18) I will apply patch #3 to fbdev tree.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (3):
  video: fbdev: sh_mobile_lcdcfb: remove unused MERAM support
  drm: shmobile: remove unused MERAM support
  video: fbdev: remove unused sh_mobile_meram driver

 drivers/gpu/drm/shmobile/Kconfig           |   1 -
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c  |  42 --
 drivers/gpu/drm/shmobile/shmob_drm_crtc.h  |   1 -
 drivers/gpu/drm/shmobile/shmob_drm_drv.h   |   2 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.c   |  11 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.h   |   1 -
 drivers/gpu/drm/shmobile/shmob_drm_plane.c |   2 -
 drivers/video/fbdev/Kconfig                |  13 -
 drivers/video/fbdev/Makefile               |   1 -
 drivers/video/fbdev/sh_mobile_lcdcfb.c     |  63 +--
 drivers/video/fbdev/sh_mobile_lcdcfb.h     |   1 -
 drivers/video/fbdev/sh_mobile_meram.c      | 754 -----------------------------
 include/linux/platform_data/shmob_drm.h    |   4 -
 include/video/sh_mobile_lcdc.h             |   3 -
 include/video/sh_mobile_meram.h            |  95 ----
 15 files changed, 1 insertion(+), 993 deletions(-)
 delete mode 100644 drivers/video/fbdev/sh_mobile_meram.c
 delete mode 100644 include/video/sh_mobile_meram.h

-- 
1.9.1
