Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B1AC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562A1218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfAYSKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:10:14 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:35708 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfAYSKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:10:14 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 5FC8380477;
        Fri, 25 Jan 2019 19:10:11 +0100 (CET)
Date:   Fri, 25 Jan 2019 19:10:09 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 18/23] drm/qxl: remove dead qxl fbdev emulation code
Message-ID: <20190125181009.GA8230@ravnborg.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
 <20190118122020.27596-19-kraxel@redhat.com>
 <e5a15f7e-b3f1-b609-4a0f-bd66ea711951@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5a15f7e-b3f1-b609-4a0f-bd66ea711951@tronnes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=8nJEP1OIZ-IA:10 a=20KFwNOVAAAA:8 a=SJz97ENfAAAA:8
        a=btvmQiUjef5DOTOxXVUA:9 a=wPNLvfGTeEIA:10 a=vFet0B0WnEQeilDPIY6i:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Noralf.

> > Lovely diffstat, thanks to the new generic fbdev emulation.
> > 
> >  drm/qxl/Makefile   |    2
> >  drm/qxl/qxl_draw.c |  232 ----------------------------------------
> >  drm/qxl/qxl_drv.h  |   21 ---
> >  drm/qxl/qxl_fb.c   |  300 -----------------------------------------------------
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_drv.h  |  21 ---
> >  drivers/gpu/drm/qxl/qxl_draw.c | 232 -------------------------------
> >  drivers/gpu/drm/qxl/qxl_fb.c   | 300 -----------------------------------------
> >  drivers/gpu/drm/qxl/Makefile   |   2 +-
> >  4 files changed, 1 insertion(+), 554 deletions(-)
> >  delete mode 100644 drivers/gpu/drm/qxl/qxl_fb.c
> > 
> 
> Nice!
> 
> Acked-by: Noralf Trønnes <noralf@tronnes.org>
It must be a very satisfying experience to see such benefits
of the many hours of works you have put into the genric
fbdev emulation code.
Well done, and indeed a nice patch from Gerd.

	Sam
