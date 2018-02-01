Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeBAPwy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:52:54 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:17695 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeBAPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:52:51 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180201155249epoutp035457a94edc1c0f2539a5c085d0374fcd~PPovLwdeF1393513935epoutp03P
X-AuditID: b6c32a45-403ff70000001023-e5-5a7337d08454
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, mcgrof@kernel.org,
        rdunlap@infradead.org, dan.carpenter@oracle.com, pebolle@tiscali.nl,
        Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 02/11] video: fbdev: kconfig: Remove blank help text
Date: Thu, 01 Feb 2018 16:52:42 +0100
Message-id: <3132455.r9uCTL3ZTk@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180131093434.20050-3-ulfalizer@gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRSAfXfv7q6rG9dp9urQYiClmB8hdrPoC4Wb9MMQrAaSM69TdDp2
        /SZCCue0TZdWs+EPDQpZYepkfiw30HCCJYYFJWZBzjQ/SqcomlbbXeC/h/c857znHA6OiDr4
        wXhuQRGjKpDlSzAhahkKjz8+fpKVxjzuPULtNAwLqIVdA0q9X/+JUQuv7/CpkbpffOp3fy+P
        muhvxqiPeiegluevUU8m3yDU0tQ/d3xrEqEGpl3gPEFvbzUAus/4WUCb2yLoLlMNRn+55+DR
        K85JlB4xbKB0Z88Mj3Z1hdIDrm00RSgVnsli8nNLGFX02Qxhju3RqkA5sa/MWfUBqwRm31rg
        i0MyDrperIBaIMRFZC+AU+N1mDsgIjcAbNYitQD3SN90Ss7pAHD9bh/KOesA1s1GuxkjE+D9
        ahNwcwB5FE7r7Zg7ASGXeHDR2cJ3B/xJGi7abQI3o2QYbDVrEDcTZDh8qpvzFD1IJsNuWzXP
        zb7kKaj94+Rzjh/cbJz2OAh5GNrsD/kcR8K3w+2eCSBZL4Ca5i0BN1oitHyawzj2hz8c3d53
        MZw1dQKODQD2bEMu2Qygyar3SqfhkOOd94cDUDO0I+BWQUCNWsQpNBztaPPWuQDX5q08bkVW
        AJ2WVb4ehBj3NG7c07hxT+MtADGBQEbJKuQMe0IZG8XKFGxxgTzqZqGiC3juKCKpFzSNXR4E
        JA4k+wlczEpFfFkJW64YBBBHJAHEok0lFRFZsvIKRlV4Q1Wcz7CDQIyjkkOEOiVRKiLlsiIm
        j2GUjOp/lIf7BleC5DhHSGmMoAFb6w/S4WnZYed0vNuy9PQmS7w6SB2uqwrtUqrGnptfpfoh
        2vmY1Aprbr7y1tVkS/z1pHFpA0GMpm1mo9rvpe1+NTPduy8vOg0JfvUZLQ8y23wQRVmcfDgo
        NfBr1bEr2Ul5w+XLVh+1+FJVa6Q9dT1zpK3R55kEZXNksRGIipX9BWQWwZtDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e+xoO4F8+IogwcvOCz+TjrGbvH633QW
        iytf37NZvD7SxGpxou8Dq8WfXTuYLC7vmsNmcWPCU0aLdy8jLBbdOsNs8fYOUO2FX7eYLfbe
        +8zowOvx+9ckRo+ds+6ye2xeoeWxaVUnm8f97uNMHh+f3mLxODH9O4vHxu1PmDw+b5Lz2Pv5
        N0sAVxSXTUpqTmZZapG+XQJXxr5pn9gLLnNXPG29ytbAuJmzi5GDQ0LAROJxb0EXIxeHkMA6
        Ron7+w8yQzhfGSVm7lzA2MXIycEmYCUxsX0VmC0ioC5xb8J+NpAiZoG3TBL7ps0FSwgLeEi8
        2b+PHcRmEVCVWLi5gxnE5hXQlFja+4IFxBYV8JLYsq+dCcTmFLCU6Pn/lBVi225GibajDxkh
        GgQlfky+B9bALCAvsW//VFYIW0ti/c7jTBMY+WchKZuFpGwWkrIFjMyrGCVTC4pz03OLjQqM
        8lLL9YoTc4tL89L1kvNzNzECY2jbYa3+HYyPl8QfYhTgYFTi4eWQLo4SYk0sK67MPcQowcGs
        JML7Zl9RlBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe/vxjkUIC6YklqdmpqQWpRTBZJg5OqQbG
        5fU/TrcnycxQ3mP2YuqmWx9nmuiJxei5brNmWHb/6oyk7c9/csdvYeqdcKLJ6ZDY+SM3I1Zt
        5wzZ/NjWSkV+fdyjjjM9lk8fKSvO6JqYx7rpaunz/Rtsgqa/Mc+q/u9zxZ/n/fGTPuLF2m3r
        FqnpKdjv5pWye6UoJNQXGSJ3f+dRH/FpO833K7EUZyQaajEXFScCAG+SESidAgAA
X-CMS-MailID: 20180201155248epcas2p150aa8f7613f1a4475437c182aab60995
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180131093527epcas2p3978f33b8407c31bd95e01bca682346da
X-RootMTR: 20180131093527epcas2p3978f33b8407c31bd95e01bca682346da
References: <20180131093434.20050-1-ulfalizer@gmail.com>
        <CGME20180131093527epcas2p3978f33b8407c31bd95e01bca682346da@epcas2p3.samsung.com>
        <20180131093434.20050-3-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wednesday, January 31, 2018 10:34:21 AM Ulf Magnusson wrote:
> Blank help texts are probably either a typo, a Kconfig misunderstanding,
> or some kind of half-committing to adding a help text (in which case a
> TODO comment would be clearer, if the help text really can't be added
> right away).
> 
> Best to remove them, IMO.

How about actually adding some meaningful help texts instead
(as a general rule each user visible option should have valid
help text)?

> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  drivers/video/fbdev/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 6962b4583fd7..11e699f1062b 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1156,7 +1156,6 @@ config FB_I810_I2C
>  	bool "Enable DDC Support"
>  	depends on FB_I810 && FB_I810_GTF
>  	select FB_DDC
> -	help

Please add a missing help text instead (take a look at FB_SAVAGE_I2C
config option to see how a valid help text entry should look like).

In the longer term we should consider removing *_I2C config options
and just make the main config options always enable I2C subsystem
directly if needed/useful (some fbdev drivers are doing it this way
already).

>  config FB_LE80578
>  	tristate "Intel LE80578 (Vermilion) support"

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
