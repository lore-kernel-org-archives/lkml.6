Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0764CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC05021773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfBCJ0W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 04:26:22 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53398 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfBCJ0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 04:26:22 -0500
Received: from [185.175.219.3] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gqE2a-0001Op-Gy; Sun, 03 Feb 2019 10:26:16 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: display: add binding for Innolux ee101ia-01d panel
Date:   Sun, 03 Feb 2019 10:26:15 +0100
Message-ID: <172133439.YmBYh9xVVU@phil>
In-Reply-To: <20190129164550.GU3271@phenom.ffwll.local>
References: <20181113124205.29319-1-heiko@sntech.de> <5825168.ASgtykK0VC@diego> <20190129164550.GU3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 29. Januar 2019, 17:45:50 CET schrieb Daniel Vetter:
> On Tue, Jan 29, 2019 at 02:37:23PM +0100, Heiko Stübner wrote:
> > Hi Thierry,
> > 
> > Am Dienstag, 13. November 2018, 13:42:05 CET schrieb Heiko Stuebner:
> > > From: Heiko Stuebner <heiko.stuebner@bq.com>
> > > 
> > > This is a panel handled through the generic lvds-panel binding,
> > > so only needs its additional compatible specified.
> > > 
> > > Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> > 
> > just pulling this pending patch out of the woodworks again too :-)
> > 
> > Thanks in advance for considering it.
> 
> It's a panel patch, you have the review from Rob, you have commit rights
> to drm-misc and panel is maintained in drm-misc. There's nothing blocking
> you from pushing it, just do it :-)

yeah, at some point I'll probably internalize the drm-misc concept
without feeling of stepping on someone's toes :-D

Anyway, applied and pushed now.
Heiko


