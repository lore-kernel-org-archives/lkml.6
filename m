Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FFBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A9F21852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 00:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Fk0k84qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeLSAbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:31:47 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59160 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeLSAbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 19:31:47 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 960DA549;
        Wed, 19 Dec 2018 01:31:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545179505;
        bh=qrJ9/csFT9RINFrrB+SBJv67ugx7WvKO4J/vyHEExf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fk0k84qfWhtZCgYZFZmmKtDjo2LiD+1x2bNdbC6c+q9OMQR5momJDsSaqM742Z8BW
         yG1+SrKvqM79QpsiZsvRfrgrSJgy69vSCW6loAR1cddMbn0TLSnfgHgRzlpNcqM59r
         NNs2MOZ0qAmDGwm5GaE1kAFl/Tnxc0lxkW0e4wyQ=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][resend] drm: dw-hdmi-i2s: convert to SPDX identifiers
Date:   Wed, 19 Dec 2018 02:32:37 +0200
Message-ID: <3162944.uzPVLzYCHc@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <87bm5ixtun.wl-kuninori.morimoto.gx@renesas.com>
References: <87lg4n1izg.wl-kuninori.morimoto.gx@renesas.com> <2503467.Tla0HvxUZs@avalon> <87bm5ixtun.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

On Wednesday, 19 December 2018 02:16:55 EET Kuninori Morimoto wrote:
> Hi
> 
> >>>> This patch updates license to use SPDX-License-Identifier
> >>>> instead of verbose license text.
> >>>> 
> >>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >>> 
> >>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> 
> >>>> ---
> >>>> few weeks passed, nothing happen. I re-post this patch again.
> >>>> I added Andrew on Cc
> >>> 
> >>> The driver seems to be lacking a maintainer :-S
> >> 
> >> bridge drivers all have a fallback maintainer, but none of them are
> >> cc'ed. It's maintained in drm-misc, so you could just push the patch
> >> too :-) Especially since you're listed:
> >> 
> >> DRM DRIVERS FOR BRIDGE CHIPS
> >> M:    Archit Taneja <architt@codeaurora.org>
> >> M:    Andrzej Hajda <a.hajda@samsung.com>
> >> R:    Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> 
> ??
> I double checked To and Cc.
> Original patch included Archit, Andrzej address,
> but these were suddenly removed on from Re: mail.
> (I added these address again on this mail).
> ... what's happening ??

I've noticed that several mailing lists sometimes drop addresses from Cc: in 
the e-mail content (but still forwards mails to those addresses). I haven't 
investigated why.

-- 
Regards,

Laurent Pinchart



