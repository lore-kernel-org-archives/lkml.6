Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA08C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F410621841
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfAJTB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:01:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:33763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfAJTB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:01:57 -0500
Received: from [91.14.65.202] ([91.14.65.202]) by web-mail.gmx.net
 (3c-app-gmx-bs35.server.lan [172.19.170.87]) (via HTTP); Thu, 10 Jan 2019
 20:01:37 +0100
MIME-Version: 1.0
Message-ID: <trinity-0da588a3-1277-4421-ad6b-1f6aeb129dd6-1547146897687@3c-app-gmx-bs35>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Daniel Vetter" <daniel@ffwll.ch>
Cc:     "CK Hu" <ck.hu@mediatek.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "Alexander Ryabchenko" <d3adme4t@gmail.com>
Subject: Aw: Re: [PATCH] drm/mediatek: Add MTK Framebuffer-Device (mt7623)
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Jan 2019 20:01:37 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
References: <20190102084917.4049-1-frank-w@public-files.de>
 <20190107103640.GH21184@phenom.ffwll.local>
 <CAKMK7uEqxz4TAt_iwEC+dMWboVxCeCduyABsSwD0Ns7k=Z_UWA@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:xedABUXpNk/nNIw+pzn6H/6zhL8w0LyGmHIfFGWyhpMYu2A/+dCAzn6j9eXepGOFzS24L
 JV/TUt0pKZMfDb4/x9wsMXXNjJkKGUfZD9MFnaOjF1qyz1G+7LpRFjAn5xFwKhK8f2Ti1/1iuRhL
 OTYVw0t/pIHNXEu41Ax/n9IMA8SzqjPJXCYlw+Cr3IuGvFdilFbfsRU5DcCcGgDGbtJkAA1PjAg9
 sYfnCpRG6Rhy5W8P2LvX8vVGKVuKvq2fl7tux3uHtHmp8SUDa50zNti33p1QaVSgpqrz0LKyuvPi
 a4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:lqvXuVTiSD8=:DRKehKc2DdRFIpMmuNF02M
 XCSxz5gW/zZ9h9D6KeaZjQ4tQJj039IaoTzsJRSKjLMLoSQxbxPlsf9s8vfBnyHBlHOjTaLKl
 cOmB6ACA2677K6JZ92GDCmikdyWPwvk+Rvj194TN5qTOB70CgPNDCIwPd2q5xKOV7B19keZdQ
 qdqTLLse+BpP+tCKrF2VS+faT/0qh4XN9+tSMKZRF7+DnyF7Wme4PAVcgvIXjpL4ytQ73gvNj
 J6ig/WRoBa7BDXRT0Gi7PAcJbOaZ+o1kq+XmW5a4OFOT3nyc1Xz80f6qKBQRx9cCElKMvSUsW
 LgWOxysay4FT81G3xOy+fdiQiY3Gbl3e4RBS1HTM12pLGLto+F+RAPpSbkyofe/XYKTSjtORq
 02ASACd0WCObgtmB3T7zKHeOEX/fMcpMcsfTCUkVIcgdwoVYnYk+qXZv+RkxTJHWkn1Ku9NdW
 K3mZDcstElJKjXLY9DymO4LBBrYA0Sw2G3olDCZXCywkLXIpX/Vc8+v9J65XmbMIOUpVPS3iI
 0VSdc+nvZhYcweDQYEWev3xmQbwfwzd4WhKU/OVOiyLDAADJdIhc+AmME8Wyt+iGGX1cbLQpR
 XiFv2PdCN/O0A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

> > Would be good to use the new generic fbdev emulation code here, for even
> > less code. Or at least know why this isn't possible to use for mtk (and
> > maybe address that in the core code). Hand-rolling fbdev code shouldn't be
> > needed anymore.
> 
> Back on the mailing list, no private replies please:

i don't wanted to spam all people with dumb questions ;)

> For examples please grep for drm_fbdev_generic_setup(). There's also a
> still in-flight series from Gerd Hoffmann to convert over bochs. That,
> plus all the kerneldoc linked from there should get you started.
> -Daniel

this is one of google best founds if i search for drm_fbdev_generic_setup:

https://lkml.org/lkml/2018/12/19/305

not very helpful...

so i tried kernel-doc

https://www.kernel.org/doc/html/latest/gpu/drm-kms-helpers.html?highlight=drm_fbdev_generic_setup#c.drm_fbdev_generic_setup

which is nice function-reference but i've found no generic workflow

as the posted driver is "only" a driver ported from kernel 4.4 by Alexander, i don't know if this new framework can be used and which parts need to be changed. I only try to bring his code Mainline....
Maybe CK Hu can help here because driver is originally from him and he knows internals. Or maybe you can help here?

i personally make my first steps as spare-time kernel-developer :)

regards Frank
