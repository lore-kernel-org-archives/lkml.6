Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D9FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83C1206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfAIXGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:06:49 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:34013 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfAIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:06:48 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 59D282001F;
        Thu, 10 Jan 2019 00:06:43 +0100 (CET)
Date:   Thu, 10 Jan 2019 00:06:41 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 12/12] drm: remove drmP.h from drm_gem_cma_helper.h
Message-ID: <20190109230641.GA28755@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
 <20190108192939.15255-13-sam@ravnborg.org>
 <20190109222405.GB21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109222405.GB21184@phenom.ffwll.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=SJz97ENfAAAA:8 a=QyXUC8HyAAAA:8
        a=P-IC7800AAAA:8 a=OC9fEarpKwUjV-LM0kIA:9 a=wPNLvfGTeEIA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=vFet0B0WnEQeilDPIY6i:22
        a=d3PnA9EDa4IxuAV0gXij:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 11:24:05PM +0100, Daniel Vetter wrote:
> On Tue, Jan 08, 2019 at 08:29:39PM +0100, Sam Ravnborg wrote:
> > With all dependencies fixed we can now remove
> > drmP.h from drm_gem_cma_helper.h.
> > It is replaced by the include files required,
> > or forward declarations as appropritate.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Acked-by: Noralf Trønnes <noralf@tronnes.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> 
> Except for the ones I commented on, all patches applied. I also fixed the
> one typo in the summary.

Thanks, I will rebase, address comments, do a new set of build tests etc. and repost.

	Sam
