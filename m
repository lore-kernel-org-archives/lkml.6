Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F93C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE79214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE79214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeKTVEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:04:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:57629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbeKTVEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:04:49 -0500
Received: from [91.14.85.22] ([91.14.85.22]) by web-mail.gmx.net
 (3c-app-gmx-bs39.server.lan [172.19.170.91]) (via HTTP); Tue, 20 Nov 2018
 11:34:14 +0100
MIME-Version: 1.0
Message-ID: <trinity-cbebb6c8-0084-49a7-b07a-8ea3dbd13e6e-1542710054258@3c-app-gmx-bs39>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Matthias Brugger" <matthias.bgg@gmail.com>
Cc:     "CK Hu" <ck.hu@mediatek.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, sean.wang@kernel.org,
        "Matthias Brugger" <mbrugger@suse.com>, airlied@linux.ie,
        mturquette@baylibre.com, sean.wang@mediatek.com,
        sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, wens@csie.org, robh+dt@kernel.org,
        rdunlap@infradead.org, laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, matthias.bgg@kernel.org,
        ulrich.hecht+renesas@gmail.com, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Aw: Re:  Re: [PATCH v5 05/12] drm: mediatek
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Nov 2018 11:34:14 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <1192d203-fcd1-47b0-00bc-9d513e5ffc3e@gmail.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-6-matthias.bgg@kernel.org>
 <1542605939.32082.12.camel@mtksdaap41>
 <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
 <1542686700.9073.15.camel@mtksdaap41> <1542686982.26483.1.camel@mtksdaap41>
 <trinity-8f0fde8e-5ef3-4272-b009-49e180c934eb-1542702383860@3c-app-gmx-bs39>
 <1192d203-fcd1-47b0-00bc-9d513e5ffc3e@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Cg3WJSTFzZ8O319bq3fGOQrXK3/sEoILitbD6OZfkSSBFOP9aa4jubHZTYlbzujgEHJ1D
 nRp8KWp07akmJ1NgMu03bZQoQ43IJeXkgRVJrRDgyW7PqhD0Vr5vywDmh82sToRYZD3w/hUXsyfo
 FYEtZQ9EPFV3QbzWEoQ2tht5eHhRNrIR1/UK7oYqyk/fryfAI6f+QLuxT2/YCUL+P8zhEnhcf7MP
 hpi4sW7jNTE/IMh92gjumfuyo9jgJJbeWjWSaFgSmrdHKa15qC7DRs/Y63nNi4PorDbl34YZB4lo
 MY=
X-UI-Out-Filterresults: notjunk:1;V01:K0:2omWjh1OKRM=:4fKr1EztsEI/2ZyncKnTb9
 pEOeGlXMhoGzGv3iiJtM6kaWxINeCRq3R3jCDaN4Z+81qtDNBjZo5wfwFHmRblRtorh8ld2Z8
 hKbXxNAs1O1L3gpHQCeRdT0DafO9TMPUm7vfNP1UZRo2uATlz2nNNZHVZfAvUYDyhJ6U4bBwT
 kk+cqgjVJYcyzqAK1fV+JScnVlY4+sQJU7CoR7wK+47N613pJeB49/9gDOfwaetUF8CSLBJoa
 pxdmz0Gr54uczhgoTlgczCMsk9VlnMd769iokvbyF4taFLDvm4HHYk/RWiICNBJFbqRwRWU0q
 AXh6S1P+1ewDngf56gMOUdsWFV4Tm0fiMHSGyNOQ1uE+QWUd6B7w6RrgByRn8yskgr7do67NP
 LCwOgkH2HqmFlxLPjhettgKF62MU8MwQp7kJmP0RldccgaE3kw+I9+Si1/H5eZdCUL/MXS1rP
 1ekUoAiI6BmaxqUWVqG/0B8TP+VjAiVNnA+96sS02y+fhbAz/qCghjEjcLUKx9zWb0Ae1eYNF
 KRox/SIHdagtSejZIgYvQQxjvoDTakbKwLjmXiz810V2m2wF1IIRA/3PGQqbKHUMdmdpy1VDT
 aXJs5it02J1lY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

right this branch based on rc1 with some other commits, but v5-patches are applied on Oct 3rd (listed in Oct 5th)

frank@frank-N56VZ:/media/data_ext/bpi-r2-kernel/github
[11:29:10]$ git checkout 4.19-hdmiv5
Already on '4.19-hdmiv5'
Your branch is up to date with 'origin/4.19-hdmiv5'.
frank@frank-N56VZ:/media/data_ext/bpi-r2-kernel/github
[11:29:13]$ make kernelversion
4.19.0-rc1
frank@frank-N56VZ:/media/data_ext/bpi-r2-kernel/github
[11:29:19]$ git log --oneline
...
fc14b8c515de drm/mediatek: add a error return value when clock driver has been prepared
0dc856306aaf drm/mediatek: implement connection from BLS to DPI0
3d0a6749bfe3 drm/mediatek: add hdmi driver for MT2701 and MT7623
b03e1b353b28 drm/mediatek: add support for SPDIF audio in HDMI
c5564966272e drm/mediatek: separate hdmi phy to different file
dee3954828db drm/mediatek: add dpi driver for mt2701 and mt7623
a838ae8b415c drm/mediatek: convert dpi driver to use drm_of_find_panel_or_bridge
f7f9f7c080ae drm/mediatek: add clock factor for different IC
be1a5447330f drm/mediatek: adjust EDGE to match clock and data
fec4504ea318 drm/mediatek: move hardware register to node data
db992e429b9c drm/mediatek: add refcount for DPI power on/off
...

compared with 4.19.0-release there is merge https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/mediatek?id=53b3b6bbfde6aae8d1ededc86ad4e0e1e00eb5f8 which seems to break v5-patches

> Gesendet: Dienstag, 20. November 2018 um 11:14 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
> An: "Frank Wunderlich" <frank-w@public-files.de>, "CK Hu" <ck.hu@mediatek.com>
> Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sean.wang@kernel.org, "Matthias Brugger" <mbrugger@suse.com>, airlied@linux.ie, mturquette@baylibre.com, sean.wang@mediatek.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, wens@csie.org, robh+dt@kernel.org, rdunlap@infradead.org, laurent.pinchart@ideasonboard.com, p.zabel@pengutronix.de, matthias.bgg@kernel.org, ulrich.hecht+renesas@gmail.com, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
> Betreff: Re: Aw: Re: [PATCH v5 05/12] drm: mediatek
>
> 
> 
> On 20/11/2018 09:26, Frank Wunderlich wrote:
> > Hi,
> > 
> > i got v5-patches working on bpi-r2 (mt7623) with a Patch from Ryder.lee and 2 from Bibby Hsieh on 4.19-rc1
> > 
> > https://github.com/frank-w/BPI-R2-4.14/commits/4.19-hdmiv5
> > 
> 
> I don't see the patches applied to this tree. Apart from that this tree has a
> lot of other patches applied. It differs greatly from mainline, so nothing we
> should discuss on this mailinglist.
> 
> Regards,
> Matthias
> 
> > but after i tried to include them on 4.19.2, i got a strange behaviour (stretched and pink font instead of white/grey)
> > 
> > see here for detailed info:
> > 
> > http://forum.banana-pi.org/t/kernel-4-19-rc1-for-testers/6618/75
> > 
> > there are some patches between rc1 and final which i tried to revert, but no luck till now (cannot revert, no effect on the issue or no output). Had informed Bibby Hsieh...
> > 
> > is there any idea, why this happen?
> > 
> > regards Frank
> > 
> 
