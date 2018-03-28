Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeC1Ng3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:36:29 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58342 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeC1NgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:36:23 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180328133622epoutp04d14f2e8520127a315642893d9a1bca93~gGQS7FURI0637506375epoutp04z
X-AuditID: b6c32a47-0fbff70000000fe8-e4-5abb9a558286
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        "James E. J. Bottomley" <jejb@parisc-linux.org>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 2/2] video/fbdev/stifb: Delete an error message for a
 failed memory allocation in stifb_init_fb()
Date: Wed, 28 Mar 2018 15:36:15 +0200
Message-id: <1633440.9F4sjlxLYt@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <f92f41b1-d4fa-4ffa-8c19-af4eb0d2d8cf@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZdljTQjd01u4og3vLbSzuf7rNaHHl63s2
        izUvVrFbnO9czmxxf90qVoutt6QtTvR9YLW4vGsOm8WjUxeYHDg9PnyM87jffZzJ48Ki36we
        R/5aezSdamf1+LxJLoAtissmJTUnsyy1SN8ugSvjyLwtbAX/mCve9G5kbWCcz9zFyMEhIWAi
        sXuKYBcjF4eQwA5GiRNtP9ggnO+MEi03fjF2MXKCFS1vWc8CkdjAKHHm5jIWkISQwFdGiZ/7
        REBsNgEriYntqxhBpooImEr8ORECUs8ssJBJomljOxNIjbBAlcTqDefZQWwWAVWJfXsOgcV5
        BTQlds9sBbNFBbwktuyDqOcU8JRYsWMDG0SNoMSPyffA9jILyEvs2z+VFcLWkTh7bB0jyDIJ
        gctsEiuO/GKCuNpF4sXcg1C2sMSr41vYIWxpiWerNkI1NDNKfNuxhxkiMYFRYs96IQjbWuLw
        8YtQG/gkOg7/ZYeEF69ERxtUiYfEjhO3oGY6Slze84EVEkKzmCQWXbvPMoFRdhaSw2chOXwW
        ksMXMDKvYhRLLSjOTU8tNiow1itOzC0uzUvXS87P3cQITh5a7jsYt53zOcQowMGoxMNbELMr
        Sog1say4MvcQowQHs5II73uN3VFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVsDXKKEBNITS1Kz
        U1MLUotgskwcnFINjDufSSexLm3a1y7eeOTXhMw7oakd788d9Tfc8HOO6+sXlzNeXtR6Yx+S
        mHX6Hpd6oNPRM7+nS4UJLBVt+RjyqTbh8aWcW09v9278dlxR2zuzJsGU7fjDDQrJKZOuLmm8
        tljqlMz8S4wpQkqWBUmuK2PS1Lz5Frj7zZbl1dK7dSPBukI2/4uroRJLcUaioRZzUXEiACox
        k40aAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t9jQd3QWbujDHbOU7G4/+k2o8WVr+/Z
        LNa8WMVucb5zObPF/XWrWC223pK2ONH3gdXi8q45bBaPTl1gcuD0+PAxzuN+93EmjwuLfrN6
        HPlr7dF0qp3V4/MmuQC2KC6blNSczLLUIn27BK6MI/O2sBX8Y65407uRtYFxPnMXIyeHhICJ
        xPKW9SxdjFwcQgLrGCX+zNzDDOF8ZZTY8v4vK0gVm4CVxMT2VYxdjBwcIgKmEn9OhIDUMAss
        ZpKY8esvI0iNsECVxOoN59lBbBYBVYl9ew4xgdi8ApoSu2e2gtmiAl4SW/a1g9mcAp4SK3Zs
        YINYdoxRYlnndBaIBkGJH5PvgdnMAvIS+/ZPZYWwtSTW7zzONIGRfxaSsllIymYhKVvAyLyK
        UTK1oDg3PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMw4Lcd1urfwfh4SfwhRgEORiUe3oKYXVFC
        rIllxZW5hxglOJiVRHjfa+yOEuJNSaysSi3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1
        tSC1CCbLxMEp1cBo/UrcROos69HtbOWfiis3XF9yKcRsteLZQ8YtAmWxx/irgtWvNOXGO+y4
        nFPcMYWj13dSWkVxasfzjC5znz1q6Yf2aLBetZ9x7vICAe5VdXXep5v0J3RNKuxIuyi192Kp
        bVKts8495jurA1MbmOSSBZoM0tp/RCsZ9iqvSzI8qj/11h6J/UosxRmJhlrMRcWJAIA59JB0
        AgAA
X-CMS-MailID: 20180328133621epcas2p2865976351cf3dc28ac258d2c9530ffcd
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180328133621epcas2p2865976351cf3dc28ac258d2c9530ffcd
X-RootMTR: 20180328133621epcas2p2865976351cf3dc28ac258d2c9530ffcd
References: <7dcd32b6-9691-14a1-29cf-3a746ef5adfc@users.sourceforge.net>
        <889131fe-199c-3bef-0781-00761b807426@users.sourceforge.net>
        <f92f41b1-d4fa-4ffa-8c19-af4eb0d2d8cf@users.sourceforge.net>
        <CGME20180328133621epcas2p2865976351cf3dc28ac258d2c9530ffcd@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, January 07, 2018 12:58:47 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 12:34:22 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
