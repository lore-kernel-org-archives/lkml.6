Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753527AbeC1OZX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:25:23 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:44050 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbeC1OZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:25:21 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180328142519epoutp01b090e4538f46f9edea7b1e458a091c5d~gG7CXeguL0993209932epoutp01Q
X-AuditID: b6c32a45-6ebff70000000fe4-33-5abba5cef8c8
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] video: au1100fb: Delete an error message for a
 failed memory allocation in au1100fb_drv_probe()
Date: Wed, 28 Mar 2018 16:25:15 +0200
Message-id: <3174977.dCR0SWXXyp@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <f2ad18dd-2525-d8d9-10a8-c12b345cb509@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWy7bCmhe65pbujDNY+FLS48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2B1aP+93HmTyaTrWzenzeJBfAHMVlk5Kak1mWWqRvl8CVMX2jekED
        S8WbzgmsDYwLmbsYOTgkBEwkds4M72Lk4hAS2MEocWTNPyYI5zujxNJDC9m6GDnBij6tvcQC
        kdjNKLHwxWVGCOcro8Sm8weZQKrYBKwkJravYgQZKyJgKvHnRAhIDbNAB6PExuNTWEBqhAWq
        JD4unckMYrMIqEq8fHWetYuRnYNXQFNiCyNIVFTAS2LLvnawiZwCnhJ3ulrBqnkFBCV+TL4H
        NoVZQF5i3/6prBC2jsTZY+vAzpEQWMAm8bnhORPE0S4Sa6feZoawhSVeHd/CDmFLSzxbtRGq
        oZlR4tuOPVBFExgl9qwXgrCtJQ4fvwi1gU+i4/Bfdkhw8Up0tEGVeEjsn9AE1eooseDkE3ZI
        mNxmlDi5fibLBEbZWUgOn4Xk8FlIDl/AyLyKUSy1oDg3PbXYqMBQrzgxt7g0L10vOT93EyM4
        7rVcdzDOOOdziFGAg1GJh9di0e4oIdbEsuLK3EOMEhzMSiK87zWAQrwpiZVVqUX58UWlOanF
        hxilOViUxHnbAlyihATSE0tSs1NTC1KLYLJMHJxSDYxCawS+b+D6Yur8KGwfj/6GvSeN3gZm
        /pZZFXVHfY9oZc+0nkm+Tye0Jz/w2Pfp7ZzSF3v/PO27EWPhorB9RtOzNKY88cPhHxcZC+7q
        kNzXcO73h+kPsi51v/3/Yc/CNslnk3i+3o0+wK7cds8qVP3EGo8E382s3dt+VHU8rzhz88Vy
        EbHjy/IFlViKMxINtZiLihMBqBWdPPcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsVy+t9jAd2zS3dHGdx7oG5x5et7NovzncuZ
        LbbekrY40feB1eLyrjlsDqwe97uPM3k0nWpn9fi8SS6AOYrLJiU1J7MstUjfLoErY/pG9YIG
        loo3nRNYGxgXMncxcnJICJhIfFp7iQXEFhLYySjxZ55/FyMXkP2VUeL83p+MIAk2ASuJie2r
        gGwODhEBU4k/J0JAapgFOhglJv5bAjZIWKBK4sv76WD1LAKqEi9fnWftYmTn4BXQlNgCFhUV
        8JLYsq+dCcTmFPCUuNPVygyx6jajxN3ZF8ASvAKCEj8m3wO7h1lAXmLf/qmsELaWxPqdx5km
        MPLPQlI2C0nZLCRlCxiZVzFKphYU56bnFhsVGOWllusVJ+YWl+al6yXn525iBIbptsNa/TsY
        Hy+JP8QowMGoxMNrsWh3lBBrYllxZe4hRgkOZiUR3vcaQCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8/PnHIoUE0hNLUrNTUwtSi2CyTBycUg2MKtnuKrkqIefiTK6UqzoaPOT+/XvbrBuOc4Ty
        RJ2Y/u8NPum8YhXDnvV1jtu2LDhgcu+OyU5//YQtrD9nz4n1UL3w55622FZxKwnHbv25ubOe
        bJoiV1WdtGWZ+qnMuHxWLle/xUKHH6mn8Gyrtq7kNGaqXfTXxymzcN37nKvnlqlU9S+5pLtb
        iaU4I9FQi7moOBEAG9jQi08CAAA=
X-CMS-MailID: 20180328142517epcas2p28aaeae6a51bcb51469110f6b49c2b764
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171127214358epcas1p35be7cd2052b40ab61f798701b67d25cd
X-RootMTR: 20171127214358epcas1p35be7cd2052b40ab61f798701b67d25cd
References: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
        <CGME20171127214358epcas1p35be7cd2052b40ab61f798701b67d25cd@epcas1p3.samsung.com>
        <f2ad18dd-2525-d8d9-10a8-c12b345cb509@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 27, 2017 06:58:22 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 27 Nov 2017 18:14:41 +0100
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
