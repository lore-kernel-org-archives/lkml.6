Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF425FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E24D20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eg+vWLwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E24D20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeINP1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:27:42 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34180 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeINP1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:27:42 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90C51CE;
        Fri, 14 Sep 2018 12:13:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536920032;
        bh=HL9Bi9lUMDAAXiKnUqPNllDzyUjLtGU9YoRElmYhwGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eg+vWLwWrH85PtsGn/DD/Wp9Fdb+VsyJi608iFXNVjB4frvgrrKqXQYP2NaKQigmR
         Do8sAEYsle0QdW+S+qF6lIO1klJCrz2JaoIHjCwYgkH670wz5IMSwsbEGalrPLM16C
         W/9mTkrWsSpfpR/snF/oYIUpbaPWtF0QGxs1ZAk8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, kbingham@kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/4] MAINTAINERS: VSP1: Add co-maintainer
Date:   Fri, 14 Sep 2018 13:14:06 +0300
Message-ID: <1716835.dM7TpKmmGR@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180806143904.4716-2-kieran.bingham@ideasonboard.com>
References: <20180806143904.4716-1-kieran.bingham@ideasonboard.com> <20180806143904.4716-2-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Monday, 6 August 2018 17:39:02 EEST Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Add myself as a co-maintainer for the Renesas VSP driver.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

Thank you for your help with the R-Car VSP driver !

> ---
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-media@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7cecb9201b3..6a30a5332b18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8935,6 +8935,7 @@ F:	drivers/media/platform/rcar-vin/
> 
>  MEDIA DRIVERS FOR RENESAS - VSP1
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
>  L:	linux-renesas-soc@vger.kernel.org
>  T:	git git://linuxtv.org/media_tree.git

-- 
Regards,

Laurent Pinchart



