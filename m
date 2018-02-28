Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbeB1PKA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:10:00 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:58608 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932121AbeB1PJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:09:54 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180228150951epoutp0314494f9f1c8fbdee991145ca0fabf076~Xhd73l55K0206802068epoutp03M
X-AuditID: b6c32a45-3ebff70000001023-1b-5a96c63e2354
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] console: Expand dummy functions for CFI
Date: Wed, 28 Feb 2018 16:09:47 +0100
Message-id: <1712993.EvPlpO244k@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1519689860-7421-1-git-send-email-keescook@chromium.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7bCmha7dsWlRBrfbVS2ufH3PZtG8eD2b
        xZnuXIsTfR9YLS7vmsNmsWhZK7PFp2f/2C2WrnjLarF65WN2B06P2Q0XWTwWbCr1uHNtD5vH
        /rlr2D3udx9n8vi8Sc5jwYz/LAHsUVw2Kak5mWWpRfp2CVwZU/50MRVMYa44+eYIcwPjaaYu
        Rk4OCQETiT+n9gLZXBxCAjsYJRqm7WaBcL4zShxr2MMOUzV3Yw8bRGI3o8SPR21QzldGibsL
        bzGDVLEJWElMbF/FCGKLCKhKfL/UzAxSxCywhUniVM9bsISwgIPE3d2zwMayABVNO7gTzOYV
        0JR4+Ok8K4gtKuAlsWVfO9iBnAKuEl3fF7FC1AhK/Jh8jwXEZhaQl9i3fyorhK0jcfbYOkaQ
        ZRICt9kkbt34BXW3i8SLfRuZIWxhiVfHt0DFpSWerdoI1bCKUeLn1b9QzmZGic/Xv7JCVFlL
        HD5+EWoFn0TH4b9A3RxAcV6JjjYhiBIPiUcdi9kgbEeJxkPboOEyg1HiVc93pgmMsrOQXD4L
        yeWzkFy+gJF5FaNYakFxbnpqsVGBoV5xYm5xaV66XnJ+7iZGcELRct3BOOOczyFGAQ5GJR5e
        h/3TooRYE8uKK3MPMUpwMCuJ8J7eDhTiTUmsrEotyo8vKs1JLT7EKM3BoiTO2xbgEiUkkJ5Y
        kpqdmlqQWgSTZeLglGpgnD8xfYbzjsd/OIrX8gkueryJqWnKTK1FelP9Re+e+bj3/7d7r73S
        bJnO7/4zVeBLwKlmnku2F3RyXnXMvv6i4sMdzdkB55yU7mQ2/+KXsDKSXHRJ4PoxkS3/9xyz
        Xhmi+WXTBZbVjnG+bo2pknfzOW/vnzXJ90xG4xu3BIMZO/nMVifGTn0w87sSS3FGoqEWc1Fx
        IgCcB3qnJAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jAV3bY9OiDLZsMLa48vU9m0Xz4vVs
        Fme6cy1O9H1gtbi8aw6bxaJlrcwWn579Y7dYuuItq8XqlY/ZHTg9ZjdcZPFYsKnU4861PWwe
        ++euYfe4332cyePzJjmPBTP+swSwR3HZpKTmZJalFunbJXBlTPnTxVQwhbni5JsjzA2Mp5m6
        GDk5JARMJOZu7GHrYuTiEBLYyShx61U/E4TzlVHi4ZUesCo2ASuJie2rGEFsEQFVie+XmplB
        ipgFtjFJtKybyQ6SEBZwkLi7exaYzQJUNO3gTjCbV0BT4uGn86wgtqiAl8SWfe1gQzkFXCW6
        vi9ihdg2i1Hi5oZOJogGQYkfk++xgNjMAvIS+/ZPZYWwtSTW7zzONIGRfxaSsllIymYhKVvA
        yLyKUTK1oDg3PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMw/Lcd1urfwfh4SfwhRgEORiUeXof9
        06KEWBPLiitzDzFKcDArifCe3g4U4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsuffyxSSCA9sSQ1
        OzW1ILUIJsvEwSnVwKhXfnHCJYOa4peb1qqpaL/IVoj9tzxE4IZD54uQDRJLlwV6fRMQzrNa
        qsRmxrg+7eaLiBxegUXdE/Yue1Zu8tVx7tXfSxxe1F9gajlof/KggmfT7Ct1zl8yT+/dJMWZ
        HP2p/EdMsn7usTesi4W8l+etvFQxT/XuP29lj9T+DxN4bhS8nzjh+FQlluKMREMt5qLiRABw
        CfiwewIAAA==
X-CMS-MailID: 20180228150949epcas2p437f68cb95b6c88e6857a538aca13f207
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180227000432epcas2p1408299421426381f05a548283953b064
X-RootMTR: 20180227000432epcas2p1408299421426381f05a548283953b064
References: <CGME20180227000432epcas2p1408299421426381f05a548283953b064@epcas2p1.samsung.com>
        <1519689860-7421-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 26, 2018 04:04:17 PM Kees Cook wrote:
> This is a small series that cleans up struct consw a bit and
> prepares it for Control Flow Integrity checking (i.e. Clang's
> -fsanitize=cfi).

for drivers/video/ parts:

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
