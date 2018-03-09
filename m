Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932127AbeCIQ0z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:26:55 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:31663 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeCIQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:26:53 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180309162651epoutp01d82dcef087da71a3ae2f701c9d4913b6~aTUu8dt4N2087220872epoutp01Y
X-AuditID: b6c32a35-891ff70000001031-c0-5aa2b5cb6bca
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] fbdev fix for v4.16-rc5
Date: Fri, 09 Mar 2018 17:26:47 +0100
Message-id: <5453854.qdYKEQ567K@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7bCmge7prYuiDF4vk7O48vU9m8WJvg+s
        Fpd3zWGzeNT3lt2BxePEjN8sHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJXRsvAsW8Ff/ooP
        TS9YGhin8XYxcnJICJhITN2ykb2LkYtDSGAHo8ShpS9YQBJCAt+BnMU2MEUnfjewQRTtZpR4
        +OoZM4TzlVFi48UHjCBVbAJWEhPbV4HZIgJGEp9fXGEFsZkFEiS+3PzMDGILC2hL7Jn3Hsxm
        EVCVON91HszmFdCUWDvtP1i9qICXxJZ97UwQcUGJH5PvsUDMkZfYt38q1EwdibPH1jGCHCEh
        8JdV4vStW0CDOIAcF4k9e4shrhaWeHV8CztEWFri0lFbiPJmRolvO/YwQ9RMYJTYs14IwraW
        OHz8ItR8Pol3X3tYIXp5JTraoEo8JK4unArV6ihx8dp5dkhgxUo82LqGcQKjzCwkV89CcvUs
        JFcvYGRexSiWWlCcm55abFhgqFecmFtcmpeul5yfu4kRHNdapjsYp5zzOcQowMGoxMMrMGNR
        lBBrYllxZe4hRgkOZiUR3vc1QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8AQEuUUIC6Yklqdmp
        qQWpRTBZJg5OqQbGcr6PE5faBbxL2ixTu1c2xvWJ83Hty2oTw34+9bt5f4vrxInnnn09oDlb
        d5rrI9mFz41eGKksVDblWiPv0e34ipHnecfziIpU+df/X56bvGaSyHTROUw6Z4+ubPBeV37z
        0dmoasbUjGf9nCv7pm36571f9fmVktwlYX+fSzzeVeL695tH3rrDDEosxRmJhlrMRcWJAKvN
        cmbnAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsVy+t9jAd1TWxdFGZzsNrO48vU9m8WJvg+s
        Fpd3zWGzeNT3lt2BxePEjN8sHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJXRsvAsW8Ff/ooP
        TS9YGhin8XYxcnJICJhInPjdwNbFyMUhJLCTUeL0rWtQzldGicPP1zCBVLEJWElMbF/FCGKL
        CBhJfH5xhRXEZhZIkNh0fyobiC0soC2xZ957ZhCbRUBV4nzXeTCbV0BTYu20/2D1ogJeElv2
        tTNBxAUlfky+xwIxR15i3/6pUDO1JNbvPM40gZF3FpKyWUjKZiEpW8DIvIpRMrWgODc9t9io
        wDAvtVyvODG3uDQvXS85P3cTIzDoth3W6tvBeH9J/CFGAQ5GJR5egRmLooRYE8uKK3MPMUpw
        MCuJ8L6vAQrxpiRWVqUW5ccXleakFh9ilOZgURLnvZ13LFJIID2xJDU7NbUgtQgmy8TBKdXA
        6GT78vJUhZ72qbmNC3YUnzox5THf7u6lF7cXHWRzzn5kZ+b/wNdH6aHC49fP2BclnwtW+DZn
        /uRz173ndSzrOTjhkYzm2WOOu1MaE59P7Luz4N2ufa/uztm17KH24ifTz4h9Nv12vlKS54/g
        Nf9chZa4fzKJXkLTWPNuCD1m51yoUvdqq7SDzBYlluKMREMt5qLiRAAQAWa2NgIAAA==
X-CMS-MailID: 20180309162650epcas1p117f2feb3b030f08733884288a17cf933
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180309162650epcas1p117f2feb3b030f08733884288a17cf933
X-RootMTR: 20180309162650epcas1p117f2feb3b030f08733884288a17cf933
References: <CGME20180309162650epcas1p117f2feb3b030f08733884288a17cf933@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev fix for v4.16-rc5 (just a single fix to close
kernel data leak in FBIOGETCMAP_SPARC ioctl).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.16-rc5

for you to fetch changes up to 250c6c49e3b68756b14983c076183568636e2bde:

  fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper(). (2018-03-07 14:00:34 +0100)

----------------------------------------------------------------
fbdev fix for v4.16-rc5:

- fix kernel data leak in FBIOGETCMAP_SPARC ioctl (Peter Malone)

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v4.16-rc4' of git://git.kernel.org/.../torvalds/linux into fbdev-for-next

Peter Malone (1):
      fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper().

 drivers/video/fbdev/sbuslib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sbuslib.c b/drivers/video/fbdev/sbuslib.c
index af6fc97..a436d44 100644
--- a/drivers/video/fbdev/sbuslib.c
+++ b/drivers/video/fbdev/sbuslib.c
@@ -122,7 +122,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		unsigned char __user *ured;
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
-		int index, count, i;
+		unsigned int index, count, i;
 
 		if (get_user(index, &c->index) ||
 		    __get_user(count, &c->count) ||
@@ -161,7 +161,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned long arg,
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
 		struct fb_cmap *cmap = &info->cmap;
-		int index, count, i;
+		unsigned int index, count, i;
 		u8 red, green, blue;
 
 		if (get_user(index, &c->index) ||
