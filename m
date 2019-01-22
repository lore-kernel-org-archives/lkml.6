Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A61C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E69020844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfAVKJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:09:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58590 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbfAVKJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:09:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4B4E9206DC; Tue, 22 Jan 2019 11:09:57 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5E92E20AA4;
        Tue, 22 Jan 2019 11:09:23 +0100 (CET)
Message-ID: <d0729355a4e5e33adae8bacfd67d6623cb2147ce.camel@bootlin.com>
Subject: Re: [PATCH RESEND v5 00/23] drm/sun4i: Support for linear and tiled
 YUV formats with the frontend
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Tue, 22 Jan 2019 11:09:23 +0100
In-Reply-To: <20190118182057.uqohb7nkffgavezi@flea>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
         <20190118182057.uqohb7nkffgavezi@flea>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2019-01-18 at 19:20 +0100, Maxime Ripard wrote:
> On Fri, Jan 18, 2019 at 03:51:10PM +0100, Paul Kocialkowski wrote:
> > This series implements support for YUV formats using the display engine
> > frontend in the sun4i DRM driver, with various fixes along the way.
> > Scaling is supported for every format handled by the frontend.
> > 
> > The tiling mode used by the VPU on Allwinner platforms is also supported
> > by this series and a dedicated fourcc modifier is introduced, along with
> > a specific ioctl for allocating tiled buffers.
> > 
> > New common fourcc helpers are also introduced in this series, especially
> > related to YUV formats.
> > 
> > This was tested on the A33, A20 and A10 platforms and all supported
> > features work properly on them. Framebuffer offsets and source
> > positions are not supported at this point.
> 
> I've applied everything, however I can't see the ioctl you mentionned
> anywhere?

Thanks for the merge! Oops, I should have updated the cover letter more
carefully: this was removed from the series and I didn't come up with
an implementation of the generic ioctl yet.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

