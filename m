Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935391AbeBMMb4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:31:56 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:23636 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935010AbeBMMbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:31:50 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180213123148epoutp047d52e5dbb2679c99a8e302012f62278e~S4opo0lkP2340323403epoutp04Q
X-AuditID: b6c32a45-3ebff70000001023-05-5a82dab3c690
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Bolle <pebolle@tiscali.nl>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 02/11] video: fbdev: kconfig: Remove blank help text
Date: Tue, 13 Feb 2018 13:31:45 +0100
Message-id: <2836658.i9VlN9LAid@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <CAFkk2KQxPnwMKmvhCoKQ0BBciTc5JKqjJqHGHAMR5uHF0w13sg@mail.gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHObsvuxuurlProGaxiHLkK1Y3C9EwuoUfhApiRDb0MkWnc9Oh
        CWV+UDOsacVEtHxJk6GmU2ozdOhMRU2MjGLlMsnA1FSWzLYmud0Jfvs95/md8/zP4RCIUI8F
        EhnZeYwyW5olwvnoK3PoibAeS4kkUjt/knJVj3CppS0tSs1srOLU0nAJRo09WMOof30GDvWh
        rw6nPmsWAPV78RrVZJlEqJWv2+60w4JQ/VYbiBfQTkc1oI21s1y6p01M63X3cPrb/VEOvb5g
        QekxrR2lu1//4NA2fQjdb3OiyXwJ/2wak5WhZpQRcTf56dOOTq6iza9gUTvILQbFeysAj4Bk
        DOxyutAKwCeEpAHAtdFphC3sAK7Ob+E7lqZjGWMbbwC0rXR4rQ0AG4brELeFk7GwqkwH3OxP
        HoVWjQl3Swi5hUDT5LjnKD+ShsumAW4FIAiUPAIbiy+6lwVk6PboCY6bA8hLsHegzMM88jL8
        4ppDWccXbj6yehghD8IB0xOM5ePw3UgncM+C5EMubBofBGzsRNhmeo6w7Ad/jfZyWQ6CP3Xd
        3g06AP9+dHmLnu27fdrAWOsMNI++947YA8vNLk9qSApgeamQVWhYNV2Hs8sJsH0dZ1/FBqB9
        cwbXgAO1u4LX7gpeuyt4A0B0YB+jUMlljCpaERWukspV+dmy8NQcuR54fpL4vAHUTCUNAZIA
        Ih/BXP1diRCTqlWF8iEACUTkLyAaSyRCQZq08BajzElR5mcxqiEQRKCi/YLS5ESJkJRJ85hM
        hlEwyp0uh+AFFoM77Zk1C7ENRdzbPHG8mqJKDwd+n2huEVfmGuqNyphWrbOuMpoJt7uC38pC
        bhjT+qauJBkndb5BccEFYj/1yp/CUw59amvRpQhc3Jt7NS/gWWTBvLmps9D6NNiYYG7BbI8P
        NdrbjzXHvrggrX/pkyK8Pjs+qe06nWm2ntNjYSJUlS6NEiNKlfQ/j1963UUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e+xgO7mW01RBn27lC3+TjrGbvH633QW
        iytf37NZvD7SxGpxou8Dq8WfXTuYLC7vmsNmcWPCU0aLdy8jLBbdOsNs8fYOUO2FX7eYLfbe
        +8zowOvx+9ckRo+ds+6ye2xeoeWxaVUnm8f97uNMHh+f3mLxODH9O4vHxu1PmDw+b5Lz2Pv5
        N0sAVxSXTUpqTmZZapG+XQJXxoVf69gLVghXvJx+kL2BsYG/i5GTQ0LARGLC2jesXYxcHEIC
        Oxkltm2YywzhfGWUWLxzFiNIFZuAlcTE9lVgtoiAusS9CfvZQIqYBRpYJN4/3g+WEBbwkHiz
        fx97FyMHB4uAqsTCBk+QMK+ApsSH46eZQGxRAS+JLfvawWxOgWCJz2dXM0Esm88oseHMY3aI
        BkGJH5PvsYDYzALyEvv2T2WFsLUk1u88zjSBkX8WkrJZSMpmISlbwMi8ilEytaA4Nz232KjA
        KC+1XK84Mbe4NC9dLzk/dxMjMIa2Hdbq38H4eEn8IUYBDkYlHt6O2Y1RQqyJZcWVuYcYJTiY
        lUR4ORY2RQnxpiRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpg
        dJ/q7dBdYxLSee/vjhNXRdmcG/wKWqt1lj14vGCN0RL1rv2ndQRP/NW/umP3XKUTrMEn8nYp
        zzh63yOVY4n07LNFuz8GBks6Hs7kKJHZWbzKrX32u5aAJROPe3FZME7r1jzQ6PC8K6Uvax/b
        z9PPRU7fid/I7lJ56b/6yYCJi999CjRoeq24V4mlOCPRUIu5qDgRAABSuJ6dAgAA
X-CMS-MailID: 20180213123147epcas2p2a2bb399e700dacef57a2340afcc0e459
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180213123147epcas2p2a2bb399e700dacef57a2340afcc0e459
X-RootMTR: 20180213123147epcas2p2a2bb399e700dacef57a2340afcc0e459
References: <20180131093434.20050-1-ulfalizer@gmail.com>
        <3132455.r9uCTL3ZTk@amdc3058>
        <CAFkk2KQxPnwMKmvhCoKQ0BBciTc5JKqjJqHGHAMR5uHF0w13sg@mail.gmail.com>
        <CGME20180213123147epcas2p2a2bb399e700dacef57a2340afcc0e459@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 01, 2018 05:56:18 PM Ulf Magnusson wrote:
> On Thu, Feb 1, 2018 at 4:52 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> >
> > Hi,
> >
> > On Wednesday, January 31, 2018 10:34:21 AM Ulf Magnusson wrote:
> >> Blank help texts are probably either a typo, a Kconfig misunderstanding,
> >> or some kind of half-committing to adding a help text (in which case a
> >> TODO comment would be clearer, if the help text really can't be added
> >> right away).
> >>
> >> Best to remove them, IMO.
> >
> > How about actually adding some meaningful help texts instead
> > (as a general rule each user visible option should have valid
> > help text)?
> >
> >> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> >> ---
> >>  drivers/video/fbdev/Kconfig | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> >> index 6962b4583fd7..11e699f1062b 100644
> >> --- a/drivers/video/fbdev/Kconfig
> >> +++ b/drivers/video/fbdev/Kconfig
> >> @@ -1156,7 +1156,6 @@ config FB_I810_I2C
> >>       bool "Enable DDC Support"
> >>       depends on FB_I810 && FB_I810_GTF
> >>       select FB_DDC
> >> -     help
> >
> > Please add a missing help text instead (take a look at FB_SAVAGE_I2C
> > config option to see how a valid help text entry should look like).
> 
> The FB_I810_I2C option was added in 74f6ae84b23 ("[PATCH] i810fb: Add
> i2c/DDC support"). What do you think about adding this bit from the
> commit message as the help text?
> 
>   Add DDC/I2C support for i810fb.  This will allow the driver to get display
>   information, especially for monitors with fickle timings.

Seems fine to me, please add:

    If unsure, say Y.

and send it as a proper patch.

> I'm not familiar with this code, so I don't want to do too much
> guessing myself. :)

:)

> > In the longer term we should consider removing *_I2C config options
> > and just make the main config options always enable I2C subsystem
> > directly if needed/useful (some fbdev drivers are doing it this way
> > already).
> >
> >>  config FB_LE80578
> >>       tristate "Intel LE80578 (Vermilion) support"
> >
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> >
> 
> Cheers,
> Ulf

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
