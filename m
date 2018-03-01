Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030202AbeCAKwZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:52:25 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:29002 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966899AbeCAKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:52:20 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180301105218epoutp01e3c97a2cdace99e7730a35d37222d9df~XxmVmq4J81306213062epoutp01P
X-AuditID: b6c32a38-ac3ff70000001054-57-5a97db61d5af
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Tejun Heo <tj@kernel.org>, Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: add Amiga Gayle PATA controller driver
Date: Thu, 01 Mar 2018 11:52:14 +0100
Message-id: <2435240.vCYXG2Zeag@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <4c590675-71dc-d7f1-b40f-3b0ee124082a@physik.fu-berlin.de>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7bCmvm7i7elRBsePC1o8u7WXyWL2e2WL
        YzseMVlc3jWHzWL5k7XMFnNbp7Nb/Fp+lNGB3WPnrLvsHptWdbJ5HDrcwehxsvUbi8fBc+cY
        PT5vkgtgi+KySUnNySxLLdK3S+DKWHpwNnNBN2vFvNenWRsYfzF3MXJwSAiYSHRf4Oli5OQQ
        EtjBKHHlT0wXIxeQ/Z1R4n3TdBaQBEjNkvM/mCASuxklZn46xwrhfGWUeHL5O1gVm4CVxMT2
        VYwgtoiAjcS/j7/ZQGxmgXOMEu1bFUBsYQEHiZmbG9hBbBYBVYnrP4+C1fMKaEqsPPUEzBYV
        8JLYsq+dCeQ6TgF3icnT4iFKBCV+TL7HAjFSXmLf/qmsELaOxNlj6xhB7pEQOMImMf/WB2aI
        q10kDq59zgZhC0u8Or6FHeJjaYlLR20h6psZJb7t2ANVP4FRYs96IQjbWuLw8YtQC/gk3n3t
        YYXo5ZXoaBOCMD0knj0Uh6h2lFjSfZ4ZEiTXGSX+zT3FPoFRdhaSs2chOXsWkrMXMDKvYhRL
        LSjOTU8tNiww0StOzC0uzUvXS87P3cQIThNaFjsY95zzOcQowMGoxMPrsH9alBBrYllxZe4h
        RgkOZiUR3tPbgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5AwJcooQE0hNLUrNTUwtSi2CyTByc
        Ug2MObmyy6aHLGk/uXXn6VnJAQtCzMO2XpDv7Vpi0erQbt2668zKpcsMuLcqO9r6WM/T26/K
        9D59vujqVnOhjx8NhHgkvn2ynZL+cOYf9Wl5j72MfSalZyhNZp6VEaTbuDVGaHuh2Y+vmzmC
        dYXmzV3tLpx1clHb1C2LFjlrvH5pURi6PKlyefVKJZbijERDLeai4kQAOlSvBQ8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsVy+t9jAd2E29OjDFbvsrB4dmsvk8Xs98oW
        x3Y8YrK4vGsOm8XyJ2uZLea2Tme3+LX8KKMDu8fOWXfZPTat6mTzOHS4g9HjZOs3Fo+D584x
        enzeJBfAFsVlk5Kak1mWWqRvl8CVsfTgbOaCbtaKea9PszYw/mLuYuTkkBAwkVhy/gcTiC0k
        sJNR4ugS/S5GLiD7K6PExYenwBJsAlYSE9tXMYLYIgI2Ev8+/mYDsZkFzjFK7FpmBmILCzhI
        zNzcwA5iswioSlz/eRSsnldAU2LlqSdgtqiAl8SWfe1AMzk4OAXcJSZPi4fYdZNRYuYhiF5e
        AUGJH5PvsUDMl5fYt38qK4StJbF+53GmCYz8s5CUzUJSNgtJ2QJG5lWMkqkFxbnpucVGBYZ5
        qeV6xYm5xaV56XrJ+bmbGIHBve2wVt8OxvtL4g8xCnAwKvHwOuyfFiXEmlhWXJl7iFGCg1lJ
        hPf0dqAQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFINjOZO
        YQ1nQmtMFzssj7iVG3x4zQb3TQq/5n5SvqWmsID1GJst68ajbUWLTC8e27H2fcBGm1YJi5gb
        H0KuTj/L+evirSn9bXxv3yQfripz0DAOnL7o45bNfFf/pE9exPf555z5XvJLYm+lx/8z6dCS
        8QrZMPfkT5M3X/gTZt4xWfxYu8yfUdLAUE2JpTgj0VCLuag4EQD1zto7agIAAA==
X-CMS-MailID: 20180301105216epcas1p4b08417478030bcb0fb17566cf59c2bca
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3
X-RootMTR: 20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3
References: <CGME20180212134949epcas2p37f0bdae15608340bc21dbb2358db8df3@epcas2p3.samsung.com>
        <19df19ad-47e8-1f17-6b7f-39365cd0d4df@physik.fu-berlin.de>
        <4c590675-71dc-d7f1-b40f-3b0ee124082a@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 01, 2018 10:55:48 AM John Paul Adrian Glaubitz wrote:
> Hello!

Hi,

> On 02/18/2018 05:18 PM, John Paul Adrian Glaubitz wrote:
> > Is there any progress on this? Is it just the SDPX headers now that
> > are missing?
> 
> Would it be okay if re-send the patch with the SPDX headers added?
> 
> Or can we get the patch merged, then I'll send a patch to add the
> SPDX headers?

I'll post updated version later today, sorry for the delay (I've been
busy with other things and the patch is not v4.16 material anyway).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
