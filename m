Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A82C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF13D214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfAIJfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:35:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58187 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfAIJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:35:46 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ghAGu-0000FV-Mx; Wed, 09 Jan 2019 10:35:36 +0100
Message-ID: <1547026534.3580.27.camel@pengutronix.de>
Subject: Re: [PATCH] etnaviv mailing list is moderated
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Matthew Wilcox <willy@infradead.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Jan 2019 10:35:34 +0100
In-Reply-To: <20190108205001.GG6310@bombadil.infradead.org>
References: <20190108205001.GG6310@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 08.01.2019, 12:50 -0800 schrieb Matthew Wilcox:
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>

Thanks, applied to etnaviv/next.

Regards,
Lucas

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32d444476a90..44888eb121d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5141,7 +5141,7 @@ DRM DRIVERS FOR VIVANTE GPU IP
> > >  M:	Lucas Stach <l.stach@pengutronix.de>
> > >  R:	Russell King <linux+etnaviv@armlinux.org.uk>
> > >  R:	Christian Gmeiner <christian.gmeiner@gmail.com>
> -L:	etnaviv@lists.freedesktop.org
> > +L:	etnaviv@lists.freedesktop.org (moderated for non-subscribers)
>  L:	dri-devel@lists.freedesktop.org
> >  S:	Maintained
> >  F:	drivers/gpu/drm/etnaviv/
