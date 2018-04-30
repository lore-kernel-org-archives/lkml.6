Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754786AbeD3PfL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:35:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44854 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753981AbeD3PfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:35:07 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180430153504euoutp0142e79d47d0ff3b85ddd7f89e957f4d0f~qQKXdordP0596905969euoutp01d
X-AuditID: cbfec7f4-b4fc79c0000043e4-a4-5ae737a54cfe
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
Date: Mon, 30 Apr 2018 17:34:59 +0200
Message-id: <2928032.Lxc8GNNcDF@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180427182536.skryxiih5lekqoze@darkstar.musicnaut.iki.fi>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djPc7pLzZ9HGXyZxGex5oWDxZWv79ks
        OicuYbc40feB1eLyrjlsFrOX9LNYrJ9/i82B3WN2x0xWj8NfF7J43O8+zuRx/MZ2Jo/Pm+QC
        WKO4bFJSczLLUov07RK4Mg5fXsxacJ21Yu/RY+wNjCdYuhg5OSQETCT+rZ7P1MXIxSEksIJR
        4vTRdhYI5zOjxK5FN+Cqfu5sh6paxiixee9WZgjnN6PEk2u/GUGq2ASsJCa2rwKzRQQ0JF7t
        62cFKWIWuMcocf/9A7BRwgKmEsv+b2cGsVkEVCUmvvvK1sXIwcEroCmxag4vSFhUwEtiyz6Q
        bZwcnAIeEg827GIFsXkFBCV+TL4HNoZZQF5i3/6prBC2jsTZY+sYQXZJCBxgk7j4dAorxNku
        En/b+qFsYYlXx7ewQ9gyEp0dB5kgGpoZJb7t2MMMkZjAKLFnvRCEbS1x+PhFqA18EpO2TWcG
        OVRCgFeiow2qxEPi7qWdbBC2o8TKr++gYbebUeLx529sExhlZyE5fBaSw2chOXwBI/MqRvHU
        0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwERx+t/xLzsYd/1JOsQowMGoxMPLIf88Sog1say4
        MvcQowQHs5II78qOZ1FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeeM06qKEBNITS1KzU1MLUotg
        skwcnFINjKuV6qTWy95UmndS3YhJODrg0yqmP8Kn7Odoxyp+VYhcPmX3Ia3yh/1b3YySVgqc
        nHOlkbtY8sAH7fmTpUP9p35eJ5x4s2633vTK3enaa5OTRWp6UuP0ZzFWaYaa74lNOuK86ImO
        XrZlgeafSw+fXnq3+reMsevrCyFtD38d+zLhSuHJPdc2CymxFGckGmoxFxUnAgAlXmBUEAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t/xq7qLzZ9HGWz6oGux5oWDxZWv79ks
        OicuYbc40feB1eLyrjlsFrOX9LNYrJ9/i82B3WN2x0xWj8NfF7J43O8+zuRx/MZ2Jo/Pm+QC
        WKO4bFJSczLLUov07RK4Mg5fXsxacJ21Yu/RY+wNjCdYuhg5OSQETCR+7mxn6mLk4hASWMIo
        savnKSuE85dRYs/jz6wgVWwCVhIT21cxgtgiAhoSr/b1gxUxC9xjlGic8JMdJCEsYCqx7P92
        ZhCbRUBVYuK7r2xdjBwcvAKaEqvm8IKERQW8JLbsA9nGycEp4CHxYMMuqGV7GSXONc0A6+UV
        EJT4Mfke2HnMAvIS+/ZPZYWwtSTW7zzONIGRfxaSsllIymYhKVvAyLyKUSS1tDg3PbfYUK84
        Mbe4NC9dLzk/dxMjMJi3Hfu5eQfjpY3BhxgFOBiVeHg55J9HCbEmlhVX5h5ilOBgVhLhXdnx
        LEqINyWxsiq1KD++qDQntfgQozQHi5I473mDyighgfTEktTs1NSC1CKYLBMHp1QDowpjmUhD
        k7Tu8k9SW85NPfxyxoXt/j16XGWTFi2InnagYFvdhXeVEuJnv3T9Xr65+i/r7e6kX+/vT+xZ
        uGN15oMC+1Ndu9wXxsvJrT67KyWkR25hWm7zxS0i7U3V17S5eI91OTftEuoze3Ql1WDFr0ML
        CiS+Bjzs3BGzxvPQ+xU3bt+c2L8irlSJpTgj0VCLuag4EQB4QmXDYgIAAA==
X-CMS-MailID: 20180430153459eucas1p1957ccaa32cee3d6ed3e4d6f23546c752
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c
X-RootMTR: 20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
        <2238944.jilJcacc6d@amdc3058>
        <20180427182536.skryxiih5lekqoze@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, April 27, 2018 09:25:37 PM Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Apr 27, 2018 at 05:09:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > omapfb equivalent of drm's commit aa61321d4c08 ("drm/omap: remove rfbi"):
> > 
> > The RFBI driver has not worked nor compiled for many years. There are
> 
> What is the build failure you are seeing?
> 
> When removing the "BROKEN", it seems to compile fine, only some sparse
> warnings:

BROKEN is not an user selectable config option so without modifying
drivers/video/fbdev/omap2/omapfb/dss/Kconfig the RFBI driver is not
even included in the kernel build..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
