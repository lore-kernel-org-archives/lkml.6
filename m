Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbeC1O3G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:29:06 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:29911 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeC1O3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:29:03 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180328142902epoutp02dc93e80a16e9e486e433b25f89440e8a~gG_SEzln73274932749epoutp02D
X-AuditID: b6c32a35-139ff70000000fee-b3-5abba6ad495e
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] video: au1100fb: Delete an unnecessary variable
 initialisation in au1100fb_drv_probe()
Date: Wed, 28 Mar 2018 16:28:59 +0200
Message-id: <2275639.QNQijrIxQE@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <37b97970-6cd7-5c85-a613-8c558b8d4fa0@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7bCmvu7aZbujDI6dkrS48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2B1aP+93HmTyaTrWzenzeJBfAHMVlk5Kak1mWWqRvl8CV0bBoM0vB
        L+aK99M2szQwLmDuYuTkkBAwkdh24w5jFyMXh5DADkaJU5eOsUA43xklXh+ZzwJT1XXuGitE
        YgOjRFfPVjaQhJDAV0aJK03JIDabgJXExPZVQKM4OEQETCX+nAgBqWcW6GCU2Hh8CtggYYFC
        iamtXWA2i4CqxKyTz8Dm8ApoSvxeM5sVxBYV8JLYsq+dCcTmFPCUOPT8CFSNoMSPyffAepkF
        5CX27Z/KCmHrSJw9tg7sBQmBJWwSe179ZoO42kVi3cp9rBC2sMSr41vYQY6TEJCWuHTUFqK+
        mVHi24490LCYwCixZ70QhG0tcfj4RagFfBLvvvawQvTySnS0QZV4SBx+fZARwnaUuHniHDMk
        gG4zSmy9fINlAqPsLCR3z0Jy9ywkdy9gZF7FKJZaUJybnlpsWGCoV5yYW1yal66XnJ+7iREc
        +1qmOxinnPM5xCjAwajEw2uxaHeUEGtiWXFl7iFGCQ5mJRHe9xpAId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rwBAS5RQgLpiSWp2ampBalFMFkmDk6pBkaxyy5TnstbtSsb8V0Tlru8a93Cuw/1
        IptOzY+6vLr33yOhH2KvZz9+0lIduGZfwYe9RpnHKkuOxXMcELW+5Xu5bm3C5VszCxcv/mwx
        786fk5vcc/ufJ2VF5EzsOTw1Ztbv5IOHzZN4hPsXW7vmfYtiX7z36YxvITqHJh+0yxfKT1r8
        T+iDUc0NJZbijERDLeai4kQA8HsorfkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsVy+t9jQd01y3ZHGUxabmpx5et7NovzncuZ
        LbbekrY40feB1eLyrjlsDqwe97uPM3k0nWpn9fi8SS6AOYrLJiU1J7MstUjfLoEro2HRZpaC
        X8wV76dtZmlgXMDcxcjJISFgItF17hprFyMXh5DAOkaJt03n2UASQgJfGSWajtaD2GwCVhIT
        21cxdjFycIgImEr8ORECUs8s0MEoMfHfErBBwgKFElNbu1hAbBYBVYlZJ5+BzeEV0JT4vWY2
        K4gtKuAlsWVfOxOIzSngKXHo+RE2iMW3GSUuHV3JAtEgKPFj8j0wm1lAXmLf/qmsELaWxPqd
        x5kmMPLPQlI2C0nZLCRlCxiZVzFKphYU56bnFhsVGOallusVJ+YWl+al6yXn525iBAbrtsNa
        fTsY7y+JP8QowMGoxMNrsWh3lBBrYllxZe4hRgkOZiUR3vcaQCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8t/OORQoJpCeWpGanphakFsFkmTg4pRoYrfTm67lHc/P057C+fNOqUV6U9nnnp9vX
        rR3uSM6V3bg2s7+q5/JShrT5J1W3zTx0SVzDJefSvBtV/30sS0+nJYRLqa74Yv3qHPuPKRe6
        I81uxG80kXw+tc57pa56x7Twwx+rl9hts9vhGfzg70YO9sPlCkufC/ZNvbV5uYDjnX9Wrz2t
        Ptw/ocRSnJFoqMVcVJwIAOZyKlFSAgAA
X-CMS-MailID: 20180328142900epcas1p3aa7711987df0fecf982a2d8f1044fe81
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171127180150epcas2p28b2fc98c549029837356af0fc6b1244c
X-RootMTR: 20171127180150epcas2p28b2fc98c549029837356af0fc6b1244c
References: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
        <CGME20171127180150epcas2p28b2fc98c549029837356af0fc6b1244c@epcas2p2.samsung.com>
        <37b97970-6cd7-5c85-a613-8c558b8d4fa0@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 27, 2017 07:01:14 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 27 Nov 2017 18:40:23 +0100
> 
> The local variable "fbdev" will be reassigned by a following statement.
> Thus omit the explicit initialisation at the beginning.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
