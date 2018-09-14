Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B1ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752E720861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CndExaFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752E720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeINP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:26:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34158 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeINP0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:26:37 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 27471CE;
        Fri, 14 Sep 2018 12:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536919968;
        bh=UrdpYZuahubKT4j0E9r4oCwnAse4Aw1b0hz1+GGZ/OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CndExaFU/JXsHHNiFQRoOl/jOhe3X1AIQ+9eRHkV0l1+aJNX+zoHUYwVSdaSnsE1D
         JiXJbJiRlsRymqGa7I1ZL8/47uZxtJ+aKRgc8fyUH2jsV30VPsSuufRc9P1W2KoHOx
         /P8SnZ1c5ILnFYRHNMPxIGL5t75132n2WL5yAOQM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, kbingham@kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] MAINTAINERS: rcar-du: Add co-maintainer
Date:   Fri, 14 Sep 2018 13:13:02 +0300
Message-ID: <1652490.uiGxaAVbv9@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
References: <20180806143904.4716-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Monday, 6 August 2018 17:39:01 EEST Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Add myself as a co-maintainer for the Renesas DRM drivers.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

Thank you for your help with the R-Car DU driver !

> ---
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7cebd5bba8a8..c7cecb9201b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4764,6 +4764,7 @@
> F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-
host1x.tx
> t
> 
>  DRM DRIVERS FOR RENESAS
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>  L:	dri-devel@lists.freedesktop.org
>  L:	linux-renesas-soc@vger.kernel.org
>  T:	git git://linuxtv.org/pinchartl/fbdev

-- 
Regards,

Laurent Pinchart



