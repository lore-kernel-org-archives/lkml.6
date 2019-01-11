Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE93D21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388020AbfAKSYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:24:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:40051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbfAKSYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:24:02 -0500
Received: from [91.14.68.96] ([91.14.68.96]) by web-mail.gmx.net
 (3c-app-gmx-bs19.server.lan [172.19.170.71]) (via HTTP); Fri, 11 Jan 2019
 19:23:42 +0100
MIME-Version: 1.0
Message-ID: <trinity-c852a1ec-38d2-41d2-aefd-9cd385e8f772-1547231022924@3c-app-gmx-bs19>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "CK Hu" <ck.hu@mediatek.com>
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        =?UTF-8?Q?=22Noralf_Tr=C3=B8nnes=22?= <noralf@tronnes.org>,
        "David Airlie" <airlied@linux.ie>,
        "Alexander Ryabchenko" <d3adme4t@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Subject: Aw: Re: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device
 (mt7623)
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Jan 2019 19:23:42 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <1547200155.4209.4.camel@mtksdaap41>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
 <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
 <20190110200225.GN21184@phenom.ffwll.local>
 <1547176809.12054.11.camel@mtksdaap41>
 <20190111092042.GP21184@phenom.ffwll.local>
 <1547200155.4209.4.camel@mtksdaap41>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:NGINZ32in0gJOYgqnehPufFl27JbseS0W1WDvSwCXAWeVB7ovN1HP9XbE2/KbPzEH4s7y
 Au2fZJ+qSNpYP4hJ8/Z+1Ffch9I3l6fVMtuepjTGZTM8owWMSYSX23jLqqIKFyViD4J4Sft052Q8
 GPGnmvK+z6DT34gaEkk5dSk+wexCV9xRp0p2R8f/icf2sPrXc//FIgZ5dm1jRVbSrCpkqwIxrWBz
 prVRFC9lIE3jzJqk6oh44rqUyTX4Lf9GWS6OtizTXA3VPVJ8eprT5OB1eDVF+s1qVnI+BGYhi5Ab
 /s=
X-UI-Out-Filterresults: notjunk:1;V03:K0:6l6+usElRyM=:rXBiu8jUm+iNKc6hAZyGQr
 6yeOHxrZr7W+1WgPTtmqWgLCG6gF1G40PZ5xxSJ0rQzY6PaQ8lboaQju2GM6aAAXQxWfkEML7
 awv8mRDAeYHoZrxrJTDMa3SqLXDRnlPCgabpaD8DTLiCTz3t1qSIcH45xDIUfsZGapOa2HRDC
 iSk2OSCxcRe7+sjP1rLy8vVUVFZzAjF1VadqWylkm4jPnwvuMrMykWjjalzQsvO4/Z8pZZ6hN
 fxFDu1Z+I+57fJ2Df/ynTw3W2KcsAGAqPmz+FJebYEs226sSapi1bmXN3BVsF6sF7eXx8/WVJ
 7HztmrzMTuHwqM2YzDgcR5y3XzUw5oZsEVleVZXsoGFmjKWVckdx77qzFbW901QytdIhrDOdX
 BDeoxdW3VrM0kaza83lOTTfSPA6MU9hRHVK5w8lmrXnfoafBZEB8Gk5a6UaAHMb8yG8j9oM9f
 BT7S7W9PwUy7XDaiEoi4XCS40PYr9usQGfmDK2/zFDo2mPT4L1Kny3yTyRxLh7tddgZELALZ6
 7UgryerD+JzUQMs8kCQPUIrjQES+G9GJushGf7T4madV6eSwxbFlb0lGG/4TQMtCWipEt23Rk
 7bveZzVqp0hW8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

like Daniel guessed, fb-console does not work with this Patch.

i tried your Patch (additional patch for headerfile): https://github.com/frank-w/BPI-R2-4.14/commits/4.20-fbdev

and R2 hangs  (no crash and no further boot)

[    5.435075] mediatek-drm 14000000.dispsys: bound 14012000.rdma (ops mtk_disp)
[    5.435134] mediatek-drm 14000000.dispsys: bound 14014000.dpi (ops mtk_dpi_c)
[    5.459277] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).      
[    5.465863] [drm] No driver support for vblank timestamp query.              
[    5.472331] [drm] Initialized mediatek 1.0.0 20150513 for 14000000.dispsys o0

my monitor is switched on, but no output....we had added fbdev-driver to get FB-console over hdmi, so it's currently useless

regards Frank
