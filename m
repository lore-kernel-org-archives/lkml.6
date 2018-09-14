Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6769CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195F120882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZneZxW2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195F120882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeINP2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:28:12 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34208 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeINP2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:28:12 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62B12CE;
        Fri, 14 Sep 2018 12:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536920062;
        bh=HvUS6OFJy/7Rxq9wV/ZfzNTSXT25/YQeCAyN5pi18DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZneZxW2CSejesZdf3E4EMLjFcFoRi0RZwWfRQLaX1Uij1JZ3OUVjjkpSl98CFsjdL
         RpUg2DLTk1dubWPG6QwY7mVGexZZs2DT46J/gmxV+ngoMOBnNjbI9f9BUPTD5Hn8Rx
         HrZ+uPD13uTFD2DnCoSa0TWuDe6aMY7XDTVfwOEk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-kernel@vger.kernel.org, kbingham@kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] MAINTAINERS: rcar-du: Add co-maintainer
Date:   Fri, 14 Sep 2018 13:14:36 +0300
Message-ID: <1670376.fKoVCqDDkR@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180913093700.GZ28160@w540>
References: <20180806143904.4716-1-kieran.bingham@ideasonboard.com> <20180913093700.GZ28160@w540>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Thursday, 13 September 2018 12:37:00 EEST jacopo mondi wrote:
> Hi Kieran, Laurent
> 
> On Mon, Aug 06, 2018 at 03:39:01PM +0100, Kieran Bingham wrote:
> > From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > 
> > Add myself as a co-maintainer for the Renesas DRM drivers.
> > 
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > ---
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-renesas-soc@vger.kernel.org
> > 
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7cebd5bba8a8..c7cecb9201b3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4764,6 +4764,7 @@
> > F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.
> > txt
> >  DRM DRIVERS FOR RENESAS
> >  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >  L:	dri-devel@lists.freedesktop.org
> >  L:	linux-renesas-soc@vger.kernel.org
> >  T:	git git://linuxtv.org/pinchartl/fbdev
> 
> Am I wrong or this git repository isn't actual anymore for DU?

You're right, the fix will be in my pull request for v4.20.

-- 
Regards,

Laurent Pinchart



