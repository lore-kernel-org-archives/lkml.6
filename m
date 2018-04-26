Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755199AbeDZJ5P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:57:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60878 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755227AbeDZJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:55:27 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180426095524euoutp0194e27d256ad74afa6549072607d8316f~o88pssA6C0515105151euoutp016
X-AuditID: cbfec7f4-713ff700000043e4-fb-5ae1a20b8e65
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] video: sh_mobile_meram: Delete an error message for a
 failed memory allocation in sh_mobile_meram_probe()
Date: Thu, 26 Apr 2018 11:55:21 +0200
Message-id: <5653552.NjqMPzOcdg@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1feb3cf8-77e6-367e-5f5c-23fdd96339ec@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djPc7rcix5GGfzt5La48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2B1aP+93HmTyaTrWzenzeJBfAHMVlk5Kak1mWWqRvl8CVcWDCf8aC
        zywVTxaeZGlg/MvcxcjJISFgInG39ziQzcUhJLCCUaL1y2lGCOczo8SCF++YYKqWTu9lgUgs
        Y5SY/WQFO0hCSOA3o8SD3/YgNpuAlcTE9lVA3RwcIgKmEn9OhIDUMwt0MEpsPD4FrFlYoIFR
        4s+DOUwgRSwCqhIzz5aC9PIKaErcXjuBEcQWFfCS2LKvHWwxp4CnRN/eGUwQNYISPybfYwGx
        mQXkJfbtn8oKYetInD22jhHi0AVsEhca8iFsF4k9+6dDvSks8er4FnYIW0ais+MgE8g9EgLN
        jBLfduyBKprAKLFnvRCEbS1x+PhFqAV8EpO2gQziAIrzSnS0QZV4SFy6NJsFwnaU+HD+Exsk
        gOYwStx7tpR1AqPsLCR3z0Jy9ywkdy9gZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kR
        GP2n/x3/soNx15+kQ4wCHIxKPLw/5j2IEmJNLCuuzD3EKMHBrCTCG9/6MEqINyWxsiq1KD++
        qDQntfgQozQHi5I4b5xGXZSQQHpiSWp2ampBahFMlomDU6qB0V7QdZvPlR9qW/NVy64HCF6a
        vybgl+dsfgatr+1Pdm3Xmbg2a27KhgX95/LnMjyr4t67pLX/7b9JWXIHmQ9lM2VGTm7fZLfb
        c/fN2AQngcKHeyZHbEjcZ68Q8e1MSMqjzgdfYyou1W9gDOBKP73At0jf8dSj3Ha7bAHXM85c
        hqtS/iyoP/LwnRJLcUaioRZzUXEiAFU30Sz6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsVy+t/xq7pcix5GGSyaLWdx5et7NovzncuZ
        LbbekrY40feB1eLyrjlsDqwe97uPM3k0nWpn9fi8SS6AOYrLJiU1J7MstUjfLoEr48CE/4wF
        n1kqniw8ydLA+Je5i5GTQ0LARGLp9F6WLkYuDiGBJYwSR+YvZoJw/jJKXDo9GayKTcBKYmL7
        KsYuRg4OEQFTiT8nQkBqmAU6GCUm/lvCDOIICzQwSvx5MIcJpIhFQFVi5tlSkF5eAU2J22sn
        MILYogJeElv2tTOB2JwCnhJ9e2dALZvHKNG+bjszRIOgxI/J91hAbGYBeYl9+6eyQthaEut3
        HmeawMg/C0nZLCRls5CULWBkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREYpNuO/dy8g/HS
        xuBDjAIcjEo8vD/mPYgSYk0sK67MPcQowcGsJMIb3/owSog3JbGyKrUoP76oNCe1+BCjNAeL
        kjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVANjnXJv8DnlBfbzb2h66KlPb8/9/zNXdKXPhHPd
        R0K1T3xZEna0PPXQCbu8lnbx5aJK9ywWdocnH99y2MXsxN7nISdqLre3sNtXPEoP7bywe+2Z
        K66v67V0PXxP2Sy7cu9900TvVTqXBHYe36F07EV1wd5K75nm6sdOz/wcHlG3ucz4tk7nDdmz
        SizFGYmGWsxFxYkAoWHSQ04CAAA=
X-CMS-MailID: 20180426095522eucas1p1fd6bd736f428f688cb2cc7c78458ea81
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171126121927epcas1p458cb7728927507525b54a47a9dfc6529
X-RootMTR: 20171126121927epcas1p458cb7728927507525b54a47a9dfc6529
References: <CGME20171126121927epcas1p458cb7728927507525b54a47a9dfc6529@epcas1p4.samsung.com>
        <1feb3cf8-77e6-367e-5f5c-23fdd96339ec@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, November 26, 2017 01:19:17 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 26 Nov 2017 13:08:43 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I've done requested audit regarding multiple fb devices support
myself now and it is okay to apply this patch.

Patch queued for 4.18, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
