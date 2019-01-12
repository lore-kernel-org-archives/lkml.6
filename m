Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF5AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05072086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfALSxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:53:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41658 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfALSxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:53:48 -0500
Received: from p54b26ced.dip0.t-ipconnect.de ([84.178.108.237] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1giOPa-0006j3-6C; Sat, 12 Jan 2019 19:53:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, hjc@rock-chips.com,
        airlied@linux.ie, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/7] drm: rockchip: vop: add rk3066 vop definitions
Date:   Sat, 12 Jan 2019 19:53:37 +0100
Message-ID: <2938788.qBnkOikdhP@phil>
In-Reply-To: <20190111145424.GA21604@bogus>
References: <20181229133318.18128-1-jbx6244@gmail.com> <154632658.xpTMZOjgxT@phil> <20190111145424.GA21604@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 11. Januar 2019, 15:54:24 CET schrieb Rob Herring:
> On Sun, Dec 30, 2018 at 06:22:00PM +0100, Heiko Stuebner wrote:
> > Hi Johan,
> > 
> > Am Samstag, 29. Dezember 2018, 14:33:14 CET schrieb Johan Jonker:
> > > From: Mark Yao <mark.yao@rock-chips.com>
> > > 
> > > This patch adds the rk3066 VOP definitions.
> > > 
> > > The VOP or LCD Controller serves as interface between
> > > framebuffer memory and a display device (LCD panel or TV set).
> > > 
> > > This SOC has two symmetrical LCDC's for a dual panel application.
> > > 
> > > A LCDC has 5 display layers.
> > > Only 3 are used here.
> > > 
> > > - Video layer 0 (Win0)
> > > - Video layer 1 (Win1)
> > > - OSD layer     (Win2)
> > 
> > Patch itself looks good, we'll need to wait a bit to give Rob a chance
> > to look at the (simple) dt-binding change and I'll drop the paragraph
> > about the display layers when applying.
> 
> Don't wait on me for simple oneline compatible additions.

This more or less was the fault of the year change :-D ... most of
the time I'd apply a simple new compatible earlier and possibly
without Ack ;-) .

And I've applied the patch to drm-misc-next now (for 5.1).

Heiko


