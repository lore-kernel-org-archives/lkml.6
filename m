Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5E021841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vt2EFxBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeLRJyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:54:13 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38950 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeLRJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:54:13 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94D8F53A;
        Tue, 18 Dec 2018 10:54:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545126851;
        bh=TpCAUkqwNHa1mlqzW76uG9BlDjxmHA6N2EEgt0Rs8vI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vt2EFxBAjCowT12L877Dc96QaY6sQVW0itSRg0PERQTjKL4QWSEjB1W/LSb075EgF
         XhB4TSY7bD3kgoagi8plFbxSgtYHp4BtRX4G23dVIOyrJE8uDimjx6b5cb0fHd5EG0
         6ltFRwoPh4zG52kFcKH2Q0ljZPVS6uD2NUH455MI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][resend] drm: dw-hdmi-i2s: convert to SPDX identifiers
Date:   Tue, 18 Dec 2018 11:55:01 +0200
Message-ID: <2503467.Tla0HvxUZs@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAKMK7uEJbMDRdGq1g6i+EqYjgsYDO0RFH64WrUjaW=16Th49ig@mail.gmail.com>
References: <87lg4n1izg.wl-kuninori.morimoto.gx@renesas.com> <1545127003.YuAFZ7QVEK@avalon> <CAKMK7uEJbMDRdGq1g6i+EqYjgsYDO0RFH64WrUjaW=16Th49ig@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tuesday, 18 December 2018 11:37:14 EET Daniel Vetter wrote:
> On Tue, Dec 18, 2018 at 7:47 AM Laurent Pinchart wrote:
> > On Tuesday, 18 December 2018 08:00:24 EET Kuninori Morimoto wrote:
> >> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >> 
> >> This patch updates license to use SPDX-License-Identifier
> >> instead of verbose license text.
> >> 
> >> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> >> ---
> >> few weeks passed, nothing happen. I re-post this patch again.
> >> I added Andrew on Cc
> > 
> > The driver seems to be lacking a maintainer :-S
> 
> bridge drivers all have a fallback maintainer, but none of them are
> cc'ed. It's maintained in drm-misc, so you could just push the patch
> too :-) Especially since you're listed:
> 
> DRM DRIVERS FOR BRIDGE CHIPS
> M:    Archit Taneja <architt@codeaurora.org>
> M:    Andrzej Hajda <a.hajda@samsung.com>
> R:    Laurent Pinchart <Laurent.pinchart@ideasonboard.com>

Note the R, not the M :-)

> S:    Maintained
> T:    git git://anongit.freedesktop.org/drm/drm-misc
> F:    drivers/gpu/drm/bridge/
> 
> 
> Cheers, Daniel
> 
> >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 5 +----
> >>  1 file changed, 1 insertion(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> >> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c index
> >> 8f9c8a6..2228689 100644
> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> >> @@ -1,12 +1,9 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >>  /*
> >>   * dw-hdmi-i2s-audio.c
> >>   *
> >>   * Copyright (c) 2017 Renesas Solutions Corp.
> >>   * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >> - *
> >> - * This program is free software; you can redistribute it and/or modify
> >> - * it under the terms of the GNU General Public License version 2 as
> >> - * published by the Free Software Foundation.
> >>   */
> >>  
> >>  #include <drm/bridge/dw_hdmi.h>

-- 
Regards,

Laurent Pinchart



