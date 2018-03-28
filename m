Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeC1OCp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:02:45 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25104 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbeC1OCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:02:39 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180328140238epoutp02c235949cba5b1bb4980308562160e1c2~gGnOscsme2121221212epoutp02J
X-AuditID: b6c32a39-579ff70000000ff4-e8-5abba07decef
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        "'SF Markus Elfring'" <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] video: s3c-fb: Delete an error message for a failed
 memory allocation in s3c_fb_probe()
Date: Wed, 28 Mar 2018 16:02:34 +0200
Message-id: <1678266.t0IYzbM4So@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <000201d367aa$74511b10$5cf35130$@gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7bCmvm7tgt1RBj++GFlc+fqezeJ853Jm
        ixVfZrJbbL0lbXGi7wOrxeVdc9gc2Dx2zrrL7nG/+ziTR9OpdlaPz5vkAliiuGxSUnMyy1KL
        9O0SuDJWN5xhLGhhrZg49wlTA2MLSxcjB4eEgInE+s86XYxcHEICOxglVtz/wQThfGeUON+/
        l7mLkROs6NvJZ6wQid2MEl2f+pghnK+MEs/+HGEBqWITsJKY2L6KEcQWEYiROLB+KhOIzSzQ
        xSjxeIoFiC0sUCQxc9s7VhCbRUBV4vvU42AbeAU0JXoungPrFRXwktiyrx2sl1PAQuL8rllM
        EDWCEj8m32OBmCkvsW//VFYIW0fi7LF1jCAHSQhsYJNoPdMIdbaLxP2NC9ghbGGJV8e3sEP8
        LC1x6agtRH0zo8S3HXug6icwSuxZLwRhW0scPn4RagGfxLuvPawQvbwSHW1QJR4Sd6dfgmp1
        lNh4bAfYbUICpxgl/v6Jn8AoOwvJ2bOQnD0LydkLGJlXMYqlFhTnpqcWGxaY6hUn5haX5qXr
        JefnbmIEJwMtyx2Mx875HGIU4GBU4uEtiNkVJcSaWFZcmXuIUYKDWUmE973G7igh3pTEyqrU
        ovz4otKc1OJDjNIcLErivAEBLlFCAumJJanZqakFqUUwWSYOTqkGxvOHWMLPXn35+/liHabb
        O5SCf/ckb5qzjzlV+MCbzd2Gje4ta8+4r97xeGa56TOHhgf8pvH2Z6tU/3i6TC3eueKD9DXD
        300/eQ42bH30zUc6ffONxTv/nGjWW/706dyppcLau9XUl+esPPZcsSrp37xd952Uz67NaXkl
        dq/+h+PVl2u5Lqt8mzBDiaU4I9FQi7moOBEAcbdPKAIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd2aBbujDJ69tba48vU9m8X5zuXM
        Fiu+zGS32HpL2uJE3wdWi8u75rA5sHnsnHWX3eN+93Emj6ZT7awenzfJBbBEcdmkpOZklqUW
        6dslcGWsbjjDWNDCWjFx7hOmBsYWli5GTg4JAROJbyefsXYxcnEICexklLiwbzozhPOVUeLV
        oW1gVWwCVhIT21cxgtgiAjESqxevZQIpYhboYpS4/H0pK0hCWKBIYua2d2A2i4CqxPepx5lB
        bF4BTYmei+fAmkUFvCS27GtnArE5BSwkzu+axQSx7RSjxI/PPYwQDYISPybfA9vMLCAvsW//
        VFYIW0ti/c7jTBMY+WchKZuFpGwWkrIFjMyrGCVTC4pz03OLjQoM81LL9YoTc4tL89L1kvNz
        NzECg3jbYa2+HYz3l8QfYhTgYFTi4S2I2RUlxJpYVlyZe4hRgoNZSYT3vcbuKCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8t/OORQoJpCeWpGanphakFsFkmTg4pRoYJ9qveLeA4fi+6Kente/E
        SH3fP2PVvX0TM9MeWC+3Skj+dq/404yYLab/J22/tu+DOm+BqH+xWfqX461M8d/PSGqfcI8x
        OF0cemzH49gvfzaJF/D/4ZfyWHb546m+kJIu8zpxlsbmud/s/xywn+6p9uBKmf2iqG9/alh8
        90jN+vT4vH3vgUPOZ5VYijMSDbWYi4oTAZxBTl9eAgAA
X-CMS-MailID: 20180328140237epcas1p2270a64e76960ac266186f6d27e0f1f37
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171127180636epcas1p4bc1c2fa2bc445e6ae4527782c6d2c987
X-RootMTR: 20171127180636epcas1p4bc1c2fa2bc445e6ae4527782c6d2c987
References: <2c837da0-6b0f-12e7-4d76-960b660a8911@users.sourceforge.net>
        <CGME20171127180636epcas1p4bc1c2fa2bc445e6ae4527782c6d2c987@epcas1p4.samsung.com>
        <000201d367aa$74511b10$5cf35130$@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 27, 2017 01:06:30 PM Jingoo Han wrote:
> On Sunday, November 26, 2017 9:17 AM, SF Markus Elfring wrote:
> > 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 26 Nov 2017 15:00:16 +0100
> > 
> > Omit an extra message for a memory allocation failure in this function.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
